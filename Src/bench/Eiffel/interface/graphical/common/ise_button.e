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

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'
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

	set_selected (b: BOOLEAN) is
			-- Darken the symbol of current button if `b', lighten it otherwise.
		deferred
		end;

	set_symbol (p: PIXMAP) is
			-- Set the pixmap if it it valid
		require
			non_void_arg: p /= Void
		deferred
		end;

feature {NONE} -- Properties

	button_name: STRING is "push_b"

end -- class ISE_BUTTON
