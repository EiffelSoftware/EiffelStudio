
class IMPORT_BUTTON 

inherit

	EB_BUTTON_COM
		rename
			make_visible as make
		end;
	WINDOWS;
	LICENCE_COMMAND

creation

	make
	
feature {NONE}

	focus_string: STRING is 
		do
			Result := Focus_labels.import_code_label
		end;

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.import_pixmap
		end;

feature {NONE}

	work (argument: ANY) is
			-- popup a window to specify what
			-- and where to import,
		local
			iw: IMPORT_WINDOW
		do
			if main_panel.project_initialized then
				!!iw.make (main_panel.base)
				iw.popup
			end
		end

end
