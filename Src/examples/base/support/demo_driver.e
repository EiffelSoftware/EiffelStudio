indexing 
	description: "Demonstration of FORMATTING and COUNTABLES"
	name: demo_driver;
	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DEMO_DRIVER

create
	make

feature -- Initialization

	make is
		local
			formatting: FORMATTING;
			countables: COUNTABLES
		do
			io.putstring ("Formatting demonstration%N%N");
			create formatting.make;
			io.putstring ("%NPress <Return> to start Countables demonstration%N");
			io.readline;
			create countables.make;
		end

end -- class DEMO_DRIVER


--|----------------------------------------------------------------
--| Copyright (C) 1994, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
