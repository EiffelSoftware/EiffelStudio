
class HELP_HOLE 

inherit

	ICON_HOLE
		redefine
			stone
		end;
	PIXMAPS
		export
			{NONE} all
		end;
	COMMAND
		export
			{NONE} all
		end;
	FOCUSABLE
		export
			{NONE} all
		end


creation

	make

	
feature {NONE}

	focus_source: PICT_COLOR_B is
		do
			Result := button;
		end;

	focus_label: LABEL is
        do
            Result := main_panel.focus_label
        end;
 
    focus_string: STRING is "Help window";

	
feature 

	make (hw: HELP_WINDOW; a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			associated_window := hw;
			set_symbol (help_pixmap);
			make_visible (a_parent);
			initialize_focus;
			add_activate_action (Current, Nothing);
		end;

	
feature {NONE}

	associated_window: HELP_WINDOW;

	
feature 

	stone: STONE;

	
feature {NONE}

	process_stone is
		local
			temp: ANY;
			helpable: HELPABLE;
			hw: HELP_WINDOW
		do
			temp := stone;
			helpable ?= temp;
			if
				not (helpable = Void)
			then
				if (associated_window = Void) then
					!!hw.make ("Help", eb_screen);
					hw.text.set_text (helpable.help_text);
					hw.realize
				else
					associated_window.text.set_text (helpable.help_text);
				end;
			end
		end;

	execute (argument: ANY) is
		local
			hw: HELP_WINDOW
		do
			!!hw.make ("Help", eb_screen);
			hw.realize;
		end;	

end
