class Attachment < ActiveRecord::Base

  attr_accessible :attachment

  has_attached_file :attachment

  validates_format_of :attachment_file_name, :with => %r{\.(png|gif|jpg|doc|docx|xsl|xslx|pdf)$}i

  validates_size_of :attachment, maximum: 2.megabytes, message: "should be less than 1MB"

  include Rails.application.routes.url_helpers

  def to_jq_attachment

    {
      "name" => read_attribute(:attachment_file_name),
      "size" => read_attribute(:attachment_file_size),
      "url" => attachment.url(:original),
      "delete_url" => attachment_path(self),
      "delete_type" => "DELETE" 
    }

  end

end
