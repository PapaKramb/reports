require "rails_helper"

RSpec.describe UserPolicy, type: :policy do
  let!(:user) { FactoryBot.create(:user) }
  let!(:context) { { user: user } }

  describe_rule :index? do
    succeed 'when user is admin' do
      before { user.role = :admin }
    end

    failed 'when user is developer' do
      before { user.role = :developer }
    end
  end
end
