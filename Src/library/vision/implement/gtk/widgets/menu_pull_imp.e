indexing

	description: 
		"EiffelVision menu_pull, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
class
	MENU_PULL_IMP
	
inherit	
	MENU_PULL_I
	PULLDOWN_IMP
		redefine
			set_size, set_width, set_height, 
			set_x, set_x_y, set_y, real_x, real_y,
			x, y, height, width, 
			set_background_color, set_foreground_color,
			set_managed, managed
		end
	
creation

	make

feature {NONE} -- Initialization

	make (a_pulldown: MENU_PULL; man: BOOLEAN; oui_parent: MENU) is
			-- Create a motif pulldown menu.
		local
			pulldown_identifier: STRING;
			mel_c: MEL_CASCADE_BUTTON;
		do
				-- The widget index is incremented by one since
				-- the option_button will be inserted before Current
				-- in the widget_manager.
			widget_index := widget_manager.last_inserted_position + 1;
			pulldown_identifier := clone (a_pulldown.identifier);
			pulldown_identifier.append ("_pull");
			if man then
				!! menu_button.make (a_pulldown.identifier, oui_parent);
			else
				!! menu_button.make_unmanaged (a_pulldown.identifier, oui_parent);
			end;
			mel_c ?= menu_button.implementation;
--XX			mel_make_menu_pull (pulldown_identifier, mel_c.parent);
--XX			mel_c.set_sub_menu (Current);
			abstract_menu := a_pulldown
		end;

feature -- Access

--XX	parent: MEL_MENU_SHELL
			-- Parent of pulldown

	text: STRING is
			-- Label of option button
		do
			Result := menu_button.text
		end;

	managed: BOOLEAN is
			-- Is the menu_button managed?
		do
			Result := menu_button.managed;
		end;

	height: INTEGER is
			-- Height of button
		do
			Result := menu_button.height;
		end;

	width: INTEGER is
			-- Width of button
		do
			Result := menu_button.width;
		end;

	real_x: INTEGER is
			-- Relative x position of button
		do
			Result := widget_oui.parent.real_x + x
		end;

	real_y: INTEGER is
			-- Relative y position of button
		do
			Result := widget_oui.parent.real_y + y
		end;

	x: INTEGER is
			-- Button x position
		do
			Result := menu_button.x;
		end;

	y: INTEGER is
			-- Button y position
		do
			Result := menu_button.y;
		end;

feature -- Status setting

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		do
			menu_button.set_text (a_text)
		end;

	set_managed (flag: BOOLEAN) is
			-- Set `managed' to `flag'.
		do
			menu_button.set_managed (flag);
		end;

	set_x (new_x: INTEGER) is
			-- Set `x' to `new_x'.
		do
			menu_button.set_x (new_x);
		end;

	set_y (new_y: INTEGER) is
			-- Set `y' to `new_y'.
		do
			menu_button.set_y (new_y);
		end;


	set_x_y (new_x, new_y: INTEGER) is
		do
			menu_button.set_x_y (new_x, new_y);
		end;

	set_size (new_width, new_height: INTEGER) is
			-- Set size to `new_width' and `new_height'.
		do
			menu_button.set_size (new_width, new_height);
		end;

	set_width (new_width: INTEGER) is
			-- Set `width' to `new_width'.
		do
			menu_button.set_width (new_width);
		end;

	set_height (new_height: INTEGER) is
			-- Set `height' to `new_height'.
		do
			menu_button.set_height (new_height);
		end;

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
		do
			menu_button.set_foreground_color (a_color);
--XX			menu_set_foreground_color (a_color);
		end;

	set_background_color (a_color: COLOR) is
		do
			menu_button.set_background_color (a_color);
--XX			menu_set_background_color (a_color);
		end;

	allow_recompute_size is
			-- Allow recompute size for button.
		do
			menu_button.allow_recompute_size;
		end;

	forbid_recompute_size is
			-- Disable recompute size for button.
		do
			menu_button.forbid_recompute_size;
		end;
	

end

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
