class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Antes de que cualquier acción del controlador se ejecute, verifica si el usuario está autenticado
  before_action :authenticate_user!

  # Define un método para verificar si el usuario está autenticado
  def authenticate_user!
    # Verifica si hay un usuario actualmente autenticado
    unless current_user
      # Si no hay un usuario autenticado, redirige al usuario a la página de inicio de sesión
      redirect_to new_user_session_path, alert: "You need to sign in or sign up before continuing."
    end
  end

  # Define un método para acceder al usuario actualmente autenticado
  def current_user
    # Devuelve el usuario actualmente autenticado, si existe
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
