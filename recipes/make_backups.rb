#
# Cookbook Name:: loosechange
# Recipe:: make_backups
#
# Author:: Arne Brasseur (<arne.brasseur@gmail.com>)
# Copyright 2012 Arne Brasseur
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

directory File.dirname(node['make_backups']['location']) do
  owner "postgres"
  group "postgres"
  mode "0755"
end

directory "/var/lib/postgresql/backups" do
  owner "postgres"
  group "postgres"
  mode "0755"
end

cookbook_file node['make_backups']['location'] do
  # source "make_backups.sh" # inferred
  mode "0500"
  owner "postgres"
  group "postgres"
end

cron "make-postgres-backups" do
  user "postgres"
  command node['make_backups']['location']
  node[:make_backups][:cron].split(/\s+/).each_with_index do |time, idx|
    self.send(%w[minute hour day month weekday][idx], time) unless time == '*'
  end
end
