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

-- samik	focus_label: FOCUS_LABEL;

	top_window: CLOSEABLE;

	make (win: like top_window; a_parent: COMPOSITE) is
		require
			valid_win: win /= Void;
		do
			top_window := win;
			make_visible (a_parent);
			-- added by samik
			if top_window = Main_panel then
				set_focus_string (Focus_labels.quit_label)
			else
				set_focus_string (Focus_labels.close_label)
			end;
			-- end of samik
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.quit_pixmap
		end;

-- samik	focus_string: STRING is
-- samik		do
-- samik			if top_window = Main_panel then
-- samik				Result := Focus_labels.quit_label
-- samik			else
-- samik				Result := Focus_labels.close_label
-- samik			end;
-- samik		end;

	execute (arg: ANY) is
		do
		--	focus_label.set_text (" ");
			top_window.close;
		end

end
