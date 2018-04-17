module Contexts
  module RegistrationContexts
    def create_registrations
      
      @reg1 = FactoryBot.create(:registration, student: @stud1, camp: @camp1, payment:"Sdr9kP08eeKkrT", credit_card_number: 341234567890123, expiration_month: 12, expiration_year: 2018)
      @reg2 = FactoryBot.create(:registration, student: @stud2, camp: @camp2, payment:"Sdr9kP08eeKkrT", credit_card_number: 6512345678901234, expiration_month: 12, expiration_year: 2018)
      @reg3 = FactoryBot.create(:registration, student: @stud1, camp: @camp2, credit_card_number: 4123456789013, expiration_month: 12, expiration_year: 2018)
    end 
    
    
    
    def delete_registrations
      @reg1.delete
      @reg2.delete
      @reg3.delete
    end
  
    

    
  end
end