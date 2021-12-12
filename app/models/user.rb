class User < ApplicationRecord
  before_save {self.email=email.downcase}
  has_many :books,dependent: :destroy
  validates :username,presence: true,
            uniqueness:{case_sensitive:false},
            length:{minimum:3,maximum:20}
  VALIDATE_EMAIL=URI::MailTo::EMAIL_REGEXP
  validates :email,presence: true,
            uniqueness:{case_sensitive:false},
            length:{minimum:3,maximum:110},
            format: {with: VALIDATE_EMAIL}
  has_secure_password
end
