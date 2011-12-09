#About

MediaMonkey is a Sinatra and Nginx powered CDN and thumbnail generator for web applications. 
  
Simply POST your file, and MediaMonkey will jump through hoops to generate the necessary thumbnails, place them in the appropriate folder and return a URL so you can access it in the future. You can also DELETE that url to
remove the file.

All GET requests are served by Nginx, including a manifest.json file in each directory allowing for easy access via JavaScript.

You can also define defaults, which Nginx will serve should the file not exist. This can be extremely useful for avatars where you don't necessarily want to query your database to show an image or the avatar.

#Warning

This is currently a work in progress, and far from production-ready. Contributions are welcome.

#Behavior

__Media is uploaded to__

`POST /:resource/:id/(:type)`
  
- If the resource is an image
	- It will be converted to the specified format
	- Thumbnails will be generated in each of the defined sizes
- If the type is defined
	- Naming will be based on the type
	- Otherwise the name or a hash will be used
	- If a file already exists for that type, the files will be replaced

__Images can be accessed through__

`GET /:resource/:id/(:type|:name)_:size.:extension`

__Other files can be accessed through__

`GET /:resource/:id/:name.:extension`

__If the file doesn't exist, Nginx will try the following__

If the size is present

- With type: `GET /:ressource/defaults/:type_:size.:extension`
- Without: `GET /:ressource/defaults/default_:size.:extension`

Otherwise

- With type: `GET /:ressource/defaults/:type.:extension`
- Without: `GET /:ressource/defaults/default.:extension`

If none of these exist, a 404 will be returned.

__Media can be deleted through__

`DELETE /:ressource/:id/(:name|:type)`

__Non public media__

TODO