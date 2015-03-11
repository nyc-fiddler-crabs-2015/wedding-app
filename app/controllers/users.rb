get '/users/index' do
  content_type :json

  admin = Admin.find(session[:user_id])
  if admin
    guests = {
      attending:    Attending.json_responses,
      notAttending: NotAttending.json_responses,
      noResponse:   NoResponse.json_responses
    }
    return guests.to_json
  else
    erb :'content/_error', :locals => {error_title: "Whoopsie Poopsie!",
                                        error_description: "You need to be an admin to view the guest list."}
  end
end

get '/users/create' do
  admin = Admin.find(session[:user_id])
  if admin
    erb :'users/_create'
  else
    erb :'content/_error', :locals => {error_title: "Whoopsie Poopsie!",
                                        error_description: "You need to be an admin to create users."}
  end
end

put '/users/rsvp' do
  user = session[:user_id]
  user.toggle_attending
end

post '/users' do
  user = User.new(params)
  if user.valid?
    user.save
    redirect '/users/success'
  else
    redirect '/users/error'
  end
end

get '/users/success' do
  erb :'content/_success', :locals => {success_title: "Great Success!",
                                        success_description: "New user successfully created."}
end

get '/users/error' do
  erb :'content/_error', :locals => {error_title: "Shucks.",
                                      error_description: "User wasn't created. Check your inputs and try again!"}
end

get %r{/users/([\d]+)} do
  user = User.find(params[:captures].first)
  erb :'users/_show', :locals => {user: user}
  # redirect "/users/#{user.username}"   ### Redirect to prettier URL???
end

# get %r{/users/([\d]+)} do     ### Prettier URL to redirect to???

# end