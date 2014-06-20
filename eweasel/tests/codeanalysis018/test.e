note
	description: "project2 application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit

		-- Violations only triggered in case of repeated inheritance with
		-- no redefine, rename, select, or undefine.
		-- Being conforming or non conforming inheritance plays no role,
		-- everything is considered together.
		-- Only one violation is triggered per ancestor.

	ANY
	ANY
		undefine
			is_equal
		end
	ANY
	
	ANCESTOR_1
	
	ANCESTOR_2
		rename
			is_equal as maybe_its_not_equal
		select
			maybe_its_not_equal
		end
	
	ARGUMENTS
	ARGUMENTS
	ARGUMENTS
	
inherit {NONE}
	
	ARGUMENTS
	
	ANCESTOR_2
	
	ANCESTOR_1

create
	make_2

feature {NONE} -- Initialization

	make_2
			-- Initialization
		do
			io.put_string ("Foo")
		end
	
end
