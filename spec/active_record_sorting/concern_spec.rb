require 'spec_helper'

describe ActiveRecordSorting::Concern do
  let(:scope) { double }

  context 'custom sorting class exists' do
    subject { User }
    let(:sorting_class) { UserSorting }

    it 'should delegate sorting to sorting class' do
      expected_to_sort_with 'name_asc', sorting_class
    end
  end

  context 'custom sorting class doesnt exists' do
    subject { Group }
    let(:sorting_class) { ActiveRecordSorting::Base }

    it 'should delegate sorting to base sorting class' do
      expected_to_sort_with 'name_asc', sorting_class
    end
  end

  context 'use scopes' do
    subject { Group.where(name: 'Lorem') }
    let(:sorting_class) { ActiveRecordSorting::Base }

    it 'should delegate sorting to base sorting class' do
      expected_to_sort_with 'name_asc', sorting_class
    end
  end

  private

  def expected_to_sort_with(order, sorting_class)
    expect(sorting_class).to receive(:new).with(subject).and_call_original
    expect_any_instance_of(sorting_class).
      to receive(:sort).with(order).and_return scope

    expect(subject.sort(order)).to eq scope
  end
end
