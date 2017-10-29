## Chef User reference #########################################################
##
## user 'name' do
##   comment                    String
##   force                      TrueClass, FalseClass # see description
##   gid                        String, Integer
##   home                       String
##   iterations                 Integer
##   manage_home                TrueClass, FalseClass
##   non_unique                 TrueClass, FalseClass
##   notifies                   # see description
##   password                   String
##   provider                   Chef::Provider::User
##   salt                       String
##   shell                      String
##   subscribes                 # see description
##   system                     TrueClass, FalseClass
##   uid                        String, Integer
##   username                   String # defaults to 'name' if not specified
##   action                     Symbol # defaults to :create if not specified
## end

## OSX User Create #############################################################
##
## dscl . -create /Users/erinadmin
## dscl . -create /Users/erinadmin UserShell /bin/bash
## dscl . -create /Users/erinadmin RealName "Joe Admin"
## dscl . -create /Users/erinadmin UniqueID "510"
## dscl . -create /Users/erinadmin PrimaryGroupID 20
## dscl . -create /Users/erinadmin NFSHomeDirectory /Users/erinadmin
## dscl . -passwd /Users/erinadmin password password
## dscl . -append /Groups/admin GroupMembership erinadmin
##
## Alt Method ##################################################################
##
## sysadminctl[21233:29122637] Usage: sysadminctl
##     -deleteUser <user name> [-secure || -keepHome]
##     -newPassword <new password> -oldPassword <old password> [-passwordHint <password hint>]
##     -resetPasswordFor <local user name> -newPassword <new password> [-passwordHint <password hint>]
##     -addUser <user name> [-fullName <full name>] [-UID <user ID>] [-password <user password>] [-hint <user hint>] [-home <full path to home>] [-admin] [-picture <full path to user image>]
##
## sudo createhomedir -c 2>&1 | grep -v "shell-init"
## sudo dseditgroup -o edit -a usernametoadd -t user admin
## sudo dseditgroup -o edit -a usernametoadd -t user wheel

resource_name :osx_user_manage

property :username, String, name_property: true, required: true
property :realname, String, required: true
property :uid, String, required: false
property :gid, String, required: false
property :password, String, required: true
property :shell, String, required: false

basePassword = rand(30042 .. 2039293302).to_i + rand(1000 .. 3932020).to_i
secPassword = rand(987003 .. 9023040).to_i + rand(1 .. 230300300).to_i / 3
randomPassword = basePassword + secPassword * rand(1 ... 7).to_i

action :create do
  if node['os'] == 'linux'
    raise 'Wrong OS'
  elsif node['os'] == 'darwin'
    execute 'name' do
      command "sysadminctl -addUser \"#{username}\" -fullName \"#{realname}\" -password \"#{password}\" -home \"/Users/#{username}\" -admin"
      sensitive true
      action :run
    end

    execute 'add_homedir' do
      command 'createhomedir -c 2>&1 | grep -v "shell-init"'
      sensitive true
      action :run
    end

    execute 'add_user_to_admin_groups' do
      command "dseditgroup -o edit -a #{username} -t user admin"
      sensitive true
      action :run
    end

    execute 'add_user_to_wheel_group' do
      command "dseditgroup -o edit -a #{username} -t user wheel"
      sensitive true
      action :run
    end
  end
end

action :remove do
  if node['os'] == 'linux'
    raise 'Wrong OS'
  elsif node['os'] == 'darwin'
    execute 'remove_user' do
      #command "sysadminctl -resetPasswordFor \"#{username}\" -newPassword \"SAklelk309ewlkdLKDsl3\""
      command "sysadminctl -resetPasswordFor \"#{username}\" -newPassword \"SAkl#{randomPassword}kdLKDsl3\""
      sensitive true
      action :run
    end
  end
end
