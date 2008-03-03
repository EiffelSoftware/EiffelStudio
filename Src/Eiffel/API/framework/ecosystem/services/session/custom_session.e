indexing
	description: "[
		The actual session handling implementation as described by the custom session interface {CUSTOM_SESSION_I}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CUSTOM_SESSION

inherit
	CUSTOM_SESSION_I

	SESSION
		rename
			make as make_session
		undefine
			kind
		end

create {SESSION_MANAGER_S}
	make

feature {NONE} -- Initialization

	make (a_file_name: like file_name; a_manager: like manager)
			-- Initialize a custom file name session
			--
			-- `a_file_name': File name to persist/retrieve a session object from.
			-- `a_manager': Session manager that owns Current.
		require
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_manager_attached: a_manager /= Void
			a_manager_is_interface_usable: a_manager.is_interface_usable
		do
			file_name := a_file_name
			make_session (False, a_manager)
		ensure
			a_file_name_set: file_name.is_equal (a_file_name)
			manager_set: manager = a_manager
		end

feature -- Access

	file_name: !STRING_8
			-- File name for the custom session

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
