# repos::remi

include_recipe "repos::epel"

major = node['platform_version'].to_i

case node[:platform]
when "debian", "ubuntu"
	# REMI is not available for these distributions
when "redhat", "centos", "scientific"

	execute "add_remi_repo" do
		command "rpm -Uhv http://rpms.famillecollet.com/enterprise/remi-release-#{major}.rpm && head -8 /etc/yum.repos.d/remi.repo | sed -e \"s/enabled=0/enabled=1/\" > /tmp/remi.repo && mv /etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo.orig && mv /tmp/remi.repo /etc/yum.repos.d/remi.repo"
		not_if "rpm -qa | egrep -q 'remi-release'"
	end

end
