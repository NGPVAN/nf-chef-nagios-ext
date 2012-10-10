dbservers = search(:node, "environment:#{node.chef_environment} AND role:database")

dbservers.each do |server|
    nagios_nrpecheck "check_mysql_#{server['ipaddress']}" do
        command "{node['nagios']['plugin_dir']}/check_mysql"
        parameters "-H #{server['ipaddress']} -u #{node['nagios']['mysql']['user']} -p #{node['nagios']['mysql']['password']}"
        action :add
    end
end
