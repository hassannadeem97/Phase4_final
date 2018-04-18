require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should have_one(:instructor)
  should have_one(:family)
  should have_secure_password
  
  should validate_presence_of(:username)
  should validate_presence_of(:password)
  should validate_presence_of(:password_digest)
  should validate_presence_of(:email)
  should validate_presence_of(:role)
  should validate_uniqueness_of(:username)
  should validate_uniqueness_of(:email).case_insensitive
  should validate_uniqueness_of(:username).case_insensitive
  should validate_length_of(:password).is_at_least(4)
  should validate_presence_of(:password_confirmation)
  
   # Validating email...
  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  # Validating phone...
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)
  
  # Validating role
  should allow_value("admin").for(:role)
  should allow_value("instructor").for(:role)
  should allow_value("parent").for(:role)
  
  
  should_not allow_value("bad").for(:role)
  should_not allow_value("admin-instructor").for(:role)
  should_not allow_value("admin;;;;;").for(:role)
  should_not allow_value("instructor,admin").for(:role)
  should_not allow_value("admin;instructor").for(:role)
  
  # set up context
  context "Within context" do
    setup do 
      create_users
    end
    
    teardown do
      delete_users
    end
    
    
    should "validating before callback" do
    @user100 = FactoryBot.build(:user, username: "maheimann", role: "instructor", email: "markaaa@example.com", phone: "1234567890", password: "abcdefg", password_confirmation: "awqefrg")
    assert_raise RuntimeError do
      @user100.check_password
    end
    @user100.password = "12345"
    @user100.password_confirmation = "12345"
    @user100.save!
    assert_nil nil, @user100.password 
    end
    
    
  end 
end
