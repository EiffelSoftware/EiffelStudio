indexing

	description:
		"Profile information about a call cycle";
	date: "$Date$";
	revision: "$Revision$"

class CYCLE_PROFILE_DATA

inherit
	PROFILE_DATA
		rename
			make as p_d_make
		redefine
			function, copy, int_function
		end

creation
	make

feature -- Creation

	make (num_calls: INTEGER; time, self_s, descen: REAL; new_function: CYCLE_FUNCTION) is
			-- Create profile data for a whole cycle.
		do
			p_d_make (num_calls, time, self_s, descen);
			int_function := new_function;
			!! functions.make;
		end;

feature -- Copy features

	copy (other: like Current) is
			-- Reinitialize by copying features of `other'.
			-- (This is also used by `close'.)
		do
			calls := other.calls;
			self := other.self;
			descendants := other.descendants;
			percentage := other.percentage;
			int_function.copy (other.int_function);
		end;

feature -- Status report

	function: CYCLE_FUNCTION is
			-- The cycle all information is about.
		do
			Result := int_function
		end

feature {CYCLE_PROFILE_DATA} -- Attrbutes

	int_function: CYCLE_FUNCTION
		-- The profiled cycle.

feature -- Adding

	add_function (new_function: LANGUAGE_FUNCTION) is
			-- Add `new_function' to cycle.
		require
			valid_function: new_function /= Void;
		do
			functions.extend(new_function);
		ensure
			added: functions.count = old functions.count + 1;
		end;

feature -- Status report

	number: INTEGER is
			-- The number of this cycle.
		do
			Result := int_function.cycle_number;
		end;

	name: STRING is
			-- The name of this cycle.
		do
			Result := int_function.name;
		end;

feature {NONE} -- Attributes

	functions: LINKED_CIRCULAR [LANGUAGE_FUNCTION]
		-- Functions in this cycle

end -- class CYCLE
