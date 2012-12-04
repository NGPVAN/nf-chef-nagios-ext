service "nagios3" do
    supports :restart => true, :status => true
    action [ :enable, :start ]
end

