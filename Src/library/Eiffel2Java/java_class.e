indexing
	description: "Access to Java classes. Static methods and %
                 %attributes are accessed via this class"
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_CLASS

inherit
	JAVA_ENTITY
		redefine
			is_equal
		end

	SHARED_JNI_ENVIRONMENT
		redefine
			is_equal
		end

create {JNI_ENVIRONMENT}
	make

feature {NONE} -- Initialization

	make (jclass_id: POINTER) is
			-- Create a new instance of Java class give "jclass_id"
		local
			mid: POINTER	
			clsid: POINTER
			str_get_name_to_c: C_STRING
			str_Ljava_lang_String_to_c: C_STRING
		do
			create str_get_name_to_c.make ("getName")
			create str_Ljava_lang_String_to_c.make ("()Ljava/lang/String;")
			java_class_id := jclass_id
				-- Get the name of the class
			clsid := jni.get_class (jclass_id)
			mid := jni.get_method_id (clsid, 
									str_get_name_to_c.item,
									str_Ljava_lang_String_to_c.item)
			name := jni.call_string_method (jclass_id, mid, default_pointer)
			debug ("java")
				io.putstring ("JAVA_CLASS: name=")
				io.putstring (name)
				io.new_line
			end
		ensure then
			java_class_id /= default_pointer
			name /= Void
		end

feature -- Access

	name: STRING
			-- Name of current class.

	java_class_id: POINTER
			-- Reference to java object.

feature -- Status report

	exists: BOOLEAN is
			-- Is Current java object alive?
		do
			Result := java_class_id /= default_pointer
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := java_class_id = other.java_class_id
		end

feature -- Reflection

	method_id (mname: STRING; sig: STRING): POINTER is
			-- Return "method_id" for a static method with "mname" and 
			-- signature "sig" that belongs to this class.
		local
			mname_to_c: C_STRING
			sig_to_c: C_STRING
		do
			create mname_to_c.make (mname)
			create sig_to_c.make (sig)
			Result := jni.get_static_method_id (java_class_id, mname_to_c.item, sig_to_c.item)
		end

	field_id (fname: STRING; sig: STRING): POINTER is
			-- Get the java field id of a static field, used to set/get this field
		require else
			(fname /= Void) and (sig /= Void)
		local
			fname_to_c: C_STRING
			sig_to_c: C_STRING
		do
			create fname_to_c.make (fname)
			create sig_to_c.make (sig)
			Result := jni.get_static_field_id (java_class_id, 
										fname_to_c.item, sig_to_c.item)
		end

feature -- calling static methods

	void_method (lmethod_id: POINTER; args: JAVA_ARGS) is
			-- call static method with specific ID, passing arguments
		local
			argp: POINTER
		do
			if args /= Void then
				argp := args.to_c
			end
			jni.call_static_void_method (java_class_id, lmethod_id, argp)
		end

	string_method (lmethod_id: POINTER; args: JAVA_ARGS): STRING is
			-- Call static routine that returns a string
		local
			argp: POINTER
		do
			if args /= Void then
				argp := args.to_c
			end
			Result := Jni.call_static_string_method (java_class_id, lmethod_id, argp)
		end

	integer_method (mid: POINTER; args: JAVA_ARGS): INTEGER is
			-- Call a static function that returns an INTEGER.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_static_int_method (java_class_id, mid, argsp)
		end

	short_method (mid: POINTER; args: JAVA_ARGS): INTEGER_16 is
			-- Call a static function that returns a short 
			-- (represented as INTEGER in Eiffel)
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_static_short_method (java_class_id, mid, argsp)
		end

	double_method (mid: POINTER; args: JAVA_ARGS): DOUBLE is
			-- Call a static function that returns a DOUBLE.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_static_double_method (java_class_id, mid, argsp)
		end

	float_method (mid: POINTER; args: JAVA_ARGS): REAL is
			-- Call a static function that returns a REAL.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_static_float_method (java_class_id, mid, argsp)
		end

	char_method (mid: POINTER; args: JAVA_ARGS): CHARACTER is
			-- Call a static function that returns a CHARACTER.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_static_char_method (java_class_id, mid, argsp)
		end

	boolean_method (mid: POINTER; args: JAVA_ARGS): BOOLEAN is
			-- Call a static function that returns a BOOLEAN.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_static_boolean_method (java_class_id, mid, argsp)
		end

	byte_method (mid: POINTER; args: JAVA_ARGS): INTEGER_8 is
			-- Call a static function that returns a byte 
			-- (represented as CHARACTER in Eiffel)
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_static_byte_method (java_class_id, mid, argsp)
		end

	long_method (mid: POINTER; args: JAVA_ARGS): INTEGER_64 is
			-- Call a static function that returns a long 
			-- (represented as INTEGER_64 in Eiffel)
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_static_long_method (java_class_id, mid, argsp)
		end

	object_method (lmethod_id: POINTER; args: JAVA_ARGS): JAVA_OBJECT is
			-- Call a static function that returns a JAVA_OBJECT. An 
			-- Eiffl proxy object is returned.
		local
			argp: POINTER
			jo: POINTER
		do
			if args /= Void then
				argp := args.to_c
			end
			jo := jni.call_static_object_method (java_class_id, lmethod_id, argp)
			if jo /= default_pointer then
					-- Check global table to see if we have an Eiffel 
					-- proxy for this object
				Result := jni.java_object_table.item (jo)
				if Result = Void then
					create Result.make_from_pointer (jo)
				end
			end
		end

feature -- Access to static attributes

	integer_attribute (fid: POINTER): INTEGER is
			-- get a value of an integer static field
		do
			Result := jni.get_static_integer_field (java_class_id, fid)
		end

	string_attribute (fid: POINTER): STRING is
			-- get the value of STRING static field
		do
			Result := jni.get_static_string_field (java_class_id, fid)
		end

	object_attribute (fid: POINTER): JAVA_OBJECT is
			-- get the value of OBJECT static field
		local
			jo: POINTER
		do
			jo := jni.get_static_object_field (java_class_id, fid)
			if jo /= default_pointer then
					-- Check global table to see if we have an Eiffel 
					-- proxy for this object
				Result := jni.java_object_table.item (jo)
				if Result = Void then
					create Result.make_from_pointer (jo)
				end
			end
		end

	boolean_attribute (fid: POINTER): BOOLEAN is
			-- Access to a boolean attribute
		do
			Result := jni.get_static_boolean_field (java_class_id, fid)
		end

	char_attribute (fid: POINTER): CHARACTER is
			-- Access to a 'char' attribute
		do
			Result := jni.get_static_char_field (java_class_id, fid)
		end

	float_attribute (fid: POINTER): REAL is
			-- Access to a 'float' attribute, returns a REAL
		do
			Result := jni.get_static_float_field (java_class_id, fid)
		end

	double_attribute (fid: POINTER): DOUBLE is
			-- Access to a double attribute
		do
			Result := jni.get_static_double_field (java_class_id, fid)
		end
	
	byte_attribute (fid: POINTER): INTEGER_8 is
			-- Access to a 'byte' attribute, returns a INTEGER_8
		do
			Result := jni.get_static_byte_field (java_class_id, fid)
		end

	short_attribute (fid: POINTER): INTEGER_16 is
			-- Access to a 'short' attribute, returns a INTEGER_16
		do
			Result := jni.get_static_short_field (java_class_id, fid)
		end

	long_attribute (fid: POINTER): INTEGER_64 is
			-- Access to a 'short' attribute, returns a INTEGER_64
		do
			Result := jni.get_static_long_field (java_class_id, fid)
		end

feature -- Setting static attributes

	set_integer_attribute (fid: POINTER; value: INTEGER) is
			-- Set an 'integer' attribute to 'value'
		do
			jni.set_static_integer_field (java_class_id, fid, value)
		end

	set_string_attribute (fid: POINTER; value: STRING) is
			-- Set a 'String' attribute to 'value'
		do
			jni.set_static_string_field (java_class_id, fid, value)
		end
	
	set_object_attribute (fid: POINTER; value: JAVA_OBJECT) is
			-- Set a java object attribute to 'value'
		do	
			jni.set_static_object_field (java_class_id, fid, value.java_object_id)
		end

	set_boolean_attribute (fid: POINTER; value: BOOLEAN) is
			-- Set a 'boolean' attribute to 'value'
		do
			jni.set_static_boolean_field (java_class_id, fid, value)
		end

	set_char_attribute (fid: POINTER; value: CHARACTER) is 
			-- Set a 'char' attribute to 'value'
		do
			jni.set_static_char_field (java_class_id, fid, value)
		end

	set_float_attribute (fid: POINTER; value: REAL) is
			-- Set a 'float' attribute to 'value'
		do
			jni.set_static_float_field (java_class_id, fid, value)
		end

	set_double_attribute (fid: POINTER; value: DOUBLE) is
			-- Set a 'double' attribute to 'value'
		do
			jni.set_static_double_field (java_class_id, fid, value)
		end
	
	set_byte_attribute (fid: POINTER; value: INTEGER_8) is
			-- Set a 'byte' attribute to 'value'
		do
			jni.set_static_byte_field (java_class_id, fid, value)
		end

	set_short_attribute (fid: POINTER; value: INTEGER_16) is
			-- Set a 'short' attribute to 'value'
		do
			jni.set_static_short_field (java_class_id, fid, value)
		end

	set_long_attribute (fid: POINTER; value: INTEGER_64) is
			-- Set a 'short' attribute to 'value'
		do
			jni.set_static_long_field (java_class_id, fid, value)
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

