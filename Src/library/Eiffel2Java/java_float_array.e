indexing
	
	description: "Access to Java array of floats"

class JAVA_FLOAT_ARRAY

inherit
	
	JAVA_ARRAY

creation
	
	make
	
feature

	make (size: INTEGER) is
			-- create a new Java array and an Eiffel accessor object
			-- Note: Java arrays are indexed from zero
		require
			size_ok: size > 0		
		do
			jarray := c_new_float_array (jni.envp, size)
		ensure
			array_ok: jarray /= default_pointer	
		end

	item (index: INTEGER): REAL is
			-- item at "index"
		require
			valid_index (index)
		do
			Result := c_get_float_array_element (jni.envp, jarray, index )					
		end

	put (litem: REAL; index: INTEGER) is
			-- replace item at "index"
		require
			valid_index (index)
		do
			c_set_float_array_element (jni.envp, jarray, index, litem)
		end

end


--|----------------------------------------------------------------
--| Eiffel2Java: library of reusable components for ISE Eiffel.
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

