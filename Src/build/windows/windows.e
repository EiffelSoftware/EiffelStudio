class
	WINDOWS 
inherit

	GRAPHICS
		redefine
			init_toolkit
		end 

	SHARED_EXEC_ENVIRONMENT

feature {NONE}


	eb_screen: SCREEN is
		once
			!! Result.make ("")
		end

	transporter: TRANSPORTER is
		once
			Result := main_panel.base
		end
	
	main_panel: MAIN_PANEL is
		once
			!! Result.make (eb_screen)
		end

	context_catalog: CONTEXT_CATALOG is
		once
			Result := main_panel.context_catalog_widget
		end

	presentation_window: BUILD_PRESENT_WINDOW is
		once
			!! Result.make ("", eb_screen)
		end

feature {NONE} -- Initial windowing

	init_toolkit: TOOLKIT_IMP is
			-- Init toolkit to desired implementation.
		once
			!! Result.make ("")
		end

	init_project is
		do
			main_panel.realize
			main_panel.unset_project_initialized
			if (tree = Void) then end
			if (context_catalog = Void) then end
			if (command_catalog = Void) then end
			if (history_window = Void) then end
			if (app_editor = Void) then end
			presentation_window.close
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
-- 			if not application_object_window.realized then
-- 				application_object_window.realize
--			end
		end

	clear_project is
		do
			context_catalog.clear
			command_catalog.clear
			window_mgr.clear_all_editors
			command_catalog.initialize_pages		
			app_editor.clear
			history_window.wipe_out
			main_panel.unset_project_initialized
			namer_window.close
			class_importer.close
		end

	update_all_windows is
		do
		end

feature {NONE} -- Windows

	command_catalog: COMMAND_CATALOG is
		do
			Result := main_panel.command_catalog_widget
		end

	app_editor: APP_EDITOR is
		once
			!! Result.make 
		end

	history_window: HISTORY_WND is
		once
			!! Result.make (eb_screen)
		end

	class_importer: CLASS_IMPORTER is
		once
			!! Result.make ("", eb_screen)
		end

	object_tool_generator: OBJECT_TOOL_GENERATOR is
		once
			!! Result.make ("", eb_screen)
		end

	object_command_generator: OBJECT_COMMAND_GENERATOR is
		once
			!! Result.make ("", eb_screen)
		end

	tree: CONTEXT_TREE is
		once
			Result := main_panel.context_tree_widget
		end

	error_box: ERROR_BOX is
		once
			!! Result
		end

	namer_window: NAMER_WINDOW is
		once
			!! Result.make (Eb_screen)
		end

	error_window: ERROR_BOX is
			-- For the Error Handler (which
			-- is also used for bench)
		do
			Result := error_box
		end

	question_box: QUESTION_BOX is
		once
			!! Result
		end

feature {NONE} -- Window Manager

	window_mgr: WINDOW_MGR is
		once
			!! Result.make (eb_screen)
		end

end
