Rails.application.routes.draw do
  root :to => "collections#index"

  resources :collections do
    collection do
      get 'search'
    end
  end


  # scope 'api/v1' do
  #   resources :collections do
  #     collection do
  #       get 'search'
  #     end
  #     resources :insta_posts
  #   end
  # end

end