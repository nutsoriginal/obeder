require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @user = create :user_with_user_menus, neem: false
    @user_attrs = attributes_for :user
    admin_http_login
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'create' do
    assert_difference('User.count', +1) do
      post :create, params: { user: @user_attrs }
    end
    assert_redirected_to admin_users_path
  end

  test 'edit' do
    get :edit, params: { id: @user.id }
    assert_response :success
  end

  test 'update' do
    new_email = 'test@restream.rt.ru'
    put :update, params: { id: @user.id,
                           user: { email: new_email } }
    assert { @user.reload.email = new_email }
  end

   test 'destroy' do
    assert_difference('User.count', -1) do
      delete :destroy, params: { id: @user.id }
    end

    assert_redirected_to admin_users_path
  end

end
