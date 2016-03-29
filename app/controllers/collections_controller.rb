require 'json'
class CollectionsController < ApplicationController
  respond_to :html

  def create
    @collection = Collection.find_or_create_by({tag: params[:tag], start_date: params[:start_date], end_date: params[:end_date]})
    !params[:search].blank? ? @tag = params[:search] : @tag = "all"

    response =  HTTParty.get("https://api.instagram.com/v1/tags/#{@tag}/media/recent?access_token=232747130.1677ed0.6096d8517e7e40658edbf5bfb138306a")
    response_body = JSON.parse(response.body)
    hashtag = params[:search].dup.prepend('#') if params[:search]
    if response_body["data"]
      response_body["data"].each do |result|
        filtered_result_data = InstaPost.filter_data(result, hashtag, @collection.start_date,@collection.end_date)
        @posts = InstaPost.create(ig_username: filtered_result_data[:ig_username], tag_time: filtered_result_data[:tag_time], content_type: filtered_result_data[:content_type], ig_link: filtered_result_data[:ig_link], image_url: filtered_result_data[:image_url], video_url: filtered_result_data[:video_url], description: filtered_result_data[:description], collection_id: @collection.id)
      end
    end
    redirect_to collections_url
  end

  def index
    posts = Collection.all
    posts.each do |c|
       @posts = c.insta_posts
    end
    respond_with do |format|
      format.html # index.html.erb
    end
  end
end
