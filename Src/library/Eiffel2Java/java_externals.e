indexing  
	
	description: "JNI external declarations"

class JAVA_EXTERNALS

feature {NONE} -- object creation

	c_new_object (env: POINTER; cls: POINTER; contructor: POINTER; args: POINTER): POINTER is
		external "C"
		end

feature {NONE} -- dynamic method calls

	c_get_method_id (env: POINTER; cls: POINTER; mname: POINTER; sig: POINTER): POINTER is
		external "C"
		end

	c_call_void_method (env: POINTER; oid: POINTER; mid: POINTER; args: POINTER) is
		external "C"
		end

	c_call_string_method (env: POINTER; oid: POINTER; mid: POINTER; args: POINTER): STRING is
		external "C"
		end

	c_call_boolean_method (env: POINTER; oid: POINTER; mid: POINTER; args: POINTER): BOOLEAN is
		external "C"
		end

	c_call_byte_method (env: POINTER; oid: POINTER; mid: POINTER; args: POINTER): CHARACTER is
		external "C"
		end

	c_call_char_method (env: POINTER; oid: POINTER; mid: POINTER; args: POINTER): CHARACTER is
		external "C"
		end

	c_call_short_method (env: POINTER; oid: POINTER; mid: POINTER; args: POINTER): INTEGER is
		external "C"
		end

	c_call_int_method (env: POINTER; oid: POINTER; mid: POINTER; args: POINTER): INTEGER is
		external "C"
		end

	c_call_long_method (env: POINTER; oid: POINTER; mid: POINTER; args: POINTER): INTEGER_64 is
		external "C"
		end

	c_call_float_method (env: POINTER; oid: POINTER; mid: POINTER; args: POINTER): REAL is
		external "C"
		end

	c_call_double_method (env: POINTER; oid: POINTER; mid: POINTER; args: POINTER): DOUBLE is
		external "C"
		end

	c_call_object_method (lenv: POINTER; cls: POINTER; mid: POINTER; argsp: POINTER): POINTER is
		external "C"
		end
	
feature {NONE} -- dynamic attribute access


	c_get_field_id (env: POINTER; cls: POINTER; fname, sig: POINTER): POINTER is
		external "C"
		end

	c_get_static_field_id (env: POINTER; cls: POINTER; fname, sig: POINTER): POINTER is
		external "C"
		end

	c_get_integer_field (env: POINTER; oid: POINTER; fid: POINTER): INTEGER is
		external "C"
		end

	c_get_static_integer_field (env: POINTER; oid: POINTER; fid: POINTER): INTEGER is
		external "C"
		end

	c_get_long_field (env: POINTER; oid: POINTER; fid: POINTER): INTEGER_64 is
		external "C"
		end

	c_get_static_long_field (env: POINTER; oid: POINTER; fid: POINTER): INTEGER_64 is
		external "C"
		end

	c_get_string_field (env: POINTER; oid: POINTER; fid: POINTER): STRING is
		external "C"
		end

	c_get_static_string_field (env: POINTER; oid: POINTER; fid: POINTER): STRING is
		external "C"
		end

	c_get_boolean_field (env: POINTER; oid: POINTER; fid: POINTER): BOOLEAN is
		external "C"
		end

	c_get_static_boolean_field (env: POINTER; oid: POINTER; fid: POINTER): BOOLEAN is
		external "C"
		end

	c_get_char_field (env: POINTER; oid: POINTER; fid: POINTER): CHARACTER is
		external "C"
		end

	c_get_static_char_field (env: POINTER; oid: POINTER; fid: POINTER): CHARACTER is
		external "C"
		end

	c_get_float_field (env: POINTER; oid: POINTER; fid: POINTER): REAL is
		external "C"
		end

	c_get_static_float_field (env: POINTER; oid: POINTER; fid: POINTER): REAL is
		external "C"
		end

	c_get_double_field (env: POINTER; oid: POINTER; fid: POINTER): DOUBLE is
		external "C"
		end

	c_get_static_double_field (env: POINTER; oid: POINTER; fid: POINTER): DOUBLE is
		external "C"
		end

	c_get_byte_field (env: POINTER; oid: POINTER; fid: POINTER): CHARACTER is
		external "C"
		end

	c_get_static_byte_field (env: POINTER; oid: POINTER; fid: POINTER): CHARACTER is
		external "C"
		end

	c_get_short_field (env: POINTER; oid: POINTER; fid: POINTER): INTEGER is
		external "C"
		end

	c_get_static_short_field (env: POINTER; oid: POINTER; fid: POINTER): INTEGER is
		external "C"
		end

	c_get_object_field (env: POINTER; oid: POINTER; fid: POINTER): POINTER is
		external "C"
		end

	c_get_static_object_field (env: POINTER; oid: POINTER; fid: POINTER): POINTER is
		external "C"
		end

feature {NONE} -- dynamic attribute setting

	c_set_integer_field ( env: POINTER; oid: POINTER; fid: POINTER; value: INTEGER) is
		external "C"
		end
		
	c_set_static_integer_field (env: POINTER; oid: POINTER; fid: POINTER; value: INTEGER) is
		external "C"
		end

	c_set_long_field ( env: POINTER; oid: POINTER; fid: POINTER; value: INTEGER_64) is
		external "C"
		end
		
	c_set_static_long_field (env: POINTER; oid: POINTER; fid: POINTER; value: INTEGER_64) is
		external "C"
		end

	c_set_string_field (env: POINTER; oid: POINTER; fid: POINTER;  value: POINTER) is
		external "C"
		end

	c_set_static_string_field (env: POINTER; oid: POINTER; fid: POINTER; value: POINTER) is
		external "C"
		end

	c_set_object_field (env: POINTER; oid: POINTER; fid: POINTER; value: POINTER) is
		external "C"
		end

	c_set_static_object_field (env: POINTER; oid: POINTER; fid: POINTER; value: POINTER) is
		external "C"
		end

	c_set_boolean_field (env: POINTER; oid: POINTER; fid: POINTER; value: BOOLEAN) is
		external "C"
		end

	c_set_static_boolean_field (env: POINTER; oid: POINTER; fid: POINTER; value: BOOLEAN) is
		external "C"
		end

	c_set_char_field (env: POINTER; oid: POINTER; fid: POINTER; value: CHARACTER) is
		external "C"
		end

	c_set_static_char_field (env: POINTER; oid: POINTER; fid: POINTER; value: CHARACTER) is
		external "C"
		end

	c_set_float_field (env: POINTER; oid: POINTER; fid: POINTER; value: REAL) is
		external "C"
		end

	c_set_static_float_field (env: POINTER; oid: POINTER; fid: POINTER; value: REAL) is
		external "C"
		end

	c_set_double_field (env: POINTER; oid: POINTER; fid: POINTER; value: DOUBLE) is
		external "C"
		end

	c_set_static_double_field (env: POINTER; oid: POINTER; fid: POINTER; value: DOUBLE) is
		external "C"
		end

	c_set_byte_field (env: POINTER; oid: POINTER; fid: POINTER; value: CHARACTER) is
		external "C"
		end

	c_set_static_byte_field (env: POINTER; oid: POINTER; fid: POINTER; value: CHARACTER) is
		external "C"
		end

	c_set_short_field (env: POINTER; oid: POINTER; fid: POINTER; value: INTEGER) is
		external "C"
		end

	c_set_static_short_field (env: POINTER; oid: POINTER; fid: POINTER; value: INTEGER) is
		external "C"
		end

feature {NONE} -- static method calls

	c_get_static_method_id (lenv: POINTER; cls: POINTER; mname: POINTER; sig: POINTER): POINTER is
		external "C"
		end

	c_call_static_void_method (lenv: POINTER; cls: POINTER; mid: POINTER; argp: POINTER) is
		external "C"
		end

	c_call_static_byte_method (lenv: POINTER; cls : POINTER; mid: POINTER; argp: POINTER) : CHARACTER is
		external "C"
		end

	c_call_static_boolean_method (lenv: POINTER; cls: POINTER; mid: POINTER; argp: POINTER): BOOLEAN is
		external "C"
		end

	c_call_static_char_method (lenv: POINTER; cls: POINTER; mid: POINTER; argp: POINTER): CHARACTER is
		external "C"
		end

	c_call_static_short_method (lenv: POINTER; cls: POINTER; mid: POINTER; argp: POINTER):INTEGER is
		external "C"
		end

	c_call_static_int_method (lenv: POINTER; cls: POINTER; mid: POINTER; argp: POINTER): INTEGER is
		external "C"
		end

	c_call_static_long_method (lenv: POINTER; cls: POINTER; mid: POINTER; argp: POINTER): INTEGER_64 is
		external "C"
		end

	c_call_static_float_method (lenv: POINTER; cls: POINTER; mid: POINTER; argp: POINTER): REAL is
		external "C"
		end

	c_call_static_double_method (lenv: POINTER; cls: POINTER; mid: POINTER; argp: POINTER): DOUBLE is
		external "C"
		end


	c_call_static_string_method (lenv: POINTER; cls: POINTER; mid: POINTER; argsp: POINTER): STRING is
		external "C"
		end

	c_call_static_object_method (lenv: POINTER; cls: POINTER; mid: POINTER; argsp: POINTER): POINTER is
		external "C"
		end

feature {NONE} -- array operations

	c_get_array_length (lenv: POINTER; ljarray: POINTER): INTEGER is
		external "C"
		end

	c_new_object_array (lenv: POINTER; lsize: INTEGER; element_jclass: POINTER; 
						initial_element: POINTER): POINTER is
		external "C"
		end

	c_get_object_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER): POINTER is
		external "C"
		end

	c_set_object_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER; lvalue: POINTER) is
		external "C"
		end

	c_new_char_array (lenv: POINTER; lsize: INTEGER ): POINTER is
		external "C"
		end

	c_get_char_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER): CHARACTER  is
		external "C"
		end

	c_set_char_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER; lvalue: CHARACTER) is
		external "C"
		end

	c_new_int_array (lenv: POINTER; lsize: INTEGER ): POINTER is
		external "C"
		end

	c_get_int_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER): INTEGER  is
		external "C"
		end

	c_set_int_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER; lvalue: INTEGER) is
		external "C"
		end

	c_new_long_array (lenv: POINTER; lsize: INTEGER ): POINTER is
		external "C"
		end

	c_get_long_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER): INTEGER_64  is
		external "C"
		end

	c_set_long_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER; lvalue: INTEGER_64) is
		external "C"
		end

	c_new_boolean_array (lenv: POINTER; lsize: INTEGER ): POINTER is
		external "C"
		end

	c_get_boolean_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER): BOOLEAN  is
		external "C"
		end

	c_set_boolean_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER; lvalue: BOOLEAN ) is
		external "C"
		end

	c_new_short_array (lenv: POINTER; lsize: INTEGER ): POINTER is
		external "C"
		end

	c_get_short_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER): INTEGER  is
		external "C"
		end

	c_set_short_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER; lvalue: INTEGER) is
		external "C"
		end

	c_new_byte_array (lenv: POINTER; lsize: INTEGER ): POINTER is
		external "C"
		end

	c_get_byte_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER): CHARACTER  is
		external "C"
		end

	c_set_byte_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER; lvalue: CHARACTER) is
		external "C"
		end

	c_new_float_array (lenv: POINTER; lsize: INTEGER ): POINTER is
		external "C"
		end

	c_get_float_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER): REAL  is
		external "C"
		end

	c_set_float_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER; lvalue: REAL) is
		external "C"
		end

	c_new_double_array (lenv: POINTER; lsize: INTEGER ): POINTER is
		external "C"
		end

	c_get_double_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER): DOUBLE is
		external "C"
		end

	c_set_double_array_element (lenv: POINTER; ljarray: POINTER; indx: INTEGER; lvalue: DOUBLE) is
		external "C"
		end

feature -- Java exception mechanism

	c_check_for_exceptions (lenv: POINTER) is
		external "C"
		end

	c_throw_java_exception (lenv: POINTER; jthrowable: POINTER) is
		external "C"
		end

	c_throw_custom_exception (lenv: POINTER; jclass_id: POINTER; msg: POINTER) is
		external "C"
		end

feature {NONE} -- class information

	c_get_object_class (lenv: POINTER; lobj: POINTER): POINTER is
		external "C"
		end

	jni_find_class (env: POINTER; name: POINTER): POINTER is
		external "C"
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

