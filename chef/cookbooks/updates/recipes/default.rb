# /recipes/default.rb

package "yum*" do
  action :upgrade
end

bash "update package: yum" do
	code <<-EOH
		yum update -y yum*
	EOH
end
bash "update all packages" do
	code <<-EOH
		yum update -y
	EOH
end

# reference: http://reiddraper.com/first-chef-recipe/
