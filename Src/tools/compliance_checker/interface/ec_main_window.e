indexing
	description: "[
		Main application window for Eiffel/CLS compliance checker.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_MAIN_WINDOW

inherit
	EC_MAIN_WINDOW_IMP

	EC_PROJECT_PERSITER
		export
			{NONE} all
		undefine
			default_create,
			copy,
			is_equal
		end
		
	EC_DIALOG_PROMPT_HELPER
		export
			{NONE} all
		undefine
			default_create,
			copy,
			is_equal
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_accelerator: EV_ACCELERATOR
			l_key: EV_KEY
			l_consts: EV_KEY_CONSTANTS
		do
			set_icon_pixmap (icon_check_compliance)
			
			vbox_project_settings.set_owner_window (Current)
			vbox_output.set_owner_window (Current)
		
			tbtn_new.select_actions.extend (agent on_new_project)
			tbtn_open.select_actions.extend (agent on_open_project)
			tbtn_save.select_actions.extend (agent on_save_project)
			tbtn_check.select_actions.extend (agent on_check_project)
			tbtn_help.select_actions.extend (agent on_show_help)
		
			btn_close.select_actions.extend (agent on_close)
			close_request_actions.extend (agent on_close)
			
				-- Ctrl+Tab
			create l_consts
			create l_key.make_with_code (l_consts.key_tab)
			create l_accelerator.make_with_key_combination (l_key, True, False, False)
			l_accelerator.actions.extend (agent on_navigate_forward)
			accelerators.extend (l_accelerator)

				-- Ctrl+Shift+Tab
			create l_accelerator.make_with_key_combination (l_key, True, False, True)
			l_accelerator.actions.extend (agent on_navigate_backward)
			accelerators.extend (l_accelerator)
			
		end

feature {NONE} -- Agent Handlers

	on_close is
			-- Called when user requests to close application
		local
			l_close: BOOLEAN
		do
			if project.is_dirty then				
				l_close := ask_question (question_close_project_not_save, button_okay, button_cancel, button_cancel, [], Current)
			else
				l_close := True
			end
			if l_close then
				vbox_output.reset_report
				destroy
				
				if application_exists then
					(create {EV_ENVIRONMENT}).application.destroy
				end
			end
		end

	on_new_project is
			-- Called when user wants to create a new project.
		local
			l_can_create: BOOLEAN
		do
			if project.is_dirty then
				l_can_create := query_clean_project
			else
				l_can_create := ask_question (question_new_project, button_okay, button_cancel, button_cancel, [], Current)
			end

			if l_can_create then
				internal_project_settings.put (create {EC_PROJECT_SETTINGS}.make_empty)
				vbox_project_settings.synchronize_project_with_interface
				sticky_project_file_name := Void
				vbox_output.reset_report
			end
		end
		
	on_open_project is
			-- Called when user want to open a new project.
		local
			l_ofd: EV_FILE_OPEN_DIALOG
			l_file_name: STRING
			retried: BOOLEAN
		do
			if not retried then
				if query_clean_project then
					create l_ofd
					l_ofd.set_title (file_dialog_open_project)
					if sticky_project_file_name /= Void and not sticky_project_file_name.is_empty then
						l_ofd.set_file_name (sticky_project_file_name)	
					end
					l_ofd.filters.extend ([filter_project, filter_name_project])
					l_ofd.show_modal_to_window (Current)
					l_file_name := l_ofd.file_name
					if l_file_name /= Void and then not l_file_name.is_empty then
						sticky_project_file_name := l_file_name
						load_project (l_file_name)
						vbox_output.reset_report
						vbox_project_settings.synchronize_project_with_interface
					end
				end
			else
				show_error (error_unable_to_retried_project, [], Current)
			end
		rescue
			retried := True
			retry
		end
		
	on_save_project is
			-- Called when user wants to save an open project.
		local
			l_sfd: EV_FILE_SAVE_DIALOG
			l_file_name: STRING
			l_ext: like project_file_name_extension
			retried: BOOLEAN
		do
			if not retried then
				if sticky_project_file_name = Void or else sticky_project_file_name.is_empty then
					l_ext := project_file_name_extension
					create l_sfd
					l_sfd.set_title (file_dialog_save_project)
					l_sfd.filters.extend ([filter_project, filter_name_project])
					l_sfd.show_modal_to_window (Current)
					l_file_name := l_sfd.file_name
					if l_file_name /= Void and then not l_file_name.is_empty then
						if l_file_name.count > l_ext.count then
							if not l_file_name.substring (l_file_name.count - (l_ext.count - 1), l_file_name.count).is_case_insensitive_equal (l_ext) then
								l_file_name.append (l_ext)
							end
						else
							l_file_name.append (l_ext)
						end
						save_project (l_file_name)
						project.set_is_dirty (False)
						sticky_project_file_name := l_file_name
					end					
				else
					save_project (sticky_project_file_name)
					project.set_is_dirty (False)
				end
			else
				show_error (error_unable_to_save_project, [], Current)
			end
		rescue
			retried := True
			retry
		end
		
	on_check_project is
			-- Called when user selects check toolbar button
		require
			nb_main_not_void: nb_main /= Void
			vbox_output_not_void: vbox_output /= Void
		local
			l_notebook: like nb_main
		do
			l_notebook := nb_main
			l_notebook.select_item (l_notebook.i_th (2))
			vbox_output.btn_start_checking.select_actions.call ([])
		end
		
	on_show_help is
			-- Called when user selects help toolbar button
		do
			--| Implement me...
		end
		
	on_back_button_selected (a_rotate: BOOLEAN) is
			-- Called when `back_button' is selected
		require
			select_tab_not_first: not a_rotate implies nb_main.selected_item_index > 1
		local
			l_notebook: like nb_main
		do
			l_notebook := nb_main
			if a_rotate and then l_notebook.selected_item_index = 1 then
				l_notebook.select_item (nb_main.i_th (l_notebook.count))
			else
				l_notebook.select_item (nb_main.i_th (l_notebook.selected_item_index - 1))
			end
		end

	on_next_button_selected (a_rotate: BOOLEAN) is
			-- Called when `next_button' is selected
		require
			select_tab_not_last: not a_rotate implies nb_main.selected_item_index < nb_main.count
		local
			l_notebook: like nb_main
		do
			l_notebook := nb_main
			if a_rotate and then l_notebook.selected_item_index = l_notebook.count then
				l_notebook.select_item (l_notebook.i_th (1))
			else
				l_notebook.select_item (l_notebook.i_th (l_notebook.selected_item_index + 1))
			end
		end

	on_navigate_forward is
			-- Handles the Ctrl+Tab accelerator actions
		require
			nb_main_not_void: nb_main /= Void
		do
			on_next_button_selected (True)
		end

	on_navigate_backward is
			-- Handles the Ctrl+Shift+Tab accelerator actions
		require
			nb_main_not_void: nb_main /= Void
		do
			on_back_button_selected (True)
		end
		
feature {NONE} -- Implementation
		
	query_clean_project: BOOLEAN is
			-- Queries project state to see if a project can be cleaned?
		local
			l_warning: EV_WARNING_DIALOG
		do
			if project.is_dirty then
				create l_warning.make_with_text (warning_new_project_unsaved)
				l_warning.set_buttons (<<button_okay, button_cancel>>)
				l_warning.set_default_cancel_button (l_warning.button (button_cancel))
				l_warning.show_modal_to_window (Current)
				Result := l_warning.selected_button.is_equal (button_okay)
			else
				Result := True
			end
		end
			
	sticky_project_file_name: STRING
			-- Sticky project file name
			
	project_file_name_extension: STRING is ".ecmp"
			-- Project file name extension

end -- class EC_MAIN_WINDOW

