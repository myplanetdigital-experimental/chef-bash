default_action :create
actions :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String
attribute :cookbook, :kind_of => String, :default => nil
