require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:camps)

  # test validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive

  should allow_value(1000).for(:min_rating)
  should allow_value(100).for(:min_rating)
  should allow_value(2872).for(:min_rating)
  should allow_value(0).for(:min_rating)

  should_not allow_value(nil).for(:min_rating)
  should_not allow_value(3001).for(:min_rating)
  should_not allow_value(50).for(:min_rating)
  should_not allow_value(-1).for(:min_rating)
  should_not allow_value(500.50).for(:min_rating)
  should_not allow_value("bad").for(:min_rating)

  should allow_value(1000).for(:max_rating)
  should allow_value(100).for(:max_rating)
  should allow_value(2872).for(:max_rating)

  should_not allow_value(nil).for(:max_rating)
  should_not allow_value(3001).for(:max_rating)
  should_not allow_value(50).for(:max_rating)
  should_not allow_value(-1).for(:max_rating)
  should_not allow_value(500.50).for(:max_rating)
  should_not allow_value("bad").for(:max_rating)

    # test that max greater than min rating
  should "shows that max rating is greater than min rating" do
    bad = FactoryBot.build(:curriculum, name: "Bad curriculum", min_rating: 500, max_rating: 500)
    very_bad = FactoryBot.build(:curriculum, name: "Very bad curriculum", min_rating: 500, max_rating: 450)
    deny bad.valid?
    deny very_bad.valid?
  end

  context "Within context" do
    # create the objects I want with factories
    setup do 
      create_curriculums
      create_users
      create_families
      create_students
    end
    
    # and provide a teardown method as well
    teardown do
      delete_students
      delete_families
      delete_users
      delete_curriculums
      
    end

    # test the scope 'alphabetical'
    should "shows that there are three curriculums in in alphabetical order" do
      assert_equal ["Endgame Principles", "Mastering Chess Tactics", "Smith-Morra Gambit"], Curriculum.alphabetical.all.map(&:name), "#{Curriculum.class}"
    end
    
    # test the scope 'active'
    should "shows that there are two active curriculums" do
      assert_equal 2, Curriculum.active.size
      assert_equal ["Endgame Principles", "Mastering Chess Tactics"], Curriculum.active.all.map(&:name).sort, "#{Curriculum.methods}"
    end
    
    # test the scope 'active'
    should "shows that there is one inactive curriculum" do
      assert_equal 1, Curriculum.inactive.size
      assert_equal ["Smith-Morra Gambit"], Curriculum.inactive.all.map(&:name).sort
    end

    # test the scope 'for_rating'
    should "shows that there is a working for_rating scope" do
      assert_equal 1, Curriculum.for_rating(1400).size
      assert_equal ["Mastering Chess Tactics","Smith-Morra Gambit"], Curriculum.for_rating(600).all.map(&:name).sort
    end
    
    should "validate before_destroy callback" do   
      @pal = FactoryBot.create(:curriculum, name: "The Tactics of Pal", min_rating: 150, max_rating: 1200, description: "All about the tacicts of Pal.")
      @pal.destroy
      assert_equal false, @pal.destroyed?
    end
    
    
    should "validating before update callback for making sure a curriculum corresponding to an upcoming camp with registrations cant be made inactive" do
    @end   = FactoryBot.create(:curriculum, name: "End", min_rating: 700, max_rating: 1500)
    @north1 = FactoryBot.create(:location, name: "North Side 1", street_1: "801111 Union Place", street_2: nil, city: "Pittsburgh", zip: "15312")
    @camp202 = FactoryBot.create(:camp, curriculum: @end, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,27), location: @north1)
    @reg1 = FactoryBot.create(:registration, student: @stud1, camp: @camp202, payment:"Sdr9kP08eeKkrT", credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    @end.update_attributes(:active => false)
    assert_equal true, @end.active
    end
    
    should "validating before update callback for making sure a curriculum corresponding to upcoming with no registrations can be made inactive" do
    @end   = FactoryBot.create(:curriculum, name: "End", min_rating: 700, max_rating: 1500)
    @north1 = FactoryBot.create(:location, name: "North Side 1", street_1: "801111 Union Place", street_2: nil, city: "Pittsburgh", zip: "15312")
    @camp202 = FactoryBot.create(:camp, curriculum: @end, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,27), location: @north1)
    @end.update_attributes(:active => false)
    assert_equal false, @end.active 
    end
    
    should "validating before update callback for making sure a curriculum corresponding to a past camp with registration can be made inactive" do
    @end   = FactoryBot.create(:curriculum, name: "End", min_rating: 700, max_rating: 1500)
    @north1 = FactoryBot.create(:location, name: "North Side 1", street_1: "801111 Union Place", street_2: nil, city: "Pittsburgh", zip: "15312")
    @camp202 = FactoryBot.create(:camp, curriculum: @end, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,27), location: @north1)
    @camp202.update_attributes(:start_date => Date.new(2017,7,23), :end_date => Date.new(2017,7,23) )
    @reg1 = FactoryBot.create(:registration, student: @stud1, camp: @camp202, payment:"Sdr9kP08eeKkrT", credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
    @end.update_attributes(:active => false)
    assert_equal false, @end.active 
    end

  end
end
