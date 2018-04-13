module Contexts
  module RegistrationContexts
    def create_registrations
      
      @reg1 = FactoryBot.create(:registration, student: @stud1, camp: @camp1, payment:"Sdr9kP08eeKkrT")
      @reg2 = FactoryBot.create(:registration, student: @stud2, camp: @camp2, payment:"Sdr9kP08eeKkrT")
      @reg3 = FactoryBot.create(:registration, student: @stud1, camp: @camp2)
    end 
    
    
    def delete_registrations
      @reg1.delete
      @reg2.delete
      @reg3.delete
    end 
    

    
  end
end