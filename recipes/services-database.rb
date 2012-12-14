master_servers = search(:node, "chef_environment:#{node.chef_environment} AND role:database")
template "/etc/nagios3/conf.d/services-chef-database-masters.cfg" do
    source "service-chef.erb"

    mode "0755"

    variables(
        :nodes => master_servers,
        :description => "MySQL Master Connectivity",
        :command => 'check_mysql',
        :hostgroup => 'app-web-servers'
    )

    notifies :restart, "service[nagios3]"
end

slave_servers = search(:node, "chef_environment:#{node.chef_environment} AND role:database-slave")
template "/etc/nagios3/conf.d/services-chef-database-slaves.cfg" do
    source "service-chef.erb"

    mode "0755"

    variables(
        :nodes => slave_servers,
        :description => "MySQL Slave Connectivity",
        :command => 'check_mysql',
        :hostgroup => 'app-web-servers'
    )

    notifies :restart, "service[nagios3]"
end

