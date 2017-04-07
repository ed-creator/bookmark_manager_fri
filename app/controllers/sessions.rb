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

get '/sessions/forgot_password' do
  erb :'sessions/forgot_password'
end

post '/sessions/forgot_password' do
  flash.next[:recovery_email] = 'Recovery email sent'
  user = User.first(email: params[:email])
  user.generate
  flash.next[:token] = user.password_token
  redirect 'sessions/forgot_password'
end

get '/sessions/reset_passwords' do
  erb :'sessions/reset_passwords'
end

post '/sessions/reset_passwords' do
  user = User.first(email: params[:email])
  user.password_confirmation = params[:new_password]
  if user.password_recovery?(params[:email], params[:token])
    user.password = (params[:new_password])
    user.save 
    session[:user_id] = user.id
    redirect '/links'
  end
end

end
