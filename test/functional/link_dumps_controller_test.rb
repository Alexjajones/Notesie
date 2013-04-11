require 'test_helper'

class LinkDumpsControllerTest < ActionController::TestCase
  setup do
    @link_dump = link_dumps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:link_dumps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create link_dump" do
    assert_difference('LinkDump.count') do
      post :create, link_dump: { description: @link_dump.description, notebook_id: @link_dump.notebook_id, user_id: @link_dump.user_id }
    end

    assert_redirected_to link_dump_path(assigns(:link_dump))
  end

  test "should show link_dump" do
    get :show, id: @link_dump
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @link_dump
    assert_response :success
  end

  test "should update link_dump" do
    put :update, id: @link_dump, link_dump: { description: @link_dump.description, notebook_id: @link_dump.notebook_id, user_id: @link_dump.user_id }
    assert_redirected_to link_dump_path(assigns(:link_dump))
  end

  test "should destroy link_dump" do
    assert_difference('LinkDump.count', -1) do
      delete :destroy, id: @link_dump
    end

    assert_redirected_to link_dumps_path
  end
end
