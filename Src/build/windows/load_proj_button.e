class LOAD_PROJ_BUTTON 

inherit

	EB_BUTTON_COM
		rename
			make_visible as make
		end;
	WINDOWS;
	LICENCE_COMMAND
	QUEST_POPUPER

creation

	make
	
feature {NONE}

	focus_string: STRING is 
		do
			Result := Focus_labels.load_project_label
		end;

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.load_project_pixmap
		end;
	
feature {NONE}

	work (argument: ANY) is
		local
			pw: OPEN_PROJ_WIN
		do
			if not main_panel.project_initialized then
				popup_window
			else
				if history_window.saved_application then
					popup_window
				else
					question_box.popup (Current, 
						Messages.open_project_qu, Void)
				end
			end
		end

feature {NONE}

	question_ok_action is
		do
			popup_window
		end;

	question_cancel_action is
		do
		end;

	open_new_application is
		local
			save_proj: SAVE_PROJECT;
			pw: OPEN_PROJ_WIN
		do
			!!save_proj;
			save_proj.execute (Void);
			if save_proj.completed then
				!!pw.make (main_panel.base) 
				pw.popup
			end;
		end

	popup_window is
		local
			pw: OPEN_PROJ_WIN;
		do
			!!pw.make (main_panel.base)
			pw.popup
		end;

	popuper_parent: COMPOSITE is
		do
			Result := main_panel.base
		end

end
