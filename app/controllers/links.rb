class BookmarkManager < Sinatra::Base

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

end 
