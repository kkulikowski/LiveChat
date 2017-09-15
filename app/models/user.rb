class User < ApplicationRecord
  enum role: [:user, :trainer, :admin]
  after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :messages
  has_many :conversations, foreign_key: :sender_id

  def set_default_role
    self.role ||= :user
  end
end
