class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :small => "200x200>", :thumb => "100x100>" }, :default_url => "/images/:style/profilepic.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 1.megabytes
  validates_attachment :avatar,   :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
end
