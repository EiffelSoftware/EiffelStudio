indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class TERMINAL_I 

inherit 

	BULLETIN_I
	
feature {TERMINAL_OUI}

	build is
			-- Build the terminal.
		deferred
		end; -- build
	
feature 

	is_font_defined (font_name: STRING): BOOLEAN is
			-- Is `font_name' defined for current terminal?
		require
			font_name_not_void: not (font_name = Void)
		deferred
		end; -- is_font_defined

	set_label_font (a_font_name: STRING) is
			-- Set font of every labels to `a_font_name'.
		require
			font_name_not_void: not (a_font_name = Void);
			font_name_defined: is_font_defined (a_font_name)
		deferred
		end; -- set_label_font

	set_button_font (a_font_name: STRING) is
			-- Set font of every buttons to `a_font_name'.
		require
			font_name_not_void: not (a_font_name = Void);
			font_name_defined: is_font_defined (a_font_name)
		deferred
		end; -- set_button_font

	set_text_font (a_font_name: STRING) is
			-- Set font of every text to `a_font_name'.
		require
			font_name_not_void: not (a_font_name = Void);
			font_name_defined: is_font_defined (a_font_name)
		deferred
		end; -- set_text_font

	label_font: STRING is
			-- Font name specified for labels
		deferred
		end; -- label_font

	button_font: STRING is
			-- Font name specified for buttons
		deferred
		end; -- button_font

	text_font: STRING is
			-- Font name specified for text
		deferred
		end -- text_font

end -- class TERMINAL_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
