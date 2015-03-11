get '/prompts/create' do
  admin = Admin.find(session[:user_id])
  if admin
    erb :'prompts/_create'
  else
    erb :'content/_error',
  end
end

post '/prompts' do
  prompt = Prompt.new(params)
  if prompt.valid?
    prompt.save
    redirect '/prompts/success'
  else
    redirect '/prompts/error'
  end
end

get '/prompts/error' do
  erb :'content/_error', :locals => {error_title: "Huzzah! You did it!",
                                        error_description: "New prompt added."}
end

get '/prompts/success' do
  erb :'content/_success', :locals => {success_title: "Huzzah! You did it!",
                                        success_description: "New prompt added."}
end

get '/prompts/:id' do
  prompt = Prompt.find(params[:id])
  erb :'prompts/_show', :locals => {prompt: prompt}
end


