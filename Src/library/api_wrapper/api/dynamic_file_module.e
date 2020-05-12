note
	description: "[
		Provices access to the raw API facilities of a dynamic module loaded from a known location
		on disk.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DYNAMIC_FILE_MODULE

inherit
	DYNAMIC_FILE_API
		rename
			make as make_api
		end

create
	make

feature {NONE} -- Initialize

	make (a_path: READABLE_STRING_32)
			-- Initialize the dynamic module with a full path.
			--
			-- `a_path': The full path to the dynamic module.
		require
			a_path_attached: attached a_path
			not_a_path_is_empty: not a_path.is_empty
		do
			create path.make_from_string (a_path)
			make_api
		ensure
			path_set: path.same_string (a_path)
		end

	initialize
			-- <Precursor>
		do
		end

feature {NONE} -- Clean up

	clean_up
			-- <Precursor>
		do
		end

feature -- Access

	path: IMMUTABLE_STRING_32
			-- <Precursor>

feature -- Status report

	is_thread_safe: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

invariant
	path_attached: attached path
	not_path_is_empty: not path.is_empty

;note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
