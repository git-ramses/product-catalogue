# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe HomeController do
  describe '#index' do
    let(:user) { create(:user) }

    context 'when user is not logged in' do
      it 'redirects the user to the root path' do
        get :index

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is logged in' do
      login_user

      it 'renders the index page' do
        get :index

        expect(response).to render_template :index
      end
    end
  end
end
