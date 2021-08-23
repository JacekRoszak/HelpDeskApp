class ServiceRequestsController < ApplicationController
  load_and_authorize_resource

  def index
    @service_request = ServiceRequest.new
  end

  def show
  end

  def new
  end

  def edit
  end

  def add_buttons
    @service_request = ServiceRequest.find(params[:service_request_id])
    render 'add_buttons.js.slim'
  end

  def take_request
    @service_request = ServiceRequest.find(params[:service_request_id])
    @service_request.technicians << current_user
    @service_request.check_taken_status
    @service_request.send_update_notifications(current_user, service_requests_url)
    render turbo_stream: turbo_stream.replace(@service_request)
  end

  def create
    if @service_request.save
      @service_request.send_create_notifications(service_requests_url)
      redirect_to service_requests_path
    else
      render turbo_stream: turbo_stream.replace(@service_request, partial: 'service_requests/form')
    end
  end

  def update
    @service_request.mark_if_closing(service_request_params[:request_status_id])

    if @service_request.update(service_request_params)
      @service_request.send_update_notifications(current_user, service_requests_url)
      redirect_to @service_request
    else
      render :edit
    end
  end

  def destroy
    @service_request.destroy
    redirect_to service_requests_url
  end

  private

  def service_request_params
    params.require(:service_request).permit(:name, :request_status_id, :user_id, :location_id, :closed_at, :important, :raport, :department_id)
  end
end
