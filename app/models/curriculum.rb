class Curriculum < ApplicationRecord
  # relationships
  has_many :camps

  # validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  ratings_array = [0] + (100..3000).to_a
  validates :min_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validates :max_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validate :max_rating_greater_than_min_rating

  # scopes
  scope :alphabetical, -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_rating, ->(rating) { where("min_rating <= ? and max_rating >= ?", rating, rating) }
  
  
  
  #callbacks  
    before_destroy :dont_destroy
    before_update :check_active
    
    def check_active 
      count = 0
      self.camps.map do |c|
        if c.start_date >= Date.today
          c.registrations.map do |r|
            count += 1
          end 
        end 
      end
      if count > 0
        self.active = true 
      end 
    end 
    
    def dont_destroy
      errors.add(:curriculum,"can't destroy any record")
      throw(:abort)
    end
    
    
    

  private
  def max_rating_greater_than_min_rating
    # only testing 'greater than' in this method, so...
    return true if self.max_rating.nil? || self.min_rating.nil?
    unless self.max_rating > self.min_rating
      errors.add(:max_rating, "must be greater than the minimum rating")
    end
  end


end
