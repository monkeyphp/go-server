#
# Cookbook Name:: go-server
# Recipe:: default
#
# Copyright 2014, David White
#
# All rights reserved - Do Not Redistribute
#

# http://download01.thoughtworks.com/go/14.1.0/ga/go-server-14.1.0-18882.noarch.rpm
case node["platform"]
    
when "centos"

    package "java-1.7.0-openjdk" do
        action :install
        provider Chef::Provider::Package::Yum
        
    end
    
    remote_file "/tmp/go-server.rpm" do
        source "http://download01.thoughtworks.com/go/14.1.0/ga/go-server-14.1.0-18882.noarch.rpm"
        action :create_if_missing
    end
    
    execute "install_go-server" do
        command "sudo rpm -Uhv /tmp/go-server.rpm" 
        action :run
    end
 
when "ubuntu"

    package "openjdk-7-jre" do
        action :install
    end

    package "unzip" do
        action :install
    end

    remote_file "#{Chef::Config[:file_cache_path]}/go-server.deb" do
        source "http://download01.thoughtworks.com/go/14.1.0/ga/go-server-14.1.0-18882.deb"
        mode "0777"
    end

    execute "install_go-server" do
        command "sudo dpkg -i #{Chef::Config[:file_cache_path]}/go-server.deb" 
        action :run
    end

    service "go-server" do
        supports :start => true, :stop => true, :restart => true, :status => true
        action :nothing
    end

end

