indexing

	description:
		"Rectangle with scrollbars or not which contains a list of %
		%selectable strings";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLL_L_M 

inherit

	SCROLL_L_I
		export
			{NONE} all
		end;

	PRIMITIVE_M
		rename
			get_int as p_get_int,
			set_int as p_set_int,
			set_unsigned_char as p_set_unsigned_char,
			clean_up as primitive_clean_up
		redefine
			action_target, set_foreground_color, update_foreground_color,
			set_background_color, update_background_color, set_managed
		end;
	PRIMITIVE_M
		rename
			get_int as p_get_int,
			set_int as p_set_int,
			set_unsigned_char as p_set_unsigned_char
		redefine
			action_target, set_foreground_color, update_foreground_color,
			set_background_color, update_background_color,
			clean_up, set_managed
		select
			clean_up
		end;

	FONTABLE_M
		rename
			resource_name as MfontList,
			screen_object as list_screen_object
		end;

	LIST_MAN_M;

	SCROLLED_W_R_M
		rename
			Mscrollbardisplaypolicy as Msbdp
		export
			{NONE} all
		end;
		
creation

	make

feature {NONE} -- Creation

	make (a_list: SCROLL_LIST; man: BOOLEAN) is
			-- Create a motif list, get screen_object value of srolled
			-- window which contains current list.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_list.identifier.to_c;
			list_screen_object := create_scroll_list ($ext_name,
					parent_screen_object (a_list, widget_index),
					man);
			screen_object := xt_parent (list_screen_object);
			a_list.set_list_imp (Current);
			a_list.set_font_imp (Current);
		end;

feature {NONE}

	action_target: POINTER is
		do
			Result := list_screen_object
		end;

    set_managed (flag: BOOLEAN) is
            -- Enable geometry managment on screen widget implementation,
            -- by window manager of parent widget if `flag', disable it
            -- otherwise.
        do
            if flag then
                xt_manage_child (action_target)
                xt_manage_child (screen_object)
            else
                xt_unmanage_child (action_target)
                xt_unmanage_child (screen_object)
            end
        end;

feature 

	is_output_only_mode: BOOLEAN is
			-- Is scale mode output only mode?
		do
			Result :=  xt_is_sensitive (screen_object)
		end;

	set_input_output is
			-- Set scale mode to input output.
		do
			xt_set_sensitive (screen_object, True)
		ensure
			input_output_mode: not is_output_only_mode
		end;

	set_output_only is
			-- Set scale mode to output only.
		do
			xt_set_sensitive (screen_object, False)
		ensure
			output_only_mode: is_output_only_mode
		end;

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
		require else
			a_color_exists: not (a_color = Void)
		
		local
			color_implementation: COLOR_X;
			ext_name: ANY;
			pix: POINTER
		do
			if not (foreground_color = Void) then
				color_implementation ?= foreground_color.implementation;
				color_implementation.remove_object (Current)
			end;
			fg_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			pix := color_implementation.pixel (screen);
			ext_name := Mforeground_color.to_c;
			c_set_color (screen_object, pix, $ext_name); 
			xt_unmanage_child (list_screen_object);
			c_set_color (list_screen_object, pix, $ext_name);
			xt_manage_child (list_screen_object);
			c_set_color (vertical_widget, pix, $ext_name);
			c_set_color (horizontal_widget, pix, $ext_name);
		ensure then
			foreground_color = a_color
		end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		require else
			a_color_exists: not (a_color = Void)
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			ext_name: ANY;
			pix: POINTER;
		do
			if bg_pixmap /= Void then
				pixmap_implementation ?= bg_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				bg_pixmap := Void
			end;
			if bg_color = Void then
				color_implementation ?= bg_color.implementation;
				color_implementation.remove_object (Current)
			end;
			bg_color := a_color;
			color_implementation ?= bg_color.implementation;
			color_implementation.put_object (Current);
			pix := color_implementation.pixel (screen);
			ext_name := Mbackground.to_c;
			c_set_color (screen_object, pix, $ext_name); 
			c_set_color (list_screen_object, pix, $ext_name); 
			c_set_color (horizontal_widget, pix, $ext_name); 
			c_set_color (vertical_widget, pix, $ext_name); 
		end;

feature {NONE}

	clean_up is
		do
			primitive_clean_up;
			if single_actions /= Void then
				single_actions.free_cdfd
			end;
		end;

feature {COLOR_X}

	update_foreground_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X;
			pix: POINTER
		do
			ext_name := Mforeground_color.to_c;
			color_implementation ?= foreground_color.implementation;
			pix := color_implementation.pixel (screen);
			c_set_color (screen_object, pix, $ext_name);
			c_set_color (list_screen_object, pix, $ext_name);
			c_set_color (horizontal_widget, pix, $ext_name);
			c_set_color (vertical_widget, pix, $ext_name);
		end;


	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X;
			pix: POINTER
		do
			ext_name := Mbackground.to_c;
			color_implementation ?= background_color.implementation;
			pix := color_implementation.pixel (screen);
			c_set_color (screen_object, pix, $ext_name);
			c_set_color (list_screen_object, pix, $ext_name);  
			c_set_color (horizontal_widget, pix, $ext_name); 
			c_set_color (vertical_widget, pix, $ext_name); 
		end;

feature {NONE}

	vertical_widget: POINTER is
		do
			Result := xt_widget (screen_object, MverticalScrollBar);
		end;

	horizontal_widget: POINTER is
		do
			Result := xt_widget (screen_object, MhorizontalScrollBar);
		end;


feature {NONE} -- External features

	create_scroll_list (l_name: POINTER; scr_obj: POINTER;
			man: BOOLEAN): POINTER is
		external
			"C"
		end;

	m_xtparent (value: POINTER): POINTER is
		external
			"C"
		alias
			"xt_parent"
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
