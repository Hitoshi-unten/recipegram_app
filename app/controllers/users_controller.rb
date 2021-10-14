class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
    # 一人の情報をユーザーモデルから持ってきて@userという変数に代入する。アクションで変数を定義してビューに渡す、この一連の流れを覚える。
    # params[:id]で番号を取ってきている。どこから番号を取ってきているかというとurlから取ってきている。ユーザーモデルにあるデータベースに登録してあるidが一番のものを取ってきてくださいと指令している。

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path, alert: '不正なアクセスです。'
    end
  end
  
  def update #まずどのユーザーを更新するのかを見つけてきて、@userに入れる。@userを更新する。redirect_to画面遷移でユーザーの詳細画面に戻る。
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '更新に成功しました。'
    else
      render :edit #もし編集に失敗したらeditにrenderさせる
    end
  end

  private #user_paramsを定義する。privateの下に書く。定番の書き方なので覚える。params.require(モデル名).permit(許可するカラム名)。user_paramsを定義しないとrailsではエラーが出る。これは何をしているのかというと、privateの下に書くことによって、users controllerの中でしかuser_paramsは呼び出せない。よってusernameとかデータの情報というのはコントローラーの中でしか呼び出せない。こうすることでセキュリティに強くなる。外部からデータベースの情報を取り出せなくなる。
  def user_params
    params.require(:user).permit(:username, :email, :profile, :profile_image)
  end
end
