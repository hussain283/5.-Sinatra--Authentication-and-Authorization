class User < ActiveRecord::Base
  #TODO : Use bcrypt to store hashed passwords and authenticate users

  validates :name, :email, :password_hash, :presence => true
  validates :email, :format => { :with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/, :message => "Invalid Email" }
  validates :email, uniqueness: { message: "Email already taken!"}
  validates :password_hash, :format => {:with => /^(?=.*\d)(?=.*[a-zA-Z]).{4,8}$/, :message => "Password must be 4-8 chars long and must contain one letter and one number"}, :on => :create
  before_create :encrypt_password

  def encrypt_password
    self.password_hash = BCrypt::Password.create(self.password_hash)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    (BCrypt::Password.new(user.password_hash) rescue nil) == password ? user : nil
  end
end
