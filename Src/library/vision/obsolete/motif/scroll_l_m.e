
-- Rectangle with scrollbars or not which contains a list of
-- selectable strings.

indexing

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
			set_unsigned_char as p_set_unsigned_char
		redefine
			action_target, set_foreground, update_foreground,
			set_background_color, update_background_color
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

feature -- Creation

	make (a_list: SCROLL_LIST) is
            -- Create a motif list, get screen_object value of srolled
            -- window which contains current list.
        local
            ext_name: ANY
        do
            ext_name := a_list.identifier.to_c;
            list_screen_object := create_scroll_list ($ext_name,
					a_list.parent.implementation.screen_object);
            screen_object := xt_parent (list_screen_object);
            a_list.set_list_imp (Current);
            a_list.set_font_imp (Current);
        end;

feature {NONE}

	action_target: POINTER is
		do
			Result := list_screen_object
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



	set_foreground (a_color: COLOR) is
			-- Set `foreground' to `a_color'.
		require else
			a_color_exists: not (a_color = Void)
		
		local
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if not (foreground = Void) then
				color_implementation ?= foreground.implementation;
				color_implementation.remove_object (Current)
			end;
			foreground := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Mforeground.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name); 
			xt_unmanage_child (list_screen_object);
			c_set_color (list_screen_object, color_implementation.pixel (screen), $ext_name);
			xt_manage_child (list_screen_object);
			c_set_color (vertical_widget, color_implementation.pixel (screen), $ext_name);
			c_set_color (horizontal_widget, color_implementation.pixel (screen), $ext_name);
		ensure then
			foreground = a_color
		end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		require else
			a_color_exists: not (a_color = Void)
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if not (background_pixmap = Void) then
				pixmap_implementation ?= background_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				background_pixmap := Void
			end;
			if not (background_color = Void) then
				color_implementation ?= background_color.implementation;
				color_implementation.remove_object (Current)
			end;
			bg_color := a_color;
			color_implementation ?= background_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Mbackground.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name); 
			c_set_color (list_screen_object, color_implementation.pixel (screen), $ext_name); 
			c_set_color (horizontal_widget, color_implementation.pixel (screen), $ext_name); 
			c_set_color (vertical_widget, color_implementation.pixel (screen), $ext_name); 
		ensure then
			background_color = a_color;
			(background_pixmap = Void)
		end;

feature {COLOR_X}

	update_foreground is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X
		do
			ext_name := Mforeground.to_c;
			color_implementation ?= foreground.implementation;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name);
			c_set_color (list_screen_object, color_implementation.pixel (screen), $ext_name);
		end;


	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X;
		do
			ext_name := Mbackground.to_c;
			color_implementation ?= background_color.implementation;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name);
			c_set_color (list_screen_object, color_implementation.pixel (screen), $ext_name);  
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

	create_scroll_list (l_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	m_xtparent (value: POINTER): POINTER is
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
