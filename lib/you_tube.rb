class YouTube
  include HTTParty
  format :xml
  base_uri 'gdata.youtube.com'
  default_params :output => 'xml'
  
  def initialize(obj)
    @clip_id   = obj.video_url.split('?v=').last.split('&').first
    @embed_url = "http://www.youtube.com/v/#{@clip_id}&hl=en&fs=1"
    @response  = self.class.get("/feeds/api/videos/#{@clip_id}")
  end
  
  def screen_ratio
    height = @response["entry"]["media:group"]["media:thumbnail"][0]["height"].to_f
    width = @response["entry"]["media:group"]["media:thumbnail"][0]["width"].to_f
    height / width
  end
  
  def thumbnail_url
    #@response["entry"]["media:group"]["media:thumbnail"][0]["url"]
    "http://img.youtube.com/vi/#{@clip_id}/0.jpg"
  end
  
  def embed_html(width = 425)
    width = 425 if width.to_i < 1
    height = (width.to_f * screen_ratio).to_i
    <<-END
      <object width="#{width}" height="#{height}" style="z-index: 0; position: relative;">
        <param name="movie" value="#{@embed_url}" />
        <param name="allowFullScreen" value="true" />
        <param name="wmode" value="transparent" />
        <param name="bgcolor" value="#FFFFFF" />
        <embed src="#{@embed_url}" type="application/x-shockwave-flash" bgcolor="#FFFFFF" allowfullscreen="true" wmode="transparent" width="#{width}" height="#{height}" />
      </object>
    END
  end
  
end
