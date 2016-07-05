class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params["id"].to_i)
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params["id"].to_i)
    erb :'/landmarks/edit'
  end


  post '/landmarks' do
    landmark = Landmark.new(name: params["landmark_name"])
    landmark.update(year_completed: params["landmark"]["year_completed"])
    landmark.save
    redirect to "/landmarks/#{landmark.id}"
  end

  
  post '/landmarks/:id' do
    landmark = Landmark.find(params[:id])
    landmark.update(name: params["name"])
    landmark.update(year_completed: params["year_completed"])
    landmark.save

    redirect to "/landmarks/#{landmark.id}"
  end

end
