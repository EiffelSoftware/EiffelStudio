indexing

	description:
			"A MEL_ROW_COLUMN used as an option menu.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_OPTION_MENU

inherit

	MEL_ROW_COLUMN
		export
			{NONE} menu_help_widget, is_popup_enabled, is_radio_behavior,
			is_working_area, is_menu_bar, is_menu_popup, is_menu_option,
			is_menu_pulldown, is_tear_off_enabled,
			set_menu_help_widget, 
			enable_popup, disable_popup,
			enable_radio_behavior, disable_radio_behavior,
			set_tear_off_to_enabled, set_tear_off_to_disabled
		redefine
			make
		end

creation 
	make, 
	make_with_label

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif option menu widget.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_option_menu (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			!! label_gadget.make_from_existing (
				xm_option_label_gadget (screen_object), Current);
			!! button_gadget.make_from_existing (
				xm_option_button_gadget (screen_object), Current);
			set_default;
			if do_manage then
				manage
			end
		end;

	make_with_label (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN; a_ms: MEL_STRING) is
			-- Create a motif option menu with a label.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed;
			ms_exists: a_ms /= Void and then not a_ms.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_option_menu_with_label (a_parent.screen_object, $widget_name, a_ms.handle);
			Mel_widgets.add (Current);
			!! label_gadget.make_from_existing (xm_option_label_gadget (screen_object), Current);
			!! button_gadget.make_from_existing (xm_option_button_gadget (screen_object), Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end

feature -- Access

	label_gadget: MEL_LABEL_GADGET;
			-- Label gadget

	button_gadget: MEL_CASCADE_BUTTON_GADGET
			-- Button gadget

feature -- Status report

    sub_menu: MEL_PULLDOWN_MENU is
            -- Pulldown menu to be associated with an option menu.
        require
            exists: not is_destroyed
        do
            Result ?= get_xt_widget (screen_object, XmNsubMenuId)
        end;

feature -- Status setting

    set_sub_menu (a_widget: MEL_PULLDOWN_MENU) is
            -- Set `sub_menu' to `a_widget'.
        require
            exists: not is_destroyed
            a_widget_exists: not a_widget.is_destroyed
        do
            set_xt_widget (screen_object, XmNsubMenuId, a_widget.screen_object)
        ensure
            sub_menu_set: sub_menu.is_equal (a_widget)
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
			"C (Widget): EIF_POINTER | <Xm/RowColumn.h>"
		alias
			"XmOptionButtonGadget"
		end;

	xm_option_label_gadget (a_parent: POINTER): POINTER is
		external
			"C (Widget): EIF_POINTER | <Xm/RowColumn.h>"
		alias
			"XmOptionLabelGadget"
		end

invariant

	valid_gadgets: button_gadget /= Void and then label_gadget /= Void

end -- class MEL_OPTION_MENU


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

