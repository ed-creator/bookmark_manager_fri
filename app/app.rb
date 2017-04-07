ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'
require_relative 'models/link'
require_relative 'models/tag'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/links', 303
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/links'
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  post '/signout' do
    flash.next[:goodbye_message] = "Goodbye"
    session[:user_id] = nil
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    @tags = Tag.all
    @user = User.first
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
    redirect '/links', 303
  end

  post '/tags' do
    tag = Tag.first(tag_name: params[:filter])
    $links = tag ? tag.links : []
    redirect '/tags/:tag_name', 303
  end

  get '/tags/:tag_name' do
    @links = $links
    erb :'links/index'
  end

  run! if app_file == $0

end
