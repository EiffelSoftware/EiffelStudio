indexing

	description:
		"Abstract notion of a tool button.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_BUTTON

inherit
	PICT_COLOR_B
		undefine
			set_sensitive, set_insensitive
		end;
	FOCUSABLE

feature -- Access

	symbol: PIXMAP is
			-- The pixmap representing Current.
		deferred
		end;

	grey_symbol: PIXMAP is
			-- Insensitive version of `symbol'
		deferred
		end;

	focus_source: WIDGET is
			-- Widget representing Current on the screen.
		do
			Result := Current
		end;

	focus_string: STRING is
		deferred
		end

feature -- Status Setting

        set_symbol (p: PIXMAP) is
                        -- Set the pixmap if it it valid
                do
                        if p.is_valid then
                                set_pixmap (p)
                        end;
                end;

        set_sensitive is
                        -- Make Current sensitive for user input.
                do
                        set_symbol (symbol)
                end;

        set_insensitive is
                        -- Make Current insensitive for user input.
                do
                        set_symbol (grey_symbol)
                end;

feature {NONE} -- Properties

	button_name: STRING is "push_b"

end -- class ISE_BUTTON
