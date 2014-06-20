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
			feature_1
			feature_2
		end
	
	-- Not empty, ok:
	feature_1
		do
			io.put_string ("Foo")
		end
	
	-- Commented: ok
	feature_2
			-- Some comment
		do
		end
	
	-- Has a comment in the body, still ok.
	feature_3
		do
			-- We are not implementing this because of blah blah blah
		end
	
	-- This one should trigger the only violation we have in this class:
	feature_4
		do
			
		end

end
