indexing

	description:
		"Abstract class for a collection of widgets.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class TERMINAL_M 

inherit 

	FONTABLE_M
		rename
			set_font as unused_set_font,
			font as unused_font
		end;
	BULLETIN_M
		undefine
			update_other_bg_color, update_other_fg_color
		end

feature -- Status report

	label_font: FONT;
			-- Font name specified for labels

	button_font: FONT;
			-- Font specified for buttons

	text_font: FONT;
			-- Font specified for text
	
feature -- Status setting

	set_label_font (a_font: FONT) is
			-- Set font of every labels to `a_font_name'.
		local
			font_implementation: FONT_X
		do
			if label_font /= Void then
				font_implementation ?= label_font.implementation;
				font_implementation.remove_object (Current)
			end;
			label_font := a_font;
			font_implementation ?= a_font.implementation;
			font_implementation.put_object (Current);
			update_label_font (font_implementation.resource (screen))
		end;

	set_button_font (a_font: FONT) is
			-- Set font of every buttons to `a_font_name'.
		local
			font_implementation: FONT_X
		do
			if button_font /= Void then
				font_implementation ?= button_font.implementation;
				font_implementation.remove_object (Current)
			end;
			button_font := a_font;
			font_implementation ?= a_font.implementation;
			font_implementation.put_object (Current);
			update_button_font (font_implementation.resource (screen))
		end;

	set_text_font (a_font: FONT) is
			-- Set font of every text to `a_font_name'.
		local
			font_implementation: FONT_X
		do
			if text_font /= Void then
				font_implementation ?= text_font.implementation;
				font_implementation.remove_object (Current)
			end;
			text_font := a_font;
			font_implementation ?= a_font.implementation;
			font_implementation.put_object (Current);
			update_text_font (font_implementation.resource (screen))
		end; 
	
feature {TERMINAL_OUI}

	build is
			-- Build the terminal.
		do
		end; 

feature {NONE} -- Implementation

	update_text_font (f_ptr: POINTER) is
		require
			valid_f_ptr: f_ptr /= default_pointer
		deferred
		end;

	update_label_font (f_ptr: POINTER) is
		require
			valid_f_ptr: f_ptr /= default_pointer
		deferred
		end;

	update_button_font (f_ptr: POINTER) is
		require
			valid_f_ptr: f_ptr /= default_pointer
		deferred
		end;

	set_primitive_font (w: POINTER; f_ptr: POINTER) is
			-- Set primitive widget `w' to f_ptr (C type
			-- is FontStruct).
		require
			valid_pointers: w /= default_pointer and then	
					f_ptr /= default_pointer
		do
			--set_motif_font (w, f_ptr, 
					--resource_name.to_c);
		end;

feature {NONE} -- External features

	xm_set_children_fg_color (pixel, widget: POINTER) is
		external
			"C"
		end;

	xm_set_children_bg_color (pixel, widget: POINTER) is
		external
			"C"
		end;

end -- class TERMINAL_M

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
