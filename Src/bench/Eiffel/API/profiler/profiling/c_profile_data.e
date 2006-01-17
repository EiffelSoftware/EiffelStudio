indexing

	description:
		"Profile information about a profiled C function."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	int_function: C_FUNCTION;
		-- The profiled function

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class C_PROFILE_DATA
