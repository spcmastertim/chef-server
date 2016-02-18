quinncloud Cookbook
===================
Basic setup for the quinncloud home, including raspberryPi's and other devices. Probably not useful for many other people.

Requirements
------------
- `tar` - quinncloud needs tar for installing ruby
. `cron` - used for scheduling jobs
. `logrotate` - keeps those hard to reach logfiles nice and tidy
. `motd` - marks all of the quinncloud managed devices as such
. `compat_resource` - I really need to see where this is getting pulled in...

Attributes
----------
Quinncloud specific attributes you need to set.  Most are held in the roles as I use the roles to pivot a lot of variables, but most defaults are held in attributes.

#### quinncloud::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['sudo']['groups']</tt></td>
    <td>list</td>
    <td>list of names of groups to get sudo access</td>
    <td><tt>none</tt></td>
  </tr>
  <tr>
    <td><tt>['authorization']['passwordless']</tt></td>
    <td>Boolean</td>
    <td>enable passwordless sudo for users</td>
    <td>none</td>
  </tr>
  <tr>
    <td><tt>['install_adds']['gem_set']</tt></td>
    <td>list</td>
    <td>list of gems to install</td>
    <td><tt>none</tt></td>
  </tr>
  <tr>
    <td><tt>['install_adds']['package_set']</tt></td>
    <td>list</td>
    <td>packages to install from repositories</td>
    <td><tt>epel for centos</tt></td>
  </tr>
  <tr>
    <td><tt>['ssh_config']['atl_port']</tt></td>
    <td>integer</td>
    <td>alternate ssh port</td>
    <td><tt>2222</tt></td>
  </tr>
  <tr>
    <td><tt>['ssh_config']['enable_scp']</tt></td>
    <td>Boolean</td>
    <td>enable scp server via ssh daemon</td>
    <td><tt>true</tt></td>
  </tr<
  <tr>
    <td><tt>['ssh_config']['key_size']</tt></td>
    <td>integer</td>
    <td>size of key for RSA encryption</td>
    <td><tt>2048</tt></td>
  </tr>
  <tr>
    <td><tt>['ssh_config']['keys_set']</tt></td>
    <td>Boolean</td>
    <td>set true if using ssh keys.  You *should* be doing this</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['ssh_config']['log_level']</tt></td>
    <td>string</td>
    <td>ssh server log level for /var/log</td>
    <td><tt>info</tt></td>
  </tr>
  <tr>
    <td><tt>['ssh_config']['port']</tt></td>
    <td>integer</td>
    <td>primary listening port for ssh server</td>
    <td><tt>22</tt></td>
  </tr>
  <tr>
    <td><tt>['ssh_config']['root_login']</tt></td>
    <td>string</td>
    <td>if and how root login is performed</td>
    <td><tt>no</tt></td>
  </tr>
  <tr>
    <td><tt>['ssh_config']['server_key_size']</tt></td>
    <td>integer</td>
    <td>Size of server side key, anything larger than 1024 puts a heavy load</td>
    <td><tt>1024</tt></td>
  </tr>
  <tr>
    <td><tt>['ssh_config']['use_dsa']</tt></td>
    <td>Boolean</td>
    <td>use the dsa encryption method</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['ssh_config']['use_ed25519']</tt></td>
    <td>Boolean</td>
    <td>use the ed25519 curve encryption method</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['ssh_config']['use_rsa]</tt></td>
    <td>Boolean</td>
    <td>use the rsa method of encryption</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### quinncloud::default
default doesn't get you much more than an motd.  See the other recipes for the heavy lifting.

e.g.
Just include `quinncloud` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[quinncloud]"
  ]
}
```

Contributing
------------
Contributions are welcome, but don't be horribly surprised to ask you who you are and why you are playing with my cookbook.  I am just too cheap to buy a private repo.

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Author: Tim Quinn - tim@quinncloud.com
