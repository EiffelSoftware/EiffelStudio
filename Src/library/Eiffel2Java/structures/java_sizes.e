indexing  
	description: "JNI external declarations"
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_SIZES

feature {NONE} -- Structure size

	sizeof_jboolean: INTEGER is
			-- Size of `jboolean' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(jboolean)"
		end	

	sizeof_jchar: INTEGER is
			-- Size of `jchar' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(jchar)"
		end
		
	sizeof_jbyte: INTEGER is
			-- Size of `jbyte' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(jbyte)"
		end
		
	sizeof_jshort: INTEGER is
			-- Size of `jshort' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(jshort)"
		end
		
	sizeof_jint: INTEGER is
			-- Size of `jint' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(jint)"
		end
		
	sizeof_jlong: INTEGER is
			-- Size of `jlong' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(jlong)"
		end
		
	sizeof_jfloat: INTEGER is
			-- Size of `jfloat' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(jfloat)"
		end
		
	sizeof_jdouble: INTEGER is
			-- Size of `jdouble' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(jdouble)"
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

