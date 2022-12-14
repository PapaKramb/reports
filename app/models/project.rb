class Project < ApplicationRecord
  has_many :reports, dependent: :destroy
  validates :name, presence: true
end
