class CLOSE_WINDOW_BUTTON 

inherit

	EB_BUTTON_COM
	
	WINDOWS
		select
			init_toolkit
		end

creation

	make

feature {NONE}

	top_window: CLOSEABLE;

	make (win: like top_window; a_parent: COMPOSITE) is
		require
			valid_win: win /= Void;
		do
			top_window := win;
			make_visible (a_parent);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.quit_pixmap
		end;

	create_focus_label is
		do
			if top_window = Main_panel then
				set_focus_string (Focus_labels.quit_label)
			else
				set_focus_string (Focus_labels.close_label)
			end			
		end
				
	execute (arg: ANY) is
		do
			top_window.close;
		end

end
