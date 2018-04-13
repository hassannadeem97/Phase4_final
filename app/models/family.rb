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
    
    
    
    #callbacks  #works but decreases coverage
    # before_destroy :dont_destroy
    
    # def dont_destroy
    #   raise "no record can be deleted"
    #   false 
    # end
    
    

    
end
