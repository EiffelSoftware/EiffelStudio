class
	WINDOWS 

inherit
	SHARED_EXEC_ENVIRONMENT

feature {NONE}

	screen: EV_SCREEN is
		once
			create Result.make
		end

 	main_window: MAIN_WINDOW is
 		once
			create Result.make_root
 		end

	context_catalog: CONTEXT_CATALOG is
		do
			Result := main_window.context_catalog
		end

feature {NONE} -- Initial windowing

	project_directory: STRING

 	init_project is
		local
			cmd: OPEN_PROJECT
 		do
			if (history_window = Void) then end
			if (app_editor = Void) then end
			if (namer_window = Void) then end
--			if (class_importer = Void) then end
			if project_directory /= Void
			and then not project_directory.empty
			then
				create cmd
				cmd.open_project (project_directory)
				project_directory := Void
			end
 		end

	init_main_window (txt: STRING) is
			-- Init the main window after retrieving a project.
		local
			title_string: STRING
		do
			title_string := "ISE EiffelBuild: "
			title_string.append (txt)
			main_window.set_title (title_string)
			main_window.set_project_initialized
		end

	display_init_windows is
		do
--			main_panel.hide_command_editor
--			if not tree.realized then
--				tree.realize
--			end
--			if not context_catalog.realized then
--				context_catalog.realize
--			end
--			main_panel.hide_command_catalog
--			if not current_mode.realized then
--				current_mode.realize
--			end
--			if not application_object_window.realized then
--				application_object_window.realize
--			end
		end

 	clear_project is
 		do
--			context_catalog.clear
--			main_window.command_catalog.clear
			window_mgr.clear_all_editors
--			main_window. command_catalog.initialize_pages
			app_editor.clear
			history_window.wipe_out
			main_window.unset_project_initialized
			namer_window.close (Void, Void)
--			class_importer.close
 		end

	update_all_windows is
		do
		end

feature {NONE} -- Windows

	history_window: HISTORY_WINDOW is
		once
			create Result.make (main_window)
		end

--	class_importer: CLASS_IMPORTER is
--		once
--			create Result.make_top_level
--		end

	error_dialog: EB_ERROR_DIALOG is
		once
			!! Result
		end

	error_window: EB_ERROR_DIALOG is
			-- For the Error Handler (which
			-- is also used for bench)
		do
			Result := error_dialog
		end

	question_dialog: EB_QUESTION_DIALOG is
		once
			!! Result
		end

feature {WINDOW_MGR} -- Application editor

	app_editor: APP_EDITOR is
		once
			create Result.make
		end

feature {NONE} -- Rename

	namer_window: NAMER_WINDOW is
		once
			create Result.make (main_window)
		end

	change_name (nm: NAMABLE) is
			-- Popup `namer_window' with `nm' to rename it.
		require
			namable: nm /= Void
		do
			if nm.is_able_to_be_named then
				namer_window.popup_with (nm)
			end
		end

feature {NONE} -- Default popuper

	popuper_parent: EV_CONTAINER is
		do
			Result := main_window
		end

feature {NONE} -- Window Manager

	window_mgr: WINDOW_MGR is
		once
			create Result.make (main_window)
		end

end -- class WINDOWS

