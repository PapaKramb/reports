class User < ApplicationRecord
  enum role: { client: 0, developer: 1, admin: 2 }

  devise :invitable, :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  has_many :reports, dependent: :destroy
end
