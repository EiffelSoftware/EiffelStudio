indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	TERMINAL_I 

inherit 

	BULLETIN_I
	
feature -- Access

	label_font: FONT is
			-- Font specified for labels
		deferred
		end;

	button_font: FONT is
			-- Font specified for buttons
		deferred
		end;

	text_font: FONT is
			-- Font specified for text
		deferred
		end

feature {TERMINAL_OUI} -- Basic operaitions

	build is
			-- Build the terminal.
		deferred
		end;
	
feature -- Element change

	set_label_font (a_font: FONT) is
			-- Set font of every labels to `a_font_name'.
		require
			font_name_not_void: a_font /= Void;
			a_font_specified: a_font.is_specified
		deferred
		end;

	set_button_font (a_font: FONT) is
			-- Set font of every buttons to `a_font'.
		require
			font_name_not_void: a_font /= Void;
			a_font_specified: a_font.is_specified
		deferred
		end;

	set_text_font (a_font: FONT) is
			-- Set font of every text to `a_font'.
		require
			font_name_not_void: a_font /= Void;
			a_font_specified: a_font.is_specified
		deferred
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TERMINAL_I

