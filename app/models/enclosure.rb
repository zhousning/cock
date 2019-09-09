# == Schema Information
#
# Table name: enclosures
#
#  id         :integer          not null, primary key
#  file       :string           default(""), not null
#  notice_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Enclosure < ActiveRecord::Base
  belongs_to :notice

  mount_uploader :file, EnclosureUploader
end
