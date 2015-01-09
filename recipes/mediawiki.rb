#
# Cookbook Name:: wikiserver
# Recipe:: mediawiki
# Author:: Eric Bordeleau (ebordeleau@myfastmail.com) 
#
# Copyright (c) 2014 All Rights Reserved.	
# References: https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Ubuntu

# Modifying PHP parameters for Mediawiki
ruby_block "Modify PHP parameters" do
  block do  
    fe = Chef::Util::FileEdit.new("#{node['php']['parameters']['file']}")
    fe.search_file_replace_line("#{node['php']['parameters']['max_upload_size']} = 2M","#{node['php']['parameters']['max_upload_size']} = 20M")  
    fe.search_file_replace_line("#{node['php']['parameters']['mem_limit']} = 8M","#{node['php']['parameters']['mem_limit']} = 128M")
    fe.write_file
  end
end

# Get the remote_file from MediaWiki
remote_file "/tmp/#{node['mediawiki']['file']}-#{node['mediawiki']['full_version']}.tar.gz" do
  owner "#{node['apache']['user']}"
  group "#{node['apache']['group']}"
  mode "0755"
  source "#{node['mediawiki']['url_base']}#{node['mediawiki']['minor_version']}/#{node['mediawiki']['file']}-#{node['mediawiki']['full_version']}.tar.gz"
end

# Decompress 
execute "Decompress and untar file" do
	cwd  "#{node['mediawiki']['installdir']}"
	command "tar xvfz /tmp/#{node['mediawiki']['file']}-#{node['mediawiki']['full_version']}.tar.gz; mv #{node['mediawiki']['file']}-#{node['mediawiki']['full_version']} #{node['mediawiki']['dir']}"
end

execute "Change ownership directory of wikipedia" do
  cwd  "#{node['mediawiki']['installdir']}"
  command "chown -R #{node['apache']['user']}:#{node['apache']['group']} *"
end

# Create apache config
template "#{node['apache']['dir']}/sites-available/#{node['mediawiki']['vhostconfig']}" do
  source 'wiki.conf.erb'
  notifies :restart, 'service[apache2]'
end  
apache_site 'wiki' do
  enable true
  notifies :restart, 'service[apache2]'
end

# Create LocalSettings.php config for Wiki
template "#{node['mediawiki']['installdir']}/#{node['mediawiki']['dir']}/LocalSettings.php" do
  source 'LocalSettings.php.erb'
  owner "#{node['apache']['user']}"
  group "#{node['apache']['group']}"
  mode "0600"
  notifies :restart, 'service[apache2]'
end 
