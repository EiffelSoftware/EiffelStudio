class CYCLE_FUNCTION

inherit
	FUNCTION

creation
	make

feature -- Creation

	make (new_number: INTEGER) is
			-- Create a cycle with number `new_number'.
		do
			number := new_number
		end

feature -- Output

	name: STRING is
			-- The name of the cycle.
		do
			!! Result.make (0);
			Result.append_string ("<cycle ");
			Result.append_string (number.out);
			Result.append_string (">")
		end

feature {NONE} -- Attributes

	number: INTEGER
		-- Number of cycle.

end -- class CYCLE_FUNCTION
