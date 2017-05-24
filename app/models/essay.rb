class Essay < ActiveRecord::Base

  belongs_to :essay_application

  mount_uploader :essay, EssayAttachmentUploader

  # validates :essay,  :presence => true, :file_size => { :maximum => 0.5.megabytes.to_i }

end
