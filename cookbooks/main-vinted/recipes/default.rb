#
# Cookbook Name:: learn_chef_apache2
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'postfix'
include_recipe 'redisio'
include_recipe 'redisio::enable'

package 'python-setuptools'

directory "/etc/postfix/py2redis" do
  action :create
end

easy_install_package "virtualenv" do
  action :install
end

bash "setup virtualenv" do
  cwd "/etc/postfix/py2redis"
  code <<-EOF
    virtualenv .
    source ./bin/activate
    pip install redis
  EOF
  not_if 'if [ -d ./bin ] ; then ; else echo 0; fi', :cwd=>'/etc/postfix/py2redis'
end

template "/etc/postfix/header_checks" do
  source "header_checks.erb"
  action :create
end

template "/etc/postfix/py2redis/mail_transfer.py" do
  source "mail_receive.py.erb"
  action :create 
end
