class WINDOWS 

feature {NONE}

	eb_screen: SCREEN is
		once
			!!Result.make ("")
		end

	transporter: TRANSPORTER is
		once
			Result := main_panel.base
		end
	
	main_panel: MAIN_PANEL is
		once
			!!Result.make (eb_screen)
		end

	context_catalog: CONTEXT_CATALOG  is
		once
			!!Result.make
		end

feature {NONE} -- Initial windowing

	init_project is
		do
			if (main_panel = Void) then end;
			if (tree = Void) then end
			if (context_catalog = Void) then end
			if (command_catalog = Void) then end
			if (history_window = Void) then end
			if (app_editor = Void) then end
			main_panel.realize;
		end

	display_init_windows is
		do
			tree.realize
			context_catalog.realize
		end

feature {NONE} -- Windows

	command_catalog: CMD_CATALOG is
		once
			!!Result.make (eb_screen)
		end	

	app_editor: APP_EDITOR is
		once
			!!Result.make (eb_screen)
		end

	history_window: HISTORY_WND is
		once
			!!Result.make (eb_screen)
		end

	tree: CONTEXT_TREE is
		once
			!!Result.make (eb_screen)
		end

	error_box: ERROR_BOX is
		once
			!!Result.make (main_panel.base)
		end

	question_box: QUESTION_BOX is
		once
			!!Result.make (main_panel.base)
		end

feature {NONE} -- Window Manager

	window_mgr: WINDOW_MGR is
		once
			!!Result.make (eb_screen)
		end

end
