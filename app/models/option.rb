class Option < ApplicationRecord
  resourcify
  belongs_to :product, optional: true
end
