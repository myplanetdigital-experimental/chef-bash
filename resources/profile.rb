actions :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String


def initialize(name, run_context=nil)
  super
  @action = :create
end
