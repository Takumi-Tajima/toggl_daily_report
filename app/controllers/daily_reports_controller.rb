class DailyReportsController < ApplicationController
  before_action :set_daily_report, only: %i[show edit update destroy]

  def index
    @daily_reports = DailyReport.default_order
  end

  def show
  end

  def new
    @daily_report = DailyReport.new
  end

  def edit
  end

  def create
    @daily_report = DailyReport.new(daily_report_params)

    if @daily_report.save
      redirect_to @daily_report, notice: 'Daily report was successfully created.'
    else
      render :new
    end
  end

  def update
    if @daily_report.update(daily_report_params)
      redirect_to @daily_report, notice: 'Daily report was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @daily_report.destroy!
    redirect_to daily_reports_url, notice: 'Daily report was successfully destroyed.'
  end

  private

  def set_daily_report
    @daily_report = DailyReport.find(params.expect(:id))
  end

  def daily_report_params
    params.expect(daily_report: %i[report_date content])
  end
end
