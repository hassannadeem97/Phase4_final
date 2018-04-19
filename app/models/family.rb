class Family < ApplicationRecord
    belongs_to :user
    has_many :students
    
    #validation 
    validates_presence_of :family_name, :parent_first_name 
    validates :user_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    
    
    #scopes
    scope :alphabetical, -> { order('family_name, parent_first_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    
    
    
    #callbacks  
    before_destroy :dont_destroy #this is for the no.4 specification
    before_update :check_upcoming_registrations #this is for the no.5 specification
    
    def dont_destroy
      errors.add(:family,"can't destroy any record")
      throw(:abort)
      
    end
    
    def check_upcoming_registrations
      if self.active_changed? == true
        if self.active_was == true
          self.user.update_attributes(:active => false)
          self.students.map do |s|
            s.registrations.map {|r| r.destroy if r.camp.start_date >= Date.today }
            
          end 
        end 
      end
    end 
    
    

    
end
