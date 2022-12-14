class ReportsController < ApplicationController
  def index
    @filterrific = initialize_filterrific(
      authorized_scope(Report.all),
      params[:filterrific]
    ) or return
    @pagy, @reports = pagy(@filterrific.find)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @report = Report.find(params[:id])
    authorize! @report
  end

  def new
    @report = Report.new
  end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      redirect_to report_path(@report)
    else
      render :new
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    authorize! @report

    if @report.update(report_params)
      redirect_to @report
    else
      render :edit
    end
  end

  def destroy
    @report = Report.find(params[:id])
    authorize! @report

    if @report.destroy
      redirect_to reports_path
    end
  end

  private

  def report_params
    params.require(:report).permit(:project_id, :what_is_done, :plan_for_next_day)
  end
end
