require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:camp_instructors)
  should have_many(:camps).through(:camp_instructors)

  # test validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:user_id)
  should validate_numericality_of(:user_id).only_integer.is_greater_than(0)


  # set up context
  context "Within context" do
    setup do 
      create_instructors
    end
    
    # teardown do
    #   delete_instructors
    # end

    should "show that there are three instructors in alphabetical order" do
      assert_equal ["Alex", "Mark", "Rachel"], Instructor.alphabetical.all.map(&:first_name)
    end

    should "show that there are two active instructors" do
      assert_equal 2, Instructor.active.size
      assert_equal ["Alex", "Mark"], Instructor.active.all.map(&:first_name).sort
    end
    
    should "show that there is one inactive instructor" do
      assert_equal 1, Instructor.inactive.size
      assert_equal ["Rachel"], Instructor.inactive.all.map(&:first_name).sort
    end

    should "show that there are two instructors needing bios" do
      assert_equal 2, Instructor.needs_bio.size
      assert_equal ["Alex", "Rachel"], Instructor.needs_bio.all.map(&:first_name).sort
    end

    should "show that name method works" do
      assert_equal "Heimann, Mark", @mark.name
      assert_equal "Heimann, Alex", @alex.name
    end
    
    should "show that proper_name method works" do
      assert_equal "Mark Heimann", @mark.proper_name
      assert_equal "Alex Heimann", @alex.proper_name
    end

    should "have a class method to give array of instructors for a given camp" do
      # create additional contexts that are needed
      create_curriculums
      create_active_locations
      create_camps
      create_camp_instructors
      assert_equal ["Alex", "Mark"], Instructor.for_camp(@camp1).map(&:first_name).sort
      assert_equal ["Mark"], Instructor.for_camp(@camp4).map(&:first_name).sort
      # remove those additional contexts
      delete_camp_instructors
      delete_curriculums
      delete_active_locations
      delete_camps
    end
    
    should "validating before save callback" do
    @user101 = FactoryBot.create(:user, username: "Paheimann", role: "admin; instructor", email: "parkaaa@example.com", phone: "1234567890", password: "abcdefg", password_confirmation: "abcdefg")
    @ins101 = FactoryBot.build(:instructor, first_name: "plex", bio: nil, user: @user101)
    @ins101.active = false
    @ins101.save!
    assert_equal false, @user101.active
    end

  end
end
