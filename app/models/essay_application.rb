class EssayApplication < ActiveRecord::Base

  has_many :essays, dependent: :destroy

  accepts_nested_attributes_for :essays

  validate :essays_presents_and_size

  mount_uploader :photo,          EssayImageUploader
  mount_uploader :transcript,     EssayAttachmentUploader
  mount_uploader :recommendation, EssayAttachmentUploader

  validates :photo,           :presence => true, :file_size => { :maximum => 15.megabytes.to_i }
  validates :transcript,      :presence => true, :file_size => { :maximum => 15.megabytes.to_i }
  validates :recommendation,  :presence => true, :file_size => { :maximum => 15.megabytes.to_i }

  private
  def essays_presents_and_size
    if essays.size < 1
      errors.add(:essays, 'At least one essay is required')
      return
    end

    essays.each do |essay|
      if essay.essay.size > 15.megabytes.to_i
        errors.add(:essays, 'is too big')
        break
      end
    end
  end

end
