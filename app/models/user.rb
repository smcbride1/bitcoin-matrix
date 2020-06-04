class User < ActiveRecord::Base

    has_secure_password
    validates :name, :username, :email, :password_digest, presence: true
    validates :username, :email, uniqueness: true

    has_many :wallets
    has_many :transactions, through: :wallets

end