indexing

	description:
		"Information about a profiled C function.";
	date: "$Date$";
	revision: "$Revision$"

class C_FUNCTION

inherit
	LANGUAGE_FUNCTION

creation
	make

feature -- Creation

	make (new_name: STRING) is
			-- Create a C function with function name
			-- `new_name'.
		do
			function_name := new_name;
		end

feature -- Output

	name: STRING is
			-- The name of the function.
		do
			Result := function_name
		end

feature {NONE} -- Attributes

	function_name: STRING
		-- C function name as declared in source code.

end -- class C_FUNCTION
