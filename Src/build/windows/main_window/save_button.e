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

	unsaved_symbol: PIXMAP is
		do
			Result := Pixmaps.unsave_pixmap
		end;

	execute (arg: ANY) is
		local
			save_proj: SAVE_PROJECT
		do
			if main_panel.project_initialized then
				!!save_proj;
				save_proj.execute (Void);
			end
		end

feature

	set_saved_symbol is
		do
			if pixmap /= symbol then
				set_symbol (symbol)
			end
		end;

	set_unsaved_symbol is
		do
			if pixmap /= unsaved_symbol then
				set_symbol (unsaved_symbol)
			end
		end;

end
