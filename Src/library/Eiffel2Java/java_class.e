indexing

	description: "Access to Java classes. Static methods and %
                 %attributes are accessed via this class"

class JAVA_CLASS

inherit

	JAVA_OBJECT
		rename
			java_object_id as java_class_id
		redefine
			create_instance, 
			field_id, 
			method_id, 
			string_method, 
			void_method,
			double_method,
			integer_method,
			short_method,
			float_method,
			char_method,
			boolean_method,
			object_method,
			byte_method,
			integer_attribute,
			string_attribute,
			object_attribute,
			boolean_attribute,
			char_attribute,
			float_attribute,
			double_attribute,
			byte_attribute,
			short_attribute,
			set_integer_attribute,
			set_string_attribute,
			set_object_attribute,
			set_boolean_attribute,
			set_char_attribute,
			set_float_attribute,
			set_double_attribute,
			set_byte_attribute,
			set_short_attribute
		end
			

creation {JNI_ENVIRONMENT}

	make

feature

	name: STRING
			-- name of this class

feature -- method ids - in a Java class these are all static


	method_id (mname: STRING; sig: STRING): POINTER is
			-- Return "method_id" for a static method with "mname" and 
			-- signature "sig" that belongs to this class.
		do
			Result := c_get_static_method_id (jni.envp, java_class_id, $(mname.to_c), $(sig.to_c))
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
			c_call_static_void_method (jni.envp, java_class_id, lmethod_id, argp)
		end

	string_method (lmethod_id: POINTER; args: JAVA_ARGS): STRING is
			-- Call static routine that returns a string
		local
			argp: POINTER
		do
			if args /= Void then
				argp := args.to_c
			end
			Result := c_call_static_string_method (jni.envp, java_class_id, lmethod_id, argp)
		end

	integer_method (mid: POINTER; args: JAVA_ARGS): INTEGER is
			-- Call a static function that returns an INTEGER.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_static_int_method (jni.envp, java_class_id, mid, argsp)
		end

	short_method (mid: POINTER; args: JAVA_ARGS): INTEGER is
			-- Call a static function that returns a short 
			-- (represented as INTEGER in Eiffel)
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_static_short_method (jni.envp, java_class_id, mid, argsp)
		end

	double_method (mid: POINTER; args: JAVA_ARGS): DOUBLE is
			-- Call a static function that returns a DOUBLE.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_static_double_method (jni.envp, java_class_id, mid, argsp)
		end

	float_method (mid: POINTER; args: JAVA_ARGS): REAL is
			-- Call a static function that returns a REAL.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_static_float_method (jni.envp, java_class_id, mid, argsp)
		end

	char_method (mid: POINTER; args: JAVA_ARGS): CHARACTER is
			-- Call a static function that returns a CHARACTER.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_static_char_method (jni.envp, java_class_id, mid, argsp)
		end

	boolean_method (mid: POINTER; args: JAVA_ARGS): BOOLEAN is
			-- Call a static function that returns a BOOLEAN.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_static_boolean_method (jni.envp, java_class_id, mid, argsp)
		end

	
	byte_method (mid: POINTER; args: JAVA_ARGS): CHARACTER is
			-- Call a static function that returns a byte 
			-- (represented as CHARACTER in Eiffel)
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_static_byte_method (jni.envp, java_class_id, mid, argsp)
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
			jo := c_call_static_object_method (jni.envp, java_class_id, lmethod_id, argp)
			if jo /= default_pointer then
				-- Check global table to see if we have an Eiffel 
				-- proxy for this object
				Result := jni.java_object_table.item (jo.hash_code)
				if Result = Void then
					!!Result.make_from_pointer (jo)
				end
			end
		end


feature -- attribute ids

	field_id (fname: STRING; sig: STRING): POINTER is
			-- Get the java field id of a static field, used to set/get this field
		require else
			(fname /= Void) and (sig /= Void)
		do
			Result := c_get_static_field_id (jni.envp, java_class_id, 
										$(fname.to_c), $(sig.to_c))
		end

feature -- access to static attributes


	integer_attribute (fid: POINTER): INTEGER is
			-- get a value of an integer static field
		do
			Result := c_get_static_integer_field (jni.envp, java_class_id, fid)
		end

	string_attribute (fid: POINTER): STRING is
			-- get the value of STRING static field
		do
			Result := c_get_static_string_field (jni.envp, java_class_id, fid)
		end

	object_attribute (fid: POINTER): JAVA_OBJECT is
			-- get the value of OBJECT static field
		local
			jo: POINTER
		do
			jo := c_get_static_object_field (jni.envp, java_class_id, fid)
			if jo /= default_pointer then
				-- Check global table to see if we have an Eiffel 
				-- proxy for this object
				Result := jni.java_object_table.item (jo.hash_code)
				if Result = Void then
					!!Result.make_from_pointer (jo)
				end
			end
		end

	boolean_attribute (fid: POINTER): BOOLEAN is
			-- access to a boolean attribute
		do
			Result := c_get_static_boolean_field (jni.envp, java_class_id, fid)
		end

	char_attribute (fid: POINTER): CHARACTER is
			-- access to a 'char' attribute
		do
			Result := c_get_static_char_field (jni.envp, java_class_id, fid)
		end

	float_attribute (fid: POINTER): REAL is
			-- access to a 'float' attribute, returns a REAL
		do
			Result := c_get_static_float_field (jni.envp, java_class_id, fid)
		end

	double_attribute (fid: POINTER): DOUBLE is
			-- access to a double attribute
		do
			Result := c_get_static_double_field (jni.envp, java_class_id, fid)
		end
	
	byte_attribute (fid: POINTER): CHARACTER is
			-- access to a 'byte' attribute, returns a CHARACTER
		do
			Result := c_get_static_byte_field (jni.envp, java_class_id, fid)
		end

	short_attribute (fid: POINTER): INTEGER is
			-- access to a 'short' attribute, returns a INTEGER
		do
			Result := c_get_static_short_field (jni.envp, java_class_id, fid)
		end

feature -- Setting static attributes

	set_integer_attribute (fid: POINTER; value: INTEGER) is
			-- set an 'integer' attribute to 'value'
		do
			c_set_static_integer_field (jni.envp, java_class_id, fid, value)
		end

	set_string_attribute (fid: POINTER; value: STRING) is
			-- set a 'String' attribute to 'value'
		local
			c_string: ANY
		do
			c_string := value.to_c
			c_set_static_string_field (jni.envp, java_class_id, fid, $c_string)
		end
	
	set_object_attribute (fid: POINTER; value: JAVA_OBJECT) is
			-- set a java object attribute to 'value'
		do	
			c_set_static_object_field (jni.envp, java_class_id, fid, value.java_object_id)
		end

	set_boolean_attribute (fid: POINTER; value: BOOLEAN) is
			-- set a 'boolean' attribute to 'value'
		do
			c_set_static_boolean_field (jni.envp, java_class_id, fid, value)
		end

	set_char_attribute (fid: POINTER; value: CHARACTER) is 
			-- set a 'char' attribute to 'value'
		do
			c_set_static_char_field (jni.envp, java_class_id, fid, value)
		end

	set_float_attribute (fid: POINTER; value: REAL) is
			-- set a 'float' attribute to 'value'
		do
			c_set_static_float_field (jni.envp, java_class_id, fid, value)
		end

	set_double_attribute (fid: POINTER; value: DOUBLE) is
			-- set a 'double' attribute to 'value'
		do
			c_set_static_double_field (jni.envp, java_class_id, fid, value)
		end
	
	set_byte_attribute (fid: POINTER; value: CHARACTER) is
			-- set a 'byte' attribute to 'value'
		do
			c_set_static_byte_field (jni.envp, java_class_id, fid, value)
		end

	set_short_attribute (fid: POINTER; value: INTEGER) is
			-- set a 'short' attribute to 'value'
		do
			c_set_static_short_field (jni.envp, java_class_id, fid, value)
		end

feature {NONE}

	create_instance (my_cls: JAVA_CLASS; sig: STRING; args: JAVA_ARGS) is 
			-- this routine is not applicable to classes
		local
			ex: EXCEPTIONS
		do
			!!ex
			ex.raise ("can't call this routine on JAVA_CLASS")
		end

	make (jclass_id: POINTER) is
			-- create a new instance of Java class give "jclass_id"
		local
			mid: POINTER	
			clsid: POINTER
		do
			java_class_id := jclass_id
			-- get the name of the class
			clsid := c_get_object_class (jni.envp, jclass_id)
			mid := c_get_method_id (jni.envp, clsid, 
									$(("getName").to_c),
									$(("()Ljava/lang/String;").to_c))
			name := c_call_string_method (jni.envp, jclass_id, mid, default_pointer)
			debug ("java")
				io.putstring ("JAVA_CLASS: name=")
				io.putstring (name)
				io.new_line
			end
		ensure then
			java_class_id /= default_pointer
			name /= Void
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

