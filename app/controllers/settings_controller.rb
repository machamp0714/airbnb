class SettingsController < ApplicationController

  def edit
    @setting = current_user.setting
  end

  def update
    @setting = current_user.setting
    if @setting.update(setting_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Cannot save..."
    end
    render "edit"
  end

  private
    def setting_params
      params.require(:setting).permit(:enable_sms, :enable_email)
    end
end
