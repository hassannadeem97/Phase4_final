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
      create_students
      create_curriculums
      create_locations
      create_camps
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
  
  
  should "validate before_destroy callback" do   
    @fam4 = FactoryBot.create(:family, family_name: "Nadeem", parent_first_name: "Mohammed", user: @user3)
    @fam4.destroy
    assert_equal false, @fam4.destroyed?
  end 
  
  should "validate before_update callback for inactive families" do   
    @stud4 = FactoryBot.create(:student, first_name: "Justin", last_name: "Musso", family: @fam2, date_of_birth: Date.new(1990,01,01), rating: 100)
    @reg = FactoryBot.create(:registration, camp: @camp2, student: @stud4, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    @reg1 = FactoryBot.create(:registration, camp: @camp1, student: @stud4, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    @reg2 = FactoryBot.create(:registration, camp: @camp2, student: @stud1, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    @fam2.update_attributes(:active => false)
    assert_equal 0, @stud4.registrations.count 
    assert_equal 0, @stud1.registrations.count 
    assert_equal false, @fam2.active
    assert_equal false, @user2.active
    
  end 
  
  
  
  
  
  end 
end
