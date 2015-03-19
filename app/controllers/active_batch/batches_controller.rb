require_dependency "active_batch/application_controller"

module ActiveBatch
  class BatchesController < ApplicationController
    before_action :set_batch, only: [:show, :destroy]

    # GET /batches
    def index
      @batches = Batch.all
    end

    # GET /batches/1
    def show
    end

    # GET /batches/new
    def new
      @batch = Batch.new
    end

    # POST /batches
    def create
      @batch = Batch.new(batch_params)

      if @batch.save
        redirect_to @batch, notice: 'Batch was successfully created.'
      else
        render :new
      end
    end

    # DELETE /batches/1
    def destroy
      @batch.destroy
      redirect_to batches_url, notice: 'Batch was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_batch
        @batch = Batch.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def batch_params
        params.require(:batch).permit(:job_class, :timestamps)
      end
  end
end
