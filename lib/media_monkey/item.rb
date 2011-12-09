require "iconv"

module MediaMonkey
  class Item
    attr_accessor :resource, :resource_id, :file_path, :file_name, :type, :base_name
  
    def process
      store_original
      generate_thumbnails
    end
    
    private
  
    def store_original
      # Create directory
      FileUtils.mkdir_p([storage_path, "original"].join("/"))
    
      # Save file to that directory
      FileUtils.cp(file_path, [storage_path, "original", file_name].join("/"))
    end
    
    def generate_thumbnails
      configuration['thumbnails'].each do |name, options|
        command_options = options.map{|key,value| "-#{key} #{value}"}.join(" ")
        original_file = [storage_path, "original", file_name].join("/")
        target_file   = [storage_path, "#{name}.#{configuration['image_format']}"].join("/")
        system "#{configuration['gm_path']} convert #{command_options} #{original_file} #{target_file}"
      end
    end
  
    def storage_path
      @storage_path ||= generate_storage_path
    end

    def generate_storage_path
      blocks = [configuration["base_directory"], resource, resource_id]
      if type
        blocks << type
      else
        if configuration["use_original_file_names"]
          base_name = escape_filename(file_name.gsub(/\.[a-z]*\z/, ""))
        else
          base_name = random_filename
        end
        blocks << base_name
      end
      return blocks.join("/")
    end
  
    def configuration
      MediaMonkey::Server.configuration
    end
  
    # Extracted from http://cl.ly/3g173l461F3O111o3X2S
    def escape_filename(string)
      result = ((translation_to && translation_from) ? Iconv.iconv(translation_to, translation_from, string) : string).to_s
      result.gsub!(/[^\x00-\x7F]+/, '')
      result.gsub!(/[^\w_ \-]+/i,   '')
      result.gsub!(/[ \-]+/i,      '-')
      result.gsub!(/^\-|\-$/i,      '')
      result.downcase!
      result.size.zero? ? random_permalink(string) : result
    rescue
      random_filename(string)
    end
  
    def random_filename(seed = nil)
      Digest::SHA1.hexdigest("#{seed}#{Time.now.to_s.split(//).sort_by {rand}}")
    end
  
  end
end