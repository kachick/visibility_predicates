# coding: us-ascii
# visibility predicates 
#  - Some predicate methods for checking method visibility.
# Copyright (c) 2012 Kenichi Kamiya

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
      define_method :"#{visibility}_instance_method?" do |name, include_inherited=true|
        sym_name = name.to_sym
        public_instance_methods = public_instance_methods(include_inherited)
        protected_instance_methods = protected_instance_methods(include_inherited)
        private_instance_methods = private_instance_methods(include_inherited)
        all_instance_methods = public_instance_methods | protected_instance_methods | private_instance_methods
        unless all_instance_methods.include? sym_name
          raise NameError, "'\#{sym_name}' is not defined method name in any visibilities"
        end

        __send__(:"#{visibility}_instance_methods").include? sym_name
      end
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
      define_method :"#{visibility}_method?" do |name, include_inherited=true|
        sym_name = name.to_sym
        public_methods = public_methods(include_inherited)
        protected_methods = protected_methods(include_inherited)
        private_methods = private_methods(include_inherited)
        all_methods = public_methods | protected_methods | private_methods
        unless all_methods.include? sym_name
          raise NameError, "'\#{sym_name}' is not defined method name in any visibilities"
        end

        __send__(:"#{visibility}_methods").include? sym_name
      end
    end

  end

  _def_predicator_method_visibility :public
  _def_predicator_method_visibility :protected
  _def_predicator_method_visibility :private

end