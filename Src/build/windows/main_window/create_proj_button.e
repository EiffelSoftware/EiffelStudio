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

	pw: OPEN_PROJ_WIN

	work (argument: ANY) is
		do
			if not main_panel.project_initialized then
				if pw = Void then
					!!pw.make (Widget_names.load_project, main_panel.base)
				end
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
		do
			if box = question_box then
				if yes then
					open_new_application
				else
					if pw = Void then
						!!pw.make ("Open project", main_panel.base) 
					end
					pw.popup
				end
			end
		end

	open_new_application is
		local
			save_proj: SAVE_PROJECT
		do
			if main_panel.project_initialized then
				!!save_proj
				save_proj.execute (Void)
			end
			if save_proj.completed then
				if pw = Void then
					!!pw.make ("Open project", main_panel.base)
				end
				pw.popup
			end
		end

end
