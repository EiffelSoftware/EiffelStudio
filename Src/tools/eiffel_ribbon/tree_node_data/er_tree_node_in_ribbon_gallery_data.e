note
	description: "[
					In-ribbon gallery tree node data
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_IN_RIBBON_GALLERY_DATA

inherit
	ER_TREE_NODE_BUTTON_DATA
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "in_ribbon_gallery_"
			xml_constants := {ER_XML_CONSTANTS}.in_ribbon_gallery
			new_unique_command_name
		end

feature -- Query

	max_rows: INTEGER
			-- Max rows of current gallery

	max_columns: INTEGER
			-- Max columns of current gallery

feature -- Command

	set_max_rows (a_rows: INTEGER)
			-- Set `max_rows' with `a_rows'
		do
			max_rows := a_rows
		ensure
			set: max_rows = a_rows
		end

	set_max_columns (a_columns: INTEGER)
			-- Set `max_columns' with `a_columns'
		do
			max_columns := a_columns
		ensure
			set: max_columns = a_columns
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
