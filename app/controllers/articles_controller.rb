class ArticlesController < ApplicationController
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
    @article = Article.find(params[:id])
  end

  protected

    def resource_not_found
      message = "The article your are looking for could not be found"
      flash[:alert] = message
      redirect_to root_path
    end

  private

    def article_params
      # Pass in article; permitting require attributes
      params.require(:article).permit(:title, :body)
    end

end
