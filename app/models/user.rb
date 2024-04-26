class User < ApplicationRecord
    has_many :posts, dependent: :destroy
  
    # Validaciones
    validates :name, presence: { message: "Name can't be blank" }
    validates :email, presence: { message: "Email can't be blank" },
                      uniqueness: { message: "Email already exists" },
                      format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email format" }
    validates :password, presence: { message: "Password can't be blank" },
                         length: { minimum: 6, message: "Password must be at least 6 characters long" }
  
    # Callback para establecer el nombre de usuario en minúsculas antes de validar
    before_validation :downcase_email
  
    private
  
    def downcase_email
      self.email = email.downcase
    end
  end
  