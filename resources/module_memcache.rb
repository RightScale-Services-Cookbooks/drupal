actions :install, :configure

attribute :site_alias, :kind_of => String, :default => nil
attribute :directory, :kind_of => String, :default => nil
attribute :memcache_server, :kind_of => String, :default => nil
attribute :enable_sessions, :kind_of => String, :default => "true"
