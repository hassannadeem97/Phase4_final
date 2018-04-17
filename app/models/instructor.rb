class Instructor < ApplicationRecord
  # relationships
  has_many :camp_instructors
  has_many :camps, through: :camp_instructors
  belongs_to :user

  # validations
  validates_presence_of :first_name, :last_name
  validates :user_id, presence: true, numericality: { greater_than: 0, only_integer: true }

  # scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :needs_bio, -> { where('bio IS NULL') }
  # scope :needs_bio, -> { where(bio: nil) }  # this also works...

  # class methods
  def self.for_camp(camp)
    # the 'instructive way'... (which I told you if you asked me for help)
    CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
    # the easy way... 
    # camp.instructors
  end

  
  

  # instance methods
  def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end
  
  #callback
  before_save :check_active
  # before_destroy :check_camp #not working properly for now 
    
  #   def check_camp
  #       check = true
  #       self.camps.map do |c|
  #           if c.end_date < Date.today
  #               check = false 
  #           end 
  #       end
        
  #       if check == false
  #           self.active = false
  #           self.user.active = false
  #           self.camp_instructors.each do |c| 
  #             if c.camp.start_date >= Date.today
  #                 c.destroy
  #             end 
  #           end
  #           raise "Can't destroy this instructor"
  #       else 
  #         self.user.destroy
  #       end
        
  #   end
    
    
    
    def check_active
        if self.active == false
            self.user.active = false
        end 
    end 
  
  

end
