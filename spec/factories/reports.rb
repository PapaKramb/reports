FactoryBot.define do
  factory :report do
    user
    project

    what_is_done { 'Test text' }
    plan_for_next_day { 'Test text' }
  end
end
