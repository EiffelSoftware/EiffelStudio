indexing
	description: "Access to Java array of shorts (in Eiffel shorts %
                 %are respresente as INTEGER)"
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_SHORT_ARRAY

inherit
	JAVA_ARRAY

create
	make,
	make_from_pointer
	
feature -- Initialization

	make (size: INTEGER) is
			-- Create a new Java array and an Eiffel accessor object
			-- Note: Java arrays are indexed from zero
		require
			size_ok: size > 0		
		do
			jarray := jni.new_short_array (size)
			create jvalue.make
		ensure
			array_ok: jarray /= default_pointer	
		end

feature -- Access

	item (index: INTEGER): INTEGER_16 is
			-- Item at `index'.
		require
			valid_index: valid_index (index)
		local
			l_array_ptr: POINTER
		do
			l_array_ptr := jni.get_short_array_elements (jarray, default_pointer)
			jvalue.make_by_pointer (l_array_ptr + index * sizeof_jshort)
			Result := jvalue.short_value
			jni.release_short_array_elements (jarray, l_array_ptr, 0)
		end

feature -- Element change

	put (an_item: INTEGER_16; index: INTEGER) is
			-- Put `an_item' at `index'. 
		require
			valid_index: valid_index (index)
		local
			l_array_ptr: POINTER
		do
			l_array_ptr := jni.get_short_array_elements (jarray, default_pointer)
			jvalue.make_by_pointer (l_array_ptr + index * sizeof_jshort)
			jvalue.set_short_value (an_item)
			jni.release_short_array_elements (jarray, l_array_ptr, 0)
		ensure
			inserted: item (index) = an_item
		end

end

--|----------------------------------------------------------------
--| Eiffel2Java: library of reusable components for ISE Eiffel.
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

