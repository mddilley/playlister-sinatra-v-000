class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :"/songs/index"
  end

  get '/songs/new' do
    erb :"/songs/new"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    erb :"/songs/show"
  end

  post '/songs' do
    @song = Song.create(:name => params["Name"])
    @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
    @song.genre_ids = params[:genres]
    @song.save
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/edit"
  end

  patch '/songs/:slug' do
    @song = Song.find_slug(params[:slug])
    @song.artist.update(:name => params["Artist Name"])
    @song.genre_ids = params["genres"]
    redirect "/songs/#{@song.slug}"
  end


end
