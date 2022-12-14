require 'rails_helper'

RSpec.describe "Reports", type: :request do
  before do
    sign_in @current_user = create(:admin)
  end

  it '#index' do
    sign_in @current_user = create(:user) 
    report_1 = create(:report, user: @current_user) 
    report_2 = create(:report, user: @current_user) 
    get '/reports' 
    expect(assigns(:reports)).to contain_exactly *[report_1, report_2] 
  end

  it '#show' do
    report = create(:report)
    get "/reports/#{report.id}"
    expect(assigns(:report)).to eq report
  end

  it '#new' do 
    get '/reports/new' 
    expect(assigns(:report)).to be_a_new Report 
  end

  it '#create' do
    sign_in @current_user = create(:user)
    project = create(:project)
    expect {
      post "/reports", params: { 
        report: attributes_for(:report, project_id: project.id) 
        } 
      }.to change(Report, :count).by 1

    expect {
      post "/reports", params: { 
        report: attributes_for(:report) 
        } 
      }.not_to change(Report, :count)

      expect(response).to be_ok
  end

  it '#edit' do 
    report = create(:report) 
    get "/reports/#{report.id}/edit" 
    expect(assigns(:report)).to eq report 
  end

  it '#update' do
    report = create(:report) 
    patch "/reports/#{report.id}", params: { 
      report: { 
        what_is_done: "New text 1",
        plan_for_next_day: "New text 2"
      } 
    }
    report.reload 
    expect(report.what_is_done.body.to_s).to include 'New text 1'
    expect(report.plan_for_next_day.body.to_s).to include 'New text 2'

    patch "/reports/#{report.id}", params: { 
      report: { 
        what_is_done: "",
        plan_for_next_day: ""
      }
    }
    
    expect(response).to be_ok
  end

  it '#destroy' do 
    report = create(:report) 
    expect { delete "/reports/#{report.id}" }.to change(Report, :count).by -1 
  end
end
