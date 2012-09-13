action :create do
  user = new_resource.user
  home = %x[echo ~#{user}].chomp
  ::BASH_PROFILE_DIRNAME = ".bash_profile.d"
  ::BASH_PROFILE_SUBDIR = ::File.expand_path("#{home}/#{BASH_PROFILE_DIRNAME}")

  directory BASH_PROFILE_SUBDIR do
    owner user
  end

  template "#{home}/.bash_profile" do
    cookbook "bash"
    source "bash_profile.erb"
    owner user
  end

  template "#{BASH_PROFILE_SUBDIR}/#{new_resource.name}.sh" do
    cookbook new_resource.cookbook_name.to_s
    source "bash_profile-#{new_resource.name}.sh.erb"
    owner user
    mode "0755"
  end
end
