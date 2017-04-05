ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
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
    redirect '/links'
  end

  post '/tags' do
    $filter = params[:filter]
    redirect '/tags/:filter'
  end

  get '/tags/:filter' do
    $filter
    erb :'links/filter'
  end

  run! if app_file == $0

end
