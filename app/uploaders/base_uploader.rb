require 'file_size_validator'
class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  unless Rails.env.test?
    storage :fog
    fog_public true
  end

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def timestamp
    Time.now.to_f
  end
end
