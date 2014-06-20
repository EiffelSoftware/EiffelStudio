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
	
	-- A violation is triggered regardless of the export status of the accessor and the attribute.
	
feature -- Public
	
	get_secret_attribute_1: INTEGER -- Violation here
		do
			Result := secret_attribute
		end
	
	get_secret_attribute_2: INTEGER
		do
			Result := secret_attribute + 1
		end
	
	get_secret_attribute_3: INTEGER
		do
			Result := secret_attribute
			io.put_string ("Foo")
		end
		
	get_secret_attribute_4: INTEGER
		do
			Result := secret_attribute
			Result := secret_attribute
				-- This one should not trigger any violation.
				-- This is not an usual getter function.
				-- We don't try to guess what the programmer is trying to do.
		end

feature {NONE} -- Secret area!

	secret_attribute: INTEGER

end
