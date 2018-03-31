class HomeController < ApplicationController
before_action :authenticate_employee!, only: [:employee_index ,:admin_index]

  def index
  end

  def profile
    @employee = current_employee
  end

 def history
  @history = Attendance.where(employee_id: current_employee.id)
  puts @history
  end


  def employee_index
    if current_employee && current_employee.isAdmin == true
      flash[:notice] = "You are an Administrator, please use 'Login as Admin' option to login !!!"
      reset_session
      redirect_to '/employees/sign_in'
    else
      @employee = current_employee
      @departments = Department.all
    end
  end

  def admin_index
    if current_employee && current_employee.isAdmin == false
      flash[:notice] = "You are a Employee, please use 'Login as Employee' option to login !!!"
      reset_session
      redirect_to '/employees/sign_in'
    else
      @admin = current_employee
      @employees = Employee.where(isAdmin: false)
      @departments = Department.all
    end
  end

  def notify_employee
    @sender = current_employee
    @employees = Employee.where(isAdmin: false)
    render 'home/employee_index'
  end

  def send_notification
    @sender = current_employee
    @employee = Employee.where(id: params[:eid]).first
    NotificationMailer.send_notification(@employee, @sender).deliver_now
    flash[:notice] = "Mail sent !!! "
    redirect_to '/admin'
  end

def employee_attendance
  @employee = Employee.where(id: params[:eid]).first
  @attendances = Attendance.where(employee_id: @employee.id)
  render 'attendances/employee_attendance'
end

end
