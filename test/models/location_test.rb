require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:camps)

  # test validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive
  should validate_presence_of(:street_1)
  should validate_presence_of(:zip)
  should validate_presence_of(:max_capacity)

  should allow_value("03431").for(:zip)
  should allow_value("15217").for(:zip)
  should allow_value("15090").for(:zip)

  should_not allow_value("3431").for(:zip)
  should_not allow_value("152179").for(:zip)
  should_not allow_value("profh").for(:zip)

  should allow_value("PA").for(:state)
  should allow_value("WV").for(:state)
  should allow_value("OH").for(:state)
  should allow_value("CA").for(:state)
  should_not allow_value("bad").for(:state)
  should_not allow_value(10).for(:state)
  
  should allow_value(8).for(:max_capacity)
  should allow_value(100).for(:max_capacity)
  should allow_value(28).for(:max_capacity)
  should_not allow_value(0).for(:max_capacity)
  should_not allow_value(-1).for(:max_capacity)
  should_not allow_value(50.5).for(:max_capacity)
  should_not allow_value("bad").for(:max_capacity)

  # set up context
  context "Within context" do
    setup do 
      create_active_locations
      create_more_curriculums
      create_past_camps
    end
    
    teardown do
      delete_past_camps
      delete_more_curriculums
      delete_active_locations
    end

    should "show that there are two locations in in alphabetical order" do
      assert_equal ["Carnegie Mellon", "North Side"], Location.alphabetical.all.map(&:name)
    end

    should "show that there are two active locations and one inactive location" do
      create_inactive_locations
      assert_equal ["Carnegie Mellon", "North Side"], Location.active.all.map(&:name).sort
      assert_equal ["Squirrel Hill"], Location.inactive.all.map(&:name).sort
      delete_inactive_locations
    end
    
    should "validate before_destroy callback" do  #check once again before submission 
      @cmu.destroy
      assert_equal false, @cmu.destroyed?
    end
    
    
  end
end
