indexing
	description: "Eiffel encapsulation of C++ class MyString"
	date: "$Date$"
	revision: "$Revision$"

class MYSTRING

inherit
	DISPOSABLE

create
	make

feature -- Initialization

	make  (a_string: STRING) is
			-- Create Eiffel and C++ objects.
		local
			l_str: C_STRING
		do
			create l_str.make (a_string)
			item := cpp_new (l_str.item)
		end

feature -- Removal

	dispose is
			-- Delete C++ object.
		do
			cpp_delete (item)
		end

feature  -- Access

	value: STRING is
			-- Call C++ counterpart.
		local
			loc_ptr: POINTER
		do
			create Result.make (0)
			loc_ptr := cpp_value (item)
			if loc_ptr /= default_pointer then
				Result.from_c (loc_ptr)
			end
		end

	length: INTEGER is
			-- Call C++ counterpart.
		do
			Result := cpp_length (item)
		end

feature {NONE} -- Externals

	cpp_new (a_string: POINTER): POINTER is 
			-- Call single constructor of C++ class.
		external
			"C++ creator MyString signature (char *) use %"mystring.h%""
		end

	cpp_delete (a_cpp_object: POINTER) is
			-- Call C++ destructor on C++ object.
		external
			"C++ delete MyString use %"mystring.h%""
		end

	cpp_value (a_cpp_object: POINTER): POINTER is
			-- Value of C++ data member.
		external
			"C++ MyString signature : EIF_POINTER use %"mystring.h%""
		alias
			"Value"
		end

	cpp_length (a_cpp_object: POINTER): INTEGER is
			-- Value of C++ data member.
		external
			"C++ MyString signature : EIF_INTEGER use %"mystring.h%""
		alias
			"Length"
		end

feature {NONE} -- Implementation

	item: POINTER

end -- class MYSTRING

--|----------------------------------------------------------------
--| C++: library of reusable components for ISE Eiffel.
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

