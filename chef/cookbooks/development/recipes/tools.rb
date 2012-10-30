# development::tools

yum_package "git"
case node['lamp']['env']
when "dev"
	yum_package "subversion"
end
