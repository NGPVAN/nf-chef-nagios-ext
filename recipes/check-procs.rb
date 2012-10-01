nagios_nrpecheck "check_procs" do
    command "#{node['nagios']['plugin_dir']}/check_procs"
    warning_condition "250"
    critical_condition "400"
    action :add
end

