indexing

	description:
		"Eiffel encapsulation of C++ class MyString";
	date: "$Date$";
	revision: "$Revision$"

class MYSTRING

inherit
	MEMORY
		redefine
			dispose
		end

creation
	make

feature -- Initialization

	make  (AString: STRING) is
			-- Create Eiffel and C++ objects.
		local
			any0: ANY
		do
			any0 := AString.to_c;
			object_ptr := cpp_new ($any0)
		end

feature -- Removal

	dispose is
			-- Delete C++ object.
		do
			cpp_delete (object_ptr)
		end

feature 

	value: STRING is
			-- Call C++ counterpart.
		local
			loc_ptr: POINTER
		do
			!! Result.make (0);
			loc_ptr := cpp_value (object_ptr);
			if loc_ptr /= default_pointer then
				Result.from_c (loc_ptr)
			end
		end

	length: INTEGER is
			-- Call C++ counterpart.
		do
			Result := cpp_length (object_ptr)
		end

feature {NONE} -- Externals

	cpp_new (AString: POINTER): POINTER is 
			-- Call single constructor of C++ class.
		external
			"C++ [new MyString %"mystring.h%"] (EIF_POINTER)"
		end

	cpp_delete (cpp_obj: POINTER) is
			-- Call C++ destructor on C++ object.
		external
			"C++ [delete MyString %"mystring.h%"] ()"
		end

	cpp_value (cpp_obj: POINTER): POINTER is
			-- Value of C++ data member.
		external
			"C++ [MyString %"mystring.h%"] (): EIF_POINTER"
		alias
			"Value"
		end

	cpp_length (cpp_obj: POINTER): INTEGER is
			-- Value of C++ data member.
		external
			"C++ [MyString %"mystring.h%"] (): EIF_INTEGER"
		alias
			"Length"
		end

feature {NONE} -- Implementation

	object_ptr: POINTER

end -- class MYSTRING
