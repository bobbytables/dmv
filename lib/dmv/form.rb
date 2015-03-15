require 'uber/inheritable_attr'

module DMV
  AttributeAlreadyDefined = Class.new(StandardError)

  class Form
    extend Uber::InheritableAttr

    inheritable_attr :_attributes
    self._attributes = Hash.new

    # Adds an attribute to the forms attributes set
    #
    # @param name The name of the attribute
    # @param options [Hash] The options for this attribute (type for example)
    def self.attribute name, options = {}
      name = name.to_sym

      if _attributes.keys.include?(name)
        raise AttributeAlreadyDefined, "the attribute #{name} has already been defined"
      end

      _attributes[name] = options.freeze
    end

    # Returns a cloned frozen hash containing the details of the
    # attributes on this form
    #
    # @return Hash (frozen)
    def self.attributes
      _attributes.clone.freeze
    end
  end
end