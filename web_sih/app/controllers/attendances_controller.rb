class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]

  # GET /attendances
  # GET /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @unmarked_records = Attendance.where(timeOut: nil, employee_id: current_employee.id)
    if @unmarked_records.count > 0
      respond_to do |format|
      # format.html{
      #   redirect_to '/checkout'
      # }
      # end
      format.js {
        render js: "window.location.href = '/checkout'"
      }
    end
      else
      latitude = params[:latitude]
      longitude = params[:longitude]
      geo_localization = "#{latitude},#{longitude}"
      query = Geocoder.search(geo_localization).first
      location = query.formatted_address
      time_in = Time.now
      employee_id = current_employee.id
      @attendance = Attendance.create(location:location, employee_id:employee_id, timeIn:time_in)
    end
  end

  def checkout
    @unmarked_records = Attendance.where(timeOut: nil, employee_id: current_employee.id)
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @attendance, notice: 'Attendance was successfully created.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_update
    @attendance = Attendance.where(id: params[:attendance_id]).first
    @attendance.timeOut = params[:timeOut]
    @attendance.save
    flash[:notice] = "Checkout time added successfully !!!"
    redirect_to '/employee'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attendance_params
    params.require(:attendance).permit(:image_uri, :location, :remarks, :timeIn, :timeOut, :employee_id)
  end
end
