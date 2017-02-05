require 'rails_helper'

RSpec.describe "User", :type => :request do
  it "sees profile" do
    user = User.create(name: 'Caio', email: "caio@caio.com")

    get user_path(user) #get "/users/#{user.id}"
    expect(response.body).to include(user.name)
    expect(response.body).to include(user.id.to_s)
    expect(response.body).to include(user.email)
  end

  it "creates profile" do
    user = User.new(name: 'Caio', email: "caio@caio.com")

    post users_path, { user: user.as_json }

    expect(response.body).to include("User has been created successfully!")
  end

  it "updates profile" do
    old_user = User.create(name: 'Caio', email: "caio@caio.com")
    new_user = User.new(name: 'Caio Penhalver', email: "caio@gmail.com")

    put user_path(old_user), { user: new_user.as_json }

    expect(response.body).to include("User has been updated successfully!")
  end

  it "deletes profile" do
    user = User.create(name: 'Caio', email: "caio@caio.com")

    delete user_path(user)

    expect(response.body).to include("User profile has been deleted!")
  end
end
