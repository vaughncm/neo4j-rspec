require "spec_helper"

RSpec.describe "Property matchers" do
  describe Post do
    describe 'define_property' do
      it { is_expected.to define_property(:title) }
      it { is_expected.to define_property(:description, :String) }
      it { is_expected.to define_property(:published, :Boolean, default: false) } # TODO: Should default be required?
      it { is_expected.to define_property(:published, :'Neo4j::Shared::Boolean', default: false) }

      it { is_expected.not_to define_property(:non_existant, :Boolean) }
    end

    describe 'define_constraint' do
      it { is_expected.to define_constraint(:custom_constraint, :unique) }
      it { is_expected.not_to define_constraint(:comments, :unique) }
    end

    it { is_expected.to track_modifications }
    it { is_expected.to track_creations }

    describe 'negative case' do
      context 'invalid type' do
        subject { expect(Post.new).to define_property(:description, :Integer) }

        it 'should fail on invalid property type' do
          expect { subject }.to raise_error RSpec::Expectations::ExpectationNotMetError,
                                            'expected the Post model to have a `Integer` property description'
        end
      end

      context 'invalid default' do
        subject { expect(Post.new).to define_property(:published, :Boolean, default: true) }

        it 'should fail on invalid default' do
          expect { subject }
            .to raise_error RSpec::Expectations::ExpectationNotMetError,
                            'expected the Post model to have a `Boolean` property published' # with default `false`'
        end
      end
    end
  end

  describe Comment do
    it { is_expected.not_to track_modifications }
    it { is_expected.not_to track_creations }
  end

  describe Person do
    it { is_expected.to define_index(:nickname) }
    it { is_expected.to define_index(:reserved) }
  end
end

