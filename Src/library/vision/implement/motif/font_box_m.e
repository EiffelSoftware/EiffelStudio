indexing

	description:
		"EiffelVision Implementation of a font box";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FONT_BOX_M

inherit

	FONT_BOX_I;

	MEMORY
		redefine
			dispose
		end;

	TERMINAL_M
		redefine
			make
		end;

creation

	make

feature {NONE} -- Creation

	make (a_font_box: FONT_BOX; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif font box.
		local
			ext_name: ANY;
			form_button: MEL_FORM
		do
			parent ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_font_box.identifier.to_c;
			data := font_box_create ($ext_name,
					parent.screen_object,
					False, man);
			screen_object := font_box_form (data);
			Mel_widgets.add (Current);
			!! form_button.make_from_existing (xt_parent (font_box_ok_button (data)), Current);
			!! ok_b.make_from_existing (font_box_ok_button (data), form_button);
			!! cancel_b.make_from_existing (font_box_cancel_button (data), form_button);
			!! apply_b.make_from_existing (font_box_apply_button (data), form_button);
			if man then	
				manage
			end
		end;

feature -- Access
	
	ok_b, apply_b, cancel_b: MEL_PUSH_BUTTON_GADGET
			-- Buttons in the font box

	data: POINTER;
			-- Pointer to the font_box_data structure

feature -- Status report

	font: FONT is
			-- Font currently selected by the user
		local
			str: STRING
		do
			!! str.make (1);
			str.from_c (font_box_current_font (data));
			!! Result.make;
			Result.set_name (str)
		end;

feature -- Status setting

	set_font (a_font: FONT) is
			-- Edit `a_font'.
		require else
			a_font_exists: not (a_font = Void)
		local
			ext_name: ANY
		do
			ext_name := a_font.name.to_c;
			font_box_set_font ($ext_name, data)
		end;

feature  -- Element change

	add_apply_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		do
			apply_b.add_activate_callback (mel_vision_callback (a_command), argument)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		do
			cancel_b.add_activate_callback (mel_vision_callback (a_command), argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		do
			ok_b.add_activate_callback (mel_vision_callback (a_command), argument)
		end;

feature -- Display

	show_apply_button is
			-- Make apply button visible.
		do
			font_box_show_apply (data)
		end;

	show_cancel_button is
			-- Make cancel button visible.
		do
			font_box_show_cancel (data)
		end;

	show_ok_button is
			-- Make ok button visible.
		do
			font_box_show_ok (data)
		end

	hide_apply_button is
			-- Make apply button invisible.
		do
			font_box_hide_apply (data)
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			font_box_hide_cancel (data)
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			font_box_hide_ok (data)
		end;

feature -- Removal

	remove_apply_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		do
			apply_b.remove_activate_callback (mel_vision_callback (a_command), argument)
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			cancel_b.remove_activate_callback (mel_vision_callback (a_command), argument)
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			ok_b.remove_activate_callback (mel_vision_callback (a_command), argument)
		end;

	dispose is
		do
			free_data (data);
			data := default_pointer
		ensure then
			data_freed: data = default_pointer
		end;

feature {NONE} -- External features

	font_box_set_font (resource: POINTER; value: POINTER) is
		external
			"C"
		end;

	font_box_apply_button (value: POINTER): POINTER is
		external
			"C"
		end;

	font_box_show_ok (value: POINTER) is
		external
			"C"
		end;

	font_box_show_cancel (value: POINTER) is
		external
			"C"
		end;

	font_box_show_apply (value: POINTER) is
		external
			"C"
		end;

	font_box_hide_ok (value: POINTER) is
		external
			"C"
		end;

	font_box_hide_cancel (value: POINTER) is
		external
			"C"
		end;

	font_box_hide_apply (value: POINTER) is
		external
			"C"
		end;

	font_box_current_font (value: POINTER): POINTER is
		external
			"C"
		end;

	font_box_ok_button (value: POINTER): POINTER is
		external
			"C"
		end;

	font_box_cancel_button (value: POINTER): POINTER is
		external
			"C"
		end;

	font_box_create (b_name: POINTER; scr_obj: POINTER; 
			is_dial, man: BOOLEAN): POINTER is
		external
			"C"
		end;

	font_box_form (value: POINTER): POINTER is
		external
			"C"
		end;

	free_data (p: POINTER) is
		external
			"C"
		alias
			"xfree"
		end

invariant

	buttons_not_void: cancel_b /= Void and then ok_b /= Void and then apply_b /= Void

end -- class FONT_BOX_M

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|	Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
