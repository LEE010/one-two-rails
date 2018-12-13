class Option < ApplicationRecord
  resourcify
  belongs_to :product, optional: true
  acts_as_votable
end
