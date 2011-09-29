note
	description: "[
					Drop down gallery tree node data
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_DROP_DOWN_GALLERY_DATA

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
			command_name_prefix := "drop_down_gallery_"
			xml_constants := {ER_XML_CONSTANTS}.drop_down_gallery
			new_unique_command_name
		end

feature -- Query

	rows: INTEGER
			-- How many rows in gallery

	columns: INTEGER
			-- How many columns in gallery

	gripper: BOOLEAN
			-- Is gripper avaliable?

feature -- Command

	set_rows (a_rows: INTEGER)
			-- Set `rows' with `a_rows'
		do
			rows := a_rows
		end

	set_columns (a_columns: INTEGER)
			-- Set `columns' with `a_columns'
		do
			columns := a_columns
		end

	set_gripper (a_gripper: BOOLEAN)
			-- Set `gripper' with `a_gripper'
		do
			gripper := a_gripper
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
