note

	description:
		"Profile information about an Eiffel feature."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class EIFFEL_PROFILE_DATA

inherit
	PROFILE_DATA
		rename
			make as p_d_make
		redefine
			int_function
		end

create
	make

feature -- Creation feature

	make (num_calls: INTEGER; time, self_s, descen: REAL_64; new_function: EIFFEL_FUNCTION)
			-- Create profile data for a single Eiffel feature.
		do
			p_d_make(num_calls, time, self_s, descen);
			int_function := new_function;
		end;

feature -- Status report

	function: EIFFEL_FUNCTION
			-- The function all the information is about.
		do
			Result := int_function;
		end;

feature {EIFFEL_PROFILE_DATA} -- Attributes

	int_function: EIFFEL_FUNCTION;
		-- The profiled function

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
