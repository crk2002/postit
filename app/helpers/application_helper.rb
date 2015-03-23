module ApplicationHelper
  
  def fix_url(url)
    url.start_with?("http://") ? url : "http://"+url
  end
  
  def fix_time(time)
    Time.zone.at(time).strftime("%D at %r %Z")
  end
  
end
