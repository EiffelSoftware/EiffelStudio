indexing
	description: "Encapsulation of `jvalue' structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_VALUE

inherit
	MEMORY_STRUCTURE

create
	make,
	make_by_pointer

feature -- Access

	boolean_value: BOOLEAN is
			-- Access `jboolean' value of Current.
		do
			Result := c_jboolean (item)
		end

	boolean_address: POINTER is
			-- Access `jboolean' value of Current.
		do
			Result := c_jboolean_address (item)
		end
		
	byte_value: INTEGER_8 is
			-- Access `jbyte' value of Current.
		do
			Result := c_jbyte (item)
		end

	byte_address: POINTER is
			-- Access `jbyte' value of Current.
		do
			Result := c_jbyte_address (item)
		end
		
	char_value: CHARACTER is
			-- Access `jchar' value of Current.
		do
			Result := c_jchar (item)
		end

	char_address: POINTER is
			-- Access `jchar' value of Current.
		do
			Result := c_jchar_address (item)
		end
		
	short_value: INTEGER_16 is
			-- Access `jshort' value of Current.
		do
			Result := c_jshort (item)
		end

	short_address: POINTER is
			-- Access `jshort' value of Current.
		do
			Result := c_jshort_address (item)
		end
		
	int_value: INTEGER is
			-- Access `jint' value of Current.
		do
			Result := c_jint (item)
		end

	int_address: POINTER is
			-- Access `jint' value of Current.
		do
			Result := c_jint_address (item)
		end
		
	long_value: INTEGER_64 is
			-- Access `jlong' value of Current.
		do
			Result := c_jlong (item)
		end

	long_address: POINTER is
			-- Access `jlong' value of Current.
		do
			Result := c_jlong_address (item)
		end
		
	float_value: REAL is
			-- Access `jfloat' value of Current.
		do
			Result := c_jfloat (item)
		end

	float_address: POINTER is
			-- Access `jfloat' value of Current.
		do
			Result := c_jfloat_address (item)
		end
		
	double_value: DOUBLE is
			-- Access `jdouble' value of Current.
		do
			Result := c_jdouble (item)
		end

	double_address: POINTER is
			-- Access `jdouble' value of Current.
		do
			Result := c_jdouble_address (item)
		end
		
	object_value: POINTER is
			-- Access `jobject' value of Current.
		do
			Result := c_jobject (item)
		end

	object_address: POINTER is
			-- Access `jobject' value of Current.
		do
			Result := c_jobject_address (item)
		end
	
feature -- Settings

	set_boolean_value (v: BOOLEAN) is
			-- Set `jboolean' value of Current with `v'.
		do
			c_set_jboolean (item, v)
		ensure
			boolean_value_set: boolean_value = v
		end

	set_byte_value (v: INTEGER_8) is
			-- Set `jbyte' value of Current with `v'.
		do
			c_set_jbyte (item, v)
		ensure
			byte_value_set: byte_value = v
		end

	set_char_value (v: CHARACTER) is
			-- Set `jchar' value of Current with `v'.
		do
			c_set_jchar (item, v)
		ensure
			char_value_set: char_value = v
		end

	set_short_value (v: INTEGER_16) is
			-- Set `jshort' value of Current with `v'.
		do
			c_set_jshort (item, v)
		ensure
			short_value_set: short_value = v
		end

	set_int_value (v: INTEGER) is
			-- Set `jint' value of Current with `v'.
		do
			c_set_jint (item, v)
		ensure
			int_value_set: int_value = v
		end

	set_long_value (v: INTEGER_64) is
			-- Set `jlong' value of Current with `v'.
		do
			c_set_jlong (item, v)
		ensure
			long_value_set: long_value = v
		end

	set_float_value (v: REAL) is
			-- Set `jfloat' value of Current with `v'.
		do
			c_set_jfloat (item, v)
		ensure
			float_value_set: float_value = v
		end

	set_double_value (v: DOUBLE) is
			-- Set `jdouble' value of Current with `v'.
		do
			c_set_jdouble (item, v)
		ensure
			double_value_set: double_value = v
		end

	set_object_value (v: POINTER) is
			-- Set `jobject' value of Current with `v'.
		do
			c_set_jobject (item, v)
		ensure
			object_value_set: object_value = v
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		do
			Result := c_structure_size
		end

feature {NONE} -- Implementation

	c_structure_size: INTEGER is
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(jvalue)"
		end
		
	c_jboolean (an_item: POINTER): BOOLEAN is
			-- Access `z' from `Current'.
		external
			"C struct jvalue access z use %"jni.h%""
		end

	c_jboolean_address (an_item: POINTER): POINTER is
			-- Access `z' from `Current'.
		external
			"C struct jvalue access &z use %"jni.h%""
		end

	c_jbyte (an_item: POINTER): INTEGER_8 is
			-- Access `b' from `Current'.
		external
			"C struct jvalue access b use %"jni.h%""
		end

	c_jbyte_address (an_item: POINTER): POINTER is
			-- Access `b' from `Current'.
		external
			"C struct jvalue access &b use %"jni.h%""
		end

	c_jchar (an_item: POINTER): CHARACTER is
			-- Access `c' from `Current'.
		external
			"C struct jvalue access @c use %"jni.h%""
		end

	c_jchar_address (an_item: POINTER): POINTER is
			-- Access `c' from `Current'.
		external
			"C struct jvalue access &c use %"jni.h%""
		end

	c_jshort (an_item: POINTER): INTEGER_16 is
			-- Access `s' from `Current'.
		external
			"C struct jvalue access s use %"jni.h%""
		end

	c_jshort_address (an_item: POINTER): POINTER is
			-- Access `s' from `Current'.
		external
			"C struct jvalue access &s use %"jni.h%""
		end

	c_jint (an_item: POINTER): INTEGER is
			-- Access `i' from `Current'.
		external
			"C struct jvalue access i use %"jni.h%""
		end

	c_jint_address (an_item: POINTER): POINTER is
			-- Access `i' from `Current'.
		external
			"C struct jvalue access &i use %"jni.h%""
		end

	c_jlong (an_item: POINTER): INTEGER_64 is
			-- Access `j' from `Current'.
		external
			"C struct jvalue access j use %"jni.h%""
		end

	c_jlong_address (an_item: POINTER): POINTER is
			-- Access `j' from `Current'.
		external
			"C struct jvalue access &j use %"jni.h%""
		end

	c_jfloat (an_item: POINTER): REAL is
			-- Access `f' from `Current'.
		external
			"C struct jvalue access f use %"jni.h%""
		end

	c_jfloat_address (an_item: POINTER): POINTER is
			-- Access `f' from `Current'.
		external
			"C struct jvalue access &f use %"jni.h%""
		end

	c_jdouble (an_item: POINTER): DOUBLE is
			-- Access `d' from `Current'.
		external
			"C struct jvalue access d use %"jni.h%""
		end

	c_jdouble_address (an_item: POINTER): POINTER is
			-- Access `d' from `Current'.
		external
			"C struct jvalue access &d use %"jni.h%""
		end

	c_jobject (an_item: POINTER): POINTER is
			-- Access `l' from `Current'.
		external
			"C struct jvalue access l use %"jni.h%""
		end

	c_jobject_address (an_item: POINTER): POINTER is
			-- Access `l' from `Current'.
		external
			"C struct jvalue access &l use %"jni.h%""
		end

	c_set_jboolean (an_item: POINTER; v: BOOLEAN) is
			-- Set `z' from `Current' wit h`v'.
		external
			"C struct jvalue access z type jboolean use %"jni.h%""
		end

	c_set_jbyte (an_item: POINTER; v: INTEGER_8) is
			-- Set `b' from `Current' wit h`v'.
		external
			"C struct jvalue access b type jbyte use %"jni.h%""
		end

	c_set_jchar (an_item: POINTER; v: CHARACTER) is
			-- Set `c' from `Current' wit h`v'.
		external
			"C struct jvalue access @c type jchar use %"jni.h%""
		end

	c_set_jshort (an_item: POINTER; v: INTEGER_16) is
			-- Set `s' from `Current' wit h`v'.
		external
			"C struct jvalue access s type jshort use %"jni.h%""
		end

	c_set_jint (an_item: POINTER; v: INTEGER) is
			-- Set `i' from `Current' wit h`v'.
		external
			"C struct jvalue access i type jint use %"jni.h%""
		end

	c_set_jlong (an_item: POINTER; v: INTEGER_64) is
			-- Set `j' from `Current' wit h`v'.
		external
			"C struct jvalue access j type jlong use %"jni.h%""
		end

	c_set_jfloat (an_item: POINTER; v: REAL) is
			-- Set `f' from `Current' wit h`v'.
		external
			"C struct jvalue access f type jfloat use %"jni.h%""
		end

	c_set_jdouble (an_item: POINTER; v: DOUBLE) is
			-- Set `d' from `Current' wit h`v'.
		external
			"C struct jvalue access d type jdouble use %"jni.h%""
		end

	c_set_jobject (an_item: POINTER; v: POINTER) is
			-- Set `l' from `Current' wit h`v'.
		external
			"C struct jvalue access l type jobject use %"jni.h%""
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




end -- class JAVA_VALUE

