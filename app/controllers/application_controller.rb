class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_current_charity
  before_filter :set_current_donor
  before_filter :set_locale

  def set_current_charity
    @current_charity = current_charity if charity_signed_in?
  end

  def set_current_donor
    @current_donor = current_donor if donor_signed_in?
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  alias_method :current_user, :current_charity
  alias_method :user_signed_in?, :charity_signed_in?
  helper_method :current_user, :user_signed_in?



  protected

  def configure_permitted_parameters
    these = ([
      :current_password,
      :organisation,
      :description,
      :website_url,
      :logo,
      :contact_name,
      :address,
      :city,
      :postcode,
      :email,
      :password,
      :password_confirmation,
      :weekday_opening_hours,
      :weekend_opening_hours,
      :tins,
      :dried_goods,
      :coffee_and_tea,
      :fresh_fruit_and_veg,
      :fresh_meat_and_fish,
      :snacks,
      :jars_and_condiments,
      :cereals,
      :cooking_ingredients,
      :drinks,
      :uht_milk,
      :none
    ])
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(these) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(these) }
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Charity)
      charity_path
    else
      super
    end
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end


end
