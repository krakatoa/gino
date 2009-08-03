class Tag < ActiveRecord::Base
  has_and_belongs_to_many :news

  validates_presence_of :label
  validates_uniqueness_of :label
end
