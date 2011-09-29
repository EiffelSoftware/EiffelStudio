note
	description: "[
					Ttree node data factory
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_DATA_FACTORY

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create constants
		end

feature -- Factory method

	tree_node_data_for (a_type: STRING): detachable ER_TREE_NODE_DATA
			-- Tree node data factory method
		require
			not_void: a_type /= Void
			valid: (create {ER_XML_CONSTANTS}).is_valid (a_type)
		do
			if a_type.is_equal (constants.command) then
				create {ER_TREE_NODE_COMMAND_DATA} Result.make
			elseif a_type.is_equal (constants.group) then
				create {ER_TREE_NODE_GROUP_DATA} Result.make
			elseif a_type.is_equal (constants.button) then
				create {ER_TREE_NODE_BUTTON_DATA} Result.make
			elseif a_type.is_equal (constants.tab) then
				create {ER_TREE_NODE_TAB_DATA} Result.make
			elseif a_type.same_string (constants.check_box) then
				create {ER_TREE_NODE_CHECKBOX_DATA} Result.make
			elseif a_type.same_string (constants.ribbon_tabs) then
				create {ER_TREE_NODE_RIBBON_DATA} Result.make
			elseif a_type.same_string (constants.toggle_button) then
				create {ER_TREE_NODE_TOGGLE_BUTTON_DATA} Result.make
			elseif a_type.same_string (constants.spinner) then
				create {ER_TREE_NODE_SPINNER_DATA} Result.make
			elseif a_type.same_string (constants.combo_box) then
				create {ER_TREE_NODE_COMBO_BOX_DATA} Result.make
			elseif a_type.same_string (constants.split_button) then
				create {ER_TREE_NODE_SPLIT_BUTTON_DATA} Result.make
			elseif a_type.same_string (constants.drop_down_gallery) then
				create {ER_TREE_NODE_DROP_DOWN_GALLERY_DATA} Result.make
			elseif a_type.same_string (constants.in_ribbon_gallery) then
				create {ER_TREE_NODE_IN_RIBBON_GALLERY_DATA} Result.make
			elseif a_type.same_string (constants.split_button_gallery) then
				create {ER_TREE_NODE_SPLIT_BUTTON_GALLERY_DATA} Result.make
			elseif a_type.same_string (constants.ribbon_application_menu) then
				create {ER_TREE_NODE_APPLICATION_MENU_DATA} Result.make
			elseif a_type.same_string (constants.recent_items) then
				create {ER_TREE_NODE_APPLICATION_MENU_DATA} Result.make
			elseif a_type.same_string (constants.mini_toolbar) then
				create {ER_TREE_NODE_MINI_TOOLBAR_DATA} Result.make
			elseif a_type.same_string (constants.context_menu) then
				create {ER_TREE_NODE_CONTEXT_MENU_DATA} Result.make
			elseif a_type.same_string (constants.drop_down_button)  then
				create {ER_TREE_NODE_DROP_DOWN_BUTTON_DATA} Result.make
			elseif a_type.same_string (constants.ribbon_helpbutton) then
				create {ER_TREE_NODE_HELP_BUTTON_DATA} Result.make
			elseif a_type.same_string (constants.drop_down_color_picker) then
				create {ER_TREE_NODE_DROP_DOWN_COLOR_PICKER_DATA} Result.make
			elseif a_type.same_string (constants.font_control) then
				create {ER_TREE_NODE_FONT_CONTROL_DATA} Result.make
			elseif a_type.same_string (constants.ribbon_quick_access_toolbar) then
				create {ER_TREE_NODE_QUICK_ACCESS_TOOLBAR_DATA} Result.make
			elseif a_type.same_string (constants.menu_group) then
				create {ER_TREE_NODE_MENU_GROUP_DATA} Result.make
			elseif a_type.same_string (constants.tab_group) then
				create {ER_TREE_NODE_TAB_GROUP_DATA} Result.make
			else
				--no data for `a_type'
				-- Maybe `a_type' is "Application". It should not have any tree node data
			end
		end

feature {NONE} -- Implementation

	constants: ER_XML_CONSTANTS
			-- Constants
;note
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
