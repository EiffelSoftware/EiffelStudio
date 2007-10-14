indexing
	description: "Dialog to manage debugger's object storage remote operation ..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DBG_OBJECT_STORAGE_MANAGEMENT_DIALOG

inherit
	ES_DIALOG
		redefine
			make
		end

	SHARED_DEBUGGER_MANAGER

	ES_SHARED_PROMPT_PROVIDER

	SHARED_WORKBENCH

create
	make

convert
	to_dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make is
			-- Initialize dialog		
		do
			buttons := dialog_buttons.yes_no_cancel_buttons
			default_button := dialog_buttons.yes_button
			default_cancel_button := dialog_buttons.cancel_button
			default_confirm_button := dialog_buttons.yes_button
			Precursor {ES_DIALOG}
			set_button_text (dialog_buttons.yes_button, interface_names.b_save_object)
			set_button_text (dialog_buttons.no_button, interface_names.b_load_object)
			set_button_action (dialog_buttons.yes_button, agent on_save)
			set_button_action (dialog_buttons.no_button, agent on_load)

			check_fields
		end

feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			ac: ES_DELAYED_ACTION
		do
			create path_field.make
			a_container.extend (path_field)
			path_field.set_browse_for_file (Void)
			create ac.make (agent check_fields, 100)
			path_field.field.change_actions.extend (agent ac.request_call)
		end

feature -- Actions

	on_save is
			-- On save action
		require
			stone_not_void: object_stone /= Void
		local
			b: BOOLEAN
		do
			if debugger_manager.safe_application_is_stopped then
				b := debugger_manager.application.remotely_store_object (object_stone.object_address, path_field.path)
				if b then
					display_success_message
				else
					display_failure_message
				end
			else
				display_not_stopped_error_message
			end
		end

	on_load is
			-- On load action
		do
			if debugger_manager.safe_application_is_stopped then
				if object_stone /= Void then
					object_value := debugger_manager.application.remotely_loaded_object (object_stone.object_address, path_field.path)
				else
					object_value := debugger_manager.application.remotely_loaded_object (Void, path_field.path)
				end
				if object_value /= Void then
					display_success_message
				else
					display_failure_message
				end
			else
				display_not_stopped_error_message
			end
		end

feature {NONE} -- Prompts

	display_not_stopped_error_message is
		do
			prompts.show_error_prompt (interface_names.l_Only_available_for_stopped_application, Void, Void)
		end

	display_failure_message is
		do
			prompts.show_error_prompt (interface_names.e_operation_failed, Void, Void)
		end

	display_success_message is
		do
			prompts.show_info_prompt (interface_names.e_operation_succeeded, Void, Void)
		end

feature -- Access

	path_field: EV_PATH_FIELD

	object_stone: OBJECT_STONE

	object_value: ABSTRACT_DEBUG_VALUE

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.general_save_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := interface_names.m_Control_debuggee_object_storage
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.


	default_button: INTEGER
			-- The dialog's default action button

	default_cancel_button: INTEGER
			-- The dialog's default cancel button

	default_confirm_button: INTEGER
			-- The dialog's default confirm button

	button_save: EV_BUTTON is
			--
		do
			Result := dialog_window_buttons.item (dialog_buttons.yes_button)
		end

	button_load: EV_BUTTON is
			--
		do
			Result := dialog_window_buttons.item (dialog_buttons.no_button)
		end

feature -- Change

	set_object_stone (st: OBJECT_STONE) is
		do
			object_stone := st
			check_fields
		end

	check_fields is
			--
		local
			f: RAW_FILE
			s: STRING
		do
			s := path_field.path
			if not s.is_empty then
				create f.make (path_field.path)
			end
			if
				f /= Void and then (not f.exists or else f.is_writable)
				and object_stone /= Void
			then
				button_save.enable_sensitive
			else
				button_save.disable_sensitive
			end
			if f /= Void and then f.exists and then f.is_readable then
				button_load.enable_sensitive
			else
				button_load.disable_sensitive
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
