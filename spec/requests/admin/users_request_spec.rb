require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/sign_in" do
    it "returns http success" do
      get new_user_session_path
      expect(response).to be_ok
    end
  end
end
