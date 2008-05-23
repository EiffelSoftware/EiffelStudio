indexing
	description: "Argument list for calls to Java methods"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class JAVA_ARGS

inherit
	SHARED_JNI_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER) is
			-- Make an argument list for at most `nb' arguments.
		require
			nb_at_least_one: nb >= 1
		do
			count := nb
			create jvalue.make
			create java_args_array.make (jvalue.structure_size * nb)
		ensure
			count_set: count = nb
		end

feature -- Access

	count: INTEGER 
			-- Number of items in Current argument list.

	item (index: INTEGER): JAVA_VALUE is
			-- Associated java value at position `i'.
		require
			valid_index: valid_index (index)
		do
			create Result.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
		ensure
			item_not_void: Result /= Void
		end

feature -- Element change

	put_double (value: DOUBLE; index: INTEGER) is
			-- Add a "double" argument at position `index'.
		require
			valid_index: valid_index (index)
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			jvalue.set_double_value (value)
		ensure
			inserted: item (index).double_value = value
		end

	put_float (value: REAL; index: INTEGER) is
			-- Add a "float" argument at position `index'.
		require
			valid_index: valid_index (index)
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			jvalue.set_float_value (value)
		ensure
			inserted: item (index).float_value = value
		end

	put_boolean (value: BOOLEAN; index: INTEGER) is
			-- Add a "boolean" argument at position `index'.
		require
			valid_index: valid_index (index)
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			jvalue.set_boolean_value (value)
		ensure
			inserted: item (index).boolean_value = value
		end

	put_byte (value: INTEGER_8; index: INTEGER) is
			-- Add a "byte" argument at position `index'.
		require
			valid_index: valid_index (index)
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			jvalue.set_byte_value (value)
		ensure
			inserted: item (index).byte_value = value
		end

	put_char (value: CHARACTER; index: INTEGER) is
			-- Add a "character" argument at position `index'.
		require
			valid_index: valid_index (index)
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			jvalue.set_char_value (value)
		ensure
			inserted: item (index).char_value = value
		end

	put_short (value: INTEGER_16; index: INTEGER) is
			-- Add a "short" argument at position `index'.
		require
			valid_index: valid_index (index)
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			jvalue.set_short_value (value)
		ensure
			inserted: item (index).short_value = value
		end

	put_int (value: INTEGER; index: INTEGER) is
			-- Add "integer" argument at position `index'.
		require
			valid_index: valid_index (index)
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			jvalue.set_int_value (value)
		ensure
			inserted: item (index).int_value = value
		end

	put_long (value: INTEGER_64; index: INTEGER) is
			-- Add "long" argument at position `index'.
		require
			valid_index: valid_index (index)
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			jvalue.set_long_value (value)
		ensure
			inserted: item (index).long_value = value
		end

	put_string (value: STRING; index: INTEGER) is
			-- Add "string" argument at position `index'.
		require
			valid_index: valid_index (index)
		local
			l_str: POINTER
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			l_str := jni.new_string (value)
			jvalue.set_object_value (l_str)
		ensure
			not_void_inserted:
				value /= Void implies jni.get_string (item (index).object_value).is_equal (value)
			void_inserted:
				value = Void implies item (index).object_value = default_pointer
		end

	put_object (value: JAVA_OBJECT; index: INTEGER) is
			-- Add an "object" argument at position `index'.
			-- Void `value' means a null value for Java.
		require
			valid_index: valid_index (index)
		local
			null: POINTER
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			if value /= Void then
				jvalue.set_object_value (value.java_object_id)
			else
				jvalue.set_object_value (null)
			end
		ensure
			not_void_inserted:
				value /= Void implies item (index).object_value = value.java_object_id
			void_inserted:
				value = Void implies item (index).object_value = default_pointer
		end

	put_array (value: JAVA_ARRAY; index: INTEGER) is
			-- Add a "array" argument at position `index'.
			-- Void `value' means a null value for Java.
		require
			valid_index: valid_index (index)
		local
			null: POINTER
		do
			jvalue.make_by_pointer (java_args_array.item + (index - 1) * sizeof_jvalue)
			if value /= Void then
				jvalue.set_object_value (value.jarray)
			else
				jvalue.set_object_value (null)
			end
		ensure
			not_void_inserted: value /= Void implies item (index).object_value = value.jarray
			void_inserted: value = Void implies item (index).object_value = default_pointer
		end 		   				

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid index for Current.
		do
			Result := 0 < i and i <= count
		end

feature {JAVA_OBJECT, JAVA_CLASS}

	to_c: POINTER is
			-- Return the pointer to the arg array that can be passed 
			-- to JNI/Java calls
		do
			Result := java_args_array.item
		end

feature {NONE} -- Implementation

	jvalue: JAVA_VALUE
			-- Hold a `jvalue' location.

	java_args_array: MANAGED_POINTER
			-- pointer to the Java array representing the arguments

feature {NONE} -- externals

	sizeof_jvalue: INTEGER is
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(jvalue)"
		end

invariant
	java_args_array_not_void: java_args_array /= Void
	count_at_least_one: count >= 1

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

