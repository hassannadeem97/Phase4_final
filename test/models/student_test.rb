require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  should belong_to(:family)
  should have_many(:registrations)
  should have_many(:camps).through(:registrations)
  
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:family_id)
  should validate_numericality_of(:family_id).only_integer.is_greater_than(0)
  
  should allow_value(1000).for(:rating)
  should allow_value(100).for(:rating)
  should allow_value(2872).for(:rating)
  should allow_value(0).for(:rating)

  should_not allow_value(3001).for(:rating)
  should_not allow_value(-1).for(:rating)
  should_not allow_value(500.50).for(:rating)
  should_not allow_value("bad").for(:rating)
  
  
  
  
  # set up context
  context "Within context" do
    setup do
      create_users
      create_families
      create_students
      create_locations 
      create_curriculums
      create_camps
      
    end
    
    teardown do
      delete_students
    end
    
    
  
  should "have a scope to alphabetize Student Names" do
      assert_equal ["Russo, Alex", "Russo, Justin", "Russo, Max"], Student.alphabetical.map{|c| c.name}
  end
  
  should "have a scope that returns active students" do
      assert_equal ["Alex", "Max"], Student.active.alphabetical.map{|c| c.first_name}
  end
  
  should "have a scope that returns inactive students" do
      assert_equal  ["Justin"], Student.inactive.alphabetical.map{|c| c.first_name}
  end
  
  should "have a scope for checking below_rating" do
      assert_equal 3, Student.below_rating(1000).size
  end
  
  should "have a scope for checking at_or_above_rating rating" do
      assert_equal 0, Student.at_or_above_rating(1000).size
  end
  
  should "have name methods that list first_ and last_names combined" do
      assert_equal "Alex Russo", @stud1.proper_name
      assert_equal "Max Russo", @stud2.proper_name
      assert_equal "Justin Russo", @stud3.proper_name
  end
    
  should "have name methods that list last_name, first_name combined" do
      assert_equal "Russo, Alex", @stud1.name
      assert_equal "Russo, Max", @stud2.name
      assert_equal "Russo, Justin", @stud3.name
  end
  
  should "have name method give age of a student that " do
      assert_equal 25, @stud1.age
      assert_equal 21, @stud2.age
      assert_equal 28, @stud3.age
  end
  
  should "validating the check_rating before callback" do
    @stud4 = FactoryBot.build(:student, first_name: "Justin", last_name: "Musso", family: @fam1, date_of_birth: Date.new(1990,01,01), rating: nil, active: false)
    @stud4.check_rating
    @stud4.save!
    assert_equal 0, @stud4.rating
  end
  
  should "validate before update callback for checking upcoming registration" do  
    @stud4 = FactoryBot.create(:student, first_name: "Justin", last_name: "Musso", family: @fam2, date_of_birth: Date.new(1990,01,01), rating: 700)
    @reg = FactoryBot.create(:registration, camp: @camp2, student: @stud4, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    @reg1 = FactoryBot.create(:registration, camp: @camp1, student: @stud4, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    assert_equal true, @stud4.active
    @stud4.update_attribute(:active, false)
    assert_equal false, @stud4.active
    assert_equal 0, @stud4.registrations.count
  end
  
  
   should "validate before destroy callback for checking upcoming registration" do  
    @stud4 = FactoryBot.create(:student, first_name: "Justin", last_name: "Musso", family: @fam2, date_of_birth: Date.new(1990,01,01), rating: 700, active: true)
    @reg = FactoryBot.create(:registration, camp: @camp2, student: @stud4, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    @reg1 = FactoryBot.create(:registration, camp: @camp1, student: @stud4, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    @camp2.update_attributes(:start_date => Date.new(2017,7,3), :end_date => Date.new(2017,7,7))
    assert_equal true, @stud4.active
    @stud4.destroy
    assert_equal false, @stud4.active
    assert_equal false, @stud4.destroyed?
  end
  
  should "validate before destroy callback for checking if the upcoming registrations were destroyed if the student can be deleted" do  
    @stud4 = FactoryBot.create(:student, first_name: "Justin", last_name: "Musso", family: @fam2, date_of_birth: Date.new(1990,01,01), rating: 700, active: true)
    @reg = FactoryBot.create(:registration, camp: @camp2, student: @stud4, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    @reg1 = FactoryBot.create(:registration, camp: @camp1, student: @stud4, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    assert_equal true, @stud4.active
    @stud4.destroy
    assert_equal true, @stud4.destroyed?
    assert_equal 0, @stud4.registrations.count
  end 
  
   
   
  
   
    
    
  
  end 
end
