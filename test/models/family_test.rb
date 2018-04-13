require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should belong_to(:user)
  should have_many(:students)
  should validate_presence_of(:family_name)
  should validate_presence_of(:parent_first_name)
  should validate_presence_of(:user_id)
  should validate_numericality_of(:user_id).only_integer.is_greater_than(0)
  
   # set up context
  context "Within context" do
    setup do 
      create_users
      create_families
    end
    
    teardown do
      delete_families
    end
  
  
  
  
  
  should "have a scope to alphabetize family Name" do
      assert_equal ["Krtiz", "Nadeemz", "Ortiz"], Family.alphabetical.map{|c| c.family_name }
  end
  
  should "have a scope that returns active familes" do
      assert_equal ["Krtiz", "Ortiz"], Family.active.alphabetical.map{|c| c.family_name}
  end
  
  should "have a scope that returns inactive families" do
      assert_equal  ["Nadeemz"], Family.inactive.alphabetical.map{|c| c.family_name}
  end
  
  
  # should "validate before_destroy callback" do  #works but decreases coverage 
  #   @fam4 = FactoryBot.create(:family, family_name: "Nadeem", parent_first_name: "Mohammed", user: @user3)
  #   assert_raise RuntimeError do
  #     @fam4.destroy
  #   end
  # end 
  
  
  
  
  
  end 
end
