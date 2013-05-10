class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :tel, :roles_mask, :birth, :vip

  # constant
  ROLES = %w[admin customer]

  # association
  has_many :photos, :dependent => :destroy

  ##############
  # validation #
  ##############
  validates :name, :presence => true
  validates :tel, :presence => true, :uniqueness => true, :format => { :with => /(^\d{7,8}$)|(^\d{11}$)/ }

  ######################       
  # callback functions #
  ######################       
  before_create :update_roles_of_user
  def update_roles_of_user
    self.roles = 'customer' if self.roles_mask.blank?
  end
  private :update_roles_of_user

  ####################
  # instance methods #
  ####################
  def roles=(roles)
    self.roles_mask = ( [ roles ].flatten & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def any_roles?(*a)
    !(roles & a.map{|i| i.to_s}).empty?
  end

  private
  def email_required?
    false
  end
end
