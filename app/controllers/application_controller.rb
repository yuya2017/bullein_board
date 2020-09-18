class ApplicationController < ActionController::Base
  before_action :set_search
  before_action :configure_permitted_parameters, if: :devise_controller?


  def set_search
    @search = Post.ransack(params[:q])
    @search_posts = @search.result.page(params[:page]).order(updated_at: "DESC").includes(:room)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :app, :time, :chess, :content])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :app, :time, :chess, :content])
  end

  def check_guest
    email = current_user&.email || params[:user][:email].downcase
    if email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end
end
