require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should belong_to(:camp)
  should belong_to(:student)

  # test validations
  should validate_presence_of(:camp_id)
  should validate_presence_of(:student_id)
  should validate_numericality_of(:camp_id).only_integer.is_greater_than(0)
  should validate_numericality_of(:student_id).only_integer.is_greater_than(0)
  
  # Validating credit_card_number
  should allow_value(5123456789012345).for(:credit_card_number)
  should allow_value(6512345678901234).for(:credit_card_number)
  should allow_value(30012345678901).for(:credit_card_number)
  should allow_value(30312345678901).for(:credit_card_number)
  should allow_value(5412345678901234).for(:credit_card_number)
  
  should_not allow_value(1123456789012345).for(:credit_card_number)
  should_not allow_value(5623456789012345).for(:credit_card_number)
  should_not allow_value(6001123456789012).for(:credit_card_number)
  should_not allow_value(351234567890123).for(:credit_card_number)
  should_not allow_value(6612345678901234).for(:credit_card_number)

  
  
  # set up context
  context "Within context" do
    setup do 
      create_users
      create_families
      create_students
      create_curriculums
      create_active_locations
      create_camps
      create_registrations
    end
    
    teardown do
      delete_registrations
    end
    
    should "not allow a student to assigned an inactive camp" do
      bad_assignment = FactoryBot.build(:registration, student: @stud1, camp: @camp3, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
      deny bad_assignment.valid?
    end

    should "not allow an inactive student to assigned to a camp" do
      bad_assignment = FactoryBot.build(:registration, student: @stud3, camp: @camp4, credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
      deny bad_assignment.valid?
    end
    
    
    should "have a scope to alphabetize registrations by student last_name, first_name" do
      assert_equal ["Russo, Alex", "Russo, Alex", "Russo, Max"], Registration.alphabetical.map{|c| c.name}
    end
    
    should "have a scope for_camp which return all registrations for a specified camp" do
      assert_equal [2, 3], Registration.for_camp(@camp2).map(&:id)
    end
    
    should "have a validation that checks the expiry date of the credit card" do
      @r = FactoryBot.build(:registration, student: @stud2, camp: @camp1, payment:"Sdr9kP08eeKkrT", credit_card_number: 341234567890123, expiration_month: 11, expiration_year: 2017)
      assert_equal ["Expiry date is invalid"], @r.expiry_date
    end 
    
    should "have a validation that checks the expiry date of the credit card again" do
      @r = FactoryBot.build(:registration, student: @stud2, camp: @camp1, payment:"Sdr9kP08eeKkrT", credit_card_number: 341234567890123, expiration_month: 01, expiration_year: 2018)
      assert_equal ["Expiry date is invalid"], @r.expiry_date
    end 
    
    should "have a validation that checks the expiry date of the credit card once again but in this case the date is valid" do
      @r = FactoryBot.build(:registration, student: @stud2, camp: @camp1, payment:"Sdr9kP08eeKkrT", credit_card_number: 341234567890123, expiration_month: 11, expiration_year: 2018)
      assert_nil nil, @r.expiry_date
    end 
    
    
    should "have a method that returns the type of credit card being used" do
      @r = FactoryBot.create(:registration, student: @stud2, camp: @camp1, payment:"Sdr9kP08eeKkrT", credit_card_number: 341234567890123, expiration_month: 11, expiration_year: 2018)
      @r1 = FactoryBot.build(:registration, student: @stud2, camp: @camp1, payment:"Sdr9kP08eeKkrT", credit_card_number: 5123456789012345, expiration_month: 11, expiration_year: 2018)
      @r2 = FactoryBot.build(:registration, student: @stud2, camp: @camp1, payment:"Sdr9kP08eeKkrT", credit_card_number: 30012345678901, expiration_month: 11, expiration_year: 2018)
      assert_equal "Amex", @r.credit_card_number_check
      assert_equal "Visa Card", @reg3.credit_card_number_check
      assert_equal "Amex", @reg1.credit_card_number_check
      assert_equal "Discovery Card", @reg2.credit_card_number_check
      assert_equal "Master Card", @r1.credit_card_number_check
      assert_equal "Diners Club", @r2.credit_card_number_check
    end
    
    should "have a method that returns the type of credit card being used this is an additional method" do
      @r1 = FactoryBot.build(:registration, student: @stud2, camp: @camp1, payment:"Sdr9kP08eeKkrT", credit_card_number: 34123450000690123, expiration_month: 11, expiration_year: 2018)
      assert_equal "credit card number invalid", @r1.credit_card_number_check
    end
    
    should "have a method that returns the payment receipt" do
      @camp21 = FactoryBot.create(:camp, curriculum: @tactics, start_date: Date.new(2018,7,29), end_date: Date.new(2018,7,30), location: @cmu, cost:1000)
      @r22 = FactoryBot.create(:registration, student: @stud2, camp: @camp21,  credit_card_number: 371234567890123, expiration_month: 11, expiration_year: 2018)
      @r22.pay
      assert_equal @r22.payment, @r22.payment
      assert_equal false, @r22.pay
    end
    
    should "have a test for the custom validation rating" do 
      @stud4 = FactoryBot.build(:student, first_name: "Justin", last_name: "Musso", family: @fam1, date_of_birth: Date.new(1990,01,01), rating: 0)
      @reg= FactoryBot.build(:registration, student: @stud4, camp: @camp4,  credit_card_number: 371234567890123, expiration_month: 11, expiration_year: 2018)
      assert_equal ["rating is invalid"], @reg.rating
      @stud4.update_attribute(:rating, 700)
      assert_nil nil, @reg.rating
    end 
    
    
    
    
  
  
  end 
end
