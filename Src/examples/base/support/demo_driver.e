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
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://www.eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

