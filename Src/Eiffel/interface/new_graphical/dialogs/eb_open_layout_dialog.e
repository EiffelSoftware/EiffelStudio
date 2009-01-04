note
	description: "Dialog to select docking layout names for opening.."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_OPEN_LAYOUT_DIALOG

inherit
	ES_DIALOG

	EB_CONSTANTS
		rename
			interface_names as interface_names_from_constants,
			interface_messages as interface_messages_from_constants
		undefine
			default_create,
			copy
		end

create
	make_with_window

feature {NONE} -- Initlization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			create manager.make (internal_development_window)
			init_widgets (a_container)
			init_layout_items
		end

	init_widgets (a_container: EV_VERTICAL_BOX)
			-- Initilalize widgets.
		require
			not_void: a_container /= Void
		do
			create list_for_existing_layouts
			list_for_existing_layouts.set_minimum_height (list_minimum_height)
			a_container.extend (list_for_existing_layouts)

			set_button_action ({ES_DIALOG_BUTTONS}.ok_button, agent on_ok)

			list_for_existing_layouts.pointer_button_press_actions.force_extend (agent on_list_select)
			list_for_existing_layouts.pointer_double_press_actions.force_extend (agent on_list_double_press)
			list_for_existing_layouts.key_press_actions.extend (agent on_list_key_press)

			dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.ok_button).disable_sensitive

			show_actions.extend_kamikaze (agent list_for_existing_layouts.set_focus)
		end

	init_layout_items
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

	on_ok
			-- On `ok' button pressed.
		local
			l_item: EV_LIST_ITEM
			l_env: EV_ENVIRONMENT
		do
			l_item := list_for_existing_layouts.selected_item
			check not_void: l_item /= Void end
			create l_env
			l_env.application.do_once_on_idle (agent manager.open_layout (l_item.text))
		end

	on_list_select
			-- Handle list selcect actions.
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_env.application.do_once_on_idle (agent do
					if list_for_existing_layouts.selected_item /= Void then
						dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.ok_button).enable_sensitive
					else
						dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.ok_button).disable_sensitive
					end
				end)
		end

	on_list_double_press
			-- Handle list double press actions.
		do
			if list_for_existing_layouts.selected_item /= Void then
				on_ok
			end
		end

	on_list_key_press (a_key: EV_KEY)
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

	list_for_existing_layouts: EV_LIST
			-- List for existing layouts.

	list_minimum_height: INTEGER = 200;
			-- Minimum height for `list_for_existing_layouts'

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.general_dialog_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := interface_names.t_open_layout
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_button: INTEGER
			-- The dialog's default action button
		once
			Result := dialog_buttons.ok_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		once
			Result := dialog_buttons.cancel_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		once
			Result := dialog_buttons.ok_button
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_OPEN_LAYOUT_DIALOG

