module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise_mapping'] = Devise.mappings[:user]
      user ||= FactoryBot.create(:user, role: 1)
      sign_in user
    end
  end
end
