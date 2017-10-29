resource_name :osx_user_manage

property :username, String, name_property: true, required: true
property :realname, String, required: true
property :password, String, required: true
property :shell, String, required: false
property :admin, String, required: true

randomPassword = rand(30042 .. 2039293302).to_i + rand(1000 .. 3932020).to_i

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

    if admin == 'true'
      execute 'add_user_to_admin_groups' do
        command "dseditgroup -o edit -a #{username} -t user admin"
        sensitive true
        action :run
      end
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
