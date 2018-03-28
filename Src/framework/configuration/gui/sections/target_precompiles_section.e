note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_PRECOMPILES_SECTION

inherit
	TARGET_LIBRARIES_SECTION
		redefine
			name,
			icon,
			conf_item_type,
			section_item_type,
			add_dialog_type,
			update_toolbar_sensitivity,
			context_menu
		end

create
	make

feature -- Access

	name: READABLE_STRING_32
			-- Name of the section.
		once
			Result := conf_interface_names.group_precompile_tree
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		once
			Result := conf_pixmaps.top_level_folder_precompiles_icon
		end

feature {NONE} -- Implementation

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		do
			create Result.make (0)
				-- we can only have one precompile, so as soon as this folder appears we can't add any more.
		end

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toolbar'.
		do
				-- we can only have one precompile, so as soon as this folder appears we can't add any more.
		end

feature {NONE} -- Type anchors

	add_dialog_type: ADD_PRECOMPILE_DIALOG
			-- Type of the dialog to create a new item.
		do
			check from_precondition: False then end
		end

	conf_item_type: CONF_PRECOMPILE
			-- Type of configuration objects represented.
		do
			check from_precondition: False then end
		end

	section_item_type: PRECOMPILE_SECTION
			-- Type of sections contained.
		do
			check from_precondition: False then end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
