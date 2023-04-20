class User < ApplicationRecord
  before_save {self.email = email.downcase}
  has_many :articles
  has_secure_password

  validates :name, presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum:3, maximum:25}

  validates :email, presence: true,
            uniqueness: {case_sensitive: false},
            length: {maximum:105},
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}
end
