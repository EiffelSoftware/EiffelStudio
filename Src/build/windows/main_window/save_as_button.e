class SAVE_AS_BUTTON 
inherit

	CREATE_PROJ_BUTTON
		redefine
			focus_string, symbol, popup_window, app_not_save_qu
		end;
	WINDOWS;

creation

	make

feature {NONE} -- Focusable

	focus_string: STRING is 
		do
			Result := Focus_labels.save_project_as_label
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.save_as_pixmap
		end;

	app_not_save_qu: STRING is
		do
			Result := Messages.save_as_project_qu
		end;

	popup_window is
		local
			pw: SAVE_AS_PROJ_WIN
		do
			if main_panel.project_initialized then
				!!pw.make (main_panel.base)
				pw.popup
			end
		end;

end
