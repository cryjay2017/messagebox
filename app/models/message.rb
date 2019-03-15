class Message < ApplicationRecord
  searchkick
  acts_as_votable
  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :category
  # pictures paperclip
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
  
  # Message title validate
  validates_presence_of :title, message: "标题不能为空"
  validates_length_of :title, in: 5..30, message: "标题长度应该在5到30个字母"
  
  #Message content validate
  validates_presence_of :content, message: "内容不能为空"
  validates_length_of :content, maximum: 1000, message: "文章内容长度不应超过1000个字母及数字"
end
