indexing

	description:
			"Additional top-level shells for an application.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TOP_LEVEL_SHELL 

inherit

	MEL_TOP_LEVEL_SHELL_RESOURCES
		export
			{NONE} all
		end;

	MEL_VENDOR_SHELL
		redefine
			screen, is_shown
		end

creation
	make

feature -- Initialization

	make (app_name, app_class: STRING; a_screen: MEL_SCREEN) is
				-- Create a top level shell.
		require
			a_screen_not_void: a_screen /= Void
		local
			application, application_class: ANY
		do
			parent := Void;
			screen := a_screen;
			if app_name /= Void then
				application := app_name.to_c
			end;
			if app_class /= Void then
				application_class := app_class.to_c
			end;
			screen_object := xt_create_top_level_shell ($application, $application_class,
								a_screen.display.handle, a_screen.handle);
			Mel_widgets.add_without_parent (Current);
			set_default
		ensure
			screen_set: screen = a_screen
		end;

	make_popup (a_name: STRING; a_parent: MEL_COMPOSITE; a_screen: MEL_SCREEN) is
			-- Create a top level shell as a popup shell.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed;
			screen_not_void: a_screen /= Void
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen := a_screen;
			check
				same_display_as_parent: screen.display = parent.screen.display
			end;
			screen_object := xt_create_top_level_popup_shell ($a_name, a_parent.screen_object, screen.handle);
			Mel_widgets.add_popup_shell (Current);
			set_default
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name);
			screen_set: screen = a_screen
		end

feature -- Access

	screen: MEL_SCREEN;
			-- Screen

	is_shown: BOOLEAN is
			-- Is Current shown on the screen?
		do
			Result := xt_is_visible (screen_object)
		end;

feature -- Status report

	is_iconic: BOOLEAN is
			-- Is the widget realized as an icon?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNiconic)
		end;

	icon_name: STRING is
			-- Abbreviated name that labels an iconified application
		require
			exists: not is_destroyed
		do
			Result := get_xt_string_no_free (screen_object, XmNiconName)
		ensure
			icon_name_not_void: Result /= Void
		end;

	icon_name_encoding is
			-- Property type for encoding `icon_name'
		require
			exists: not is_destroyed
		do
		ensure
		end;

feature -- Status setting

	enable_iconic is
			-- Set `is_iconic' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNiconic, True)
		ensure
			iconic_enabled: is_iconic 
		end;

	disable_iconic is
			-- Set `is_iconic' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNiconic, False)
		ensure
			iconic_disabled: not is_iconic 
		end;

	set_icon_name (a_string: STRING) is
			-- Set `icon_name' to `a_string'.
		require
			exists: not is_destroyed;
			a_string_not_void: a_string /= Void
		do
			set_xt_string (screen_object, XmNiconName, a_string)
		ensure
			icon_name_set: icon_name.is_equal (a_string)
		end;

	set_icon_name_encoding is
			-- Set the property type for encoding `icon_name'.
		require
			exists: not is_destroyed
		do
		ensure
		end;

feature {NONE} -- External features

	xt_create_top_level_shell (appl_name, appl_class_name: POINTER; 
				display_ptr: POINTER; screen_ptr: POINTER): POINTER is
		external
			"C"
		end;

	xt_create_top_level_popup_shell (a_name: POINTER; 
				display_ptr: POINTER; screen_ptr: POINTER): POINTER is
		external
			"C"
		end;

end -- class MEL_TOP_LEVEL_SHELL


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

