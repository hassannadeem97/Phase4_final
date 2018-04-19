class Registration < ApplicationRecord
    attr_accessor :credit_card_number, :expiration_year, :expiration_month
    
    belongs_to :student
    belongs_to :camp
    
    
    validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :student_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :credit_card_number,  format: { with: /\A(?:(4[0-9]{12}(?:[0-9]{3})?)|(5[1-5][0-9]{14})|(6(?:011|5[0-9][0-9])[0-9]{12})|(3[47][0-9]{13})|(3(?:0[0-5]|[68][0-9])[0-9]{11}))\z/}
    validate :student_is_active_in_system
    validate :camp_is_active_in_system
    validate :expiry_date
    validate :rating #this is for the no.6 specification
    #validate :same_camp #this is for the second part of the no.6 specification. I am not sure if it is 100% accurate
    
    
    
    
    #scopes
    scope :alphabetical, -> { joins(:student).order('last_name', 'first_name') }
    
    def self.for_camp(camp_id) # i did this instead of a scope because for instrcutor instead of writing a scope prof.h wrote a class method. 
        self.where(camp_id: camp_id)
    end
    
    def name
        "#{self.student.last_name}, #{self.student.first_name}"
    end 
    
    def pay
        if self.payment == nil
            self.payment = Base64.encode64("camp: #{self.camp_id}; student: #{self.student_id}; amount_paid: #{self.camp.cost}; card: #{self.credit_card_number_check} ****<#{self.credit_card_number.to_s.last(4)}>")
            return self.payment
        else 
            false 
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
    
  
    def expiry_date
        if self.expiration_month != nil and self.expiration_year != nil
            if self.expiration_month >= Date.today.strftime("%m").to_i and self.expiration_year >= Date.today.strftime("%Y").to_i
    
            else 
                errors.add(:base,"Expiry date is invalid")
                
            end
        end 
    end 
    
    # additional method to get the type of credit card
     def credit_card_number_check 
        if self.credit_card_number != nil
            if self.credit_card_number.to_s.match(/^4/) and (self.credit_card_number.to_s.length == 16 or self.credit_card_number.to_s.length == 13)
              "Visa Card"
            elsif self.credit_card_number.to_s.match(/^5[1-5]/) and (self.credit_card_number.to_s.length == 16)
              "Master Card"
            elsif self.credit_card_number.to_s.match(/^6011|65/ ) and (self.credit_card_number.to_s.length == 16)
              "Discovery Card"
            elsif self.credit_card_number.to_s.match(/^30[0-5]/) and (self.credit_card_number.to_s.length == 14)
              "Diners Club"
            elsif self.credit_card_number.to_s.match(/^3[47]/) and (self.credit_card_number.to_s.length == 15)
              "Amex"
            else 
              "credit card number invalid"
            end 
        end 
     end
  
  
  
  
    def rating
        if self.student != nil
            if self.student.rating >= self.camp.curriculum.min_rating and self.student.rating <= self.camp.curriculum.max_rating
            else 
                errors.add(:base,"rating is invalid")
            end

        end 
    end
    
    # def same_camp
    #     arr = Camp.where('(start_date >= ? and start_date <= ?) and time_slot = ? and active = ?', self.camp.start_date, self.camp.end_date, self.camp.time_slot, true)
    #     arr1 =[]
    #     arr.each{|c| arr1 << c.id}
    #     stud = []
    #     arr1.each do |a|
    #     stud << Student.joins(:registrations).where('registrations.camp_id = ?', a)
    #     end
    #     stud = stud.flatten
    #     if stud.include?(self.student)
    #         errors.add(:base, "camp clashes with another ")
    #     end 
        
    # end
    

    
     

end 