indexing

	description: 
		"Motif Cascade Button Gadget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CASCADE_BUTTON_GADGET

inherit

	MEL_CASCADE_BUTTON_GADGET_RESOURCES
		export
			{NONE} all
		end;

	MEL_LABEL_GADGET
		rename
			make as mel_label_make
		export
			{NONE} mel_label_make
		redefine
			parent
		end

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_ROW_COLUMN; do_manage: BOOLEAN) is
			-- Create a motif cascade button gadget.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed;
			valid_parent: a_parent.is_menu_bar or else
					a_parent.is_menu_popup or else a_parent.is_menu_pulldown
		local
			widget_name: ANY
		do
			parent := a_parent;	
			widget_name := a_name.to_c;
			screen_object := xm_create_cascade_button_gadget (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Access

	parent: MEL_ROW_COLUMN;
			-- Parent of cascade button (must be either a
			-- MEL_MENU_BAR or MEL_MENU_POPUP or MEL_MENU_PULLDOWN)

	activate_command: MEL_COMMAND_EXEC is
			-- Command set for the activate callback
		do
			Result := motif_command (XmNactivateCallback)
		end;

	cascading_command: MEL_COMMAND_EXEC is
			-- Command set for the activate callback
		do
			Result := motif_command (XmNcascadingCallback)
		end;

feature -- Satus report

	cascade_pixmap: MEL_PIXMAP is
			-- Pixmap of the cascade button
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNcascadePixmap);
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	mapping_delay: INTEGER is
			-- Number of milliseconds it will take to the
			-- application to display the submenu
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNmappingDelay)
		ensure
			mapping_delay_large_enough: mapping_delay >= 0
		end;

	sub_menu: MEL_ROW_COLUMN is
			-- Widget of the pulldown menu pane associated
			-- with the cascade button
		require
			exists: not is_destroyed
		do
			Result ?= get_xt_widget (screen_object, XmNsubMenuId)
		end;

feature -- Status setting

	set_cascade_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `cascade_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_result: a_pixmap /= Void and then a_pixmap.is_valid;
			same_depth: parent.depth = a_pixmap.depth;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNcascadePixmap, a_pixmap)
		ensure
			pixmap_set: cascade_pixmap.is_equal (a_pixmap)
		end;

	set_mapping_delay (a_time: INTEGER) is
			-- Set `mapping_delay' to `a_time'.
		require
			exists: not is_destroyed;
			a_time_large_enough: a_time >= 0
		do
			set_xt_int (screen_object, XmNmappingDelay, a_time)
		ensure
			time_set: mapping_delay = a_time
		end;

	set_sub_menu (a_menu: like sub_menu) is
			-- Set `sub_menu' to `a_menu'.
		require
			exists: not is_destroyed;
			a_menu_exists: not a_menu.is_destroyed;
			valid_menu: a_menu.is_menu
		do
			set_xt_widget (screen_object, XmNsubMenuId, a_menu.screen_object)
		ensure
			sub_menu_set: sub_menu = a_menu
		end;

feature  -- Element Change

	set_activate_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the button is pressed
			-- and released.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNactivateCallback, a_command, an_argument);
		ensure
			command_set: command_set (activate_command, a_command, an_argument)
		end;

	set_cascading_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed before the submenu associated
			-- with the cascade button is mapped.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNcascadingCallback, a_command, an_argument);
		ensure
			command_set: command_set (cascading_command, a_command, an_argument)
		end;

feature  -- Removal

	remove_activate_callback is
			-- Remove the command for the activate callback.
		do
			remove_callback (XmNactivateCallback)
		ensure
			removed: activate_command = Void
		end;

	remove_cascading_callback is
			-- Remove the command for the cascading callback.
		do
			remove_callback (XmNcascadingCallback)
		ensure
			removed: cascading_command = Void
		end;

feature {NONE} -- Implementation

	xm_create_cascade_button_gadget (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/CascadeBG.h>"
		alias
			"XmCreateCascadeButtonGadget"
		end;

end -- class MEL_CASCADE_BUTTON_GADGET


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

