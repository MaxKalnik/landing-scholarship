class EssayImageUploader < BaseUploader

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
