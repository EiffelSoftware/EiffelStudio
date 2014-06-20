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
		local
			l_foo: BOOLEAN
		do
			feature_1
			feature_2
		rescue
			l_foo := true
		end
	
	feature_1
		do
			io.put_string ("Foo")
		end
	
	feature_2
			-- This feature should trigger a violation.
		do
			io.put_string ("Foo")
		rescue
		end

end
