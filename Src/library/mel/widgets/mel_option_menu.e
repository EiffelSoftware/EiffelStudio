indexing

	description:
			"A MEL_RUN_COLUMN used as an option menu.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_OPTION_MENU

inherit

	MEL_ROW_COLUMN
		rename
			make as row_column_make
		export
			{NONE} menu_help_widget, is_popup_enabled, radio_behavior,
			is_working_area, is_menu_bar, is_menu_popup, is_menu_option,
			is_menu_pulldown, is_tear_off_enabled,
			set_menu_help_widget, set_popup_enabled, 
			set_radio_behavior, set_tear_off_enabled,
			row_column_make
		end

creation 
	make, make_with_label

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif option menu widget.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_option_menu (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.put (Current, screen_object);
			!! label_gadget.make_from_existing (xm_option_label_gadget (screen_object));
			!! button_gadget.make_from_existing (xm_option_button_gadget (screen_object));
			set_default;
			if do_manage then
				manage
			end
		end;

	make_with_label (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN; a_ms: MEL_STRING) is
			-- Create a motif option menu with a label.
		require
			a_name_exists: a_name /= Void
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed;
			a_ms_exists: a_ms /= Void and then not a_ms.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_option_menu_with_label (a_parent.screen_object, $widget_name, a_ms.handle);
			Mel_widgets.put (Current, screen_object);
			!! label_gadget.make_from_existing (xm_option_label_gadget (screen_object));
			!! button_gadget.make_from_existing (xm_option_button_gadget (screen_object));
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed
		end

feature -- Access

	label_gadget: MEL_LABEL_GADGET;
			-- Label gadget

	button_gadget: MEL_CASCADE_BUTTON_GADGET
			-- Button gadget

feature -- Status report

	is_recomputing_size_allowed: BOOLEAN is
			-- Is Current allowed to recompute its size?
		require
			exists: not is_destroyed
		do
			Result := button_gadget.is_recomputing_size_allowed
		end

feature -- Status setting

	set_recomputing_size_allowed (b: BOOLEAN) is
			-- Set `is_recomputing_size_allowed' to `b'.
		require
			exists: not is_destroyed
		do
			button_gadget.set_recomputing_size_allowed (b)
		ensure
			recompute_size_allowed: is_recomputing_size_allowed = b
		end;

feature {NONE} -- Implementation

	xm_create_option_menu (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/RowColumn.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateOptionMenu"
		end;

	xm_create_option_menu_with_label (a_parent, a_name, a_xmstring: POINTER): POINTER is
		external
			"C"
		end;

	xm_option_button_gadget (a_parent: POINTER): POINTER is
		external
			"C [macro <Xm/RowColumn.h>] (Widget): EIF_POINTER"
		alias
			"XmOptionButtonGadget"
		end;

	xm_option_label_gadget (a_parent: POINTER): POINTER is
		external
			"C [macro <Xm/RowColumn.h>] (Widget): EIF_POINTER"
		alias
			"XmOptionLabelGadget"
		end

invariant

	valid_gadgets: button_gadget /= Void and then label_gadget /= Void

end -- class MEL_OPTION_MENU

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
