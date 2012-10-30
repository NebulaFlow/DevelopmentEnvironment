# php::default

# php
log("php version required = #{node['lamp']['phpversion']}") { level :debug }
case node['lamp']['phpversion']
when "5.3.16", "latest"
	log("REMI repo required") { level :debug }
	include_recipe "repos::remi"
end

yum_package "php" do
	# enablerepo doesn't work, see http://tickets.opscode.com/browse/CHEF-2427
	#case node['lamp']['phpversion']
	#when "5.3.16", "latest" # 5.3.16-3.el6.remi
	#	options "--enablerepo=remi"
	#else
	#	version = "5.3.3-14.el6_3"
	#end
end
yum_package "php-common"
yum_package "php-cli"
yum_package "php-gd"
yum_package "php-mbstring"
yum_package "php-mysql"
yum_package "php-soap"
#yum_package "php-pecl-amqp"
#yum_package "php-pecl-memcached"
#yum_package "php-redis"
#yum_package "php-sqlite"
template "php-date_timezone.ini" do
	path "/etc/php.d/date_timezone.ini"
	source "_etc_php.d_date_timezone.ini.erb"
	owner "root"
	group "root"
	mode 0644
end
execute "php-date_timezone.ini-chcon" do
	command "chcon system_u:object_r:etc_t:s0 /etc/php.d/date_timezone.ini"
	action :run
end
case node['lamp']['env']
when "dev"
	yum_package "phpMyAdmin"
	yum_package "php-pdepend-PHP-Depend"
	yum_package "php-pear-PHP-CodeSniffer"
	yum_package "php-pear-PhpDocumentor"
	yum_package "php-pecl-xdebug"
	yum_package "php-pecl-xhprof"
	yum_package "php-phpmd-PHP-PMD"
	yum_package "php-phpunit-PHP-CodeCoverage"
	yum_package "php-phpunit-phpcpd"
	yum_package "php-phpunit-phpdcd"
	yum_package "php-phpunit-phploc"
	template "php-index.php" do
		path "/var/www/html/index.php"
		source "_var_www_html_index.php.erb"
		owner "root"
		group "root"
		mode 0644
	end
	execute "php-index.php-chcon" do
		command "chcon system_u:object_r:httpd_sys_content_t:s0 /var/www/html/index.php"
		action :run
	end
end
