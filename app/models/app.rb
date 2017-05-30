class App < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy
  
  validates :name, presence: { message: 'Application name cannot be emptied.' }
  validates :url, presence: { message: 'Application url cannot be emptied.' }
  validates :user, presence: { message: 'An application must have associated user.' }
end
