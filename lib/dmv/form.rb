require 'uber/inheritable_attr'

module DMV
  AttributeAlreadyDefined = Class.new(StandardError)

  class Form
    extend Uber::InheritableAttr

    inheritable_attr :_attributes
    self._attributes = Hash.new

    # Adds an attribute to the forms attributes set and creates accessors
    #
    # @param name The name of the attribute
    # @param options [Hash] The options for this attribute (type for example)
    def self.attribute *names
      options = names.last.kind_of?(Hash) ? names.pop : {}

      names.each do |name|
        name = name.to_sym

        if _attributes.keys.include?(name)
          raise AttributeAlreadyDefined, "the attribute #{name} has already been defined"
        end

        _attributes[name] = options.freeze
        attr_accessor name
      end
    end

    # Returns a cloned frozen hash containing the details of the
    # attributes on this form
    #
    # @return Hash (frozen)
    def self.attributes
      _attributes.clone.freeze
    end

    # Initialize a new form instance from values
    #
    # @param attributes A hash of attributes to be set
    def initialize attributes = {}
      attributes.each do |attribute, value|
        send("#{attribute}=", value)
      end
    end
  end
end