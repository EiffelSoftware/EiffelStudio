--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- PUSH_BG_M: implementation of push button.

indexing

	date: "$Date$";
	revision: "$Revision$"

class PUSH_BG_M 

inherit

	PUSH_BG_I
		export
			{NONE} all
		end;

	PUSH_B_M
		undefine
			make
		redefine
			set_action, remove_action,
			set_background_color,
			set_foreground
		end

creation

	make

feature 

	make (a_push_bg: PUSH_BG) is
			-- Create a motif push button gadget.
		local
			ext_name: ANY
		do
			ext_name := a_push_bg.identifier.to_c;
			screen_object := create_push_b_gadget ($ext_name, a_push_bg.parent.implementation.screen_object);
			a_push_bg.set_font_imp (Current)
		end;

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		require else
			no_translation_on_gadgets: false
		do
		end;

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

	create_push_b_gadget (p_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

