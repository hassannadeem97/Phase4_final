module Contexts
  module FamilyContexts
    def create_families
     
      @fam1 = FactoryBot.create(:family, family_name: "Ortiz", parent_first_name: "Big Papi", user: @user1)
      @fam2 = FactoryBot.create(:family, family_name: "Krtiz", parent_first_name: "Small Papi", user: @user2)
      @fam3 = FactoryBot.create(:family, family_name: "Nadeemz", parent_first_name: "Unknown", user: @user3, active: false)
    end 
    
    
    def delete_families
      @fam1.delete
      @fam2.delete
      @fam3.delete
      delete_users
    end 
  
  end
end