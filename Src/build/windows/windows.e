class
	WINDOWS 
inherit

	GRAPHICS
		redefine
			init_toolkit
		end 

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

	context_catalog: CONTEXT_CATALOG  is
		once
			!! Result.make
		end

feature {NONE} -- Initial windowing

	 init_toolkit: OBSOLETE_MOTIF is
                        -- The demo uses the
                        -- Motif toolkit
                once
                        !!Result.make ("");
                end;

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
			if not tree.realized then
				tree.realize
			end;
			if not context_catalog.realized then
				context_catalog.realize
			end
		end;

	clear_project is
		do
			context_catalog.clear;
			command_catalog.clear;
			window_mgr.clear_all_editors;
			command_catalog.initialize_pages;		
			app_editor.clear;
			history_window.wipe_out;
			main_panel.unset_project_initialized;
			namer_window.close;
		end;

	update_all_windows is
		do
		end;

feature {NONE} -- Windows

	command_catalog: CMD_CATALOG is
		once
			!! Result.make (eb_screen)
		end	

	app_editor: APP_EDITOR is
		once
			!! Result.make 
		end

	history_window: HISTORY_WND is
		once
			!! Result.make (eb_screen)
		end

	tree: CONTEXT_TREE is
		once
			!! Result.make (eb_screen)
		end

	error_box: ERROR_BOX is
		once
			!! Result
		end

	namer_window: NAMER_WINDOW is
		once
			!! Result.make (Eb_screen)
		end;

	error_window: ERROR_BOX is
			-- For the Error Handler (which
			-- is also used for bench)
		do
			Result := error_box
		end;

	question_box: QUESTION_BOX is
		once
			!! Result
		end;

feature {NONE} -- Window Manager

	window_mgr: WINDOW_MGR is
		once
			!! Result.make (eb_screen)
		end

end
