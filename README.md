OSX Users Cookbook
=======================

This cookbook will add or remove users on Mac OSX.

## Platform

* Mac OS X

Usage
-----

```
osx_user_manage "username" do
  realname "User A. Name"
  password "userpass"
  shell "/bin/bash"
  admin 'false'   # || 'true'
  action :create  # || :remove
end
```

To-Do
-----

* Add converge_if_changed
* Use Ruby-native methods

License and Authors
-------------------

* Author: Erin L. Kolp (<ekolp@kickbackpoints.com>)
* Copyright: 2017 Erin L. Kolp.

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
