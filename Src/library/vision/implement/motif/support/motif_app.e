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

create

	make

feature {NONE} -- Initialization

	make is 
			-- Create the application.
		do
			set_toolkit;
			set_default;
			create screen.make ("");
			create base.make (application_name, screen);
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
			create init_toolkit.make (application_name);
			if (toolkit = Void) then end
		end

end -- class MOTIF_APP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

