class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end


  get '/figures/:id' do
    @figure = Figure.find(params["id"].to_i)
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params["id"].to_i)
    erb :'/figures/edit'
  end


  post '/figures' do
    figure = Figure.new(name: params["figure_name"])

    if params["figure"]
      params["figure"]["title_ids"].each do |id|
        figure.titles << Title.find(id.to_i)
      end if params["figure"]["title_ids"]

      params["figure"]["landmark_ids"].each do |id|
        figure.landmarks << Landmark.find(id.to_i)
      end if params["figure"]["landmark_ids"] != nil
    end

    if params["title"]
      figure.titles << Title.find_or_create_by(name: params["title"]["name"]) if params["title"]["name"] != ""
    end

    if params["landmark"]
      figure.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"]) if params["landmark"]["name"] != ""
    end

    figure.save
    redirect to "/figures/#{figure.id}"
  end

  post '/figures/:id' do
    figure = Figure.find(params[:id].to_i)
    figure.update(name: params["figure_name"]) if !params["figure_name"].empty?
    figure.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"]) if !params["figure_name"].empty?
    figure.landmarks << Landmark.find(params["figure"]["landmark_ids"]) if !params["figure_name"].empty?

    figure.save
    redirect to "/figures/#{figure.id}"
  end


end
