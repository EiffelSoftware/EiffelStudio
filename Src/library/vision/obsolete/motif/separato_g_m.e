--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- SEPARATO_G_M: Motif implementation of separator gadget.

indexing

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
			set_foreground
		end

creation

	make

feature 

	make (a_separator_gadget: SEPARATOR_G) is
			-- Create a motif separator gadget.
		local
			ext_name: ANY
		do
			ext_name := a_separator_gadget.identifier.to_c;
			screen_object := create_separator_gadget ($ext_name, a_separator_gadget.parent.implementation.screen_object)
		ensure
			is_horizontal
		end;

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

	set_foreground (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require else
			color_not_void: not (new_color = Void)
		do
		end

feature {NONE} -- External features

	create_separator_gadget (sg_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

