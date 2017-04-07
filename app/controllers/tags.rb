class BookmarkManager < Sinatra::Base

post '/tags' do
  tag = Tag.first(tag_name: params[:filter])
  $links = tag ? tag.links : []
  redirect '/tags/:tag_name', 303
end

get '/tags/:tag_name' do
  @links = $links
  erb :'links/index'
end

end 
