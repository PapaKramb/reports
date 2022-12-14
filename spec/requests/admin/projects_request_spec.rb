require 'rails_helper'

RSpec.describe "Admin::Projects", type: :request do
  before do 
    sign_in @current_user = create(:admin)
  end

  it '#index' do 
    project_1 = create(:project) 
    project_2 = create(:project) 
    get '/admin/projects/' 
    expect(assigns(:projects)).to contain_exactly *[project_1, project_2] 
  end

  it '#new' do 
    get '/admin/projects/new' 
    expect(assigns(:project)).to be_a_new Project 
  end

  it '#create' do 
    expect { 
      post '/admin/projects', params: { 
        project: attributes_for(:project) 
        } 
      }.to change(Project, :count).by 1 
  end

  it '#edit' do 
    project = create(:project) 
    get "/admin/projects/#{project.id}/edit" 
    expect(assigns(:project)).to eq project 
  end

  it '#update' do 
    project = create(:project) 
    patch "/admin/projects/#{project.id}", params: { 
      project: { 
        name: 'New name' 
      } 
    } 
    expect(project.reload.name).to eq 'New name' 
  end

  it '#destroy' do 
    project = create(:project) 
    expect { delete "/admin/projects/#{project.id}" }.to change(Project, :count).by -1 
  end
end
