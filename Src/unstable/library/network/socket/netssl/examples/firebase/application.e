note
	description : "firebase application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
		local
			l_firebase_api: FIREBASE_API

		do
			create l_firebase_api.make
				-- Get
			if attached l_firebase_api.get ("/users/jack/name") as l_response then
				print ("%NGET: "+  l_response)
				io.put_new_line
			end

				-- Put
			if attached l_firebase_api.put ("/users/jack/name","{ %"first%": %"Jack%", %"last%": %"Sparrow%" }") as l_response then
				print ("%NPUT: "+  l_response)
				io.put_new_line
			end

				-- Post
			if attached l_firebase_api.post ("/users/jack/name","{%"user_id%" : %"jack%", %"text%" : %"Ahoy!%"}") as l_response then
				print ("%NPOST: "+  l_response)
				io.put_new_line
			end


				-- Patch
			if attached l_firebase_api.patch ("/users/jack/name/","{%"last%":%"Jones%"}") as l_response then
				print ("%NPATCH: "+  l_response)
				io.put_new_line
			end

				-- Delete
			if attached l_firebase_api.delete ("/users/jack/name/last") as l_response then
				print ("%NDELETE: "+  l_response)
			end
		end


end
