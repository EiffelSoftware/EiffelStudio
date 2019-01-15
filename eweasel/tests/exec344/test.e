class TEST
inherit
	TEST1
		redefine
			string
		end

create
	make

feature
	 make
	 	do
	 		new_tuple (create {DIRECTORY_NAME}.make_from_string ("Manu"))
	 	end

	string: DIRECTORY_NAME

end
