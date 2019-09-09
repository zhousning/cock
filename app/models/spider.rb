class Spider < ActiveRecord::Base


  has_many :selectors, :dependent => :destroy
  accepts_nested_attributes_for :selectors, reject_if: :all_blank, allow_destroy: true


end
