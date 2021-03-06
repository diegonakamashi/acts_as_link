require 'net/http'
require 'uri'
require 'rubygems'
require 'bitly'

module ActsAsLink
  class Link
    
    IMAGE_EXTENSIONS = %w(.bmp .gif .ico .jpeg .jpg .png .psd .svg .tif .tiff .xcf)
    
    def initialize(url)
      @uri = URI.parse(url)
      raise 'Link is not an url' if (@uri.class != URI::HTTP && @uri.class != URI::HTTPS)
    end  
    
    def is_broken?
      response = Net::HTTP.start(@uri.host, @uri.port) { |http| response = http.head(@uri.path.size > 0 ? @uri.path : "/")}  
      response_code_is_not_valid?(response.code)
    end
    
    def is_an_image?
      extension = get_extension(@uri.to_s)
      verify_if_extension_is_an_image(extension)
    end
    
    def shorten
      shorten_link_with_bitly(@uri.to_s)    
    end
    
  private 

    def response_code_is_not_valid?(code) 
      if code_is_empty(code) || code_is_an_error_code(code)
        true
      else
        false
      end
    end  
    
    def code_is_empty(code)
      if code.nil?
        true
      else
        code[0..0] == ""
      end 
    end
    
    def code_is_an_error_code(code)
      code[0..0] == "4" || code[0..0] == "5"
    end
    
    def get_extension(uri)
      point_position = uri.rindex('.')
      uri_length = uri.length
      point_position > (uri_length - 6) ? uri[point_position..uri_length] : nil
    end
    
    def verify_if_extension_is_an_image(extension)
      return false if extension.nil?
      is_an_image = false
      IMAGE_EXTENSIONS.each do |ext| 
        is_an_image = (extension == ext)
        break if is_an_image
      end
      is_an_image
    end
    
    def shorten_link_with_bitly(link)
      Bitly.use_api_version_3
      bitly = Bitly.new('actsaslink', 'R_fc70af6573e064c0f4081317bb592f18')
      bitly.shorten(link).short_url
    end
      
  end
end
