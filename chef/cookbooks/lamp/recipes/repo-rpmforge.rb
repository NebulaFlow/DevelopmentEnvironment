case node[:platform]
when "debian", "ubuntu"
	# EPEL is not available for these distributions
when "redhat", "centos", "scientific"

	execute "add_rpmforge_repo" do
		command "rpm --import http://dag.wieers.com/packages/RPM-GPG-KEY.dag.txt && rpm -Uhv rpm -Uhv http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.#{node[:languages][:ruby][:host_cpu]}.rpm"
		not_if "rpm -qa | egrep -qx 'rpmforge-release'"
	end

end