class LOAD_PROJ_BUTTON 

inherit

	EB_BUTTON_COM
	
	WINDOWS
		select
			init_toolkit
		end
	LICENCE_COMMAND
	QUEST_POPUPER

creation

	make
	
feature {NONE}
  
	  make (a_parent: COMPOSITE) is
        do
            make_visible (a_parent)
        end

	create_focus_label is 
		do
			set_focus_string (Focus_labels.load_project_label)
		end;

-- samik	focus_label: LABEL is
-- samik		do
-- samik			Result := main_panel.focus_label
-- samik		end
  
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
