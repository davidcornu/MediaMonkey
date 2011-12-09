require "sinatra/base"

module MediaMonkey
  class Server < Sinatra::Base

    # Application directory
    dir = File.dirname(File.expand_path(__FILE__))

    configure do
      # Load MediaMonkey YAML configuration file
      set :configuration, YAML.load_file("#{dir}config_templates/media_monkey.yml")
    end
    
    post "/:resource/:id(/:type)" do
      # params[:file][:filename]
      # FileUtils.mkdir_p()
      # FileUtils.cp(params[:document][:file][:tempfile].path, somewhere)
    end
    
    delete "/:resource/:id/:name" do
      
    end
    
  end
end