require 'test/unit'

$VERBOSE = true

require_relative '../lib/visibility_predicates'


class Foo
  def public_foo; end
  protected; def protected_foo; end
  private; def private_foo; end
  protected; def modified_foobar; end
end

class Bar < Foo
  private :modified_foobar
end

class Test_Predicate_Top_InstanceMethodVisibility < Test::Unit::TestCase

  def test_public
    assert_same true, Foo.public_instance_method?(:public_foo)
    assert_same false, Foo.public_instance_method?(:protected_foo)
    assert_same false, Foo.public_instance_method?(:private_foo)
  end

  def test_public_with_string_name
    assert_same true, Foo.public_instance_method?('public_foo')
    assert_same false, Foo.public_instance_method?('protected_foo')
    assert_same false, Foo.public_instance_method?('private_foo')
  end

  def test_protected
    assert_same false, Foo.protected_instance_method?(:public_foo)
    assert_same true, Foo.protected_instance_method?(:protected_foo)
    assert_same false, Foo.protected_instance_method?(:private_foo)
  end

  def test_private
    assert_same false, Foo.private_instance_method?(:public_foo)
    assert_same false, Foo.private_instance_method?(:protected_foo)
    assert_same true, Foo.private_instance_method?(:private_foo)
  end

  def test_modified
    assert_same true, Foo.protected_instance_method?(:modified_foobar)
    assert_same false, Foo.private_instance_method?(:modified_foobar)
  end

end


class Test_Predicate_Inherited_InstanceMethodVisibility < Test::Unit::TestCase

  def test_public
    assert_same true, Bar.public_instance_method?(:public_foo)
    assert_same false, Bar.public_instance_method?(:protected_foo)
    assert_same false, Bar.public_instance_method?(:private_foo)
  end

  def test_public_with_string_name
    assert_same true, Bar.public_instance_method?('public_foo')
    assert_same false, Bar.public_instance_method?('protected_foo')
    assert_same false, Bar.public_instance_method?('private_foo')
  end

  def test_protected
    assert_same false, Bar.protected_instance_method?(:public_foo)
    assert_same true, Bar.protected_instance_method?(:protected_foo)
    assert_same false, Bar.protected_instance_method?(:private_foo)
  end

  def test_private
    assert_same false, Bar.private_instance_method?(:public_foo)
    assert_same false, Bar.private_instance_method?(:protected_foo)
    assert_same true, Bar.private_instance_method?(:private_foo)
  end

  def test_modified
    assert_same false, Bar.protected_instance_method?(:modified_foobar)
    assert_same true, Bar.private_instance_method?(:modified_foobar)
  end

  def test_public_rejected_parent
    assert_raises NameError do
      Bar.public_instance_method?(:public_foo, false)
    end

    assert_raises NameError do
      Bar.public_instance_method?(:protected_foo, false)
    end

    assert_raises NameError do
      Bar.public_instance_method?(:private_foo, false)
    end
  end

  def test_protected_rejected_parent
    assert_raises NameError do
      Bar.protected_instance_method?(:public_foo, false)
    end

    assert_raises NameError do
      Bar.protected_instance_method?(:protected_foo, false)
    end

    assert_raises NameError do
      Bar.protected_instance_method?(:private_foo, false)
    end
  end

  def test_private_rejected_parent
    assert_raises NameError do
      Bar.private_instance_method?(:public_foo, false)
    end

    assert_raises NameError do
      Bar.private_instance_method?(:protected_foo, false)
    end

    assert_raises NameError do
      Bar.private_instance_method?(:private_foo, false)
    end
  end

end



class Test_Predicate_MethodVisibility < Test::Unit::TestCase

  BAR = Bar.new

  class << BAR
    def public_BAR; end
    protected; def protected_BAR; end
    private; def private_BAR; end
  end

  def test_public
    assert_same true, BAR.public_method?(:public_foo)
    assert_same false, BAR.public_method?(:protected_foo)
    assert_same false, BAR.public_method?(:private_foo)
  end

  def test_public_with_string_name
    assert_same true, BAR.public_method?('public_foo')
    assert_same false, BAR.public_method?('protected_foo')
    assert_same false, BAR.public_method?('private_foo')
  end

  def test_protected
    assert_same false, BAR.protected_method?(:public_foo)
    assert_same true, BAR.protected_method?(:protected_foo)
    assert_same false, BAR.protected_method?(:private_foo)
  end

  def test_private
    assert_same false, BAR.private_method?(:public_foo)
    assert_same false, BAR.private_method?(:protected_foo)
    assert_same true, BAR.private_method?(:private_foo)
  end

  def test_modified
    assert_same false, BAR.protected_method?(:modified_foobar)
    assert_same true, BAR.private_method?(:modified_foobar)
  end

  def test_public_rejected_parent
    assert_raises NameError do
      Bar.public_method?(:public_foo, false)
    end

    assert_raises NameError do
      Bar.public_method?(:protected_foo, false)
    end

    assert_raises NameError do
      Bar.public_method?(:private_foo, false)
    end
  end

  def test_protected_rejected_parent
    assert_raises NameError do
      Bar.protected_method?(:public_foo, false)
    end

    assert_raises NameError do
      Bar.protected_method?(:protected_foo, false)
    end

    assert_raises NameError do
      Bar.protected_method?(:private_foo, false)
    end
  end

  def test_private_rejected_parent
    assert_raises NameError do
      Bar.private_method?(:public_foo, false)
    end

    assert_raises NameError do
      Bar.private_method?(:protected_foo, false)
    end

    assert_raises NameError do
      Bar.private_method?(:private_foo, false)
    end
  end

  def test_public_singleton
    assert_same true, BAR.public_method?(:public_BAR)
    assert_same false, BAR.public_method?(:protected_BAR)
    assert_same false, BAR.public_method?(:private_BAR)
  end

  def test_protected_singleton
    assert_same false, BAR.protected_method?(:public_BAR)
    assert_same true, BAR.protected_method?(:protected_BAR)
    assert_same false, BAR.protected_method?(:private_BAR)
  end

  def test_private_singleton
    assert_same false, BAR.private_method?(:public_BAR)
    assert_same false, BAR.private_method?(:protected_BAR)
    assert_same true, BAR.private_method?(:private_BAR)
  end

end


class Test_VisibilityPredicates_README < Test::Unit::TestCase

  class Foo
    private; def modified_foobar; end
  end

  class Bar < Foo
    protected :modified_foobar
  end

  def test_overview
    assert_same false, Bar.new.public_method?(:modified_foobar)
    assert_same true, Bar.new.protected_method?(:modified_foobar)
    assert_same false, Bar.new.private_method?(:modified_foobar)
  end

end