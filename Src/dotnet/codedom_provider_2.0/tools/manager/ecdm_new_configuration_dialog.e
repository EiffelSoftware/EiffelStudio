indexing
	description: "New configuration dialog"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECDM_NEW_CONFIGURATION_DIALOG

inherit
	ECDM_NEW_CONFIGURATION_DIALOG_IMP


create
	make

feature {NONE} -- Initialization

	make (a_manager: ECDM_MANAGER) is
			-- Set `manager' with `a_manager'.
		require
			non_void_manager: a_manager /= Void
		do
			default_create
			manager := a_manager
		ensure
			manager_set: manager = a_manager
		end
		
	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
		end

feature -- Access

	configuration: ECDM_CONFIGURATION
			-- Created configuration

	manager: ECDM_MANAGER
			-- Configurations manager

feature {NONE} -- Events

	on_name_change is
			-- Called by `change_actions' of `config_name_text_field'.
		do
			check_ok
		end
		
	on_browse_for_folder is
			-- Called by `select_actions' of `browse_button'.
		local
			l_open_dialog: EV_DIRECTORY_DIALOG
		do
			create l_open_dialog.make_with_title ("Configuration Folder")
			l_open_dialog.show_modal_to_window (Current)
			configuration_folder_text_field.set_text (l_open_dialog.directory)
			check_ok			
		end
	
	on_application_select is
			-- Called by `select_actions' of `applications_list'.
		do
			if not remove_button.is_sensitive then
				remove_button.enable_sensitive
			end
		end

	on_application_deselect is
			-- Called by `deselect_actions' of `applications_list'.
		do
			if applications_list.selected_items.is_empty then
				remove_button.disable_sensitive
			end
		end
	
	on_add is
			-- Called by `select_actions' of `add_button'.
		local
			l_app: STRING
			l_found: BOOLEAN
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog.make_with_title ("Add Application")
			l_open_dialog.filters.extend (["*.exe", "Applications"])
			l_open_dialog.show_modal_to_window (Current)
			l_app := l_open_dialog.file_name
			if l_app /= Void and then not l_app.is_empty then
				from
					applications_list.start
					if not applications_list.after then
						l_found := applications_list.item.text.is_equal (l_app)
						applications_list.forth
					end
				until
					applications_list.after or l_found
				loop
					l_found := applications_list.item.text.is_equal (l_app)
					applications_list.forth
				end
				if l_found then
					display_error ("Application already in list, please choose a different application.")
					on_add
				else
					applications_list.extend (create {EV_LIST_ITEM}.make_with_text (l_app))
					check_ok
				end
			end
		end
		
	on_remove is
			-- Called by `select_actions' of `remove_button'.
		local
			l_apps: LIST [EV_LIST_ITEM]
		do
			l_apps := applications_list.selected_items
			from
				l_apps.start
			until
				l_apps.after
			loop
				applications_list.prune_all (l_apps.item)
				l_apps.forth
			end
			check_ok
		end
		
	on_ok is
			-- Called by `select_actions' of `ok_button'.
		local
			l_dialog: EV_MESSAGE_DIALOG
			l_app_path: STRING
			l_config: ECDM_CONFIGURATION
		do
			create configuration.make_empty (configuration_folder_text_field.text, config_name_text_field.text)
			if configuration.last_save_successful then
				from
					applications_list.start
				until
					applications_list.after
				loop
					l_app_path := applications_list.item.text
					if manager.is_registered (l_app_path) then
						l_config := manager.configuration (l_app_path)
						if l_config /= Void then
							create l_dialog.make_with_text ("Application " + l_app_path + " is already configured with " + l_config.path + ".%NWould you like to configure this application with " + configuration.path + " instead?")
							l_dialog.set_buttons_and_actions (<<"Yes", "No">>, <<agent manager.replace_configuration (l_app_path, configuration), agent do_nothing>>)
							l_dialog.set_default_push_button (l_dialog.button ("Yes"))
							l_dialog.show_modal_to_window (Current)
						else
							manager.replace_configuration (l_app_path, configuration)
						end
					else
						manager.register (applications_list.item.text, configuration)
					end
					applications_list.forth
				end
				destroy
			else
				configuration := Void
				display_error ("Could not initialize configuration, please check configuration name and folder.%NMake sure configuration folder does not contain a file with the same name as the configuration name.")
			end
		end
	
	on_cancel is
			-- Called by `select_actions' of `cancel_button'.
		do
			destroy
		end

feature {NONE} -- Implementation

	check_ok is
			-- Set OK button sensitivity according to dialog content.
		local
			l_enable_sensitive: BOOLEAN
			l_folder_path: STRING
			l_configs: LIST [ECDM_CONFIGURATION]
		do
			l_folder_path := configuration_folder_text_field.text
			if l_folder_path /= Void then
				l_enable_sensitive := (create {DIRECTORY}.make (l_folder_path)).exists
			end
			if l_enable_sensitive then
				l_enable_sensitive := not applications_list.is_empty and config_name_text_field.text /= Void and then not config_name_text_field.text.is_empty
				if l_enable_sensitive then
					from
						l_configs := manager.all_configurations
						l_configs.start
					until
						l_configs.after or not l_enable_sensitive
					loop
						l_enable_sensitive := not l_configs.item.name.is_equal (config_name_text_field.text)
						l_configs.forth
					end
				end
			end
			if l_enable_sensitive and not ok_button.is_sensitive then
				ok_button.enable_sensitive
			elseif not l_enable_sensitive and ok_button.is_sensitive then
				ok_button.disable_sensitive
			end
		end

	set_configuration (a_configuration: like configuration) is
			-- Set `configuration' with `a_configuration'.
		do
			configuration := a_configuration
		ensure
			set: configuration = a_configuration
		end
	
	display_error (a_message: STRING) is
			-- Display error message `a_message' in error dialog.
		require
			non_void_message: a_message /= Void
		local
			l_dialog: EV_MESSAGE_DIALOG
		do
			create l_dialog.make_with_text (a_message)
			l_dialog.set_pixmap ((create {EV_STOCK_PIXMAPS}).Error_pixmap)
			l_dialog.set_buttons (<<"OK">>)
			l_dialog.set_default_push_button (l_dialog.button ("OK"))
			l_dialog.show_modal_to_window (Current)
		end

invariant
	non_void_manager: manager /= Void

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
end -- class ECDM_NEW_CONFIGURATION_DIALOG

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
