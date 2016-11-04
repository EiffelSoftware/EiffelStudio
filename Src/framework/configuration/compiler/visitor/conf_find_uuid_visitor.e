﻿note
	description: "[
		Visitor that looks for libraries with a given UUID.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FIND_UUID_VISITOR

inherit
	CONF_FIND_VISITOR [attached CONF_LIBRARY]
		rename
			found_groups as found_libraries
		end

create
	make

feature -- Access

	uuid: detachable UUID
			-- UUID used to find libraries

feature -- Status setting

	set_uuid (a_uuid: like uuid)
			-- Set `uuid' to `a_uuid'.
		do
			uuid := a_uuid
		ensure
			uuid_set: uuid = a_uuid
		end

feature {NONE} -- Query

	is_matching (a_library: attached CONF_LIBRARY): BOOLEAN
			-- <Precursor>
		do
			Result := attached a_library.library_target as t and then t.system.uuid ~ uuid
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
