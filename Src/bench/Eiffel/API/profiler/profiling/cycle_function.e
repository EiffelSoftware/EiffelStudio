indexing

	description:
		"Information about a call cycle.";
	date: "$Date$";
	revision: "$Revision$"

class CYCLE_FUNCTION

inherit
	LANGUAGE_FUNCTION

creation
	make

feature -- Creation

	make (new_number: INTEGER) is
			-- Create a cycle with number `new_number'.
		do
			cycle_num := new_number
		end

feature -- Output

	name: STRING is
			-- The name of the cycle.
		do
			!! Result.make (0);
			Result.append_string ("<cycle ");
			Result.append_string (cycle_num.out);
			Result.append_string (">")
		end

end -- class CYCLE_FUNCTION
