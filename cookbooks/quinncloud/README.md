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
    <td><tt>['quinncloud']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
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
