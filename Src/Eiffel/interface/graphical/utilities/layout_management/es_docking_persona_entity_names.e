indexing
	description: "[
		Entity names for layout persona description files for {ES_DOCKING_PERSONA_LOAD_CALLBACKS}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_DOCKING_PERSONA_ENTITY_NAMES

feature -- Access

	layout_tag: !STRING_8 = "layout"

	zone_tag: !STRING_8 = "zone"

	tool_tag: !STRING_8 = "tool"

feature -- Attribute

	name_attribute: !STRING_8 = "name"

	dock_attribute: !STRING_8 = "dock"

	style_attribute: !STRING_8 = "style"

	size_attribute: !STRING_8 = "size"

	id_attribute: !STRING_8 = "id"

feature -- Values

	none_dock_value: !STRING = "none"

	botton_dock_value: !STRING = "bottom"

	top_dock_value: !STRING = "top"

	left_dock_value: !STRING = "left"

	right_dock_value: !STRING = "right"

	floating_style_value: !STRING = "floating"

	tiled_style_value: !STRING = "tiled"

	tabbed_style_value: !STRING = "tabbed"

	auto_hide_style_value: !STRING = "auto-hide"

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
