require "spec_helper"

RSpec.describe "Property matchers" do
  describe Post do
    describe 'define_property' do
      it { is_expected.to define_property(:title) }
      it { is_expected.to define_property(:description, :String) }
      it { is_expected.to define_property(:published, :Boolean) }

      it { is_expected.not_to define_property(:non_existant, :Boolean) }
    end

    describe 'define_constraint' do
      it { is_expected.to define_constraint(:custom_constraint, :unique) }
      it { is_expected.not_to define_constraint(:comments, :unique) }
    end

    it { is_expected.to track_modifications }
    it { is_expected.to track_creations }
  end

  describe Comment do
    it { is_expected.not_to track_modifications }
    it { is_expected.not_to track_creations }
  end
end

