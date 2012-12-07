
webservers = search(:node, "chef_environment:#{node.chef_environment} AND role:web")

template "/etc/nagios3/conf.d/hosts-chef-webheads.cfg" do
    source "host-chef.erb"

    mode "0755"

    variables(
        :nodes => webservers
    )

    notifies :restart, "service[nagios3]"
end
