
indexing

	date: "$Date$";
	revision: "$Revision$"

class TERMINAL_OUI

inherit 

	BULLETIN
		redefine
			implementation, set_default
		end

feature {NONE}

	set_default is
			-- Set default value and build the terminal
		do
			implementation.build
		end; -- set_default

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: TERMINAL_I;
			-- Implementation of terminal widget

feature 

	is_font_defined (font_name: STRING): BOOLEAN is
			-- Is `font_name' defined for current terminal?
		require
			exists: not destroyed;
			font_name_not_void: not (font_name = Void)
		do
			Result := implementation.is_font_defined (font_name)
		end;

	set_label_font (a_font_name: STRING) is
			-- Set font of every labels to `a_font_name'.
		require
			exists: not destroyed;
			font_name_not_void: not (a_font_name = Void);
			font_name_defined: is_font_defined (a_font_name)
		do
			implementation.set_label_font (a_font_name);
		end; 

	set_button_font (a_font_name: STRING) is
			-- Set font of every buttons to `a_font_name'.
		require
			exists: not destroyed;
			font_name_not_void: not (a_font_name = Void);
			font_name_defined: is_font_defined (a_font_name)
		do
			implementation.set_button_font (a_font_name);
		end;

	set_text_font (a_font_name: STRING) is
			-- Set font of every text to `a_font_name'.
		require
			exists: not destroyed;
			font_name_not_void: not (a_font_name = Void);
			font_name_defined: is_font_defined (a_font_name)
		do
			implementation.set_text_font (a_font_name);
		end;

	label_font: STRING is
			-- Font name specified for labels
		require
			exists: not destroyed
		do
			Result := implementation.label_font
		end;

	button_font: STRING is
			-- Font name specified for buttons
		require
			exists: not destroyed
		do
			Result := implementation.button_font
		end;

	text_font: STRING is
			-- Font name specified for text
		require
			exists: not destroyed
		do
			Result := implementation.text_font
		end 

end


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
