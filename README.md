visibility_predicates
========================

Description
-----------

Provide some predicate methods for to check method visibility.

Features
--------

* Kernel#public_method?
* Kernel#protected_method?
* Kernel#private_method?
* Module#public_instance_method?
* Module#protected_instance_method?
* Module#private_instance_method?

Usage
-----

### Overview

```ruby
require 'visibility_predicates'

class Foo
  private; def modified_foobar; end
end

class Bar < Foo
  protected :modified_foobar
end

Bar.new.public_method? :modified_foobar    #=> false
Bar.new.protected_method? :modified_foobar #=> true
Bar.new.private_method? :modified_foobar   #=> false
```

Requirements
-------------

* Ruby - [1.8.7 or later](http://travis-ci.org/#!/kachick/visibility_predicates)

Install
-------

```bash
gem install visibility_predicates
```

Build Status
-------------

[![Build Status](https://secure.travis-ci.org/kachick/visibility_predicates.png)](http://travis-ci.org/kachick/visibility_predicates)

Link
----

* [code](https://github.com/kachick/visibility_predicates)
* [API](http://kachick.github.com/visibility_predicates/yard/frames.html)
* [issues](https://github.com/kachick/visibility_predicates/issues)
* [CI](http://travis-ci.org/#!/kachick/visibility_predicates)
* [gem](https://rubygems.org/gems/visibility_predicates)

License
--------

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.

