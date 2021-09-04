class User < ApplicationRecord
  has_many :records, dependent: :destroy
end
