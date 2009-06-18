indexing
	description : "project application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			string: PEG_PARSER_STRING
		do
			create string.make_from_string ("123456789")
			print ("%N")
			print ("%N")
			print (string.out)
			print ("%N")
			print (string.substring (5, 8))
			print ("%N")
			print (string.substring_index (4))
			print ("%N")
			print (string.substring_index (4).substring (2, 3))
			print ("%N")
			print (string.is_empty)
			print ("%N")
			print (string.starts_with ('1'))
			print ("%N")
			print (string.starts_with ('2'))
			print ("%N")
			print (string.substring (5, 6).starts_with ('5'))
			print ("%N")
		end

end
