indexing

	description:
			"Additional top-level shells for an application.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TOP_LEVEL_SHELL 

inherit

	MEL_VENDOR_SHELL
		redefine
			screen
		end;

	MEL_TOP_LEVEL_SHELL_RESOURCES
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

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
			Mel_widgets.put (Current, screen_object);
			set_default
		end;

	make_popup (a_name: STRING; a_parent: MEL_COMPOSITE; a_screen: MEL_SCREEN) is
			-- Create a top level shell as a popup shell.
		require
			a_name_exists: a_name /= Void;
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed;
			a_screen_not_void: a_screen /= Void
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
			Mel_widgets.put (Current, screen_object);
			set_default
		ensure
			exists: not is_destroyed
		end

feature -- Access

	screen: MEL_SCREEN;
			-- Screen

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

	set_iconic (b: BOOLEAN) is
			-- Set `is_iconic' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNiconic, b)
		ensure
			iconic_enabled: is_iconic = b
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
