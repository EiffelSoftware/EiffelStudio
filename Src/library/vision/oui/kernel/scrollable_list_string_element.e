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
	make

feature -- Access

	value: STRING is
			-- String to appear in scrollable list box
		do
			Result := Current
		end

end -- class SCROLLABLE_LIST_STRING_ELEMENT
