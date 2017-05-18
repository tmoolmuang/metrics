class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  before_save { self.email = email.downcase if email.present? }
  after_initialize :init
         
  def init
    self.role  ||= :standard           
  end
  
  enum role: [:standard, :admin]         
end
