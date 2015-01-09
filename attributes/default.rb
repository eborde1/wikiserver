# Oracle Java
default['java']['install_flavor']	 = "oracle"
default['java']['jdk_version']   	 = "7"
default['java']['arch']				 = "x86_64"
default['java']['ark_retries'] 		 = 2
default['java']['ark_retry_delay'] 	 = 5
default['java']['oracle']['accept_oracle_download_terms'] = true

# Apache 
default['apache']['admin_mail'] = "ebordeleau@myfastmail.com"
default['apache']['htmldocroot'] = "/var/www/wikisite"
default['apache']['loglevel'] = 'debug'
default['apache']['dir'] = "/etc/apache2"
default['apache']['user'] = 'www-data'
default['apache']['group'] = 'www-data'
default['apache']['servername'] = "wiki"

# MysSQL server
default['mysqld']['db_root_user'] = 'mysql'
default['mysqld']['root_password'] = 'mysql'
default['mysqld']['cmd'] = 'mysql -u root -p'
default['mysqld']['wiki_db'] = 'wikidb'
default['mysqld']['create_db_cmd'] = " -e 'create database wikidb;'"
default['mysqld']['grant_cmd'] = " -e \"grant index, create, select, insert, update, delete, alter, lock tables on wikidb.* to "
default['mysqld']['dumpfile'] = "wikidb_configured.sql"

# PHP parameters
default['php']['parameters']['file'] ="/etc/php5/cgi/php.ini"
default['php']['parameters']['max_upload_size'] ="upload_max_filesize"
default['php']['parameters']['mem_limit'] ="memory_limit"

# MediaWiki
default['mediawiki']['url_base'] = 'http://releases.wikimedia.org/mediawiki/'
default['mediawiki']['minor_version'] = '1.24'
default['mediawiki']['full_version'] = '1.24.1'
default['mediawiki']['file'] = 'mediawiki'

default['mediawiki']['sitename'] = 'Eric Wiki'
default['mediawiki']['namespace'] = 'Eric_Wiki'
default['mediawiki']['installdir'] = '/var/www'
default['mediawiki']['dir'] = 'wikisite'
default['mediawiki']['admin_user'] = 'wikiadmin'
default['mediawiki']['admin_passwd'] = 'WikiPassword123'
default['mediawiki']['vhostconfig'] = 'wiki.conf'
