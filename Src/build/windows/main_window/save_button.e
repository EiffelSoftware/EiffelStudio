class SAVE_BUTTON 
inherit

	EB_BUTTON_COM
		rename
			make_visible as make
		end;
	WINDOWS

creation

	make

feature {NONE}

	focus_string: STRING is 
		do
			Result := Focus_labels.save_project_label
		end;

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.save_pixmap
		end;

	execute (arg: ANY) is
		local
			save_proj: SAVE_PROJECT
		do
			!!save_proj;
			save_proj.execute (Void);
		end

end
