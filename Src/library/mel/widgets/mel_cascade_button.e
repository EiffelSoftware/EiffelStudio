indexing

	description:
			"Button that posts menus.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CASCADE_BUTTON

inherit

	MEL_CASCADE_BUTTON_RESOURCES
		export
			{NONE} all
		end;

	MEL_LABEL
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
			-- Create a motif cascade button widget.
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
			screen_object := xm_create_cascade_button (a_parent.screen_object, $widget_name, default_pointer, 0);
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

feature -- Satus report

	cascade_pixmap: MEL_PIXMAP is
			-- Cascade pixmap
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNcascadePixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.shared
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
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			is_pixmap: a_pixmap.is_pixmap;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNcascadePixmap, a_pixmap)
		ensure
			pixmap_set: cascade_pixmap.is_equal (a_pixmap)
		end;

	set_mapping_delay (a_time: INTEGER) is
			-- Set the number of milliseconds it will take to the
			-- application to display the submenu.
		require
			exists: not is_destroyed;
			a_time_large_enough: a_time >= 0
		do
			set_xt_int (screen_object, XmNmappingDelay, a_time)
		ensure
			time_set: mapping_delay = a_time
		end;

	set_sub_menu (a_menu: MEL_ROW_COLUMN) is
			-- Set the ID of the pulldown menu pane associated
			-- with the cascade button.
		require
			exists: not is_destroyed;
			menu_exists: a_menu /= Void and then not a_menu.is_destroyed
			valid_menu: a_menu.is_menu
		do
			set_xt_widget (screen_object, XmNsubMenuId, a_menu.screen_object)
		ensure
			sub_menu_set: sub_menu.is_equal (a_menu)
		end;

feature  -- Element Change

	add_activate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button is pressed and released.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNactivateCallback, a_callback, an_argument)
		end;

	add_cascading_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called before the submenu associated with
			-- the cascade button is mapped.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNcascadingCallback, a_callback, an_argument)
		end;

feature  -- Removal

	remove_activate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button is pressed and released.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNactivateCallback, a_callback, an_argument)
		end;

	remove_cascading_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called before the submenu associated with
			-- the cascade button is mapped.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNcascadingCallback, a_callback, an_argument)
		end;

feature {NONE} -- Implementation

	xm_create_cascade_button (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/CascadeB.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateCascadeButton"
		end;

end -- class MEL_CASCADE_BUTTON

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
