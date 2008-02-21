indexing
	description: "Dialog to select docking layout names for opening.."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_OPEN_LAYOUT_DIALOG

inherit
	EV_DIALOG

	EB_CONSTANTS
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initlization

	make (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method.
		do
			default_create
			set_title (interface_names.t_open_layout)
			create manager.make (a_dev_window)
			init_widgets
			init_layout_items
			key_press_actions.extend (agent on_key_press)
		end

	init_widgets is
			-- Initilalize widgets.
		local
			l_h_box: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
		do
			create vertical_box
			vertical_box.set_border_width (layout_constants.default_border_size)
			vertical_box.set_padding (Layout_constants.Default_padding_size)
			extend (vertical_box)

			create list_for_existing_layouts
			list_for_existing_layouts.set_minimum_height (list_minimum_height)
			vertical_box.extend (list_for_existing_layouts)

			create l_h_box
			l_h_box.set_padding (layout_constants.default_padding_size)
			vertical_box.extend (l_h_box)
			vertical_box.disable_item_expand (l_h_box)

			create l_cell
			l_h_box.extend (l_cell)

			create ok
			ok.set_text (interface_names.b_ok)
			layout_constants.set_default_size_for_button (ok)
			ok.select_actions.extend (agent on_ok)
			l_h_box.extend (ok)
			l_h_box.disable_item_expand (ok)

			create cancel
			cancel.set_text (interface_names.b_cancel)
			layout_constants.set_default_size_for_button (cancel)
			cancel.select_actions.extend (agent on_cancel)
			l_h_box.extend (cancel)
			l_h_box.disable_item_expand (cancel)

			list_for_existing_layouts.pointer_button_press_actions.force_extend (agent on_list_select)
			list_for_existing_layouts.pointer_double_press_actions.force_extend (agent on_list_double_press)
			list_for_existing_layouts.key_press_actions.extend (agent on_list_key_press)

			ok.disable_sensitive

			show_actions.extend_kamikaze (agent list_for_existing_layouts.set_focus)
		end

	init_layout_items is
			-- Initlialize layout list items.
		local
			l_item: EV_LIST_ITEM
			l_names: DS_HASH_TABLE [TUPLE [FILE_NAME, BOOLEAN], STRING_GENERAL]
		do
			from
				l_names := manager.layouts
				l_names.start
			until
				l_names.after
			loop
				create l_item.make_with_text (l_names.key_for_iteration)
				list_for_existing_layouts.extend (l_item)
				l_names.forth
			end
		end

feature {NONE} -- Implementation functions

	on_key_press (a_key: EV_KEY) is
			-- Handle key press actions.
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_escape then
				destroy
			else

			end
		end

	on_cancel is
			-- On `cancel' button pressed.
		do
			destroy
		end

	on_ok is
			-- On `ok' button pressed.
		local
			l_item: EV_LIST_ITEM
			l_env: EV_ENVIRONMENT
		do
			l_item := list_for_existing_layouts.selected_item
			check not_void: l_item /= Void end
			create l_env
			l_env.application.do_once_on_idle (agent manager.open_layout (l_item.text))
			destroy
		end

	on_list_select is
			-- Handle list selcect actions.
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_env.application.do_once_on_idle (agent do
					if list_for_existing_layouts.selected_item /= Void then
						ok.enable_sensitive
					else
						ok.disable_sensitive
					end
				end)
		end

	on_list_double_press is
			-- Handle list double press actions.
		do
			if list_for_existing_layouts.selected_item /= Void then
				on_ok
			end
		end

	on_list_key_press (a_key: EV_KEY) is
			-- Handle list press actions.
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_enter then
				if list_for_existing_layouts.selected_item /= Void then
					on_ok
				end
			else

			end
		end

feature {NONE} -- Implementation

	manager: EB_NAMED_LAYOUT_MANAGER
			-- Named layout manager.

	vertical_box: EV_VERTICAL_BOX
			-- Vertical box

	list_for_existing_layouts: EV_LIST
			-- List for existing layouts.

	ok, cancel: EV_BUTTON
			-- Ok, cancel buttons.

	list_minimum_height: INTEGER is 200;
			-- Minimum height for `list_for_existing_layouts'

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EB_OPEN_LAYOUT_DIALOG

