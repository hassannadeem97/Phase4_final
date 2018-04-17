module Contexts
  module StudentContexts
    def create_students
      
      @stud1 = FactoryBot.create(:student, first_name: "Alex", last_name: "Russo", family: @fam2, date_of_birth: Date.new(1992,07,22), rating: 700)
      @stud2 = FactoryBot.create(:student, first_name: "Max", last_name: "Russo", family: @fam3, date_of_birth: Date.new(1996,06,21), rating: 700)
      @stud3 = FactoryBot.create(:student, first_name: "Justin", last_name: "Russo", family: @fam1, date_of_birth: Date.new(1990,01,01), rating: 700, active: false)
    
    end 
    
    
    def delete_students
      @stud1.delete
      @stud2.delete
      @stud3.delete
      delete_families
     
    end 
    
  end
end