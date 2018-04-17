class Student < ApplicationRecord
    belongs_to :family
    has_many :registrations 
    has_many :camps, through: :registrations 
    
    #validations
    validates :rating, numericality: { only_integer: true }, :inclusion => 0..3000
    validates_presence_of :first_name, :last_name
    validates :family_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    
    #scopes
    scope :alphabetical, -> { order('last_name, first_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :below_rating, ->(ceiling) { where("rating < ? or rating = ?", ceiling, nil) }
    scope :at_or_above_rating, ->(floor) { where("rating >= ? ", floor) }

    
    # instance methods
    def name
        last_name + ", " + first_name
    end
      
    def proper_name
        first_name + " " + last_name
    end
      
    def age
        current = Date.current 
        dob = self.date_of_birth
        age = (((current.year * 100 + current.month) * 100 + current.day) - ((dob.year * 100 + dob.month) * 100 + dob.day))/10000
        age 
    end
    
    
    #call backs
    before_create :check_rating
    before_update :check_upcoming_registrations
    
    
    def check_rating
        if self.rating == nil 
            self.rating = 0
        end 
    end
    
    
    
    def check_upcoming_registrations
        if self.active_changed? == true 
            if self.active_was == true
                self.registrations.map {|r| r.destroy if r.camp.start_date >= Date.today }
            end 
        end
        
        
    end 
    
   
    
    
end
