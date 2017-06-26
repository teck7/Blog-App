class ArticlesController < ApplicationController

  # Ensure a user is signin except for a couple of action
  before_action :authenticate_user!, except: [:index, :show]
  #Filter with method called set_article on certain action
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # Create new articel instance and pass in params
    @article = Article.new(article_params)
    # Article is saved
    if @article.save
      # Show success message
      flash[:success] = "Article has been created"
      # Redirect to all articles page
      redirect_to articles_path
    else
      # Show warning message only at that instance
      flash.now[:danger] = "Article has not been created"
      # Display create article page as new again
      render :new
    end
  end

  def show

  end

  def edit
    unless @article.user == current_user
      flash[:alert] = "You can only edit your own article."
      redirect_to root_path
    end
  end

  def update
    unless @article.user == current_user
      flash[:danger] = "You can only edit your own article."
      redirect_to root_path
    else
      if @article.update(article_params)
        flash[:success] = "Article has been updated"
        redirect_to @article
      else
        flash.now[:danger] = "Article has not been updated"
        render :edit
      end
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = "Article has been deleted."
      redirect_to articles_path
    end
  end

  protected

    def resource_not_found
      message = "The article you are looking for could not be found"
      flash[:alert] = message
      redirect_to root_path
    end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      # Pass in article; permitting require attributes
      params.require(:article).permit(:title, :body)
    end

end
