-- Show/Hide windows
class SHOW_WINDOW_HOLE

inherit

	TREE_HOLE
        rename
            make as parent_make
		redefine
			process_context
		end;

creation

	make

feature {NONE}

    make (a_parent: COMPOSITE) is
        do
            parent_make (a_parent)
        end

	create_focus_label is
		do
			set_focus_string (Focus_labels.show_window_label)
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
					main_panel.interface_entry.set_toggle_on
					cont.show
				end;
			end
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.show_window_pixmap
		end;

end
