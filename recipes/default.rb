#
# Cookbook Name:: wikiserver
# Recipe:: mediawiki
# Author:: Eric Bordeleau (ebordeleau@myfastmail.com) 
#
# Copyright (c) 2014 All Rights Reserved.	

include_recipe "apache2::default"
include_recipe "apache2::mod_ssl"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_ajp"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_php5"


# Disable default site
apache_site '000-default' do
  enable false
end

# Install jdk7 from Oracle
java_ark "jdk" do
    bin_cmds ["java", "javac", "keytool"]
    action :install
end

# Install package php5-mysql
apt_package "php5-mysql" do
  action :install 
end


