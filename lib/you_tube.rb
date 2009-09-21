class YouTube
  include HTTParty
  format :xml
  base_uri 'gdata.youtube.com'
  default_params :output => 'xml'
  
  def initialize(obj)
    @clip_id   = obj.video_url.split('?v=').last
    @embed_url = "http://www.youtube.com/v/#{@clip_id}&hl=en&fs=1"
    @response  = self.class.get("/feeds/api/videos/#{@clip_id}")
  end
  
  def thumbnail_url
    @response["entry"]["media:group"]["media:thumbnail"][0]["url"]
  end
  
  def embed_html(width = 425)
    width = 425 if width.to_i < 1
    height = (width.to_i * 0.809411764705882).to_i
    <<-END
      <object width="#{width}" height="#{height}">
        <param name="movie" value="#{@embed_url}" />
        <param name="allowFullScreen" value="true" />
        <embed src="#{@embed_url}" type="application/x-shockwave-flash" allowfullscreen="true" width="#{width}" height="#{height}" />
      </object>
    END
  end
  
end
