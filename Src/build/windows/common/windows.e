class WINDOWS 

inherit

	GRAPHICS

	WIDGET_NAMES

feature {NONE}

	eb_screen: SCREEN is
		once
			!!Result.make ("")
		end

	transporter: TRANSPORTER is
		once
			Result := main_panel.base
		end
	
feature 

	main_panel: MAIN_PANEL is
		once
			!!Result.make (B_ase, eb_screen)
		end

feature

	context_catalog: CONTEXT_CATALOG  is
		once
			!!Result.make
		end

	init_windowing is
		do
			if (toolkit = Void) then end
		end

	init_project is
		do
			if (main_panel = Void) then end;
			init_session;
			main_panel.realize;
		end

	init_session is
		do
			if (context_catalog = Void) then end
			if (app_editor = Void) then end
			if (command_catalog = Void) then end
			if (history_window = Void) then end
		end

	display_init_windows is
		do
			tree.realize
			context_catalog.realize
		end

	command_catalog: CMD_CATALOG is
		once
			!!Result.make (C_ommandcatalog, eb_screen)
		end	

	app_editor: APP_EDITOR is
		once
			!!Result.make (eb_screen)
		end

	history_window: HISTORY_WND is
		once
			!!Result.make (H_istorywindow, main_panel.base)
		end

	tree: CONTEXT_TREE is
		once
			!!Result.make (eb_screen)
		end

	warning_box: WARNING_BOX is
		once
			!!Result.make (A_lert, main_panel.base)
		end

	error_box: ERROR_BOX is
		once
			!!Result.make (E_rror, main_panel.base)
		end

	question_box: QUESTION_BOX is
		once
			!!Result.make (Q_uestion, main_panel.base)
		end

	window_mgr: WINDOW_MGR is
		once
			!!Result.make (eb_screen, 3)
		end

end
