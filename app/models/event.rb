class Event < ActiveRecord::Base
  belongs_to :app
  
  validates :name, presence: { message: 'Event name cannot be emptied.' }
  validates :app, presence: { message: 'An event must have associated application.' }
end
