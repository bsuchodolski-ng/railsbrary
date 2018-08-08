class UsersBaseController < ApplicationController
  before_action :authenticate_user!
end
