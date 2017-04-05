ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'models/link'
require_relative 'models/tag'

class BookmarkManager < Sinatra::Base

  get '/links' do
    @links = Link.all
    @tags = Tag.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new_link'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    tag = Tag.first_or_create(tag_name: params[:tag_name])
    link.tags << tag
    link.save
    # LinkTag.create(:link => link, :tag => tag)
    redirect '/links'
  end

  run! if app_file == $0

end
