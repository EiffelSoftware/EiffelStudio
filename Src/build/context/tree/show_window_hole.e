-- Show/Hide windows
class SHOW_WINDOW_HOLE

inherit

	TREE_HOLE
		redefine
			process_context
		end;
	EB_BUTTON 

creation

	make

feature {NONE}

	focus_string: STRING is
		do
			Result := Focus_labels.show_window_label
		end;

	process_context (dropped: CONTEXT_STONE) is
		local
			cont: CONTEXT
		do
			cont := dropped.data;
			if cont.is_window then
				if cont.shown then
					cont.hide
				else
					cont.show
				end
			end
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.show_window_pixmap
		end;

end
