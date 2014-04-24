#
# Cookbook Name:: go-server
# Recipe:: default
#
# Copyright 2014, David White
#
# All rights reserved - Do Not Redistribute
#

package "openjdk-7-jre" do
    action :install
end

package "unzip" do
    action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/go-server.deb" do
    source "http://download01.thoughtworks.com/go/13.4.1/ga/go-server-13.4.1-18342.deb"
    mode 0777
end

package "go-server" do
    source "#{Chef::Config[:file_cache_path]}/go-server.deb"
    provider Chef::Provider::Package::Dpkg
    action :install
end

service "go-server" do
    supports :start => true, :stop => true, :restart => true, :status => true
    action :nothing
end

template "/etc/default/go-server" do
    source   "go-server.erb"
    owner    "root"
    group    "root"
    mode     0644
    notifies :restart, resources(:service => "go-server")
end

# http://www.thoughtworks.com/products/docs/go/13.4/help/

# download location
# http://www.go.cd/download/
# http://download01.thoughtworks.com/go/13.4.1/ga/go-server-13.4.1-18342.deb

# # update apt
# $ sudo apt-get update
# # get a compatible java
# $ sudo apt-get install openjdk-7-jre
# # unzip

# # download the go-server deb
# $ wget http://download01.thoughtworks.com/go/13.4.1/ga/go-server-13.4.1-18342.deb

# remote_file "#{Chef::Config[:file_cache_path]}/large-file.tar.gz" do
#   source "http://www.example.org/large-file.tar.gz"
# end

# $ sudo dpkg -i http://download01.thoughtworks.com/go/13.4.1/ga/go-server-13.4.1-18342.deb

# /etc/­go/cr­uise-­confi­g.xml­
# /etc/default/go-server
# http://ubuntu:8153/go