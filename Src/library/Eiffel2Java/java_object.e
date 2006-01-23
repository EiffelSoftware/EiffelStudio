indexing
	description: "This class gives Eiffel access to Java objects. You %
                 %can use it directly or inherit from to and create a %
                 %more convienient Eiffel class that makes the Java %
                 %object look like an Eiffel object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_OBJECT

inherit
	JAVA_ENTITY
		redefine
			is_equal
		end
	
	SHARED_JNI_ENVIRONMENT
		redefine
			is_equal
		end

create
	create_instance,
	make_from_pointer

feature -- Initialization

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
			clsp := jni.get_class (jobject)
			jclass := jni.find_class_by_pointer (clsp)

				-- Add to the Eiffel/java object table
			jni.java_object_table.put (Current, java_object_id)
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
					io.putstring ("JAVA_OBJECT: creating new object Class=")
					io.putstring (jclass.java_class_id.out)
					io.putstring (" Constructor ID=")
					io.putstring (constructor_id.out)
					io.new_line
				end
				java_object_id := jni.new_object (jclass.java_class_id, 
												constructor_id, argsp)
			end
			if java_object_id = default_pointer then
				io.putstring ("Failed to get constructor for class:")
				io.putstring (my_cls.name)
				io.new_line
			else
				jni.java_object_table.put (Current, java_object_id)
			end
		ensure
			created: java_object_id /= default_pointer	
		end

feature -- Access

	java_object_id: POINTER
			-- Reference to java object.

	jclass: JAVA_CLASS
			-- Associated java class.

feature -- Status report

	exists: BOOLEAN is
			-- Is Current java object alive?
		do
			Result := java_object_id /= default_pointer
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := java_object_id = other.java_object_id
		end

feature -- Reflection

	method_id (feature_name: STRING; signature: STRING): POINTER is
			-- Find the method_id for `feature_name' with signature 
			-- encoded by "signature"
		local
			method_name_to_c, signature_to_c: C_STRING
		do
			create method_name_to_c.make (feature_name)
			create signature_to_c.make (signature)
			Result := jni.get_method_id (jclass.java_class_id, 
									   method_name_to_c.item, signature_to_c.item)
		end

	field_id (lname: STRING; sig: STRING): POINTER is
			-- Get the java field id used to set/get this field
		local
			lname_to_c, sig_to_c: C_STRING
		do
			create lname_to_c.make (lname)
			create sig_to_c.make (sig)
			Result := jni.get_field_id (jclass.java_class_id, 
									  lname_to_c.item, sig_to_c.item)
		end

feature -- Calls

	void_method (mid: POINTER; args: JAVA_ARGS) is
			-- Call a Java procedure with method_id "mid" and 
			-- arguments "args.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			jni.call_void_method (java_object_id, mid, argsp)
		end

	string_method (mid: POINTER; args: JAVA_ARGS): STRING is
			-- Call an instance function that returns a STRING.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_string_method (java_object_id, mid, argsp)
		end

	integer_method (mid: POINTER; args: JAVA_ARGS): INTEGER is
			-- Call an instance function that returns an INTEGER.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_int_method (java_object_id, mid, argsp)
		end

	short_method (mid: POINTER; args: JAVA_ARGS): INTEGER_16 is
			-- Call an instance function that returns a Short (in 
			-- Eiffel we still return an INTEGER).
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_short_method (java_object_id, mid, argsp)
		end

	long_method (mid: POINTER; args: JAVA_ARGS): INTEGER_64 is
			-- Call an instance function that returns an Long. This 
			-- function is not implemented. 
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_long_method (java_object_id, mid, argsp)
		end

	double_method (mid: POINTER; args: JAVA_ARGS): DOUBLE is
			-- Call an instance function that returns a DOUBLE.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_double_method (java_object_id, mid, argsp)
		end

	float_method (mid: POINTER; args: JAVA_ARGS): REAL is
			-- Call an instance function that returns a REAL.
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_float_method (java_object_id, mid, argsp)
		end

	char_method (mid: POINTER; args: JAVA_ARGS): CHARACTER is
			-- Call an instance function that returns a char
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_char_method (java_object_id, mid, argsp)
		end

	boolean_method (mid: POINTER; args: JAVA_ARGS): BOOLEAN is
			-- Call an instance function that returns a boolean
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_boolean_method (java_object_id, mid, argsp)
		end

	object_method (lmethod_id: POINTER; args: JAVA_ARGS): JAVA_OBJECT is
			-- Call an instance function that returns a java object
		local
			argp: POINTER
			jo: POINTER
		do
			if args /= Void then
				argp := args.to_c
			end
			jo := jni.call_object_method (java_object_id, lmethod_id, argp)
			if jo /= default_pointer then
				-- Check global table to see if we have an Eiffel 
				-- proxy for this object
				Result := jni.java_object_table.item (jo)
				if Result = Void then
					create Result.make_from_pointer (jo)
				end
			end
		end

	byte_method (mid: POINTER; args: JAVA_ARGS): INTEGER_8 is
			-- Call an instance function that return a byte
			-- ( 8-bit integer (signed)), in Eiffel return
			-- a INTEGER_8
		local
			argsp: POINTER
		do
			if args /= Void then
				argsp := args.to_c
			end
			Result := jni.call_byte_method (java_object_id, mid, argsp)
		end

feature -- Attributes

	integer_attribute (fid: POINTER): INTEGER is
			-- Access to an integer attribute
		do
			Result := jni.get_integer_field (java_object_id, fid)
		end

	string_attribute (fid: POINTER): STRING is
			-- Access to a String attribute
		do
			Result := jni.get_string_field (java_object_id, fid)
		end

	object_attribute (fid: POINTER): JAVA_OBJECT is
			-- Access to a java object attribute
		local
			jo: POINTER
		do
			jo := jni.get_object_field (java_object_id, fid)
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
			Result := jni.get_boolean_field (java_object_id, fid)
		end

	char_attribute (fid: POINTER): CHARACTER is
			-- Access to a 'char' attribute
		do
			Result := jni.get_char_field (java_object_id, fid)
		end

	float_attribute (fid: POINTER): REAL is
			-- Access to a 'float' attribute, returns a REAL
		do
			Result := jni.get_float_field (java_object_id, fid)
		end

	double_attribute (fid: POINTER): DOUBLE is
			-- Access to a double attribute
		do
			Result := jni.get_double_field (java_object_id, fid)
		end
	
	byte_attribute (fid: POINTER): INTEGER_8 is
			-- Access to a 'byte' attribute, returns a INTEGER_8
		do
			Result := jni.get_byte_field (java_object_id, fid)
		end

	short_attribute (fid: POINTER): INTEGER_16 is
			-- Access to a 'short' attribute, returns a INTEGER_16
		do
			Result := jni.get_short_field (java_object_id, fid)
		end

	long_attribute (fid: POINTER): INTEGER_64 is
			-- Access to a 'long' attribute, returns a INTEGER_64
		do
			Result := jni.get_long_field (java_object_id, fid)
		end

feature -- Attributes setting

	set_integer_attribute (fid: POINTER; value: INTEGER) is
			-- Set an 'integer' attribute to 'value'
		do
			jni.set_integer_field (java_object_id, fid, value)
		end

	set_string_attribute (fid: POINTER; value: STRING) is
			-- Set a 'String' attribute to 'value'
		do
			jni.set_string_field (java_object_id, fid, value)
		end
	
	set_object_attribute (fid: POINTER; value: JAVA_OBJECT) is
			-- Set a java object attribute to 'value'
		do	
			jni.set_object_field (java_object_id, fid, value.java_object_id)
		end

	set_boolean_attribute (fid: POINTER; value: BOOLEAN) is
			-- Set a 'boolean' attribute to 'value'
		do
			jni.set_boolean_field (java_object_id, fid, value)
		end

	set_char_attribute (fid: POINTER; value: CHARACTER) is 
			-- Set a 'char' attribute to 'value'
		do
			jni.set_char_field (java_object_id, fid, value)
		end

	set_float_attribute (fid: POINTER; value: REAL) is
			-- Set a 'float' attribute to 'value'
		do
			jni.set_float_field (java_object_id, fid, value)
		end

	set_double_attribute (fid: POINTER; value: DOUBLE) is
			-- Set a 'double' attribute to 'value'
		do
			jni.set_double_field (java_object_id, fid, value)
		end
	
	set_byte_attribute (fid: POINTER; value: INTEGER_8) is
			-- Set a 'byte' attribute to 'value'
		do
			jni.set_byte_field (java_object_id, fid, value)
		end

	set_short_attribute (fid: POINTER; value: INTEGER_16) is
			-- Set a 'short' attribute to 'value'
		do
			jni.set_short_field (java_object_id, fid, value)
		end

	set_long_attribute (fid: POINTER; value: INTEGER_64) is
			-- Set a 'short' attribute to 'value'
		do
			jni.set_long_field (java_object_id, fid, value)
		end

invariant
	valid_proxy: java_object_id /= default_pointer

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

