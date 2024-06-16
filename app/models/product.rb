# frozen_string_literal: true

# represents a product item
class Product < ApplicationRecord
  # belongs_to :order

  validates :name, presence: true
  validates :price, numericality: true
  validates :description, presence: true
end
