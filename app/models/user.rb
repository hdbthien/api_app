class User < ApplicationRecord
  has_many :orders

  has_secure_password

  validates_presence_of :name, :email, :password_digest
  validates :password, length: {minimum: 8}
  validates :email, uniqueness: {case_sensitive: false}
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}
end
