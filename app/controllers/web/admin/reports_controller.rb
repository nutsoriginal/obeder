class Web::Admin::ReportsController < Web::Admin::ApplicationController
  before_action :authorize_cook

  def index
    @beginning_of_month = start_date
    @report_year = year.to_i
    @report_month = month.to_i
    @users = User.order(:name)
    @menus = monthly_report_menus
    @user_menus = UserMenu.joins(:menu).where(menu: @menus, neem: false)
      .pluck(:'menus.date', :'user_id')
  end

  def export
    service = MonthlyReportService.new(month, year)
    exported_data = service.export_to_xlsx_stream
    send_data(exported_data[:read], filename: exported_data[:filename], type: exported_data[:type])
  end

  private

  def export_xlsx_filename
    monthly_report_service = MonthlyReportService.new(month, year)
  end

  def monthly_report_menus
    Menu.in_date_range(start_date, start_date.end_of_month).order(:date)
  end

  def start_date
    "01-#{month}-#{year}".to_date
  end

  def year
    params[:year]
  end

  def month
    params[:month]
  end
end
