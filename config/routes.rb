Phcscriptcdn::Engine.routes.draw do

	# CDN Frontend
	namespace :frontend do
		# Frontend Routes
		resources :cdnpages
	end

	# Script CDN Listing System
	namespace :script do
		# Main Script Module
		resources :listings, class_name: 'Phcscriptcdn::Script::Listing' do
			resources :urls, class_name: 'Phcscriptcdn::Script::Url'
			resources :authors, class_name: 'Phcscriptcdn::Script::Author'
		end
		resources :extensions, class_name: 'Phcscriptcdn::Script::Extension'
		resources :versions, class_name: 'Phcscriptcdn::Script::Version'
		resources :licences, class_name: 'Phcscriptcdn::Script::Licence'
	end
	
	# Application API
	namespace :api, :path => "", :constraints => {:subdomain => "api"} do
		namespace :v1 do

			# Routes for API
			resources :mains, defaults: {format: 'json'}
			resources :informations, defaults: {format: 'json'}
			resources :versions, defaults: {format: 'json'}

		end
	end

end
