class Web::Admin::UserMenusController < Web::Admin::ApplicationController
  def index
    @date = date
    @neem_users = User.where(neem: true)
    @user_menus = UserMenu.em.for_date(params[:date])
    @dishes_stats = @user_menus.map(&:dishes).flatten.group_by(&:name)
      .map{ |key, value| { type: key, count: value.count } }
  end

  private

  def date
    Date.parse(params[:date])
  end
end