indexing
	description: "Test class for application_generator."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CLASS

inherit
	APPLICATION_GENERATOR

create
	make_and_launch

feature -- Create

	make_and_launch is
		do
			default_create
			prepare
			launch
		end

end -- class TEST_CLASS


--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

