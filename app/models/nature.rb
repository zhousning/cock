# == Schema Information
#
# Table name: natures
#
#  id          :integer          not null, primary key
#  name        :string
#  type        :string
#  title       :string
#  tag         :string
#  template_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Nature < ActiveRecord::Base
  belongs_to :template


end
