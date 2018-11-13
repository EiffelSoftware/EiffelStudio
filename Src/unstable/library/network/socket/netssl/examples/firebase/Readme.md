Simple Firebase API example using SSL

The example shows how to use the Firebase Rest API described here Check https://firebase.google.com/docs/reference/rest/database/


First you will need to create a Firebase database using Google Cloud PLatform

Then go to your console  https://console.firebase.google.com

Get the URL of your API that will be something like this `https://[PROJECT_ID].firebaseio.com`


To learn more read: https://firebase.google.com



How to use it:
=============
Update the FIREBASE_API with your host

	host: STRING = "[PROJECT_ID].firebaseio.com"
			-- Update to use your [PROJECT-ID].


Static Version
==============
OpenSSL Static libraries are not distrubuted by default. 
Check OpenSSL library to get more information.

Client
------
	Use the ecf `firebase_static.ecf` 



Dynamic Version
===============
Dynamic libraries are part of the delivery.

Client
------
	Use the ecf `firebase.ecf` 

