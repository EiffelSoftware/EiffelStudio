--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCROLLED_T_M

inherit

	TEXT_M
		rename
			enable_word_wrap as text_enable_word_wrap,
			disable_word_wrap as text_disable_word_wrap,
			set_foreground as text_set_foreground,
			set_background_color as text_set_background_color
		undefine
			make
		redefine
			action_target
		end;

	TEXT_M
		undefine
			make
		redefine
			action_target, disable_word_wrap, enable_word_wrap,
			set_foreground, set_background_color
		select
			disable_word_wrap, enable_word_wrap,
			set_foreground, set_background_color
		end;

	SCROLLED_T_I;

creation

	make

feature -- Creation

	make (a_scrolled_text: TEXT) is
			-- Create a motif scrolled text.
		local
			ext_name: ANY
		do
			ext_name := a_scrolled_text.identifier.to_c;
			action_target := create_scrolled_text ($ext_name,
					a_scrolled_text.parent.implementation.screen_object);
			screen_object := xt_parent (action_target);
			a_scrolled_text.set_font_imp (Current)
		end;

feature -- Color

	set_background_color (a_color: COLOR) is
		local
			temp_screen_object: POINTER
		do
			text_set_background_color (a_color);
				--! Window background color
			temp_screen_object := screen_object;
			screen_object := action_target;
			text_set_background_color (a_color);
				--! Text background color
			screen_object := temp_screen_object
		end;	

	set_foreground (a_color: COLOR) is
		local
			temp_screen_object: POINTER
		do
			temp_screen_object := screen_object;
			screen_object := action_target;
			text_set_foreground (a_color);
				--! Text background color
				--! Cannot set Window's foreground color
			screen_object := temp_screen_object
		end;	

feature

	disable_word_wrap is
            -- Specify that lines are free to go off the right edge
            -- of the window.
        do
			show_horizontal_scrollbar;
           	text_disable_word_wrap; 
        end;
 
    enable_word_wrap is
            -- Specify that lines are to be broken at word breaks.
            -- The text does not go off the right edge of the window.
			-- The horizontal bar is not shown.
        do
			hide_horizontal_scrollbar;
            text_enable_word_wrap;
		ensure then
			not is_horizontal_scrollbar
        end;

	action_target: POINTER;
			-- Widget ID on which action must be applied

	hide_horizontal_scrollbar is
			-- Make horizontal scrollbar invisible.
		do
            set_xt_boolean (action_target, False, MscrollHorizontal);
		end;

	hide_vertical_scrollbar is
			-- Make vertical scrollbar invisible.
		do
            set_xt_boolean (action_target, False, MscrollVertical);
		end;

	is_horizontal_scrollbar: BOOLEAN is
			-- Is horizontal scrollbar visible?
		do
            Result := xt_boolean (action_target, MscrollHorizontal);
		end;

	is_vertical_scrollbar: BOOLEAN is
			-- Is vertical scrollbar visible?
		do
            Result := xt_boolean (action_target, MscrollVertical);
		end;

	show_horizontal_scrollbar is
			-- Make horizontal scrollbar visible.
		do
            set_xt_boolean (action_target, True, MscrollHorizontal);
		end;

	show_vertical_scrollbar is
			-- Make vertical scrollbar visible.
		do
            set_xt_boolean (action_target, True, MscrollVertical);
		end;

feature {NONE} -- Externals

	create_scrolled_text (st_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xt_parent (scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

