note
	description: "[
		Exposes an output window to be register with the output manager service ({OUTPUT_MANAGER_S}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OUTPUT_I

inherit
	USABLE_I

	LOCKABLE_I

	SITE [OUTPUT_MANAGER_S]
		export
			{OUTPUT_MANAGER_S} all
		end

feature -- Access

	name: !IMMUTABLE_STRING_32
			-- Name given the output editor
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
			result_consistent: Result ~ name
		end

	output_window: !OUTPUT_WINDOW
			-- Name given the output editor
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = output_window
		end

feature -- Status report

	is_active: BOOLEAN
			-- Indicates if the output is current active
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Basic operations

	clear
			-- Clears and cached output.
		require
			is_interface_usable: is_interface_usable
		do
			output_window.clear_window
		end

	activate
			-- Active the output and bring it into view.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			is_active: is_active
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
