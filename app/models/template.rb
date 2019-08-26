# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  name       :string
#  cn_name    :string
#  nest       :string
#  image      :boolean
#  index      :boolean
#  new        :boolean
#  edit       :boolean
#  show       :boolean
#  form       :boolean
#  js         :boolean
#  scss       :boolean
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Template < ActiveRecord::Base


  has_many :natures, :dependent => :destroy
  accepts_nested_attributes_for :natures, reject_if: :all_blank, allow_destroy: true

  has_many :relates, :dependent => :destroy
  accepts_nested_attributes_for :relates, reject_if: :all_blank, allow_destroy: true

end
