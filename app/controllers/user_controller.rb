class UserController < ApplicationController
  before_action :get_users, only: %i[index show_users]

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
    if check_code || current_user&.record.present?
      #Code bị trùng chuyển về trang hiện tại
      redirect_to show_users_path(current_user.id), notice: "Code không hợp lệ"
    else
      extra_coin = 30
      #Lưu vào record
      present_user = User.find_by(invited_code: invited_code)
      record = Record.create(user_id: current_user.id, present_user_id: present_user.id)
      present_user.coin += extra_coin
      #Gọi hàm tăng coin
      raising_coin(present_user, extra_coin)
      present_user.update(coin: present_user.coin)
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

  def raising_coin(present_user, extra_coin)
    extra_coin -= 10

    return if extra_coin == 0
    last_present_user = User.find_by(id: present_user&.record&.present_user_id)
    if last_present_user.present?
      last_present_user.coin += extra_coin
      last_present_user.save
    end

    raising_coin(last_present_user, extra_coin)
  end

end
