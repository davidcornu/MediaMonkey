require "sinatra/base"
require "yaml"
require "./item.rb"

module MediaMonkey
  class Server < Sinatra::Base
    
    dir = File.dirname(File.expand_path(__FILE__))

    set :configuration, YAML.load_file("#{dir}/config_templates/media_monkey.yml")

    # Create base directory if it doesn't exist
    FileUtils.mkdir_p(configuration['base_directory'])
    
    get "/test" do
      return <<-EOF
        <!DOCTYPE html>
        <html>
          <head>
            <title>Test Page</title>
          </head>
          <body>
            <form action="/profiles/1" method="POST" enctype="multipart/form-data">
              <input type='file' name='file'/>
              <input type='submit'/>
            </form>
          </body>
        </html>
      EOF
    end
    
    post "/:resource/:id/?:type?" do
      @item = Item.new
      @item.resource = params[:resource]
      @item.resource_id = params[:id]
      @item.file_path = params[:file][:tempfile].path
      @item.file_name = params[:file][:filename]
      @item.type = params[:type]
        
      if @item.process
        "Success"
      else
        raise "Error processing item."
      end
    end
    
    delete "/:resource/:id/:name" do
      
    end
    
    # Start the server if ruby file executed directly
    run! if app_file == $0
    
  end
end
