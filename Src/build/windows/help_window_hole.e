
-- Hole for the help window

class HELP_WINDOW_HOLE 

inherit

	HELP_HOLE
		rename
			make as button_make
		redefine
			process_any, create_empty_editor
		end

creation

	make

feature {NONE}

	associated_window: HELP_WINDOW;

	make (hw: HELP_WINDOW; a_parent: COMPOSITE) is
		require
			valid_hw: hw /= Void;
			valid_a_parent: a_parent /= Void;
		do
			associated_window := hw;
			button_make (a_parent, associated_window.focus_label);
		end;

feature {NONE}

	process_any (dropped: STONE) is
		do
			associated_window.update_text (dropped.data);
		end;

	create_empty_editor is
		do
		end;

end
