indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	TERMINAL_WINDOWS 

inherit
	BULLETIN_WINDOWS
		redefine
			class_name,
			resize_for_shell
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
		end

	set_label_font (a_font: FONT) is
			-- Set font of every labels
		require
			font_not_void: a_font /= Void
   		do
			label_font := a_font					 	
		end

	set_button_font (a_font: FONT) is
			-- Set font of every buttons
		require
			font_not_void: a_font /= Void
   		do
			 button_font := a_font
		end

	set_text_font (a_font: FONT) is
			-- Set font of every texts
		require
			font_not_void: a_font /= Void
 		do
			text_font := a_font		 
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionTerminal"
		end

	resize_for_shell is
			-- Resize current widget if the parent is a shell.			
		local
			tw: TOP_WINDOWS
		do
			tw ?= parent
			if tw /= Void and then tw.exists and then not fixed_size_flag then
				set_x_y (0, 0)
				set_size (tw.client_width, tw.client_height)
			end
		end

end -- TERMINAL_WINDOWS
 
--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

