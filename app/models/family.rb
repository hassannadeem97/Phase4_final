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
    before_destroy :dont_destroy
    
    def dont_destroy
      errors.add(:family,"can't destroy any record")
      throw(:abort)
      
    end
    
    

    
end
