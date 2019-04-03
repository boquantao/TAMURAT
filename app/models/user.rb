class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
                    # uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :login_id, presence: true, uniqueness: true
  VALID_ROLE_REGEX = /Decision Maker|Company Representative|Validtor|Administrator/i
  validates :role, presence: true, format: { with: VALID_ROLE_REGEX }

  def admin?
    self.role == "Administrator"
  end
end