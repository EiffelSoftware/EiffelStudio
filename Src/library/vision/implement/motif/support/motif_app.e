indexing

	description: 
		"Parent of any graphic application based on motif implementation.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	MOTIF_APP 

inherit

	GRAPHICS
		redefine
			init_toolkit
		end

creation

	make

feature {NONE} -- Initialization

	make is 
			-- Create the application.
		do
			set_toolkit;
			set_default;
			!! screen.make ("");
			!! base.make (application_name, screen);
			build;
			base.realize;
			iterate
		end;

feature -- Access

	application_name: STRING;
			-- Name of the application top level

	base: BASE;
			-- Top level of the application

	screen: SCREEN;
			-- Default screen of the application
			-- (take the envirronment variable $DISPLAY)

feature -- Element change

	build is
			-- Build an application.
		do
		end;

feature {NONE} -- Implementation

	set_default is
			-- Define default parameters for the application.
		do
		end;

	init_toolkit: TOOLKIT_IMP; 
			-- Toolkit of the application

	set_toolkit  is
			-- Set motif as toolkit.
		do
			!! init_toolkit.make (application_name);
			if (toolkit = Void) then end
		end

end -- class MOTIF_APP



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

