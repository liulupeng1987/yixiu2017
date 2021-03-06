class Product < ApplicationRecord
  validates :price, presence: true
  mount_uploader :image, ImageUploader
  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC')}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  has_many :favorites
  has_many :users, through: :favorites, source: :user
  has_many :comments
  belongs_to :category
  has_many :photos
  accepts_nested_attributes_for :photos
end
