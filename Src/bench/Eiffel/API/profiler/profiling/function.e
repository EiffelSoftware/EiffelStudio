indexing

	description:
			"Information about the name of a certain function %
			%  or feature.";
	date:		"$Date$";
	revision:	"$Revision $"

deferred class FUNCTION

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

	out: STRING is
			-- Representation for output.
		do
			Result := name;
		end;

feature {GPROF_CONVERTER} -- Attributes

	cycle_num: INTEGER
		-- `Current' is member of cycle `cycle_number'

end -- class FUNCTION
