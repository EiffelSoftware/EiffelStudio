indexing

	description:
			"Information about the name of a certain function %
			%  or feature.";
	date: "$Date$";
	revision: "$Revision$"

deferred class LANGUAGE_FUNCTION

inherit
	ANY
		undefine
			out
		end;

feature -- Name of the function

	name: STRING is
			-- The name of the function.
		deferred
		end

feature -- Cyclic

	set_member_of_cycle (cyc_num: INTEGER) is
			-- Makes `Current' member of cycle with number `cyc_num'.
		do
			cycle_num := cyc_num;
		end;

feature -- Status report

	is_member_of_cycle: BOOLEAN is
			-- Is `Current' member of any cycle?
		do
			Result := (not (cycle_number = 0));
		end;

	cycle_number: INTEGER is
			-- Number of the cycle `Current' is member of.
		require
			member: is_member_of_cycle;
		do
			Result := cycle_num;
		end;

feature -- Output

	append_to (st: STRUCTURED_TEXT) is
			-- Append Current function to `st'.
		require
			valid_st: st /= Void
		do
			st.add_string (out)
		end;

	out: STRING is
			-- Representation for output.
		do
			Result := name;
		end;

feature {NONE} -- Attributes

	cycle_num: INTEGER
			-- Number of the cycle of which this function is a member.

end -- class LANGUAGE_FUNCTION
