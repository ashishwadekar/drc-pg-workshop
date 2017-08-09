require 'rails_helper'

RSpec.describe Wizard, type: :model do
  describe "factory" do
    context "name validations" do
      context "when a name is provided" do
        it "returns true" do
          expect(build(:wizard).valid?).to be true
        end

        it "does not raise en error when trying to save" do
          expect { create(:wizard) }.to_not raise_error
        end

        it "does not raise a Not Null error when trying to save without validations" do
          wizard = build(:wizard)
          expect { wizard.save(validate: false) }.to_not raise_error
        end
      end

      context "when a name is not provided" do
        it "returns false" do
          expect(build(:wizard, name: nil).valid?).to be false
        end

        it "raises en error when trying to save" do
          expect { create(:wizard, name: nil) }.to raise_error(ActiveRecord::RecordInvalid)
        end

        it "raises a Not Null error when trying to save without validations" do
          wizard = build(:wizard, name: nil)
          expect { wizard.save(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
        end
      end
    end
  end
end
