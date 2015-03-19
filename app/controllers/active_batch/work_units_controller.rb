require_dependency "active_batch/application_controller"

module ActiveBatch
  class WorkUnitsController < ApplicationController
    before_action :set_work_unit, only: [:show, :destroy]

    # GET /jobs
    def index
      @work_units = WorkUnit.all
    end

    # GET /jobs/1
    def show
    end

    # DELETE /jobs/1
    def destroy
      @work_unit.destroy
      redirect_to work_units_url, notice: 'Job was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_work_unit
        @work_unit = WorkUnit.find(params[:id])
      end

  end
end
