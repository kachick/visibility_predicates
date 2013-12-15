# coding: us-ascii
# visibility predicates 
#  - Some predicate methods for checking method visibility.
# Copyright (c) 2012 Kenichi Kamiya

# @note
# for 1.8.7 compatibility coding
#   * &to_sym for cast method names
#   * not use define_method for include_inherited=true

class Module

  class << self

    private

    # @param [Symbol, String] visibility
    # @macro [attach] _def_predicator_instance_method_visibility
    #   @method $1_instance_method?(name, include_inherited=true)
    #   @param [Symbol, String, #to_sym] name
    #   @param [Boolean] include_inherited
    #   @return [Boolean]
    def _def_predicator_instance_method_visibility(visibility)
      class_eval %Q{
        def #{visibility}_instance_method?(name, include_inherited=true)
          sym_name = name.to_sym
          public_instance_methods = public_instance_methods(include_inherited).map(&:to_sym)
          protected_instance_methods = protected_instance_methods(include_inherited).map(&:to_sym)
          private_instance_methods = private_instance_methods(include_inherited).map(&:to_sym)
          all_instance_methods = public_instance_methods | protected_instance_methods | private_instance_methods
          unless all_instance_methods.include? sym_name
            raise NameError, "'\#{sym_name}' is not defined method name in any visibilities"
          end

          #{visibility}_instance_methods.include? sym_name
        end
      }
    end

  end

  _def_predicator_instance_method_visibility :public
  _def_predicator_instance_method_visibility :protected
  _def_predicator_instance_method_visibility :private

end


module Kernel

  class << self

    private

    # @param [Symbol, String] visibility
    # @macro [attach] _def_predicator_method_visibility
    #   @method $1_method?(name, include_inherited=true)
    #   @param [Symbol, String, #to_sym] name
    #   @param [Boolean] include_inherited
    #   @return [Boolean]
    def _def_predicator_method_visibility(visibility)
      module_eval %Q{
        def #{visibility}_method?(name, include_inherited=true)
          sym_name = name.to_sym
          public_methods = public_methods(include_inherited).map(&:to_sym)
          protected_methods = protected_methods(include_inherited).map(&:to_sym)
          private_methods = private_methods(include_inherited).map(&:to_sym)
          all_methods = public_methods | protected_methods | private_methods
          unless all_methods.include? sym_name
            raise NameError, "'\#{sym_name}' is not defined method name in any visibilities"
          end

          #{visibility}_methods.include? sym_name
        end
      }
    end

  end

  _def_predicator_method_visibility :public
  _def_predicator_method_visibility :protected
  _def_predicator_method_visibility :private

end