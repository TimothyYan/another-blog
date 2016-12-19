class CommentsController < ApplicationController
  
  http_basic_authenticate_with name: "Tim", password: "railsisawesome", only: :destroy
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end
  
  def destroy
    # Find article looking a
    @article = Article.find(params[:article_id])
    # Locate comment within comments section
    @comment = @article.comments.find(params[:id])
    # Remove from database and redirect to show action to the article
    @comment.destroy
    redirect_to article_path(@article)
  end
  
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
