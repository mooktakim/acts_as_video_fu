module Mdarby
  module Acts #:nodoc:
    module Acts_as_video_fu_helper
  
      def display_video(obj, width = 425)
        video_klass(obj).embed_html(width)
      end
      
      def thumbnail_url(obj)
        video_klass(obj).thumbnail_url
      end
      
      
      private
      
        def video_klass(obj)
          obj.type.new(obj)
        end
        
    end
  end
end
