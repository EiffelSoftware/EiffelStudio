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
			l_foo: INTEGER
		do
			inspect l_foo
				when 1 then
					io.put_integer (1)
				when 2 then
					io.put_integer (2)
			end
			
			inspect l_foo
				when 1 then
					io.put_integer (1)
				when 2 then
					io.put_integer (2)
				else
					io.put_integer (0)
			end
			
			inspect l_foo -- Violation here
			end
			
			inspect l_foo -- Violation here
				else
					io.put_integer (0)
			end
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
