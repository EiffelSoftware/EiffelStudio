
-- MENU_PULL_M: implementation of pulldown for menu buttons.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MENU_PULL_M 

inherit
	MENU_PULL_I
		export
			{NONE} all
		end;

	MENU_M
		rename
			set_foreground as menu_set_foreground,
			set_background_color as menu_set_background_color,
			set_size as menu_set_size,
			set_width as menu_set_width,
			set_height as menu_set_height
		redefine
			set_x_y, 
			real_x, real_y, 
			x, y, set_x, set_y, height, width,
			managed, set_managed
		end;

	MENU_M
		redefine
			set_x_y, set_size, set_width, set_height, 
			real_x, real_y, 
			x, y,
			set_x, set_y, height, width, managed, set_managed,
			set_foreground, set_background_color
		select
			set_size, set_width, set_height, 
			set_foreground, set_background_color
		end;

creation

	make

feature -- Creation

	make (a_pulldown: MENU_PULL) is
			-- Create a motif pulldown menu.
		local
			pulldown_identifier: STRING;
			ext_name: ANY;
			parent: MENU
		do
				-- The widget index is incremented by one since
				-- the option_button will be inserted before Current
				-- in the widget_manager.
			widget_index := widget_manager.last_inserted_position + 1;
			pulldown_identifier := clone (a_pulldown.identifier);
			pulldown_identifier.append ("_pull");
			parent ?= widget_manager.parent_using_index (a_pulldown, widget_index);
			check
				intern: parent /= Void
			end;
			!! menu_button.make (a_pulldown.identifier, parent);
			ext_name := pulldown_identifier.to_c;
			screen_object := create_pulldown ($ext_name,
					parent.implementation.screen_object);
			abstract_menu := a_pulldown;
			xm_attach_menu (menu_button.implementation.screen_object, screen_object);
		end;

feature

	text: STRING is
			-- Label of option button
		do
			Result := menu_button.text
		end; -- text

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		do
			menu_button.set_text(a_text)
		end;


	managed: BOOLEAN is
		do
			Result := menu_button.managed;
		end;

	set_managed (flag: BOOLEAN) is
		do
			menu_button.set_managed (flag);
		end;

	set_x (new_x: INTEGER) is
		do
			menu_button.set_x (new_x);
		end;

	set_y (new_y: INTEGER) is
		do
			menu_button.set_y (new_y);
		end;

	height: INTEGER is
		do
			Result := menu_button.height;
		end;

	width: INTEGER is
		do
			Result := menu_button.width;
		end;


	real_x: INTEGER is
		do
			Result := menu_button.real_x;
		end;

	real_y: INTEGER is
		do
			Result := menu_button.real_y;
		end;

	x: INTEGER is
		do
			Result := menu_button.x;
		end;

	y: INTEGER is
		do
			Result := menu_button.y;
		end;

	set_x_y (new_x, new_y: INTEGER) is
		do
			menu_button.set_x_y (new_x, new_y);
		end;


	set_size (new_width, new_height: INTEGER) is
		do
			menu_button.set_size (new_width, new_height);
		end;

	set_width (new_width: INTEGER) is
		do
			menu_button.set_width (new_width);
		end;

	set_height (new_height: INTEGER) is
		do
			menu_button.set_height (new_height);
		end;

	set_foreground (a_color: COLOR) is
		do
			menu_button.set_foreground (a_color);
			menu_set_foreground (a_color);
		end;

	set_background_color (a_color: COLOR) is
		do
			menu_button.set_background_color (a_color);
			menu_set_background_color (a_color);
		end;

	allow_recompute_size is
		do
			menu_button.allow_recompute_size;
		end;

	forbid_recompute_size is
		do
			menu_button.forbid_recompute_size;
		end;


feature {NONE} -- External features

	create_pulldown (p_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xm_attach_menu (scr_obj1, scr_obj2: POINTER) is
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
