visibility_predicates
========================

[![Build Status](https://secure.travis-ci.org/kachick/visibility_predicates.png)](http://travis-ci.org/kachick/visibility_predicates)
[![Gem Version](https://badge.fury.io/rb/visibility_predicates.png)](http://badge.fury.io/rb/visibility_predicates)

Some predicate methods for checking method visibility.

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

* [Ruby 2.5 or later](http://travis-ci.org/#!/kachick/visibility_predicates)

Install
-------

```bash
gem install visibility_predicates
```

Link
----

* [Home](http://kachick.github.com/visibility_predicates/)
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

