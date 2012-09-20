# Mostly stolen from https://github.com/rebbix/chef-cookbooks-yum/blob/master/recipes/epel.rb

major = node['platform_version'].to_i
epel  = node['prerequisites']['epel-repo']

case node[:platform]
when "debian", "ubuntu"
	# EPEL is not available for these distributions
when "redhat", "centos", "scientific"

	execute "add_epel_repo" do
		command "rpm -Uhv http://download.fedoraproject.org/pub/epel/#{major}/i386/epel-release-#{epel}.noarch.rpm"
		not_if "rpm -qa | egrep -qx 'epel-release-#{epel}(|.noarch)'"
	end

end