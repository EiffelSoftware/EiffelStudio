indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	TERMINAL_WINDOWS 

inherit
	BULLETIN_WINDOWS
		redefine
			class_name
		end

feature {TERMINAL} -- Initialisation

	build is
			-- Build the terminal
		do
		end

feature -- Access

	label_font: FONT 
			-- Font name for labels

	button_font: FONT 
			-- Font name for buttons

	text_font: FONT 
			-- Font name for texts

feature -- Report

	is_font_defined (a_font: FONT): BOOLEAN is
			-- Is `font_name' defined for current message?
		require
			font_not_void: a_font /= Void
 		do
--			Result := a_font.is_specified
		end

	set_label_font (a_font: FONT) is
			-- Set font of every labels
		require
			font_not_void: a_font /= Void
--			font_valid: a_font.is_specified
   		do
			label_font := a_font					 	
		end

	set_button_font (a_font: FONT) is
			-- Set font of every buttons
		require
			font_not_void: a_font /= Void
--			font_valid: a_font.is_specified
   		do
			 button_font := a_font
		end

	set_text_font (a_font: FONT) is
			-- Set font of every texts
		require
			font_not_void: a_font /= Void
--			font_valid: a_font.is_specified
 		do
			text_font := a_font		 
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionTerminal"
		end

end -- TERMINAL_WINDOWS
 
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
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
