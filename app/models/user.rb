class User < ApplicationRecord
  
  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_votable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  
  #用户名的验证
  validates_presence_of :username, message: "用户不能为空"
  validates_length_of :username, in: 4..20, message: "用户名长度在4-15位字母或数字"
  validates_uniqueness_of :username, case_sensitive: false, message: "该用户名已存在!"
  # 邮件的验证
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_presence_of :email, message: "邮箱不能为空"
  validates_format_of :email, with: VALID_EMAIL_REGEX, message: "邮箱格式不对请重新输入邮箱"
  validates_uniqueness_of :email, case_sensitive: false, message: "该邮箱已存在！请重新输入"
  # 密码验证
  validates_presence_of :password, message: "密码不能为空"
  validates_length_of :password, minimum: 6, on: :create, message: "密码长度不应短于6位!"
  # 重复密码验证
  validates_confirmation_of :password, message: "两次密码不一致!"
  validates_presence_of :password_confirmation, message: "请再输入一次密码!", allow_blank: true
  # checkbox 验证
  validates_acceptance_of :remember_me
end
