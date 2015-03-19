Rails.application.routes.draw do

  mount ActiveBatch::Engine => "/activejob_batch"
end
