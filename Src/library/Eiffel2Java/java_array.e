indexing
	
	description: "parent of all Java array classes that contains the %
                 %common routines to all arrays. Not to be used directly,%
                 % instead use the class with array of specific type."

class JAVA_ARRAY

inherit

	SHARED_JNI_ENVIRONMENT
	JAVA_EXTERNALS

creation {NONE} -- prevent people from creating instances of this type

	make_from_pointer

feature

	make_from_pointer (p: POINTER) is
			-- make an Eiffel array accessor out of a pointer to a 
			-- Java array
		require
			valid: p /= default_pointer
		do
			jarray := p
		end

	count : INTEGER is
			-- number of cells in this array
		do
			Result := c_get_array_length (jni.envp,jarray)
		end

	valid_index (index: INTEGER): BOOLEAN is
			-- index is valid if it's between 0..count-1
		do
			Result := (index >= 0) and (index < count)
		end

feature {JAVA_ARGS}

	jarray: POINTER

invariant

	jarray /= default_pointer

end  --class








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

