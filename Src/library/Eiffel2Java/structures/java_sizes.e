indexing  
	description: "JNI external declarations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

