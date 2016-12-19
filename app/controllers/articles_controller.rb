class ArticlesController < ApplicationController
  
  http_basic_authenticate_with name: "Tim", password: 'railsisawesome', except: [:index, :show]
 
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.all
  end
  
  def show
  end
  
  # Creating a new instance variable called @article, otherwise @article would
  # 'nil' in our view, and calling @article.errors.any? would throw an error
  def new
    @article = Article.new
  end
    
  def edit
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
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  def destroy
    @article.destroy
    redirect_to articles_path
  end
  
  private
    def find_article
      @article = Article.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :text)
    end
    
end