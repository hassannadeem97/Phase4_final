module Contexts
  module UserContexts
    def create_users
      @user1 = FactoryBot.create(:user, username: "mheimann", password: "123456", password_confirmation:"123456", role: "parent", email: "mark@example.com", phone: "1234567890")
      @user2 = FactoryBot.create(:user, username: "aheimann", password: "012345", password_confirmation:"012345", role: "parent", email: "alex@example.com", phone: "1234567809")
      @user3 = FactoryBot.create(:user, username: "hassann", password: "010101", password_confirmation:"010101", role: "parent", email: "hassann@example.com", phone: "0234567890", active: false)
    end 
    
    
    def delete_users
      @user1.delete
      @user2.delete
      @user3.delete
    end 
    
    
    def create_more_users
      @user4 = FactoryBot.create(:user, username: "bheimann", password: "123456", password_confirmation:"123456", role: "instructor", email: "bm@example.com", phone: "1234567890")
      @user5 = FactoryBot.create(:user, username: "cheimann", password: "0123456", password_confirmation:"0123456", role: "instructor", email: "cm@example.com", phone: "1234567809")
      @user6 = FactoryBot.create(:user, username: "bassann", password: "1123456", password_confirmation:"1123456", role: "instructor", email: "bassann@example.com", phone: "0234567890")
      @user7 = FactoryBot.create(:user, username: "dheimann", password: "2123456", password_confirmation:"2123456", role: "instructor", email: "dm@example.com", phone: "1234567890")
      @user8 = FactoryBot.create(:user, username: "eheimann", password: "3123456", password_confirmation:"3123456", role: "instructor", email: "em@example.com", phone: "1234567809")
      @user9 = FactoryBot.create(:user, username: "Eassann", password: "4123456", password_confirmation:"4123456", role: "instructor", email: "Eassann@example.com", phone: "0234567890")
      @user10 = FactoryBot.create(:user, username: "fheimann", password: "5123456", password_confirmation:"5123456", role: "instructor", email: "f@example.com", phone: "1234567890")
      @user11 = FactoryBot.create(:user, username: "gheimann", password: "6123456", password_confirmation:"6123456", role: "instructor", email: "g@example.com", phone: "1234567809")
      @user12 = FactoryBot.create(:user, username: "fassann", password: "7123456", password_confirmation:"7123456", role: "instructor", email: "Fassann@example.com", phone: "0234567890")
      @user13 = FactoryBot.create(:user, username: "oheimann", password: "8123456", password_confirmation:"8123456", role: "instructor", email: "o@example.com", phone: "1234567890")
      @user14 = FactoryBot.create(:user, username: "lheimann", password: "9123456", password_confirmation:"9123456", role: "instructor", email: "l@example.com", phone: "1234567809")
      @user15 = FactoryBot.create(:user, username: "oassann", password: "00123456", password_confirmation:"00123456", role: "instructor", email: "oassann@example.com", phone: "0234567890")
      
    
    end 
  
    def delete_more_users 
      @user4.delete
      @user5.delete
      @user6.delete
      @user7.delete
      @user8.delete
      @user9.delete
      @user10.delete
      @user11.delete
      @user12.delete
      @user13.delete
      @user14.delete
      @user15.delete
      
    end 
  
  end
end