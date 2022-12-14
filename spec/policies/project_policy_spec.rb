require "rails_helper"

RSpec.describe ProjectPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }
  let(:context) { { user: user } }
  let(:project) { build_stubbed(:project) }

  let(:policy) { described_class.new(project, user: user) }

  describe_rule :index? do
    succeed
  end

  describe_rule :show? do
    succeed
  end

  describe_rule :create? do
    succeed 'when user is admin' do
      before { user.role = :admin }
    end

    failed 'when user is developer' do
      before { user.role = :developer }
    end
  end

  describe_rule :update? do
    succeed 'when user is admin' do
      before { user.role = :admin }
    end

    failed 'when user is not admin' do
      before { user.role = :developer }
    end
  end

  describe_rule :destroy? do
    succeed 'when user is admin' do
      before { user.role = :admin }
    end

    failed 'when user is developer' do
      before { user.role = :developer }
    end
  end
end
