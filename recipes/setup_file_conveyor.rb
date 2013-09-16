package "python-setuptools" do
  action :install
end

bash "easy_install" do
  code <<-EOF
  easy_install pip
EOF
end

bash "install fileconveyor" do
  cwd "/mnt/"
  code <<-EOF
    pip install -e git+https://github.com/wimleers/fileconveyor@master#egg=fileconveyor
  EOF
end

template "/mnt/src/fileconveyor/fileconveyor/config.xml" do
  source "fileconveyor_config.xml.erb"
  owner "root"
  group "root"
  #variables()
  action :create
end

template "/mnt/src/fileconveyor/fileconveyor/settings.py" do
  source "settings.py.erb"
  owner "root"
  group "root"
  #variables()
  action :create
end

bash "start fileconveyor" do
  code <<-EOF
  nohup /mnt/src/fileconveyor/fileconveyor/arbitrator.py &
EOF
end

