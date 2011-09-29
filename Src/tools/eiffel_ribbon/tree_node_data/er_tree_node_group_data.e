note
	description: "[
					Group tree node data
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_GROUP_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "group_"
			xml_constants := {ER_XML_CONSTANTS}.group
			new_unique_command_name
		end

feature -- Query

	size_definition: detachable STRING
			-- Size definition of buttons

	is_ideal_sizes_large_checked: BOOLEAN
			-- Is ideal sizes including Large?

	is_ideal_sizes_medium_checked: BOOLEAN
			-- Is ideal sizes including Medium?

	is_ideal_sizes_small_checked: BOOLEAN
			-- Is ideal sizes including Small?

	is_scale_large_checked: BOOLEAN
			-- Is scale including Large?			

	is_scale_medium_checked: BOOLEAN
			-- Is scale including Medium?

	is_scale_small_checked: BOOLEAN
			-- Is scale including Small?

	is_scale_popup_checked: BOOLEAN
			-- Is scale including Popup?

feature -- Command

	set_size_definition (a_size_definition: like size_definition)
			-- Set `size_definition' with `a_size_definition'
		do
			size_definition := a_size_definition
		end

	set_ideal_sizes_large_checked (a_bool: BOOLEAN)
			-- Set `is_ideal_sizes_large_checked' with `a_bool'
		do
			is_ideal_sizes_large_checked := a_bool
			if a_bool then
				is_ideal_sizes_medium_checked := False
				is_ideal_sizes_small_checked := False
			end
		end

	set_ideal_sizes_medium_checked (a_bool: BOOLEAN)
			-- Set `is_ideal_sizes_medium__checked' with `a_bool'
		do
			is_ideal_sizes_medium_checked := a_bool
			if a_bool then
				is_ideal_sizes_large_checked := False
				is_ideal_sizes_small_checked := False
			end
		end

	set_ideal_sizes_small_checked (a_bool: BOOLEAN)
			-- Set `is_ideal_sizes_small_checked' with `a_bool'
		do
			is_ideal_sizes_small_checked := a_bool
			if a_bool then
				is_ideal_sizes_medium_checked := False
				is_ideal_sizes_large_checked := False
			end
		end

	set_scale_large_checked (a_bool: BOOLEAN)
			-- Set `is_scale_large_checked' with `a_bool'
		do
			is_scale_large_checked := a_bool
		end

	set_scale_medium_checked (a_bool: BOOLEAN)
			-- Set `is_scale_medium_checked' with `a_bool'
		do
			is_scale_medium_checked := a_bool
		end

	set_scale_small_checked (a_bool: BOOLEAN)
			-- Set `is_scale_small_checked' with `a_bool'
		do
			is_scale_small_checked := a_bool
		end

	set_scale_popup_checked (a_bool: BOOLEAN)
			-- Set `is_scale_popup_checked' with `a_bool'
		do
			is_scale_popup_checked := a_bool
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
