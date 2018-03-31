class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def todays_attendance employee_id
    Attendance.where(employee_id: 1).where(updated_at: (Time.now.midnight - 1.day)..Time.now)
  end
end


