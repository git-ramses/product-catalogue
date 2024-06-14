# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe UsersController, type: :controller do
  describe '#show' do
    let(:user) { create(:user) }

    subject { get :show, params: { id: 1 } }

    context 'when user is not logged in' do
      it 'redirects the user to the root path' do
        expect(subject).to redirect_to new_user_session_path
      end
    end

    context 'when user is logged in' do
      login_user

      context 'when user is not authorized' do
        let!(:other_user) { create(:user) }

        subject { get :show, params: { id: other_user.id } }

        before { allow(controller).to receive(:authorize!).and_raise(CanCan::AccessDenied) }

        it 'redirects to root path' do
          expect(subject).to redirect_to root_path
        end
      end

      context 'when user is authorized' do
        before { allow(controller).to receive(:authorize!).and_return(true) }

        it 'renders the show template' do
          expect(subject).to render_template :show
        end
      end
    end
  end

  describe '#edit' do
    let(:user) { create(:user) }

    subject { get :edit, params: { id: 1 } }

    context 'when user is not logged in' do
      it 'redirects the user to the root path' do
        expect(subject).to redirect_to new_user_session_path
      end
    end

    context 'when user is logged in' do
      login_user

      context 'when user is not authorized' do
        let!(:other_user) { create(:user) }

        before { allow(controller).to receive(:authorize!).and_raise(CanCan::AccessDenied) }

        subject { get :show, params: { id: other_user.id } }

        it 'redirects to root path' do
          expect(subject).to redirect_to root_path
        end
      end

      context 'when user is authorized' do
        before { allow(controller).to receive(:authorize!).and_return(true) }

        it 'renders the edit template' do
          expect(subject).to render_template :edit
        end
      end
    end
  end

  describe '#update' do
    let(:user) { create(:user) }
    let(:params) { { id: user.id, user: { role: 0 } } }

    subject { patch :update, params: params }

    context 'when user is not logged in' do
      it 'redirects the user to the root path' do
        expect(subject).to redirect_to new_user_session_path
      end
    end

    context 'when user is logged in' do
      login_user

      context 'when user is not authorized' do
        let!(:other_user) { create(:user) }

        subject { get :show, params: { id: other_user.id } }

        before { allow(controller).to receive(:authorize!).and_raise(CanCan::AccessDenied) }

        it 'redirects to root path' do
          expect(subject).to redirect_to root_path
        end
      end

      context 'when user is authorized' do
        before { allow(controller).to receive(:authorize!).and_return(true) }

        context 'when update succeeds' do
          it 'updates the user' do
            patch :update, params: params
            expect(response).to redirect_to user_path(id: user.id)
          end
        end
      end
    end
  end
end
