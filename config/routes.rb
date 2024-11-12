Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  post   "transfer/pix/:pix_key",         to: "transfers#transfer_pix"
  post   "transfer/create_pixkey",        to: "transfers#create_pixkey"
  post   "transfer/doc",                  to: "transfers#transfer_ted"
  post   "transfer/ted",                  to: "transfers#transfer_doc"

  get    "transfers/",            to: "transfers#user_transfers_list"
  get    "transfers/:id/receipt", to: "transfers#get_transfer_receipt"

  get    "admin/transfers/",    to: "transfers#list"
  get    "admin/transfers/:id", to: "transfers#show"
  delete "admin/transfers/:id", to: "transfers#delete"
end
