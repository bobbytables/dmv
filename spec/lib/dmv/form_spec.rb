require 'spec_helper'

RSpec.describe DMV::Form do
  let(:form_class) { Class.new(described_class) }

  describe '.middleware' do
    it 'returns a Middleware::Builder object' do
      expect(form_class.middleware).to be_kind_of(DMV::Middleware)
    end

    context 'inheritance' do
      let(:parent_class) { form_class }
      let(:child_class) { Class.new(parent_class) }

      it 'does not screw with the parent classes middleware' do
        parent_class.middleware.use Proc.new { |env| }
        child_class.middleware.use Proc.new { |env| }

        expect(parent_class.middleware.stack.length).to be(1)
      end
    end
  end

  describe '.attribute' do
    it 'adds the attribute to the attribute set' do
      form_class.attribute :bunk_attr

      expect(form_class._attributes.length).to be(1)
    end

    it 'raises an exception if the attribute is already defined' do
      form_class.attribute :bunk_attr
      expect { form_class.attribute :bunk_attr }.to raise_error(DMV::AttributeAlreadyDefined)
    end

    it 'can set multiple attributes in one call' do
      form_class.attribute :hello, :world
      expect(form_class._attributes.length).to be(2)
    end

    it 'defaults the options on the attribute to an empty hash' do
      form_class.attribute :bunk
      expect(form_class._attributes[:bunk]).to eq({})
    end

    it 'sets the options hash passed in to the attribute being set' do
      form_class.attribute :bunk, hello: 'world'
      expect(form_class._attributes[:bunk]).to eq(hello: 'world')
    end

    it 'creates accessors for the attributes' do
      form_class.attribute :bunk
      form = form_class.new
      expect(form).to respond_to(:bunk).and respond_to(:bunk=)
    end
  end

  describe '.attributes' do
    before { form_class.attribute :hello, :world }

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
    before { form_class.attribute :bunk, :foo }

    context 'with a hash as the first argument' do
      it 'sets the attributes to the corresponding values' do
        form = form_class.new(bunk: 'hello', foo: 'world')

        expect(form.bunk).to eq('hello')
        expect(form.foo).to eq('world')
      end
    end
  end

  describe 'Accessors' do
    subject(:form) { form_class.new }

    before { form_class.attribute :bunk }

    describe '#set' do
      it 'sets the value of the attribute' do
        form.set(:bunk, 'testing123')

        expect(form.bunk).to eq('testing123')
      end
    end

    describe '#get' do
      it 'gets the value for an attribute' do
        form.set(:bunk, 'bunkfoo')

        expect(form.get(:bunk)).to eq('bunkfoo')
      end
    end
  end
end