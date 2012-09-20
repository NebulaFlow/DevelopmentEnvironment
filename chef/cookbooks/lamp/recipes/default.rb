# /recipes/default.rb

include_recipe "lamp::tools"
include_recipe "lamp::apache"
include_recipe "lamp::mysql"
include_recipe "lamp::php"
