require 'rails_helper'

RSpec.describe "User", :type => :request do
  it "sees profile" do
    user = User.create(name: 'Caio',
                        email: "caio@caio.com",
                        password: "112628")

    post auth_path, { auth: { email: user.email, password: user.password } }

    expect(response.body).to include("token")

    json_response = JSON.parse(response.body)
    #$stderr.puts json_response['token']

    get user_path(user), { token: json_response['token'] } #get "/users/#{user.id}"

    expect(response.body).to include(user.name)
    expect(response.body).to include(user.id.to_s)
    expect(response.body).to include(user.email)
  end

  it "creates profile" do
    user = User.new(name: 'Caio',
                    email: "caio@caio.com",
                    password: "112628")

    post users_path, { user: user.as_json}

    expect(response.body).to include("User has been created successfully!")
  end

  it "updates profile" do
    old_user = User.create(name: 'Caio',
                          email: "caio@caio.com",
                          password: "112628",
                          password_confirmation: "112628")
    new_user = User.new(name: 'Caio Penhalver',
                        email: "caio@gmail.com",
                        password: "112628")

    post auth_path, { auth: { email: old_user.email,
                              password: old_user.password } }

    expect(response.body).to include("token")

    json_response = JSON.parse(response.body)

    put user_path(old_user), { user: new_user.as_json,
                              token: json_response['token'] }

    expect(response.body).to include("User has been updated successfully!")
  end

  it "deletes profile" do
    user = User.create(name: 'Caio',
                      email: "caio@caio.com",
                      password: "112628")

    post auth_path, { auth: { email: user.email, password: user.password } }

    expect(response.body).to include("token")

    json_response = JSON.parse(response.body)

    delete user_path(user), { token: json_response['token'] }

    expect(response.body).to include("User profile has been deleted!")
  end

  it "authenticates" do
    user = User.create(name: 'Caio',
                      email: "caio@caio.com",
                      password: "112628")

    post auth_path, { auth: { email: user.email, password: user.password } }

    expect(response.body).to include("token")
  end

  it "rquests profile without token" do
    user = User.create(name: 'Caio',
                        email: "caio@caio.com",
                        password: "112628")

    get user_path(user) #get "/users/#{user.id}"

    expect(response.body).not_to include(user.name)
    expect(response.body).not_to include(user.id.to_s)
    expect(response.body).not_to include(user.email)
    expect(response.body).to include('Authentication failed')
  end

  it "rquests profile with wrong token" do
    user = User.create(name: 'Caio',
                        email: "caio@caio.com",
                        password: "112628")

    get user_path(user), {token: 'kjaflkjdfklajdçaçlaksjf'} #get "/users/#{user.id}"

    expect(response.body).not_to include(user.name)
    expect(response.body).not_to include(user.id.to_s)
    expect(response.body).not_to include(user.email)
    expect(response.body).to include('Authentication failed')
  end

end
