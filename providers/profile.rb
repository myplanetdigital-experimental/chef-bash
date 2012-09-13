::BASH_PROFILE_DIRNAME = ".bash_profile.d"

action :create do
  user = new_resource.user
  home = %x[echo ~#{user}].chomp
  bash_profile_subdir = ::File.expand_path("#{home}/#{BASH_PROFILE_DIRNAME}")

  directory bash_profile_subdir do
    owner user
  end

  template "#{home}/.bash_profile" do
    cookbook "bash"
    source "bash_profile.erb"
    owner user
    variables(:bash_profile_subdir => bash_profile_subdir)
  end

  template "#{bash_profile_subdir}/#{new_resource.name}.sh" do
    cookbook new_resource.cookbook_name.to_s
    source "bash_profile-#{new_resource.name}.sh.erb"
    owner user
    mode "0755"
  end
end
