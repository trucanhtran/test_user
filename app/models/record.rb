class Record < ApplicationRecord
  belongs_to :user
  belongs_to :invited_user
end
