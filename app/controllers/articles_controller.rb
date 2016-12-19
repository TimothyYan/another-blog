class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  # Creating a new instance variable called @article, otherwise @article would
  # 'nil' in our view, and calling @article.errors.any? would throw an error
  def new
    @article = Article.new
  end
    
    def edit
      @article = Article.find(params[:id])
    end
  def create
    @article = Article.new(article_params)
    
    # Check validations from model. True -
    if (@article.save)
      redirect_to @article
    else
    # 'save' returns false, render method used so @article object is paseed back
    # to 'new' template when rendered within same request as form submission
    # redirect will tell browser to  issue another request
      render 'new'
    end
  end
  
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
    
end