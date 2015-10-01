resources :custom_fields, only: [] do
  resources :values, only: [ :new, :create ], controller: "custom_field/values"
end
