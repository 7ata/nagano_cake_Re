class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
   case resource
   when Admin
    root_path
   when Customer
    customer_path(current_customer.id)
   end
  end

  private


  protected

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:last_name,:fast_name,
   :last_name_kana,:fast_name_kana,:postal_code,:address,:telephone_number,:is_deleted,
   :created_at,:updated_at])
  end
end
