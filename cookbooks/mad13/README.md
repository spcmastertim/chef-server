mad13 Cookbook
==============
Mad13 Entertainment primary site
Installs needed dependancies and pulls the wordpress tarball down from Github

Requirements
------------
This cookbook should pull all required software and install it using your
system of choice, so long as it is yum or apt based ;)

#### packages
This recipe will install apache2 or httpd (2.4 or 2.2, depending on your distro)
and also php, mysql and some additional required software.

Attributes
----------
The attributes are all role based, and should be self explanitory based on name.


#### mad13::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mad13']['enabled']</tt></td>
    <td>Boolean</td>
    <td>whether the site is enabled</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### mad13::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `mad13` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mad13]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License GPLv3
Author: Tim Quinn (admin@mad13ent.com)
