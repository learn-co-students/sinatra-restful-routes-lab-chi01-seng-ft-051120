require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes' do 
    erb :index
  end 

  get '/recipes/new' do 
    erb :new 
  end 

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])

    erb :show 
  end
  
  post '/recipes' do 
    if params[:recipe] == nil
      @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])  
    else 
      @recipe = Recipe.create(params[:recipe])
    end
    
    redirect "/recipes/#{@recipe.id}"
  end 

  get '/recipes/:id/edit' do 
    @recipe = Recipe.find(params[:id])

    erb :edit 
  end 

  patch '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    @recipe.update
    redirect "/recipes/#{@recipe.id}"
  end 

  delete '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    @recipe.destroy 
    redirect '/recipes'
  end 
end
