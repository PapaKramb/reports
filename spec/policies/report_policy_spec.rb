require "rails_helper"

RSpec.describe ReportPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }
  let(:context) { { user: user } }
  let(:report) { build_stubbed(:report) }

  let(:policy) { described_class.new(report, user: user) }

  describe_rule :index? do
    succeed
  end

  describe_rule :show? do
    succeed 'when user is admin or author report' do
      before do
        user.role = :admin
        user.id = :record
      end
    end

    failed 'when user is not admin and not author report' do
      before { user.role = :developer }
    end
  end

  describe_rule :create? do
    succeed 'when user is admin' do
      before { user.role = :admin }
    end

    succeed 'when user is developer' do
      before { user.role = :developer }
    end
  end

  describe_rule :update? do
    succeed 'when user is admin or author report' do
      before do
        user.role = :admin
        user.id = :record
      end
    end

    failed 'when user is not admin and not author report' do
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
