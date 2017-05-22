class App < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: { message: 'Application name cannot be emptied.' }
  validates :url, presence: { message: 'Application url cannot be emptied.' }
end
