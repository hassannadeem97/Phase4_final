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
      bad_assignment = FactoryBot.build(:registration, student: @stud1, camp: @camp3)
      deny bad_assignment.valid?
    end

    should "not allow an inactive student to assigned to a camp" do
      bad_assignment = FactoryBot.build(:registration, student: @stud3, camp: @camp4)
      deny bad_assignment.valid?
    end
    
    should "validating before callback" do
    @reg1.encode_payment
    @reg1.save!
    assert_equal @reg1.encode_payment, @reg1.payment 
      
    end
  
  
  end 
end
