require 'spec_helper'

describe ActiveRecordSorting::Concern do
  context 'custom sorting class exists' do
    subject { User }
    let(:scope) { User.where(nil) }
    let(:sorting_class) { UserSorting }

    it 'should delegate sorting to sorting class' do
      expected_to_sort_with 'name_asc', sorting_class, scope
    end
  end

  context 'custom sorting class doesnt exists' do
    subject { Group }
    let(:scope) { Group.where(nil) }
    let(:sorting_class) { ActiveRecordSorting::Base }

    it 'should delegate sorting to base sorting class' do
      expected_to_sort_with 'name_asc', sorting_class, scope
    end
  end

  context 'use scopes' do
    subject { Group.where(name: 'Lorem') }
    let(:scope) { subject }
    let(:sorting_class) { ActiveRecordSorting::Base }

    it 'should delegate sorting to base sorting class' do
      expected_to_sort_with 'name_asc', sorting_class, scope
    end
  end

  private

  def expected_to_sort_with(order, sorting_class, scope)
    expect(sorting_class).to receive(:new).with(scope).and_call_original
    expect_any_instance_of(sorting_class).
      to receive(:sort).with(order).and_return scope

    expect(subject.sort(order)).to eq scope
  end
end
