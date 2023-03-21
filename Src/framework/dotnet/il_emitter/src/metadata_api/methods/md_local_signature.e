note
	description: "[
			Representation a local signature used for defining type of all
			local variables of a method.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_LOCAL_SIGNATURE

inherit
	MD_SIGNATURE
		rename
			set_type as add_local_type
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize current.
		do
			Precursor {MD_SIGNATURE}
			reset
			internal_put ({MD_SIGNATURE_CONSTANTS}.Local_sig, 0)
			current_position := 1
			state := local_count_state
		ensure then
			current_position_set: current_position = 1
			state_set: state = local_count_state
		end

feature -- Reset

	reset
			-- Reset content.
		do
			internal_put ({MD_SIGNATURE_CONSTANTS}.Local_sig, 0)
			current_position := 1
			state := local_count_state
		ensure
			current_position_set: current_position = 1
			state_set: state = local_count_state
		end

feature -- Settings

	set_local_count (n: INTEGER)
			-- Set number of method locals.
			-- To be compressed.
		require
			valid_state: state = Local_count_state
		do
			compress_data (n)
			state := 0
		end

feature -- State

	state: INTEGER
			-- Current state of signature settings.

	local_count_state: INTEGER = 1;

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class MD_LOCAL_SIGNATURE
