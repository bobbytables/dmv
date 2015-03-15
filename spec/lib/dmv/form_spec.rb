require 'spec_helper'

RSpec.describe DMV::Form do
  subject(:form_class) { Class.new(described_class) }

  describe '.attribute' do
    it 'adds the attribute to the attribute set' do
      form_class.attribute :bunk_attr

      expect(form_class._attributes.length).to be(1)
    end

    it 'raises an exception if the attribute is already defined' do
      form_class.attribute :bunk_attr
      expect { form_class.attribute :bunk_attr }.to raise_error(DMV::AttributeAlreadyDefined)
    end
  end

  describe '.attributes' do
    before do
      form_class.attribute :hello
      form_class.attribute :world
    end

    it 'returns all attributes defined on the form' do
      expect(form_class.attributes).to include(
        hello: {}, world: {}
      )
    end

    it 'returns an immutable attributes definition' do
      expect(form_class.attributes).to be_frozen
    end

    it 'does not freeze the private attribute set' do
      expect { form_class.attributes }.to_not change(form_class._attributes, :frozen?)
    end
  end

  describe '#initialize' do

  end
end