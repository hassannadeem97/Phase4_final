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
      create_users
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
    
    should "validating before save callback for making sure a user corresponding an inactive instructor is inactive" do
    @user101 = FactoryBot.create(:user, username: "Paheimann", role: "instructor", email: "parkaaa@example.com", phone: "1234567890", password: "abcdefg", password_confirmation: "abcdefg")
    @ins101 = FactoryBot.create(:instructor, first_name: "plex", bio: nil, user: @user101)
    assert_equal true, @user101.active
    assert_equal true, @ins101.active
    @ins101.update_attributes(:active => false)
    assert_equal false, @ins101.active
    assert_equal false, @user101.active
    end
    
    should "validating before destroy callback for making sure when an instructor can be destroyed" do
    @user103 = FactoryBot.create(:user, username: "laheimann", role: "instructor", email: "larkaaa@example.com", phone: "1234567890", password: "abcdefg", password_confirmation: "abcdefg")
    @ins103 = FactoryBot.create(:instructor, first_name: "lex", bio: nil, user: @user103)
    @end   = FactoryBot.create(:curriculum, name: "End", min_rating: 700, max_rating: 1500)
    @north1 = FactoryBot.create(:location, name: "North Side 1", street_1: "801111 Union Place", street_2: nil, city: "Pittsburgh", zip: "15312")
    @camp202 = FactoryBot.create(:camp, curriculum: @end, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,27), location: @north1)
    @cam_ins = FactoryBot.create(:camp_instructor, instructor: @ins103, camp: @camp202)
    
    @ins103.destroy
    assert_equal true, @ins103.destroyed?
    assert_equal true, @user103.destroyed?
    
    end
    
    should "validating before destroy callback for making sure when an instructor cannot be destroyed" do
    @user103 = FactoryBot.create(:user, username: "laheimann", role: "instructor", email: "larkaaa@example.com", phone: "1234567890", password: "abcdefg", password_confirmation: "abcdefg")
    @ins103 = FactoryBot.create(:instructor, first_name: "lex", bio: nil, user: @user103)
    @end   = FactoryBot.create(:curriculum, name: "End", min_rating: 700, max_rating: 1500)
    @north1 = FactoryBot.create(:location, name: "North Side 1", street_1: "801111 Union Place", street_2: nil, city: "Pittsburgh", zip: "15312")
    @camp202 = FactoryBot.create(:camp, curriculum: @end, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,27), location: @north1)
    @camp202.update_attributes(:start_date => Date.new(2017,7,3), :end_date => Date.new(2017,7,7))
    @camp203 = FactoryBot.create(:camp, curriculum: @end, start_date: Date.new(2018,7,29), end_date: Date.new(2018,7,30), location: @north1)
    @cam_ins = FactoryBot.create(:camp_instructor, instructor: @ins103, camp: @camp202)
    @cam_ins1 = FactoryBot.create(:camp_instructor, instructor: @ins103, camp: @camp203)
    assert_equal true, @ins103.active
    @ins103.destroy
    assert_equal false, @ins103.destroyed?
    assert_equal false, @ins103.active
    assert_equal false, @user103.active
    assert_equal 1, @ins103.camp_instructors.count
    
    
    end

  end
end
