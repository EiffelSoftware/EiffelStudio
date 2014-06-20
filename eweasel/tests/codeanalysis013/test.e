note
	description: "project2 application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			io.put_string ("Foo")
		end
	
	bad_feature__1 -- Double underscore
		do
			io.put_string ("Foo")
		end
	
	bad_feature_2_ -- Trailing underscore
		do
			io.put_string ("Foo")
		end
		
	bAD_feature_3 -- Casing
		do
			io.put_string ("Foo")
		end

end
