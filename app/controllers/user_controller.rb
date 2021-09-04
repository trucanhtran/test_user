class UserController < ApplicationController
  before_action :get_users, only: %i[index show_users ]

  def index
    @user = User.new
  end

  def show_users
    @user = User.find_by(id: params[:id])
  end

  def check_code
    invited_code = params[:invited_code].strip
    current_user = User.find_by(id: params[:id])
    check_code = current_user.invited_code == invited_code
    #Kiểm tra code
    if check_code
      #Code bị trùng chuyển về trang hiện tại
      redirect_to show_users_path(current_user.id), notice: "Code không hợp lệ"
    else
      present_user = User.find_by(invited_code: invited_code )
      present_user.coin += 30;
      present_user.update(coin: present_user.coin)
      byebug
      #Lưu vào record
      record = current_user.records.new(users_id: present_user.id)
      record.save!
      byebug
      redirect_to show_users_path(current_user.id), notice: "Nhập thành công"
    end

  end

  def create_user
    user_coin = 100
    invited_code = (0...8).map { ('a'..'z').to_a[rand(26)] }.join.upcase
    @user = User.new(
      name: params[:name],
      coin: user_coin,
      invited_code: invited_code
    )
    if @user.save
      redirect_to show_users_path(@user.id), notice: "Tạo thành công"
    else
      render :create_user
      flash[:error]= "Không tạo được user"
    end
  end

  private

  def get_users
    @users = User.all
  end


end
