--
-- This class represents arguments that can be passed to a
-- Java method
--
indexing

	description: "Argument list for calls to Java methods"

class JAVA_ARGS

inherit

	SHARED_JNI_ENVIRONMENT

	MEMORY
		redefine
			dispose
		end

creation

	make

feature

	make (ncount: INTEGER) is
			-- make an argument list for at most "ncount" arguments
		require
			ncount >= 1
		do
			count := ncount
			top := 1
			!!contents.make (1, ncount)
			java_args_array := c_allocate_java_args (ncount)
		ensure
			java_args_array /= default_pointer
			count = ncount
		end

	count: INTEGER 
			-- number of positions in the arg list

	push_double (value : DOUBLE) is
			-- add a "double" argument
		require
			not full
		do
			contents.put (value, top)
			c_put_double_arg (jni.envp, java_args_array, value, top -1)
			top:= top +1
		end

	push_float (value : REAL) is
			-- add a "float" argument
		require
			not full
		do
			contents.put (value, top)
			c_put_float_arg (jni.envp, java_args_array, value, top -1)
			top:= top +1
		end

	push_boolean (value : BOOLEAN) is
			-- add a "boolean" argment
		require
			not full
		do
			contents.put (value, top)
			c_put_boolean_arg (jni.envp, java_args_array, value, top -1)
			top:= top +1
		end

	push_char (value : CHARACTER) is
			-- add a "character" argument
		require
			not full
		do
			contents.put (value, top)
			c_put_char_arg (jni.envp, java_args_array, value, top -1)
			top:= top +1
		end

	push_short (value :INTEGER) is
			-- add a "short" argument
		require
			not full
		do
			contents.put (value, top)
			c_put_short_arg (jni.envp, java_args_array, value, top -1)
			top:= top +1
		end

	push_int (value: INTEGER) is
			-- add "integer" argument
		require
			not full
		do
			contents.put (value, top)
			c_put_int_arg (jni.envp, java_args_array, value, top-1)
			top := top + 1
		end

	push_string (value: STRING) is
			-- add "string" argument
		require
			not full
		do
			contents.put (value, top)
			c_put_string_arg (jni.envp, java_args_array, $(value.to_c), top-1)
			top := top + 1
		end

	push_object (value : JAVA_OBJECT) is
			-- add an "object" argument (Void allowed)
		require
			not full
		do
			contents.put (value, top)
			if value /= Void then
				c_put_object_arg (jni.envp, java_args_array, value.java_object_id, top-1)
			else
				c_put_object_arg (jni.envp, java_args_array, default_pointer, top-1)
			end
			top := top + 1
		end

	push_array (value : JAVA_ARRAY) is
			-- add a "array" argument (Void allowed)
		require
			not full
		do
			contents.put (value, top)
			if value /= Void then
				c_put_object_arg (jni.envp, java_args_array, value.jarray, top-1)
			else
				c_put_object_arg (jni.envp, java_args_array, default_pointer, top-1)
			end
			top := top + 1
		end 		   				

	full: BOOLEAN is
			-- true if argument list is full
		do
			Result := top > count
		end

	reset is
			-- reset the argument list
		do
			top := 1
		end

feature {JAVA_OBJECT, JAVA_CLASS}

	to_c: POINTER is
			-- Return the pointer to the arg array that can be passed 
			-- to JNI/Java calls
		do
			Result := java_args_array
		end

feature {NONE}

	contents: ARRAY [ANY]
			-- objects that are current arguments

	top: INTEGER
			-- place where the next argument will go

	java_args_array: POINTER
			-- pointer to the Java array representing the arguments

	dispose is
			-- dispose of the C memory allocated for the argument list
		do
			if java_args_array /= default_pointer then
				c_free_java_args (java_args_array)
			end
		end

feature {NONE} -- externals


	c_allocate_java_args (ncount: INTEGER): POINTER is
		external "C"
		end

	c_free_java_args (p: POINTER) is
		external "C"
		end

	c_put_double_arg (lenv: POINTER; jaa: POINTER; value: DOUBLE; pos: INTEGER) is
		external "C"
		end

	c_put_boolean_arg (lenv: POINTER; jaa: POINTER; value: BOOLEAN; pos: INTEGER) is
		external "C"
		end

	c_put_short_arg (lenv: POINTER; jaa: POINTER; value: INTEGER; pos: INTEGER) is
		external "C"
		end

	c_put_float_arg (lenv: POINTER; jaa: POINTER; value: REAL; pos: INTEGER) is
		external "C"
		end

	c_put_char_arg (lenv: POINTER; jaa: POINTER; value: CHARACTER; pos: INTEGER) is
		external "C"
		end

	c_put_int_arg  (lenv: POINTER; jaa: POINTER; value: INTEGER; pos: INTEGER) is
		external "C"
		end

	c_put_string_arg (lenv: POINTER; jaa: POINTER; value: POINTER; pos: INTEGER) is
		external "C"
		end


	c_put_object_arg (lenv: POINTER; jaa: POINTER; value: POINTER; pos: INTEGER) is
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

