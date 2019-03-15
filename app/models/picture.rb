class Picture < ApplicationRecord
  belongs_to :message
  
  has_attached_file :image, styles: { medium: "260x250#", thumb: "600x400#" },
  default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 5.megabytes
  
end
