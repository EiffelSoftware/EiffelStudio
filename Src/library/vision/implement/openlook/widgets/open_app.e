indexing

	description: "Parent of any graphic application based on openlook implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OPEN_APP 

inherit

	GRAPHICS
		redefine
			init_toolkit
		end

creation

	make
	
feature {NONE}

	init_toolkit: OPENLOOK; 
			-- Toolkit of the application
	
feature 

	base: BASE;
			-- Top level of the application

	screen: SCREEN;
			-- Default screen of the application
			-- (take the envirronment variable $DISPLAY)
	
feature {NONE}

	application_name: STRING;
			-- Name of the application top level

	set_default is
			-- Define default parameters for the application.
		do
		end;

	build is
			-- Build an application.
		do
		end;

feature 

	make is 
			-- Create the application.
		do
			set_toolkit;
			set_default;
			!!screen.make ("");
			!!base.make (application_name, screen);
			build;
			base.realize;
			iterate
		end;

feature {NONE}

	set_toolkit  is
			-- Set openlook as toolkit.
		do	
			!!init_toolkit.make (application_name);
			if (toolkit = Void) then end
		end

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
