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
			copy,
			out,
			is_equal
		end

create
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

