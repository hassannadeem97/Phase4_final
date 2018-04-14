module Contexts
  module InstructorContexts
    def create_instructors
      create_users
      @mark   = FactoryBot.create(:instructor, user: @user1 )
      @alex   = FactoryBot.create(:instructor, first_name: "Alex", bio: nil, user: @user2)
      @rachel = FactoryBot.create(:instructor, first_name: "Rachel", bio: nil, active: false, user: @user3)
    end

    def delete_instructors
      @mark.delete
      @alex.delete
      @rachel.delete
      delete_users
    end

    def create_more_instructors
      
      
      create_more_users
      @mike     = FactoryBot.create(:instructor, first_name: "Mike", last_name: "Ferraco", bio: "A stupendous chess player as you have ever seen.", user: @user4)
      @patrick  = FactoryBot.create(:instructor, first_name: "Patrick", last_name: "Dustmann", bio: "A stupendous chess player as you have ever seen.", user: @user5)
      @austin   = FactoryBot.create(:instructor, first_name: "Austin", last_name: "Bohn", bio: "A stupendous chess player as you have ever seen.", user: @user6)
      @nathan   = FactoryBot.create(:instructor, first_name: "Nathan", last_name: "Hahn", bio: "A stupendous chess player as you have ever seen.", user: @user7)
      @ari      = FactoryBot.create(:instructor, first_name: "Ari", last_name: "Rubinstein", bio: "A stupendous chess player as you have ever seen.", user: @user8)
      @seth     = FactoryBot.create(:instructor, first_name: "Seth", last_name: "Vargo", bio: "A stupendous chess player as you have ever seen.", user: @user9)
      @stafford = FactoryBot.create(:instructor, first_name: "Stafford", last_name: "Brunk", bio: "A stupendous chess player as you have ever seen.", user: @user10)
      @brad     = FactoryBot.create(:instructor, first_name: "Brad", last_name: "Hess", bio: "A stupendous chess player as you have ever seen.", user: @user11)
      @ripta    = FactoryBot.create(:instructor, first_name: "Ripta", last_name: "Pasay", bio: "A stupendous chess player as you have ever seen.", user: @user12)
      @jon      = FactoryBot.create(:instructor, first_name: "Jon", last_name: "Hersh", bio: "A stupendous chess player as you have ever seen.", user: @user13)
      @ashton   = FactoryBot.create(:instructor, first_name: "Ashton", last_name: "Thomas", bio: "A stupendous chess player as you have ever seen.", user: @user14)
      @noah     = FactoryBot.create(:instructor, first_name: "Noah", last_name: "Levin", bio: "A stupendous chess player as you have ever seen.", user: @user15)
    end

    def delete_more_instructors
      @mike.delete
      @patrick.delete
      @austin.delete
      @nathan.delete
      @ari.delete
      @seth.delete
      @stafford.delete
      @brad.delete
      @ripta.delete
      @jon.delete
      @ashton.delete
      @noah.delete
      delete_more_users
    end
  end
end