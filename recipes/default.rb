package "bash"

directory "/etc/bash" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

%w(
  bash_logout
  bashcomp-modules
  bashcomp.sh
  bashrc
  color.sh
  detect.sh
  prompt.sh
).each do |f|
  cookbook_file "/etc/bash/#{f}" do
    source f
    owner "root"
    group "root"
    mode "0644"
  end
end

file "/etc/bashrc" do
  action :delete
  only_if %{test -f /etc/bash.bashrc}
end

link "/etc/bash.bashrc" do
  to "/etc/bash/bashrc"
end

file "/root/.bashrc" do
  action :delete
  only_if %{test -f /root/.bashrc}
end

# removed default bash files from skel
# we don't need them because we use a systemwide config
file "/etc/skel/.bashrc" do
  action :delete
  only_if %{test -f /etc/skel/.bashrc}
end
file "/etc/skel/.profile" do
  action :delete
  only_if %{test -f /etc/skel/.profile}
end
