indexing

	description:
			"Main shell for an application.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_APPLICATION_SHELL

inherit

	MEL_APPLICATION_SHELL_RESOURCES
		export
			{NONE} all
		end;

	MEL_TOP_LEVEL_SHELL
		redefine
			make
		end

creation
	make

feature -- Initialization

	make (app_name, app_class: STRING; a_screen: MEL_SCREEN) is
			-- Create an application shell.
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
			screen_object := xt_create_app_shell ($application, $application_class,
							a_screen.display.handle, 
							a_screen.handle);
			Mel_widgets.add_without_parent (Current);
			set_default
		end;

feature -- Status report

	argc: INTEGER is
			-- Number of command line arguments.
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNargc)
		ensure
			argc_large_enough: Result >= 0
		end;

	argv: STRING is
			-- List of command line arguments.
		require
			exists: not is_destroyed
		do
			Result := c_get_argv (screen_object)
		ensure
			argv_not_void: Result /= Void
		end;

feature {NONE} -- Implementation

	c_get_argv (src_obj: POINTER): STRING is
		external
			"C"
		end;

	xt_create_app_shell (appl_name, appl_class_name: POINTER; 
				display_ptr: POINTER; screen_ptr: POINTER): POINTER is
		external
			"C"
		end;

end -- class MEL_APPLICATION_SHELL


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

