class FiguresController < ApplicationController

  # get '/figures' do
  #   @figures = Figure.all
  #   erb :'/figures/index'
  # end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do

    figure = Figure.new(name: params["figure_name"])

    params["figure"]["title_ids"].each do |id|
      figure.titles << Title.find(id.to_i)
    end if params["figure"]["title_ids"] != nil

    params["figure"]["landmark_ids"].each do |id|
      figure.landmarks << Landmark.find(id.to_i)
    end if params["figure"]["landmark_ids"] != nil

    figure.titles << Title.find_or_create_by(name: params["title"]["name"]) if params["title"]["name"] != ""

    figure.save
  end

end
