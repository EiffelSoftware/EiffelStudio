class CREATE_PROJ_BUTTON 

inherit

	EB_BUTTON_COM
		rename
			make_visible as make
		end;
	WINDOWS;
	LICENCE_COMMAND;
	QUEST_POPUPER
		redefine
			continue_after_popdown
		end

creation

	make

feature {NONE}

	focus_string: STRING is
		do
			Result := Focus_labels.create_project_label
		end;

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.create_project_pixmap
		end;
	
feature {NONE}

	work (argument: ANY) is
		local
			pw: CREATE_PROJ_WIN
		do
			if not main_panel.project_initialized then
				popup_window
			else
				if history_window.saved_application then
					popup_window
				else
					question_box.popup (Current, 
						Messages.save_project_qu, Void)
				end
			end
		end

feature {NONE}

	continue_after_popdown (box: QUESTION_BOX yes: BOOLEAN) is
		local
			pw: CREATE_PROJ_WIN;
		do
			if box = question_box then
				if yes then
					open_new_application
				else
					popup_window
				end
			end
		end

	open_new_application is
		local
			save_proj: SAVE_PROJECT;
			pw: CREATE_PROJ_WIN;
		do
			!!save_proj;
			save_proj.execute (Void)
			if save_proj.completed then
				popup_window
			end
		end;

	popup_window is
		local
			pw: CREATE_PROJ_WIN;
		do
			!!pw.make (main_panel.base) 
			pw.popup
		end;

end
