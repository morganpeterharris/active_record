# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  prefix         :string(255)
#  products_count :integer          default(0)
#  parent_id      :integer
#
# Indexes
#
#  index_categories_on_parent_id  (parent_id)
#

class Category < ApplicationRecord
  has_many :products, lambda { where('inventory > 0') }, dependent: :destroy

  validates :name,   presence: true
  validates :prefix, presence: true

  before_validation :add_default_prefix, if: Proc.new { |cat| cat.prefix.blank? }

  # around_save :benchmark

  private

    def add_default_prefix
      puts "*** Adding default prefix ***"
      self.prefix = 'GEN'
    end
end
