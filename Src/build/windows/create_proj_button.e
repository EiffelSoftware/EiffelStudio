class CREATE_PROJ_BUTTON 

inherit

	EB_BUTTON_COM
		rename
			make_visible as make
		end;
	WINDOWS;
	LICENCE_COMMAND;
	QUEST_POPUPER

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
						app_not_save_qu, Void)
				end
			end
		end

	app_not_save_qu: STRING is
		do
			Result := Messages.create_project_qu
		end;

feature {NONE}

	question_cancel_action is
		do
		end;

	question_ok_action is
		do
			popup_window
		end;

	popup_window is
		local
			pw: CREATE_PROJ_WIN;
		do
			!!pw.make (main_panel.base) 
			pw.popup
		end;

	popuper_parent: COMPOSITE is
		do
			Result := main_panel.base
		end;

end
