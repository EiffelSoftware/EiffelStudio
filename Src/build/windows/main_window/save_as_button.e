class SAVE_AS_BUTTON 
inherit

	EB_PICT_B
		rename
			make_visible as make
		end;
	WINDOWS;
	LICENCE_COMMAND

creation

	make

feature {NONE} -- Focusable

	focus_string: STRING is "Save project as..."

	symbol: PIXMAP is
		do
			Result := Pixmaps.save_as_pixmap
		end;

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end

feature {NONE} -- Execute

	work (argument: ANY) is
		local
			pw: SAVE_AS_PROJ_WIN	
		do
			if main_panel.project_initialized then
				!!pw.make ("Save project as...", main_panel.base)
				pw.popup
			end
		end

end
