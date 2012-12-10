
master_servers = search(:node, "chef_environment:#{node.chef_environment} AND role:database")
template "/etc/nagios3/conf.d/hosts-chef-database-masters.cfg" do
    source "host-chef.erb"

    mode "0755"

    variables(
        :nodes => master_servers,
        :group => 'mysql-servers'
    )

    notifies :restart, "service[nagios3]"
end

slave_servers = search(:node, "chef_environment:#{node.chef_environment} AND role:database-slave")
template "/etc/nagios3/conf.d/hosts-chef-database-slaves.cfg" do
    source "host-chef.erb"

    mode "0755"

    variables(
        :nodes => slave_servers,
        :group => 'mysql-slaves'
    )

    notifies :restart, "service[nagios3]"
end

trailing_servers = search(:node, "chef_environment:#{node.chef_environment} AND role:database-trailing")
template "/etc/nagios3/conf.d/hosts-chef-database-trailing.cfg" do
    source "host-chef.erb"

    mode "0755"

    variables(
        :nodes => trailing_servers,
        :group => 'mysql-slaves'
    )

    notifies :restart, "service[nagios3]"
end
