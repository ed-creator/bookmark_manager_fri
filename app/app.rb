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
    params[:tag_name].split(',').each do |tag|
      link.tags << Tag.first_or_create(tag_name: tag.strip)
    end
    link.save
    redirect '/links'
  end

  post '/tags' do
    tag = Tag.first(tag_name: params[:filter])
    $links = tag ? tag.links : []
    redirect '/tags/:tag_name'
  end

  get '/tags/:tag_name' do
    @links = $links
    erb :'links/index'
  end

  run! if app_file == $0

end
