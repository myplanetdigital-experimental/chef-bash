user = new_resource.user
home = system("echo ~#{user}").chomp

::BASH_INCLUDES_DIRNAME = ".bash_profile.d"
::BASH_INCLUDES_SUBDIR = ::File.expand_path("#{home}/#{BASH_INCLUDES_DIRNAME}")

action :create do
  directory BASH_INCLUDES_SUBDIR do
    owner user
  end

  template "#{home}/.bash_profile" do
    source "bash_profile.erb"
    owner user
  end

  template "#{BASH_INCLUDES_SUBDIR}/#{new_resource.name}.sh" do
    source "bash_profile-#{new_resource.name}.sh.erb"
    owner user
    mode "0755"
  end
end
