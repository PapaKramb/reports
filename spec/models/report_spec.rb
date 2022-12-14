require 'rails_helper'

RSpec.describe Report, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:project) }

  it_behaves_like 'factorized model'
  it_behaves_like 'localized model'

  it { should validate_presence_of :what_is_done }
  it { should validate_presence_of :plan_for_next_day }
end
