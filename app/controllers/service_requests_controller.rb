class ServiceRequestsController < ApplicationController
  load_and_authorize_resource

  def index
    @service_requests = ServiceRequest.all
  end

  def show
  end

  def new
    @service_request = ServiceRequest.new
  end

  def edit
  end

  def create
    if @service_request.save
      redirect_to @service_request, notice: 'Service request was successfully created.'
    else
      render :new
    end
  end

  def update
    if @service_request.update(service_request_params)
      redirect_to @service_request, notice: 'Service request was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @service_request.destroy
    redirect_to service_requests_url, notice: 'Service request was successfully destroyed.'
  end

  private

  def service_request_params
    params.require(:service_request).permit(:name, :request_status_id, :user_id, :location_id, :closed_at, :important, :raport, :department_id)
  end
end
