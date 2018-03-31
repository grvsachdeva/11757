class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:employee).permit(:email, :password, :password_confirmation, :contactno, :departmentname)
  end

  def account_update_params
    params.require(:employee).permit(:email, :password, :password_confirmation, :contactno, :departmentname)
  end

end
