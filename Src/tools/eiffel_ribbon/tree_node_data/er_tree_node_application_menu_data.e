note
	description: "[
					Application menu tree node data
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_APPLICATION_MENU_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "application_menu_"
			xml_constants := {ER_XML_CONSTANTS}.ribbon_application_menu
			new_unique_command_name

			-- Default value
			max_count := 9
		end

feature -- Query

	max_count: INTEGER
			-- Max count of recent item

	enable_pinning: BOOLEAN
			-- Enable pinning in recent items?

feature -- Command

	set_max_count (a_max_count: INTEGER)
			-- Set `max_count' with `a_max_count'
		do
			max_count := a_max_count
		ensure
			set: max_count = a_max_count
		end

	set_enable_pinning (a_bool: BOOLEAN)
			-- Set `enable_pinning' with `a_bool'
		do
			enable_pinning := a_bool
		ensure
			set: enable_pinning = a_bool
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
