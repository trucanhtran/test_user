class User < ApplicationRecord
  has_one :record, dependent: :destroy
end
