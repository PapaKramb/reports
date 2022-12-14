module Admin
  class ProjectsController < ApplicationController
    def index
      @projects = Project.all
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      authorize!

      if @project.save
        redirect_to admin_projects_path
      else
        render :new
      end
    end

    def edit
      @project = Project.find(params[:id])
    end

    def update
      @project = Project.find(params[:id])
      authorize!

      if @project.update(project_params)
        redirect_to admin_projects_path
      else
        render :edit
      end
    end

    def destroy
      @project = Project.find(params[:id])
      authorize!

      if @project.destroy
        redirect_to admin_projects_path
      end
    end

    private

    def project_params
      params.require(:project).permit(:name)
    end
  end
end
