indexing

	description: "This class gives Eiffel access to Java objects. You %
                 %can use it directly or inherit from to and create a %
                 %more convienient Eiffel class that makes the Java %
                 %object look like an Eiffel object"

class JAVA_OBJECT

inherit

	SHARED_JNI_ENVIRONMENT
	JAVA_EXTERNALS

creation

	create_instance, make_from_pointer

feature -- creation

	make_from_pointer (jobject: POINTER) is
			-- Create an Eiffel proxy, give a pointer to a Java object
			-- (Java object already exists)
		require
			valid_java_id: jobject /= default_pointer
		local
			clsp: POINTER	
		do
			java_object_id := jobject
			-- Figure out out class
			clsp := c_get_object_class (jni.envp, jobject)
			jclass := jni.find_class_by_pointer (clsp)
			-- Add to the Eiffel/java object table
			jni.java_object_table.put (Current, java_object_id.hash_code)
		end

	create_instance (my_cls: JAVA_CLASS; sig: STRING; args: JAVA_ARGS) is
			-- Create an instance of the class by calling the 
			-- constructor with the specified arguments. If "sig" is 
			-- void then we assume that the contructor has no 
			-- arguments. In that case "args" can be void
		require
			class_valid: my_cls /= Void
			sig_and_args_consistent: (sig = Void) implies (args = Void)
		local
			constructor_id, argsp: POINTER
			lsig: STRING
		do
			jclass := my_cls
			lsig := sig
			if lsig = Void then
				lsig := "()V"
			end
			constructor_id := method_id ("<init>", lsig)
			if args /= Void then
				argsp := args.to_c
			end
			if constructor_id /= default_pointer then
				debug ("java")
					io.putstring ("JAVA_OBJECT: creating new object jni=")
					io.putstring (jni.envp.out)
					io.putstring (" Class=")
					io.putstring (jclass.java_class_id.out)
					io.putstring (" Constructor ID=")
					io.putstring (constructor_id.out)
					io.new_line
				end
				java_object_id := c_new_object (jni.envp, jclass.java_class_id, 
												constructor_id, argsp)
			end
			if java_object_id = default_pointer then
				io.putstring ("Failed to get constructor for class:")
				io.putstring (my_cls.name)
				io.new_line
			else
				jni.java_object_table.put (Current, java_object_id.hash_code)
			end
		ensure
			created: java_object_id /= default_pointer	
		end

feature -- method id's

	method_id (method_name: STRING; signature: STRING): POINTER is
			-- Find the method_id for "method_name" with signature 
			-- encoded by "signature"
		require
			(method_name /= Void) and (signature /= Void)
		local
			method_name_to_c: ANY
			signature_to_c: ANY
		do
			method_name_to_c := method_name.to_c
			signature_to_c := signature.to_c
			Result := c_get_method_id (jni.envp, jclass.java_class_id, 
									   $method_name_to_c, $signature_to_c)
		ensure
			method_exists: Result /= default_pointer	
		end

feature -- call object's methods


	void_method (mid: POINTER; args: JAVA_ARGS) is
			-- Call a Java procedure with method_id "mid" and 
			-- arguments "args.
		require
			valid_method: mid /= default_pointer
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			c_call_void_method (jni.envp, java_object_id, mid, argsp)
		end


	string_method (mid: POINTER; args: JAVA_ARGS): STRING is
			-- Call an instance function that returns a STRING.
		require
			valid_method: mid /= default_pointer
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_string_method (jni.envp, java_object_id, mid, argsp)
		end

	integer_method (mid: POINTER; args: JAVA_ARGS): INTEGER is
			-- Call an instance function that returns an INTEGER.
		require
			valid_method: mid /= default_pointer
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_int_method (jni.envp, java_object_id, mid, argsp)
		end

	short_method (mid: POINTER; args: JAVA_ARGS): INTEGER is
			-- Call an instance function that returns a Short (in 
			-- Eiffel we still return an INTEGER).
		require
			valid_method: mid /= default_pointer
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_short_method (jni.envp, java_object_id, mid, argsp)
		end

	long_method (mid: POINTER; args: JAVA_ARGS) is
			-- Call an instance function that returns an Long. This 
			-- function is not implemented. 
		local
			ex: expanded EXCEPTIONS
		do
			io.putstring ("Not a legal call,%N")
			ex.raise ("Not implemented")
		end

	double_method (mid: POINTER; args: JAVA_ARGS): DOUBLE is
			-- Call an instance function that returns a DOUBLE.
		require
			valid_method: mid /= default_pointer
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_double_method (jni.envp, java_object_id, mid, argsp)
		end

	float_method (mid: POINTER; args: JAVA_ARGS): REAL is
			-- Call an instance function that returns a REAL.
		require
			valid_method: mid /= default_pointer
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_float_method (jni.envp, java_object_id, mid, argsp)
		end

	char_method (mid: POINTER; args: JAVA_ARGS): CHARACTER is
			-- Call an instance function that returns a char
		require
			valid_method: mid /= default_pointer
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_char_method (jni.envp, java_object_id, mid, argsp)
		end

	boolean_method (mid: POINTER; args: JAVA_ARGS): BOOLEAN is
			-- Call an instance function that returns a boolean
		require
			valid_method: mid /= default_pointer
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_boolean_method (jni.envp, java_object_id, mid, argsp)
		end

	object_method (lmethod_id: POINTER; args: JAVA_ARGS): JAVA_OBJECT is
			-- Call an instance function that returns a java object
		require
			valid_method_id: lmethod_id /= default_pointer
		local
			argp: POINTER
			jo: POINTER
		do
			if args /= Void then
				argp := args.to_c
			end
			jo := c_call_object_method (jni.envp, java_object_id, lmethod_id, argp)
			if jo /= default_pointer then
				-- Check global table to see if we have an Eiffel 
				-- proxy for this object
				Result := jni.java_object_table.item (jo.hash_code)
				if Result = Void then
					!!Result.make_from_pointer (jo)
				end
			end
		end


	byte_method (mid: POINTER; args: JAVA_ARGS): CHARACTER is
			-- Call an instance function that return a byte
			-- ( 8-bit integer (signed) ), in Eiffel return
			-- a CHARACTER
		require
			valid_method: mid /= default_pointer
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := c_call_byte_method (jni.envp, java_object_id, mid, argsp)
		end


feature -- attribute IDs

	field_id (lname: STRING; sig: STRING): POINTER is
			-- Get the java field id used to set/get this field
		require
			(lname /= Void) and (sig /= Void)
		local 
			lname_to_c: ANY
			sig_to_c: ANY
		do
			lname_to_c := lname.to_c
			sig_to_c := sig.to_c
			Result := c_get_field_id (jni.envp, jclass.java_class_id, 
									  $lname_to_c, $sig_to_c)
		end

feature -- access object's attributes


	integer_attribute (fid: POINTER): INTEGER is
			-- access to an integer attribute
		do
			Result := c_get_integer_field (jni.envp, java_object_id, fid)
		end

	string_attribute (fid: POINTER): STRING is
			-- access to a String attribute
		do
			Result := c_get_string_field (jni.envp, java_object_id, fid)
		end

	object_attribute (fid: POINTER): JAVA_OBJECT is
			-- access to a java object attribute
		local
			jo: POINTER
		do
			jo := c_get_object_field (jni.envp, java_object_id, fid)
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
			Result := c_get_boolean_field (jni.envp, java_object_id, fid)
		end

	char_attribute (fid: POINTER): CHARACTER is
			-- access to a 'char' attribute
		do
			Result := c_get_char_field (jni.envp, java_object_id, fid)
		end

	float_attribute (fid: POINTER): REAL is
			-- access to a 'float' attribute, returns a REAL
		do
			Result := c_get_float_field (jni.envp, java_object_id, fid)
		end

	double_attribute (fid: POINTER): DOUBLE is
			-- access to a double attribute
		do
			Result := c_get_double_field (jni.envp, java_object_id, fid)
		end
	
	byte_attribute (fid: POINTER): CHARACTER is
			-- access to a 'byte' attribute, returns a CHARACTER
		do
			Result := c_get_byte_field (jni.envp, java_object_id, fid)
		end

	short_attribute (fid: POINTER): INTEGER is
			-- access to a 'short' attribute, returns a INTEGER
		do
			Result := c_get_short_field (jni.envp, java_object_id, fid)
		end

feature -- setting object's attribute

	set_integer_attribute (fid: POINTER; value: INTEGER) is
			-- set an 'integer' attribute to 'value'
		do
			c_set_integer_field (jni.envp, java_object_id, fid, value)
		end

	set_string_attribute (fid: POINTER; value: STRING) is
			-- set a 'String' attribute to 'value'
		local
			c_string: ANY
		do
			c_string := value.to_c
			c_set_string_field (jni.envp, java_object_id, fid, $c_string)
		end
	
	set_object_attribute (fid: POINTER; value: JAVA_OBJECT) is
			-- set a java object attribute to 'value'
		do	
			c_set_object_field (jni.envp, java_object_id, fid, value.java_object_id)
		end

	set_boolean_attribute (fid: POINTER; value: BOOLEAN) is
			-- set a 'boolean' attribute to 'value'
		do
			c_set_boolean_field (jni.envp, java_object_id, fid, value)
		end

	set_char_attribute (fid: POINTER; value: CHARACTER) is 
			-- set a 'char' attribute to 'value'
		do
			c_set_char_field (jni.envp, java_object_id, fid, value)
		end

	set_float_attribute (fid: POINTER; value: REAL) is
			-- set a 'float' attribute to 'value'
		do
			c_set_float_field (jni.envp, java_object_id, fid, value)
		end

	set_double_attribute (fid: POINTER; value: DOUBLE) is
			-- set a 'double' attribute to 'value'
		do
			c_set_double_field (jni.envp, java_object_id, fid, value)
		end
	
	set_byte_attribute (fid: POINTER; value: CHARACTER) is
			-- set a 'byte' attribute to 'value'
		do
			c_set_byte_field (jni.envp, java_object_id, fid, value)
		end

	set_short_attribute (fid: POINTER; value: INTEGER) is
			-- set a 'short' attribute to 'value'
		do
			c_set_short_field (jni.envp, java_object_id, fid, value)
		end

feature {JNI_ENVIRONMENT, JAVA_OBJECT, JAVA_OBJECT_ARRAY, JAVA_OBJECT_TABLE, JAVA_ARGS}

	java_object_id: POINTER

	jclass: JAVA_CLASS

invariant

	valid_proxy: java_object_id /= default_pointer

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

