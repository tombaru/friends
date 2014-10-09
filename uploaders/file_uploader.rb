class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
	  "uploads/videos/#{model.id}"
  end
end