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
	 		new_tuple (create {FILE_NAME}.make_from_string ("Manu"))
	 	end

	string: FILE_NAME

end
