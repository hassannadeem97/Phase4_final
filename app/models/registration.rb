class Registration < ApplicationRecord
    belongs_to :student
    belongs_to :camp
    
    validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :student_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validate :student_is_active_in_system
    validate :camp_is_active_in_system
    
    before_save :encode_payment
    
    def encode_payment
        if self.payment != nil
            self.payment = Base64.encode64(self.payment)
        end 
    end
    
    
    def student_is_active_in_system
        if self.student != nil
            if self.student.active != true
                errors.add(:student, "is not currently active") 
            end
        end 
    end

    def camp_is_active_in_system
        if self.camp != nil
            if self.camp.active != true
                errors.add(:camp,"is not currently active") 
            end 
        end 
    end

end 