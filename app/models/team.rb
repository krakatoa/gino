class Team < ActiveRecord::Base
  belongs_to :tag

  before_save :refresh_tag

  validates_presence_of :name

  private
  def refresh_tag
    if new_record?
      new_tag = Tag.create(:label => self.name)
      self.tag = new_tag
    else
      update_tag = self.tag
      update_tag.label = self.name
      update_tag.save
    end
  end
end
