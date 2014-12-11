TableView-iTunes-JSON-Project
=============================

A simple app to demonstrate the use of table views and simple JSON parsing methods in Swift.

The app consists of two views: a master view, containing a UISearchBar and a UITableView and a detail view that displays album art. The master view takes input from the search bar, constructs a URL to be sent via HTTP to iTunes, which returns a JSON response containing album information. A method is called to parse the JSON, and new album objects are created and listed in the table view. Tapping a row on the table view passes the albumArtURL property of the selected object (via indexPathForSelectedRow()) to the detail view, which uses a UIImageView to load the (super low res) album art and display it.

The networking logic is, unfortunately, written synchronously, and as a result the app is not as responsive as it should be. Future projects will explore asynchronous logic, and it will be awesome. 
