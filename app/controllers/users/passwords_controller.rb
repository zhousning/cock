class Users::PasswordsController < Devise::PasswordsController
  layout "application_no_header"

  def forget 
    @user = User.new 
  end

  def update_password
    code = params[:confirm_code]
    @user = User.find_by_phone(user_params[:phone]) 
    #if @user && code == cookies[:reg_code]
    if @user
      if @user.update(user_params)
        bypass_sign_in(@user)
        redirect_to root_path
      else
        render :forget
      end
    else
      redirect_to forget_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:phone, :password, :password_confirmation)
    end
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
