class CLOSE_WINDOW_BUTTON 

inherit

	EB_BUTTON_COM;
	WINDOWS

creation

	make

feature {NONE}

	focus_label: FOCUS_LABEL;

	top_window: CLOSEABLE;

	make (win: like top_window; a_parent: COMPOSITE; l: FOCUS_LABEL) is
		require
			valid_win: win /= Void;
			valid_l: l /= Void
		do
			focus_label := l
			top_window := win;
			make_visible (a_parent);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.quit_pixmap
		end;

	focus_string: STRING is
		do
			if top_window = Main_panel then
				Result := Focus_labels.quit_label
			else
				Result := Focus_labels.close_label
			end;
		end;

	execute (arg: ANY) is
		do
			focus_label.set_text (" ");
			top_window.close;
		end

end
