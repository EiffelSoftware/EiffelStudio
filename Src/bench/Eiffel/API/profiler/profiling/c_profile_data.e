indexing

	description:
		"Profile information about a profiled C function.";
	date: "$Date$";
	revision: "$Revision$"

class C_PROFILE_DATA

inherit
	PROFILE_DATA
		rename
			make as p_d_make
		redefine
			function, copy, int_function
		end

create
	make

feature -- Creation feature

	make (num_calls: INTEGER; time, self_s, descen: REAL; new_function: C_FUNCTION) is
			-- Create an object containing profile data for a single C function.
		do
			p_d_make(num_calls, time, self_s, descen);
			int_function := new_function;
		end;

feature -- Copy features

	copy (other: like Current) is
			-- Reinitialize by copying features of `other'.
			-- (This is also used by `clone'.)
		do
			calls := other.calls;
			self := other.self;
			descendants := other.descendants;
			percentage := other.percentage;
			int_function.copy (other.int_function);
		end;

feature -- Status report

	function: C_FUNCTION is
			-- The function where information is about.
		do
			Result := int_function;
		end

feature {C_PROFILE_DATA} -- Attributes

	int_function: C_FUNCTION
		-- The profiled function

end -- class C_PROFILE_DATA
