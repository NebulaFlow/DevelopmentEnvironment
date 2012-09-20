# /recipes/mysql.rb

# Install
yum_package "mysql-server"
case node['lamp']['env']
when "dev"
	yum_package "mysqlreport"
	yum_package "mysqltuner"
	yum_package "mytop"
end

# Configure
# Remove test databases & users.
bash "mysql-hardening" do
	code <<-EOH
		/usr/bin/mysqladmin -u root password '#{node[:lamp][:mysql_password]}'
		mysql -u root -p#{node[:lamp][:mysql_password]} -e 'DROP DATABASE test;'
	EOH
	not_if "mysql -u root -p#{node[:lamp][:mysql_password]} -e 'show databases' | grep -q test"
end
# Set to auto-start and start it now
service "mysqld" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end
