indexing

	description: 
		"Parent of any graphic application based on the Motif toolkit. %
		%This is an convenience class to automatically setup the %
		%environment for a motif application.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_APPLICATION

feature {NONE} -- Initialization

	make is
			-- Create the application.
		do
			set_default;
			!! application_context.make;
			!! display.make (application_context, Void, 
					application_name, application_class_name);
			if display.is_valid then
				!! top_level.make (application_name, Void, display.default_screen);
				build;
				top_level.realize;
				application_context.iterate
			end
		end;

feature -- Access

	top_level: MEL_APPLICATION_SHELL;
			-- Top level of the application

	display: MEL_DISPLAY;
			-- Application display

	application_name: STRING
			-- Application name

	application_class_name: STRING
			-- Application class name

	application_context: MEL_APPLICATION_CONTEXT
			-- Application context

feature -- Status setting

	set_application_name (a_string: STRING) is
			-- Set the name of the application.
		require
			string_is_not_void: a_string /= Void
		do
			application_name := a_string
		ensure
			application_name_set: application_name = a_string
		end;

	set_application_class_name (a_string: STRING) is
			-- Set the class name of the application.
		require
			string_is_not_void: a_string /= Void
		do
			application_class_name := a_string
		ensure
			application_class_name_set: application_class_name = a_string
		end;

feature -- Basic operations

	exit is
			-- Exit from the application
		do
			application_context.exit
		end;

	iterate is
			-- Loop the application.
		do
			application_context.iterate
		end;

feature {NONE} -- Implementation

	set_default is
			-- Define default parameters for the application.
		do
		end;

	build is
			-- Build an application.
		do
		end;

	build_application_class_name is
			-- Set the application class name according to
			-- the recommandations of Motif.
		require
			application_name_not_void: application_name /= Void
		local
			the_class_name: STRING
		do
			the_class_name := clone (application_name);
			if (the_class_name.count >= 1) then
				the_class_name.put ((the_class_name @ 1).upper, 1);
				if ((the_class_name.count >= 2) and then ((the_class_name @ 1).is_equal ('X'))) then
					the_class_name.put ((the_class_name @ 2).upper, 2)
				end
			end;
			application_class_name := the_class_name
		end;

end -- class MEL_APPLICATION

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
