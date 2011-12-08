#About

MediaMonkey is a Sinatra and Nginx powered CDN and thumbnail generator for web applications. 
  
Simply POST your file, and MediaMonkey will jump through hoops to generate the necessary thumbnails, place them in the appropriate folder and return a URL so you can access it in the future. You can also DELETE that url to
remove the file.

All GET requests are served by Nginx, including a manifest.json file in each directory allowing for easy access via JavaScript.

You can also define defaults, which Nginx will serve should the file not exist. This can be extremely useful for avatars where you don't necessarily want to query your database to show an image or the avatar.

#Warning

This is currently a work in progress, and far from production-ready. Contributions are welcome.