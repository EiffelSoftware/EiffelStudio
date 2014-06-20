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
	
		-- Placing every argument on a single line
		-- so that every violation is on a different line
	feature_with_many_arguments (
			a_ok: detachable STRING;
			a_bad__1: detachable STRING;
			a_baD_2: detachable STRING;
			a_baD_3: detachable STRING;
			bad_4: detachable STRING; -- ok if l_ prefix is not enforced
		)
		do
			
		end

end
