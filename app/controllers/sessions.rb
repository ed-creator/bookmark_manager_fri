class BookmarkManager < Sinatra::Base

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

post '/sessions/end' do
  flash.next[:goodbye_message] = "Goodbye"
  session[:user_id] = nil
  redirect '/links'
end

end 
