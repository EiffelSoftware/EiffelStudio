indexing
	
	description: "This class can be used as a%
		%scrollable_element in scrollable_list."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SCROLLABLE_LIST_STRING_ELEMENT

inherit

	STRING

	SCROLLABLE_LIST_ELEMENT
		undefine
			setup,
			consistent,
			copy,
			out,
			is_equal
		end

creation
	make,
	make_from_string

feature -- Access

	value: STRING is
			-- String to appear in scrollable list box
		do
			Result := Current
		end

end -- class SCROLLABLE_LIST_STRING_ELEMENT

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

