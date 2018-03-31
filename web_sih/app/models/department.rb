class Department < ApplicationRecord
  def employees_department department
    Employee.where(departmentname: department)
  end
end
