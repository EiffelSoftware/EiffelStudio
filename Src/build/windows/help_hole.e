
class HELP_HOLE 

inherit

	EDIT_BUTTON
		rename
			make as button_make
		redefine
			process_stone
		end

creation

	make

feature {NONE}

	associated_window: HELP_WINDOW;

	focus_string: STRING is 
		do
			Result := Focus_labels.help_label
		end;

	make (hw: HELP_WINDOW; a_parent: COMPOSITE; l: FOCUS_LABEL) is
		require
			valid_a_parent: a_parent /= Void;
			valid_l: l /= Void
		do
			associated_window := hw;
			button_make (a_parent, l);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.help_pixmap
		end;
	
feature {NONE}

	process_stone is
		local
			helpable: HELPABLE;
			hw: HELP_WINDOW
		do
			helpable ?= stone;
			if helpable /= Void then
				if (associated_window = Void) then
					!! hw.make (eb_screen);
					hw.set_text (helpable.help_text);
					hw.realize
				else
					associated_window.set_text (helpable.help_text);
				end;
			end
		end;

	create_empty_editor is
		local
			hw: HELP_WINDOW
		do
			if associated_window = Void then
				!! hw.make (eb_screen);
				hw.realize;
			end
		end;	

end
