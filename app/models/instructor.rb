class Instructor < ApplicationRecord
  # relationships
  has_many :camp_instructors
  has_many :camps, through: :camp_instructors
  belongs_to :user
  
  attr_accessor :check_destroy

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
  before_destroy :check_camp
  after_rollback :delete_upcoming_camps #so when I tried destroying the upcoming camps the instructor was assigned 
  #to in the check_camp callback it did not happen because the error raised just rollbacked any transactions that took place. so what i did here
  #is that when the instructor can't be destroyed since he has taught in a past camp an error is raised. when this error is raised ActiveRecord 
  #raises a rollback. So i created a new variable known as check_destroy which becomes the id of that instructor when the error is raised and then i see in my rollback
  #callback if check_destroy is equal to self.id (and also the rollback callback checks if a rollback occured) then i destroy the camp_instructors corresponding
  #to the instructor whose id was saved and also make the instructor inactive and its user inactive
  
    
    def check_camp
        check = true
        self.camps.map do |c|
            if c.end_date < Date.today
                check = false 
            end 
        end
        
        if check == false
          self.check_destroy = self.id
          errors.add(:base,"Can't destroy this instructor")
          throw(:abort)
          
          
        else 
          self.user.destroy
        end
        
    end
    
    
    
    def check_active
        if self.active == false
            self.user.active = false
        end 
    end
    
    def delete_upcoming_camps
      if self.check_destroy == self.id
        self.check_destroy = nil
        self.check_destroy = false
        self.active = false
        self.user.active = false
        self.camp_instructors.each {|c|  c.destroy if c.camp.start_date >= Date.today}
      end 
    end 
  
  

end
