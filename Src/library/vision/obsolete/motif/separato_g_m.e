
-- SEPARATO_G_M: Motif implementation of separator gadget.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SEPARATO_G_M 

inherit

	SEPARATO_G_I
		export
			{NONE} all
		end;

	SEPARATOR_M
		rename
			make as separator_m_make
		redefine
			set_action, remove_action,
			set_background_color,
			set_foreground_color
		end

creation

	make

feature {NONE} -- Creation

	make (a_separator_gadget: SEPARATOR_G; man: BOOLEAN) is
			-- Create a motif separator gadget.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_separator_gadget.identifier.to_c;
			screen_object := create_separator_gadget ($ext_name, 
				parent_screen_object (a_separator_gadget, widget_index),
				man);
		ensure
			--default_orientation: is_horizontal
		end;

feature

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		require else
			no_translation_on_gadgets: false
		do
		end; -- remove_action

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		require else
			no_translation_on_gadgets: false
		do
		end; -- set_action

	set_background_color (new_color: COLOR) is
			-- Set background color to `new_color'.
		require else
			argument_not_void: not (new_color = Void)
		do
		end; -- set_background_color

	set_foreground_color (new_color: COLOR) is
			-- Set foreground_color color to `new_color'.
		require else
			color_not_void: not (new_color = Void)
		do
		end

feature {NONE} -- External features

	create_separator_gadget (sg_name: POINTER; scr_obj: POINTER;
			man: BOOLEAN): POINTER is
		external
			"C"
		end;

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
