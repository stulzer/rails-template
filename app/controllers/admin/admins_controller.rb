class Admin::AdminsController < Admin::BaseController
  menu_item :admins

  before_action :set_admin, :only => [:show, :edit, :update, :destroy]

  def index
    @admins = Admin.all
  end

  def show
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    flash[:notice] = 'Admin criado com sucesso.' if @admin.save
    respond_with @admin, :location => admin_admins_path
  end

  def edit
  end

  def update
    flash[:notice] = 'Admin alterado com sucesso.' if @admin.update_attributes(admin_params)
    respond_with @admin, :location => admin_admins_path
  end

  def destroy
    flash[:alert] = 'Admin deletado com sucesso' if @admin.destroy
    respond_with @admin, :location => admin_admins_path
  end

  private
    def set_admin
      @admin = Admin.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit(:name, :email, :password, :password_confirmation)
    end
end
