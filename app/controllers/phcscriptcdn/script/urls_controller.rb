require_dependency "phcscriptcdn/application_controller"

module Phcscriptcdn
  class Script::UrlsController < ApplicationController

    # Include Core Helpers, Security & Action Filters
    include Phccorehelpers::PhcpluginsproHelper
    before_action :authenticate_user!
    before_action :set_paper_trail_whodunnit
    before_action :set_script_url, only: [:show, :edit, :update, :destroy]

    # INDEX
    def index
      script_listing = Script::Listing.find(params[:listing_id])
      @script_urls = script_listing.urls
    end

    # SHOW
    def show
      script_listing = Script::Listing.find(params[:listing_id])
      @script_url = script_listing.urls.friendly.find(params[:id])
    end

    # NEW
    def new
      script_listing = Script::Listing.find(params[:listing_id])
      @script_url = script_listing.urls.build
    end

    # EDIT
    def edit
      script_listing = Script::Listing.find(params[:listing_id])
      @script_url = script_listing.urls.find(params[:id])
    end

    # CREATE
    def create
      @script_listing = Script::Listing.find(params[:listing_id])
      @script_url = @script_listing.urls.create(script_url_params)
      @script_url.user_id = current_user.id
      if @script_url.save
        redirect_to script_listing_urls_path, :flash => { :success => 'Author was successfully created.' }
      else
        render :new
      end
    end

    # UPDATE
    def update
      if @script_url.update(script_url_params)
        redirect_to script_listing_urls_path, :flash => { :success => 'Author was successfully updated.' }
      else
        render :edit
      end
    end

    # DELETE
    def destroy
      @script_listing = Script::Listing.find(params[:listing_id])
      @script_url = @script_listing.urls.find(params[:id])
      @script_url.destroy
      redirect_to script_listing_urls_path, :flash => { :error => 'Author was successfully destroyed.' }
    end

    private

    # Common Callbacks
    def set_script_url
      @script_url = Script::Url.friendly.find(params[:id])
    end

    # Whitelists
    def script_url_params
      params.require(:script_url).permit(:script_url, :script_url_release, :script_url_cdn_update, :slug, :user_id, :listing_id, :version_id, :extension_id)
    end

  end
end
