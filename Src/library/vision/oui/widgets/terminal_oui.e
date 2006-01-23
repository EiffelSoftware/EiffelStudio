indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	TERMINAL_OUI

inherit 

	BULLETIN
		redefine
			implementation, set_default
		end

feature -- Access

	label_font: FONT is
			-- Font specified for labels
		require
			exists: not destroyed
		do
			Result := implementation.label_font
		end;

	button_font: FONT is
			-- Font specified for buttons
		require
			exists: not destroyed
		do
			Result := implementation.button_font
		end;

	text_font: FONT is
			-- Font specified for text
		require
			exists: not destroyed
		do
			Result := implementation.text_font
		end 

feature -- Element change

	set_label_font (a_font: FONT) is
			-- Set font of every labels to `a_font'.
		require
			exists: not destroyed;
			font_name_not_void: a_font /= Void;
			a_font_specified: a_font.is_specified
		do
			implementation.set_label_font (a_font);
		end; 

	set_button_font (a_font: FONT) is
			-- Set font of every buttons to `a_font'.
		require
			exists: not destroyed;
			font_name_not_void: a_font /= Void;
			a_font_specified: a_font.is_specified
		do
			implementation.set_button_font (a_font);
		end;

	set_text_font (a_font: FONT) is
			-- Set font of every text to `a_font'.
		require
			exists: not destroyed;
			font_name_not_void: a_font /= Void;
			a_font_specified: a_font.is_specified
		do
			implementation.set_text_font (a_font);
		end;

feature {NONE} -- Implementation

	set_default is
			-- Set default value and build the terminal
		do
			implementation.build
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: TERMINAL_I;;
			-- Implementation of terminal widget

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




end -- class TERMINAL_OUI

