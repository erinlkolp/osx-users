#
# Cookbook:: osx-users
# Recipe:: _erin_test
#
# Copyright:: 2017, Erin Kolp, All Rights Reserved.

target_user = 'erinone'
target_realname = 'Erin Kolp'
target_password = 'erinone'
target_uid = '12001'
target_gid = '12001'
target_shell = '/bin/bash'

#osx_user_manage "#{target_user}" do
#  username "#{target_user}"
#  realname "#{target_realname}"
#  uid "#{target_uid}"
#  gid "#{target_gid}"
#  password "#{target_password}"
#  shell "#{target_shell}"
#  action :create
#end

osx_user_manage "#{target_user}" do
  username "#{target_user}"
  realname "#{target_realname}"
  uid "#{target_uid}"
  gid "#{target_gid}"
  password "#{target_password}"
  shell "#{target_shell}"
  action :remove
end
