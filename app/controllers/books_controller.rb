class BooksController < ApplicationController
  before_action :authenticate_user!,except: [:top]
  before_action :baria_user, only: [:destroy, :update, :edit]

  def create

    # １. データを新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    @book.user_id = current_user.id

    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render 'index'

    end

  end

  def index
     @books = Book.all
     @book = Book.new
     @user = current_user
     @new_book = Book.new
  end

  def show
      @book = Book.find(params[:id])
      @user = @book.user
      @new_book = Book.new
  end

  def edit
      @book = Book.find(params[:id])
  end

  def update

    @book = Book.find(params[:id])

    if @book.update(book_params)
       flash[:notice] = "successfully"
       redirect_to book_path(@book.id)
    else
       render 'edit'
    end
  end


  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    redirect_to books_path  # 投稿一覧画面へリダイレクト
  end


  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def baria_user
     @book = Book.find(params[:id])
     @user = @book.user
     if current_user != @user
        redirect_to books_path
     end
  end

end
