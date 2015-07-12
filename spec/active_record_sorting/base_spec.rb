require 'spec_helper'

describe ActiveRecordSorting::Base do
  context '.named_sorting_orders' do
    subject { described_class }

    context 'default value' do
      it { expect(subject.sorting_orders).to eq([]) }
    end

    context 'is set' do
      before do
        subject.named_sorting_orders :some_named_order, :some_named_order_2
      end

      it { expect(subject.sorting_orders).to eq [:some_named_order, :some_named_order_2] }
    end
  end

  context '#sort' do
    subject { described_class.new(scope) }
    let(:scope) { User }

    context 'no sorting order' do
      it 'should return scope' do
        expect(subject.sort(nil)).to eq scope
      end
    end

    context 'named sorting order' do
      before do
        described_class.named_sorting_orders :named_order
      end

      let(:new_scope) { double }

      it 'call custom named scope' do
        expect(subject).to receive(:named_order).with('asc').and_return(new_scope)
        expect(subject.sort('named_order_asc')).to eq new_scope
      end
    end

    context 'simple column ordering' do
      let(:new_scope) { double }

      it 'call custom named scope' do
        expect(scope).to receive(:order).with('users.name desc').and_return new_scope
        expect(subject.sort('name_desc')).to eq new_scope
      end
    end

    context 'relation ordering' do
      let(:new_scope) { double }

      it 'call custom named scope' do
        expect(scope).to receive(:includes).with(:group).and_return new_scope
        expect(new_scope).to receive(:order).with('groups.name asc').and_return new_scope
        expect(subject.sort('group.name_asc')).to eq new_scope
      end

      context 'relation doesnt exist' do
        it 'should return scope' do
          expect(subject.sort('unknown_model.name_asc')).to eq scope
        end
      end
    end
  end
end
