# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActionPolicy::Unauthorized do
    flash[:danger] = 'Not authorized to access this page'
    redirect_to root_path
  end
end
