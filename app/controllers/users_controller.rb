class UsersController < ApplicationController
  before_action :authorize_request
  before_action :find_user, except: %i[create index]

end
