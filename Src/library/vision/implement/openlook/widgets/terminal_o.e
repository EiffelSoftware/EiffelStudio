--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class TERMINAL_O 

inherit

	BULLETIN_O

feature {TERMINAL}

	build is
			-- Build the terminal.
		do
		end;

	is_font_defined (font_name: STRING): BOOLEAN is
			-- Is `font_name' defined for current message?
		require
			font_name_not_void: not (font_name = Void)
		do
		end; -- is_font_defined

	set_label_font (a_font_name: STRING) is
			-- Set font of every labels to `a_font_name'.
		require
			font_name_not_void: not (a_font_name = Void);
			font_name_defined: is_font_defined (a_font_name)
		do
		end; -- set_label_font

	set_button_font (a_font_name: STRING) is
			-- Set font of every buttons to `a_font_name'.
		require
			font_name_not_void: not (a_font_name = Void);
			font_name_defined: is_font_defined (a_font_name)
		do
		end; -- set_button_font

	set_text_font (a_font_name: STRING) is
			-- Set font of every text to `a_font_name'.
		require
			font_name_not_void: not (a_font_name = Void);
			font_name_defined: is_font_defined (a_font_name)
		do
		end; -- set_text_font

feature {NONE}

	label_font_name: STRING;
			-- Font name specified for labels

	button_font_name: STRING;
			-- Font name specified for buttons

	text_font_name: STRING;
			-- Font name specified for text

	label_font_pointer: POINTER;
			-- Font pointer of label font

	button_font_pointer: POINTER;
			-- Font pointer of button font

	text_font_pointer: POINTER;
			-- Font pointer of text font

	
feature 

	label_font: STRING is
			-- Font name specified for labels
		do
			Result := label_font_name
		end; -- label_font

	button_font: STRING is
			-- Font name specified for buttons
		do
			Result := button_font_name
		end; -- button_font_name

	text_font: STRING is
			-- Font name specified for text
		do
			Result := text_font_name
		end; -- text_font

	
feature {NONE}

	resource_font (a_font_name: STRING; a_font_resource: STRING; old_font_pointer: POINTER): POINTER is
			-- Return a font pointer using name `font_name',  resource `a_font_resource'
			-- and font_pointer `old_font_pointer'
		require
			font_name_not_void: not (a_font_name = Void);
			font_resource_not_void: not (a_font_resource = Void)
		do
		end

end 
