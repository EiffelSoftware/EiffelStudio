-- Eiffelbuild button that is focusable and has a symbol. 
deferred class EB_BUTTON

inherit

	FOCUSABLE;
	CONSTANTS;
	PICT_COLOR_B
		rename
			make as pict_color_make,
			identifier as oui_identifier
		end;

feature {NONE}

	focus_source: WIDGET is
		do
			Result := Current
		end;

	make_visible (a_parent: COMPOSITE) is	
		require
			valid_a_parent: a_parent /= Void
		do
			pict_color_make (Widget_names.pcbutton, a_parent);
			set_symbol (symbol);
			initialize_focus;
		end;

	symbol: PIXMAP is
		deferred
		end;

	set_symbol (s: PIXMAP) is
			-- Set icon symbol.
		require
			valid_argument: s /= Void
		do
			if s.is_valid then
				set_pixmap (s);
			end
		end;

end
