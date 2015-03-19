require 'test_helper'

module ActiveBatch
  class BatchesControllerTest < ActionController::TestCase

  fixtures :all

    setup do
      @routes = Engine.routes
      @batch = active_batch_batches(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:batches)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create batch" do
      assert_difference('Batch.count') do
        post :create, batch: { job_class: @batch.job_class }
      end

      assert_redirected_to batch_path(assigns(:batch))
    end

    test "should show batch" do
      get :show, id: @batch
      assert_response :success
    end

    test "should destroy batch" do
      assert_difference('Batch.count', -1) do
        delete :destroy, id: @batch
      end

      assert_redirected_to batches_path
    end
  end
end
