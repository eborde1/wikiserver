#
# Cookbook Name:: wikiserver
# Recipe:: config_mysql
# Author:: Eric Bordeleau (ebordeleau@myfastmail.com) 
#
# Copyright (c) 2014 All Rights Reserved.


# Configuration of MySQL

execute "create wikidb" do
	command "#{node['mysqld']['cmd']}#{node['mysqld']['root_password']}#{node['mysqld']['create_db_cmd']};"
	action :run
end
execute "grant_localhost" do
	command "#{node['mysqld']['cmd']}#{node['mysqld']['root_password']}#{node['mysqld']['grant_cmd']} '#{node['mediawiki']['admin_user']}'@'localhost' identified by '#{node['mediawiki']['admin_passwd']}';\" "
	action :run
end
execute "grant_hostname" do
	command "#{node['mysqld']['cmd']}#{node['mysqld']['root_password']}#{node['mysqld']['grant_cmd']} '#{node['mediawiki']['admin_user']}'@'www' identified by '#{node['mediawiki']['admin_passwd']}';\" "
	action :run
end

# Copy dumpfile to /tmp
cookbook_file "#{node['mysqld']['dumpfile']}" do
	path "/tmp/#{node['mysqld']['dumpfile']}"
	owner "root"
	group "root"
	mode "0755"
	:create_if_missing
end

# Load mysql configured dumpfile 
execute "load_config_from_dump" do
	command "#{node['mysqld']['cmd']}#{node['mysqld']['root_password']} #{node['mysqld']['wiki_db']}< /tmp/#{node['mysqld']['dumpfile']}"
	action :run
end

