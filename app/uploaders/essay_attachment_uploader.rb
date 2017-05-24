class EssayAttachmentUploader < BaseUploader

  def extension_black_list
    %w(exe bat)
  end

end
