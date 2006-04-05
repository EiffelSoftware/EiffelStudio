indexing

	description:
		"Profile information about a call cycle"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
	make

feature -- Creation

	make (num_calls: INTEGER; time, self_s, descen: REAL; new_function: CYCLE_FUNCTION) is
			-- Create profile data for a whole cycle.
		do
			p_d_make (num_calls, time, self_s, descen);
			int_function := new_function;
			create functions.make;
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

	functions: LINKED_CIRCULAR [LANGUAGE_FUNCTION];
		-- Functions in this cycle

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CYCLE
