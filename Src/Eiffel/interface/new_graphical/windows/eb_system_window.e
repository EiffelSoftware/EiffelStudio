indexing
	description: "Window for configuring Eiffel projects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_WINDOW

inherit
	EB_WINDOW
		redefine
--			build_menus,
--			build_file_menu,
			window_displayed
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EB_ERROR_MANAGER
		export
			{NONE} all
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		end

	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

create
	make,
	default_create

feature -- Tab access

--	ok_button: EV_BUTTON
--			-- Ok button.
--
--	general_tab: EB_SYSTEM_GENERAL_TAB
--			-- Widget describing General tab.
--
--	debug_tab: EB_SYSTEM_DEBUG_TAB
--			-- Widget describing debug tab.
--
--	clusters_tab: EB_SYSTEM_CLUSTERS_TAB
--			-- Widget describing clusters tab.
--
--	externals_tab: EB_SYSTEM_EXTERNALS_TAB
--			-- Widget describing externals tab.
--
--	msil_tab: EB_SYSTEM_MSIL_TAB
--			-- Widget describing MSIL specific option tab.
--
--	msil_assembly_tab: EB_SYSTEM_MSIL_ASSEMBLY_TAB
--			-- Widget describing MSIL assembly specific option tab.
--
--	msil_resources_tab: EB_SYSTEM_MSIL_RESOURCES_TAB
--			-- Widget describing MSIL resources specific option tab.
--
--	advanced_tab: EB_SYSTEM_ADVANCED_TAB
--			-- Widget describing advanced tab.

feature -- Status

	is_initialized: BOOLEAN
			-- Did current build all tabs.

feature -- Interface access

--	root_ast: ACE_SD
--			-- Parsed/Newly created Ace file

feature -- Actions

	window_displayed is
			--
		do
			conf_todo_msg ("whole class")
--			ok_button.set_focus
		end

	ok_action is
			-- Action performed when clicking `Ok' button.
		do
--			save_content
--			if successful_save then
--				window.hide
--			end
		end

	cancel_action is
			-- Action performed when clicking `Cancel' button.
		do
			window.hide
		end

	apply_action is
			-- Action performed when clicking `Apply' button.
		do
--			save_content
		end

--	load_ace is
--		local
--			file_dialog: EB_FILE_OPEN_DIALOG
--			l_env: EXECUTION_ENVIRONMENT
--			l_dir: STRING
--		do
--			create file_dialog.make_with_preference (preferences.dialog_data.last_opened_system_ace_directory_preference)
--			set_dialog_filters_and_add_all (file_dialog, <<ace_files_filter>>)
--			file_dialog.open_actions.extend (agent retrieve_ace_file (file_dialog))
--			create l_env
--			l_dir := l_env.current_working_directory
--			file_dialog.show_modal_to_window (window)
--			l_env.change_working_directory (l_dir)
--		end
--
--	edit_ace is
--		local
--			cmd_exec: COMMAND_EXECUTOR
--			cmd_string: STRING
--		do
--			cmd_string := preferences.misc_data.general_shell_command.twin
--			if not cmd_string.is_empty then
--				cmd_string.replace_substring_all ("$target", Eiffel_ace.Lace.file_name)
--				cmd_string.replace_substring_all ("$line", "1")
--				create cmd_exec
--				cmd_exec.execute (cmd_string)
--				window.hide
--			end
--		end
--
--	enable_msil_generation is
--			-- Enable MSIL generation.
--		do
--			if is_initialized then
--				tab_list.do_all (agent {EB_SYSTEM_TAB}.enable_msil_widgets)
--			end
--		end
--
--	enable_c_generation is
--			-- Enable C generation.
--		do
--			if is_initialized then
--				tab_list.do_all (agent {EB_SYSTEM_TAB}.enable_c_widgets)
--			end
--		end

feature -- Content initialization

	initialize_content is
			-- Initialize content of Window.
		do
--				-- Clean previously entered data
--			reset_content
--			check_content
--
--			if is_content_valid then
--				retrieve_content (root_ast)
--			end
		rescue
			add_error_message ("Unable to initialize the System Tool")
		end

--	check_content is
--			-- Check content of Ace file and if valid set `root_ast'.
--		local
--			is_incorrect: BOOLEAN
--			error_dialog: EV_WARNING_DIALOG
--			l_file_name: STRING
--			l_file: PLAIN_TEXT_FILE
--		do
--			l_file_name := Eiffel_ace.file_name
--			if Workbench.system_defined or else l_file_name /= Void then
--				create l_file.make (l_file_name)
--				if l_file.exists and then l_file.is_readable then
--					has_content := True
--
--						-- Create a new freshly parsed AST. If there is a
--						-- syntax error during parsing of chose Ace file,
--						-- we open an empty window.
--					root_ast := Eiffel_ace.Lace.parsed_ast
--					if root_ast = Void then
--						is_incorrect := True
--					end
--				else
--					is_incorrect := True
--				end
--			else
--				has_content := False
--			end
--			is_content_valid := has_content and not is_incorrect
--			if is_incorrect then
--					-- Not a valid Ace file, we reject.
--				create error_dialog.make_with_text (Warning_messages.w_Cannot_read_file (Eiffel_Ace.file_name) +
--					"%NNot a valid configuration file.")
--				error_dialog.show_modal_to_window (window)
--			end
--		end

	is_content_valid: BOOLEAN
			-- Is content of retrieved Ace file correct?

	has_content: BOOLEAN
			-- Has an ace file been specified?

	reset_content is
			-- Delete all entered information.
		local
--			l_tab_list: like tab_list
		do
--			l_tab_list := tab_list
--			l_tab_list.do_all (agent {EB_SYSTEM_TAB}.reset)
--			if Workbench.has_compilation_started then
--				l_tab_list.do_all (agent {EB_SYSTEM_TAB}.disable_widgets_set_before_has_compilation_started)
--			end
--			if Workbench.is_already_compiled then
--				l_tab_list.do_all (agent {EB_SYSTEM_TAB}.disable_widgets_set_before_is_already_compiled)
--			end
--			is_content_valid := False
		end

--	retrieve_content (ast: like root_ast) is
--			-- Retrieve content of `ast' and store it in each
--			-- tab.
--		require
--			is_valid: is_content_valid
--			has_content: has_content
--			ast_not_void: ast /= Void
--		do
--			tab_list.do_all (agent {EB_SYSTEM_TAB}.retrieve (root_ast))
--		end

feature -- Content saving

--	save_content is
--			-- Store `Ace' file with content of dialog.
--		local
--			st: GENERATION_BUFFER
--			ace_file, backup_file: PLAIN_TEXT_FILE
--			ast: like root_ast
--			err: EV_WARNING_DIALOG
--			l_list: like tab_list
--		do
--			l_list := tab_list
--			l_list.do_all (agent {EB_SYSTEM_TAB}.perform_check)
--
--			if
--				l_list.for_all (agent {EB_SYSTEM_TAB}.is_valid)
--			then
--				if Eiffel_ace.file_name = Void or else root_ast = Void then
--						-- Creation of AST.
--					create root_ast
--					ast := root_ast
--				else
--					ast := root_ast.duplicate
--				end
--
--				l_list.do_all (agent {EB_SYSTEM_TAB}.store (ast))
--
--				create st.make (2048)
--				ast.save (st)
--				if Eiffel_ace.file_name = Void then
--					Eiffel_ace.set_file_name (default_ace_file_name)
--				end
--				create ace_file.make (Eiffel_ace.file_name)
--				if not ace_file.exists or else ace_file.is_writable then
--						-- Save a backup_file
--					create backup_file.make_open_write (Eiffel_ace.file_name + ".swp")
--					ace_file.open_read
--					ace_file.copy_to (backup_file)
--					backup_file.close
--					ace_file.close
--
--					ace_file.open_write
--					st.put_in_file (ace_file)
--					ace_file.close
--					successful_save := True
--				else
--						-- Could not save Ace file
--					successful_save := False
--					create err.make_with_text (Warning_messages.W_not_creatable (Eiffel_ace.file_name))
--					err.show_modal_to_window (window)
--				end
--
--				if successful_save then
--						-- We now check the validity of the syntax
--					ast := Eiffel_ace.Lace.parsed_ast
--					successful_save := ast /= Void
--					if not successful_save then
--							-- Restore backup_file.
--						backup_file.open_read
--						ace_file.open_write
--						backup_file.copy_to (ace_file)
--						backup_file.close
--						ace_file.close
--
--						create err.make_with_text (Warning_messages.W_incorrect_ace_configuration)
--						err.show_modal_to_window (window)
--					end
--					check
--						backup_exists: backup_file.exists
--					end
--					backup_file.delete
--				end
--			else
--				successful_save := False
--				create err.make_with_text (Warning_messages.W_incorrect_ace_configuration)
--				err.show_modal_to_window (window)
--			end
--
--				-- Post­store operation to refresh display
--			l_list.do_all (agent {EB_SYSTEM_TAB}.post_store_reset)
--		end

feature {NONE} -- Initialization

	build_interface is
			-- Build window interface.
		local
--			notebook: EV_NOTEBOOK
--			vbox: EV_VERTICAL_BOX
--			button: EV_BUTTON
--			hbox: EV_HORIZONTAL_BOX
--			l_accelerator: EV_ACCELERATOR
--			l_msil_notebook: EV_NOTEBOOK
		do
--			set_title (default_name)
--			set_minimized_title (default_name)
--
--				-- Close window when user press escape.
--			create l_accelerator.make_with_key_combination (
--				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_escape), False, False, False)
--			l_accelerator.actions.extend (agent cancel_action)
--			window.accelerators.extend (l_accelerator)
--
--			create hbox
--			hbox.set_padding (Layout_constants.Small_padding_size)
--			hbox.set_border_width (Layout_constants.Default_border_size)
--			create notebook
--
--			create general_tab.make (Current)
--			notebook.extend (general_tab)
--			notebook.set_item_text (general_tab, general_tab.name)
--
--			create debug_tab.make (Current)
--			notebook.extend (debug_tab)
--			notebook.set_item_text (debug_tab, debug_tab.name)
--
--			create clusters_tab.make (Current)
--			notebook.extend (clusters_tab)
--			notebook.set_item_text (clusters_tab, clusters_tab.name)
--
--			if Platform_constants.is_windows then
--				create l_msil_notebook
--
--				create msil_tab.make (Current)
--				l_msil_notebook.extend (msil_tab)
--				l_msil_notebook.set_item_text (msil_tab, msil_tab.name)
--
--				create msil_assembly_tab.make (Current)
--				l_msil_notebook.extend (msil_assembly_tab)
--				l_msil_notebook.set_item_text (msil_assembly_tab, msil_assembly_tab.name)
--
--				create msil_resources_tab.make (Current)
--				l_msil_notebook.extend (msil_resources_tab)
--				l_msil_notebook.set_item_text (msil_resources_tab, msil_resources_tab.name)
--
--				notebook.extend (l_msil_notebook)
--				notebook.set_item_text (l_msil_notebook, ".NET")
--			end
--
--			create externals_tab.make (Current)
--			notebook.extend (externals_tab)
--			notebook.set_item_text (externals_tab, externals_tab.name)
--
--			create advanced_tab.make (Current)
--			notebook.extend (advanced_tab)
--			notebook.set_item_text (advanced_tab, advanced_tab.name)
--
--			hbox.extend (notebook)
--
--				-- All tabs have been created.
--			is_initialized := True
--
--			create vbox
--			vbox.set_padding (Layout_constants.Small_padding_size)
--			vbox.set_border_width (Layout_constants.Default_border_size)
--
--				-- Create Ok button
--			create ok_button.make_with_text_and_action (Interface_names.b_OK, agent ok_action)
--			extend_button (vbox, ok_button)
--
--				-- Create Cancel button
--			create button.make_with_text_and_action (Interface_names.b_Cancel, agent cancel_action)
--			extend_button (vbox, button)
--
--				-- Create Apply button
--			create button.make_with_text_and_action (Interface_names.b_Apply, agent apply_action)
--			extend_button (vbox, button)
--
--				-- Cosmetics
--			vbox.extend (create {EV_CELL})
--
--			hbox.extend (vbox)
--			hbox.disable_item_expand (vbox)
--
--			window.extend (hbox)
--
--				-- Default is to enable Standard C compilation
--			enable_c_generation
--
--				-- Closing window
--			window.close_request_actions.wipe_out
--			window.close_request_actions.put_front (agent cancel_action)
		end

--	build_menus is
--			-- No menus here
--		local
--			menu_bar: EV_MENU_BAR
--		do
--			build_file_menu
--			create menu_bar
--			menu_bar.extend (file_menu)
---- ARNAUD: Removed the menu.
----			window.set_menu_bar (menu_bar)
--		end

--	build_file_menu is
--			-- Create and build `file_menu'.
--		local
--			menu_item: EV_MENU_ITEM
--		do
--			create file_menu.make_with_text (Interface_names.m_file)
--
--				-- Open
--			create menu_item.make_with_text (Interface_names.m_open)
--			file_menu.extend (menu_item)
--
--			file_menu.extend (create {EV_MENU_SEPARATOR})
--
--			create menu_item.make_with_text (Interface_names.m_ok)
--			menu_item.select_actions.extend (agent ok_action)
--			file_menu.extend (menu_item)
--
--			create menu_item.make_with_text (Interface_names.m_apply)
--			menu_item.select_actions.extend (agent apply_action)
--			file_menu.extend (menu_item)
--
--			create menu_item.make_with_text ("Cancel")
--			menu_item.select_actions.extend (agent cancel_action)
--			file_menu.extend (menu_item)
--		end

feature {NONE} -- Implementation

--	retrieve_ace_file (f: EB_FILE_OPEN_DIALOG) is
--			-- Retrieve selected Ace file from `f' and set it to
--			-- system if valid.
--		require
--			f_not_void: f /= Void
--		local
--			old_ace_location: STRING
--			new_location: STRING
--			error_dialog: EV_WARNING_DIALOG
--		do
--			old_ace_location := Eiffel_ace.file_name
--			new_location := f.file_name
--
--			if
--				not new_location.is_empty and then
--				Eiffel_ace.valid_file_name (new_location)
--			then
--				Eiffel_ace.set_file_name (f.file_name)
--
--				check_content
--
--				if is_content_valid then
--					reset_content
--					is_content_valid := True
--					retrieve_content (root_ast)
--				else
--						-- No need to raise an error, it is done in
--						-- `check_content'.
--					Eiffel_ace.set_file_name (old_ace_location)
--				end
--			else
--				Eiffel_ace.set_file_name (old_ace_location)
--				create error_dialog.make_with_text (
--					Warning_messages.w_Cannot_read_file (new_location))
--				error_dialog.show_modal_to_window (window)
--			end
--		end
--
--feature {NONE} -- Internal status
--
--	default_name: STRING is
--		do
--			Result := Interface_names.t_system
--		end
--
	pixmap: EV_PIXMAP is
			-- Pixmap for Current window.
		do
			Result := Pixmaps.icon_system_window
		end

	successful_save: BOOLEAN
			-- Did we successfully write our changes to disk?

feature {NONE} -- Interface names

--	default_ace_file_name: STRING is "Ace.ace"
--			-- Default ace file name.

feature {NONE} -- Tab access

--	tab_list: ARRAYED_LIST [EB_SYSTEM_TAB] is
--			-- List of available tab in Current.
--		require
--			window_initialized: is_initialized
--		do
--			if Platform_constants.is_windows then
--				create Result.make (6)
--				Result.extend (general_tab)
--				Result.extend (debug_tab)
--				Result.extend (clusters_tab)
--				Result.extend (externals_tab)
--				Result.extend (msil_tab)
--				Result.extend (msil_assembly_tab)
--				Result.extend (msil_resources_tab)
--				Result.extend (advanced_tab)
--			else
--				create Result.make (5)
--				Result.extend (general_tab)
--				Result.extend (debug_tab)
--				Result.extend (clusters_tab)
--				Result.extend (externals_tab)
--				Result.extend (advanced_tab)
--			end
--		end

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

end -- class EB_SYSTEM_WINDOW
