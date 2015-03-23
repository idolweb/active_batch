ActiveBatch::Engine.routes.draw do
  resources :work_units

  resources :batches

  root to: 'batches#index'

end
