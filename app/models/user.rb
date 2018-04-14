class User < ApplicationRecord
    
    
    has_one :instructor 
    has_one :family
    has_secure_password
    
    validates_presence_of :username, :password_digest, :email, :role, :password_confirmation, :password
    validates :username, uniqueness: { case_sensitive: false }
    validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format" }
    validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
    # validates :role, format: { with: /admin;?\s?|instructor;?\s?|parent;?\s?/}
    validates :password, length: { minimum: 4 }
    
    
    before_save :check_password
    
    def check_password
        if self.password != self.password_confirmation
            raise "password should match password_confirmation"
        end 
    end 
    
end
