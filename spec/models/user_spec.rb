require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:reports).dependent(:destroy) }

  it_behaves_like 'factorized model'
  it_behaves_like 'localized model'

  it { should define_enum_for(:role).with([:client, :developer, :admin]) }
end
