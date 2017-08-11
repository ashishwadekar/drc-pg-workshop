require 'rails_helper'

RSpec.describe RestaurantBranch, type: :model do
  describe "#add_menu_item" do
    let(:restaurant) { create(:restaurant) }
    let(:branch) { create(:branch, restaurant: restaurant) }
    let(:menu_item_name) { Faker::Food.dish }
    let(:menu_item_attributes) do
      {
        name: Faker::Food.dish,
        description: Faker::Hipster.paragraph(2, false),
        price: Faker::Commerce.price,
      }
    end

    context "when the menu item does not exist" do
      it "adds the menu item to the branch" do
        expect {
          branch.add_menu_item(menu_item_attributes)
        }.to change {
          branch.menu_items.count
        }.by(1)
      end
    end

    context "when the menu item already exists" do
      it "adds the menu item to the branch" do
        branch.add_menu_item(menu_item_attributes)
        expect(MenuItem.where(name: menu_item_attributes[:name]).count).to eq(1)

        expect {
          branch.add_menu_item(menu_item_attributes)
        }.to raise_error(ActiveRecord::StatementInvalid) # fails constraint

        expect(MenuItem.where(name: menu_item_attributes[:name]).count).to eq(1)
      end
    end
  end
end
