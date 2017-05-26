class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :apps         
  before_save { self.email = email.downcase if email.present? }
  after_initialize :init
  
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }
         
  def init
    self.role  ||= :standard           
  end
  
  enum role: [:standard, :admin]         
end
