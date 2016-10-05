class Tweet < ActiveRecord::Base

  MAX_TWEET_SIZE = 140

  belongs_to :user, required: true
  validates :text, presence: true, length: { maximum: MAX_TWEET_SIZE }


  # validates :user_id, presence: true => Valida user_id
  # validates :user, presence: true => Valida que tem um user associado

  #belongs_to :user, required: true => Valida ambos

end
