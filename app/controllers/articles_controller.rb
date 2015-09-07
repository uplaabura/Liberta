class ArticlesController < ApplicationController
	
	#http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

	def index
    @all_articles = Article.all
  end

	def show
    @article = Article.find(params[:id])
  end

	def new
		@article = Article.new
	end 

	def create
		#render plain: params[:article].inspect
		#@article = Article.new(params[:article])
		@article = Article.new(article_params)

		if @article.save
		  redirect_to article_path(@article)
		else
		  render 'articles/new'
		end
	end 

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to article_path(@article)
		else
			render 'articles/edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		 
		redirect_to articles_path
	end

	#private vars
	private
	  def article_params
	    params.require(:article).permit(:title, :text)
	  end
end
