# Set up git client and server for the network
# we will install the server only on pi2, the rest will just
# have the client installed.

# variables
git_load = node['git_config']['server_pkg']

package [git_load] do
  action :upgrade
end
