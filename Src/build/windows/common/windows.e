class
	WINDOWS 
inherit

	GRAPHICS
		redefine
			init_toolkit
		end 

	SHARED_EXEC_ENVIRONMENT

	QUEST_POPUPER

feature {NONE}


	eb_screen: SCREEN is
		once
			create Result.make ("")
		end

--	transporter: TRANSPORTER is
--		once
--			Result := main_panel.base
--		end
--	
 	main_window: MAIN_WINDOW is
 		once
			create Result.make_top_level
 		end

	context_catalog: CONTEXT_CATALOG is
		do
			Result := main_window.context_catalog
		end

--	presentation_window: BUILD_PRESENT_WINDOW is
--		once
--			create Result.make ("", eb_screen)
--		end

feature {NONE} -- Initial windowing

	init_toolkit: TOOLKIT_IMP is
			-- Init toolkit to desired implementation.
		once
			!! Result.make ("")
		end

 	init_project is
 		do
--			main_panel.realize
--			main_panel.unset_project_initialized
--			if (tree = Void) then end
--			if (context_catalog = Void) then end
--			if (command_catalog = Void) then end
--			if (history_window = Void) then end
--			if (app_editor = Void) then end
--			presentation_window.close
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
--			command_catalog.clear
--			window_mgr.clear_all_editors
--			command_catalog.initialize_pages		
--			app_editor.clear
--			history_window.wipe_out
--			main_panel.unset_project_initialized
--			namer_window.close
--			class_importer.close
 		end

	update_all_windows is
		do
		end

feature {WINDOWS} -- Finish application

	save_question: BOOLEAN

	exit_build (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		do
			if history_window.saved_application then
				question_dialog.popup (Current, Messages.exit_qu, Void, False)
			else
				save_question := True
				question_dialog.popup (Current, Messages.save_project_qu, Void, False)
			end
		end

	question_ok_action, close_without_any_check is
--		local
--			save_proj: SAVE_PROJECT
--			quit_app_com: QUIT_NOW_COM
		do
			if save_question then
--				!!save_proj
--				save_proj.execute (Void)
--				save_question := False
--				question_box.popup (Current, Messages.exit_qu, Void)
			else
--				discard_license
--				!! quit_app_com
--				quit_app_com.execute (Void)
			main_window.destroy
			end
		end

	question_cancel_action is
		do
			if save_question then
				save_question := False
				question_dialog.popup (Current, Messages.exit_qu, Void, False)
			end
		end

	popuper_parent: EV_CONTAINER is
		do
			Result := main_window
		end

feature {NONE} -- Windows

--	app_editor: APP_EDITOR is
--		once
--			!! Result.make 
--		end

	history_window: HISTORY_WINDOW is
		once
			create Result.make (main_window)
		end

--	class_importer: CLASS_IMPORTER is
--		once
--			create Result.make_top_level
--		end

--	tree: CONTEXT_TREE is
--		once
--			Result := main_panel.context_tree_widget
--		end

	error_dialog: EB_ERROR_DIALOG is
		once
			!! Result
		end

	namer_window: NAMER_WINDOW is
		once
			create Result.make (main_window)
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

feature {NONE} -- Window Manager

	window_mgr: WINDOW_MGR is
		once
			!! Result.make (main_window)
		end

end -- class WINDOWS

