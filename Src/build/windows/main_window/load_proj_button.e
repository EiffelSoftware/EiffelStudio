class LOAD_PROJ_BUTTON 

inherit

	EB_BUTTON_COM
		rename
			make_visible as make
		end;
	WINDOWS;
	LICENCE_COMMAND
	QUEST_POPUPER
		undefine
			continue_after_popdown
		end

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
				!!pw.make (main_panel.base)
				pw.popup
			else
				if not history_window.saved_application then
					question_box.popup (Current, 
						Messages.save_project_qu, Void)
				else
					open_new_application
				end
			end
		end

feature {NONE}

	continue_after_popdown (box: QUESTION_BOX yes: BOOLEAN) is
		local
			pw: OPEN_PROJ_WIN
		do
			if box = question_box then
				if yes then
					open_new_application
				else
					!!pw.make (main_panel.base) 
					pw.popup
				end
			end
		end

	open_new_application is
		local
			save_proj: SAVE_PROJECT;
			pw: OPEN_PROJ_WIN
		do
			if main_panel.project_initialized then
				!!save_proj
				save_proj.execute (Void)
			end
			if save_proj.completed then
				!!pw.make (main_panel.base)
				pw.popup
			end
		end

end
