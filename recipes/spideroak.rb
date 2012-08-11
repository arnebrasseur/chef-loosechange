apt_repo "spideroak" do
  case node['platform']
  when "debian"
    url "http://apt.spideroak.com/debian/"
    distribution "stable"
    components ["non-free"]
  when "ubuntu"
    url "http://apt.spideroak.com/ubuntu-spideroak-hardy/"
    distribution "release"
    components ["restricted"]
  end
  key_url "http://apt.spideroak.com/spideroak-apt-pubkey.asc"
  key_id "F1A41D5E"
end

package "spideroak"

template "/tmp/spideroak.json" do
  source "setup.json.erb"
end

execute "SpiderOak setup" do
  command "SpiderOak --setup=/tmp/spideroak.json"
end

execute "SpiderOak includes" do
  Array(node[:spideroak][:include_dirs]).each do |dir|
    command "SpiderOak --include-dir='#{dir}'"
  end
end

cron "SpiderOak batch sync" do
  command "SpiderOak --batchmode"
  minute 0
  hour 4
end
