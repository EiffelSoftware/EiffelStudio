--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- DRAW_B_M: implementation of draw button.

indexing

	date: "$Date$";
	revision: "$Revision$"

class DRAW_B_M 

inherit

	DRAWING_X
		export
			{NONE} all
		end;

    DRAW_B_I;

    DRAW_B_R_M
        export
            {NONE} all
        end;

    PUSH_B_M
		rename
			make as push_b_m_make
        export
            {NONE} all
        end

creation

	make

feature -- Creation

	make (a_draw_b: DRAW_B) is
			-- Create a motif draw button.
		local
			ext_name: ANY
		do
			ext_name := a_draw_b.identifier.to_c;
			screen_object := create_draw_b ($ext_name,
							a_draw_b.parent.implementation.screen_object);
			display_pointer := xt_display (screen_object);
			create_gc
		end;

feature

    add_expose_action (a_command: COMMAND; argument: ANY) is
            -- Add `a_command' to the list of action to execute when
            -- current draw button is exposed.
        require else
            not_a_command_void: not (a_command = Void)
        do
            if (expose_actions = Void) then
                !! expose_actions.make (screen_object,
						Mexpose, widget_oui)
            end;
            expose_actions.add (a_command, argument)
        end;

    remove_expose_action (a_command: COMMAND; argument: ANY) is
            -- Remove `a_command' from the list of action to execute when
            -- current draw button is exposed.
        require else
            not_a_command_void: not (a_command = Void)
        do
            expose_actions.remove (a_command, argument)
        end;

feature {NONE}

	window_object: POINTER is
			-- X identifier of the drawable.
		do
			Result := xt_window (screen_object)
		end;

    expose_actions: EVENT_HAND_M;
            -- An event handler to manage call-backs when
            -- current draw button is exposed

feature {NONE} -- External features

	create_draw_b (d_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

