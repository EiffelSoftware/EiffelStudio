indexing

	description:
		"Profile information about an Eiffel feature.";
	date: "$Date$";
	revision: "$Revision$"

class EIFFEL_PROFILE_DATA

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

	make (num_calls: INTEGER; time, self_s, descen: REAL; new_function: EIFFEL_FUNCTION) is
			-- Create profile data for a single Eiffel feature.
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

	function: EIFFEL_FUNCTION is
			-- The function all the information is about.
		do
			Result := int_function;
		end;

feature {EIFFEL_PROFILE_DATA} -- Attributes

	int_function: EIFFEL_FUNCTION
		-- The profiled function

end -- class EIFFEL_PROFILE_DATA
