indexing

	description:
		"Abstract notion of a tool button.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_BUTTON

inherit
	ACTIVE_PICT_COLOR_B;
	FOCUSABLE

feature -- Access

	symbol: PIXMAP is
			-- The pixmap representing Current.
		deferred
		end;

	focus_source: WIDGET is
			-- Widget representing Current on the screen.
		do
			Result := Current
		end;

feature -- Status Setting

	set_symbol (p: PIXMAP) is
			-- Set the pixmap if it it valid
		do
			if p.is_valid then
				set_pixmap (p)
			end;
		end;

feature {NONE} -- Properties

	button_name: STRING is "push_b"

end -- class ISE_BUTTON
