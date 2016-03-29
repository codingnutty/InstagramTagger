class InstaPost < ActiveRecord::Base
  belongs_to :collection

  def preflight
    render nothing: true
  end

  def self.contains_hashtag?(text, hashtag)
    text.downcase.include?(hashtag)
  end

  def self.falls_within_date_range?(date, start_date, end_date)
    if(start_date.to_i <= date.to_i && date.to_i <= end_date.to_i)
      return true
    else
      return false
    end
  end

  def self.caption_empty?(result)
    result["caption"]["text"] ? false : true
  end

  def self.is_a_video?(result)
    result["type"] == "video"
  end

  def self.filter_data(result, hashtag, search_start_date, search_end_date)
    filtered_data = {ig_username: result["user"]["username"], content_type: result["type"], image_url: result["images"]["thumbnail"]["url"], "ig_link": result["link"]}

    if caption_empty?(result)
      filtered_data[:description] = ""
    else
      created_time = result["caption"]["created_time"].concat("000")
      filtered_data[:description] = result["caption"]["text"]
      if contains_hashtag?(filtered_data[:description], hashtag)
        if falls_within_date_range?(created_time, search_start_date, search_end_date)
          filtered_data[:tag_time] = created_time
        end
      else
        comments = result["comments"]["data"].select {|comment| comment['from']['username'] == filtered_data[:ig_username]}
        comments.each do |comment|

          if contains_hashtag?(comment["text"], hashtag)
            filtered_data[:tag_time] = comment["created_time"].concat("000")
            break
          end
        end
      end
    end

    if is_a_video?(result)
      filtered_data[:video_url] = result["videos"]["standard_resolution"]["url"]
    else
      filtered_data[:video_url] = ""
    end
    filtered_data
  end
end
