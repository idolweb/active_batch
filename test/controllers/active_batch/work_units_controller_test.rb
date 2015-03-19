require 'test_helper'

module ActiveBatch
  class WorkUnitsControllerTest < ActionController::TestCase

    fixtures 'active_batch/work_units'

    setup do
      @routes = Engine.routes
      @work_unit = active_batch_work_units(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:work_units)
    end

    test "should show work_unit" do
      get :show, id: @work_unit
      assert_response :success
    end

    test "should destroy work_unit" do
      assert_difference('WorkUnit.count', -1) do
        delete :destroy, id: @work_unit
      end

      assert_redirected_to work_units_path
    end
  end
end
