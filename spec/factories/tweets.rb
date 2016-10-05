FactoryGirl.define do
  factory :tweet do
    user
    text 'Isso é um tweet válido!'

    trait :invalid_tweet do
      text 'Tweet inválido porque o tweet é inválido porque o tweet é inválido porque ' + \
            'o tweet é inválido porque o tweet é inválido porque o tweet é inválido'
    end
  end
end
