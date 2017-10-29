#
# Cookbook:: osx-users
# Recipe:: _erin_test
#
# Copyright:: 2017, Erin Kolp, All Rights Reserved.

target_user = 'erinone'
target_realname = 'Erin Kolp'
target_password = 'erinone'
target_shell = '/bin/bash'

osx_user_manage "#{target_user}" do
  username "#{target_user}"
  realname "#{target_realname}"
  password "#{target_password}"
  shell "#{target_shell}"
  admin 'true'
  action :create
end

osx_user_manage "#{target_user}" do
  username "erintwo"
  realname "erintwo"
  password "erintwo"
  shell "/bin/bash"
  admin 'false'
  action :create
end
