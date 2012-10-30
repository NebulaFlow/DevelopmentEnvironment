# apache::default

# Install
yum_package "httpd"
yum_package "mod_ssl"

# Configure
service "httpd" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end
bash "httpd-firewall" do
	code <<-EOH
		iptables -I INPUT -p tcp --dport 80 -j ACCEPT
		iptables -I INPUT -p tcp --dport 443 -j ACCEPT
		service iptables save
	EOH
	not_if "iptables -L | grep 'tcp dpt:http'"
end
template "httpd-_namevirtualhost.conf" do
	path "/etc/httpd/conf.d/_namevirtualhost.conf"
	source "apache-_etc_httpd_conf.d__namevirtualhost.conf.erb"
	owner "root"
	group "root"
	mode 0644
	notifies :restart, resources(:service => "httpd")
end
execute "httpd-_namevirtualhost.conf-chcon" do
	command "chcon system_u:object_r:httpd_config_t:s0 /etc/httpd/conf.d/_namevirtualhost.conf"
	action :run
end
