class Wallet < ActiveRecord::Base

    validates :user_id, :name, :restriction_type, presence: true
    validates :username, :email, uniqueness: true

    has_many :transactions
    belongs_to :user

end