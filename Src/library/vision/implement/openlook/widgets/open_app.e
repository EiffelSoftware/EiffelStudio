--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Parent of any graphic application based on openlook implementation.

indexing

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

