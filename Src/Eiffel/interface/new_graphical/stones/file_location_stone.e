note
	description: "Objects that represents a file location"
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_LOCATION_STONE

inherit
	FILED_STONE

create
	make_with_path

feature{NONE} -- Initialization

	make_with_path (a_path: PATH)
			-- Initialize with `a_path`.
		do
			file_name := a_path.name
		end

feature -- Access

	file_name: READABLE_STRING_GENERAL

	stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		once
			Result := Cursors.cur_object
		end

	x_stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		once
			Result := Cursors.cur_X_object
		end

	stone_signature: STRING_32
		do
			Result := file_name.to_string_32
		end

	history_name: STRING_32
		do
			Result := Interface_names.s_location_stone
			Result.append_string (stone_signature)
		end

	header: STRING_GENERAL
			-- Display class name, class' cluster and class location in
			-- window title bar.
		do
			Result := {STRING_32} "Location %"" + file_name + {STRING_32} "%""
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
