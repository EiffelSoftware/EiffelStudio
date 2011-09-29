note
	description: "[
					Drop down color picker tree node data
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_DROP_DOWN_COLOR_PICKER_DATA

inherit
	ER_TREE_NODE_BUTTON_DATA
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			command_name_prefix := "drop_down_color_picker_"
			xml_constants := {ER_XML_CONSTANTS}.drop_down_color_picker
			new_unique_command_name
		end

feature -- Command

	set_color_template (a_color: detachable STRING)
			-- Set `color_template' with `a_color'
		require
			valid: a_color /= Void implies is_valid (a_color)
		do
			color_template := a_color
		ensure
			set: color_template = a_color
		end

feature -- Query

	color_template: detachable STRING
			-- Color template

	is_valid (a_template: STRING): BOOLEAN
			-- Is `a_template' valid?
		require
			not_void: a_template /= Void
		do
			if a_template.same_string (standard_colors) or else
				a_template.same_string (theme_colors) or else
				a_template.same_string (highlight_colors) then
				Result := True
			end
		end

feature -- Enumeration

	standard_colors: STRING = "StandardColors"
			-- Standard colors

	theme_colors: STRING = "ThemeColors"
			-- Theme colors

	highlight_colors: STRING = "HighlightColors"
			-- Highlight colors
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
