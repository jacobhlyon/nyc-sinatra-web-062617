class FiguresController < ApplicationController

	get '/figures' do 
		@figures = Figure.all

		erb :'figures/index'
	end

	get '/figures/new' do

		erb :'figures/new'
	end

	post '/figures' do
		# binding.pry
		@figure = Figure.create(name: params[:figure][:name])

		if !params[:landmark][:name].empty?
			@landmark = Landmark.create(name: params[:landmark][:name])
			@figure.landmarks << @landmark
		elsif params[:figure][:landmark_ids]
			@landmark = Landmark.find(params[:figure][:landmark_ids])
			@figure.landmarks << @landmark
		else 
			@figure.landmarks = []
		end


		if !params[:title][:name].empty?
			@title = Title.create(name: params[:title][:name])
			@figure.titles << @title
			@figure.save

		else
			@title = Title.find(params[:figure][:title_ids])
			@figure.titles << @title
			@figure.save
		end

		redirect '/figures'
	end

	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])

		erb :'figures/edit'
	end

	post '/figures/:id' do 
		@figure = Figure.find(params[:id])
		@figure.name = params[:figure][:name]
		if params[:figure][:landmarks]
			@figure.landmarks = Landmark.find(params[:figure][:landmarks])
		end
		if !params[:figure][:new_landmark].empty?
			@landmark = Landmark.new(name: params[:figure][:new_landmark])
			@figure.landmarks << @landmark
		end
		@figure.save

		redirect "/figures/#{@figure.id}"
	end

	get '/figures/:id' do
		@figure = Figure.find(params[:id])

		erb :'figures/show'
	end

	

end