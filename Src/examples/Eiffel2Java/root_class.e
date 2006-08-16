indexing
	description: "System's root class"
	legal: "See notice at end of class."
	status: "See notice at end of class.";

class
	ROOT_CLASS

inherit
	SHARED_JNI_ENVIRONMENT

create
	make

feature -- Creation

	make is
		local
			class_test: JAVA_CLASS
			instance_of_class_test: JAVA_OBJECT
			fid: POINTER
			value: INTEGER
			j_args: JAVA_ARGS
		do
				--| Creation of the Java object
			class_test := jni.find_class ("test")

			io.put_string ("Creating instance of class `test'%N")
			create instance_of_class_test.create_instance (class_test, "()V", Void)

				
				--| Access to a public attribute
				-- 'fid' contains the id of the field 'my_integer'
			fid := instance_of_class_test.field_id ("my_integer", "I")
				-- 'value' contains the value of the field referenced by 'fid'
			value := instance_of_class_test.integer_attribute (fid)

			io.put_string ("Value of `my_integer' is " + value.out + "%N")

				--| Access to a static attribute using directly the JAVA_CLASS
			fid := class_test.field_id ("my_static_integer", "I")
			value := class_test.integer_attribute (fid)

			io.put_string ("Value of `my_static_integer' is " + value.out + "%N")

				--| Access to the method 'my_method'
				-- Get the id of 'my_method'
			fid := instance_of_class_test.method_id ("my_method", "(ILjava/lang/String;)V")

				-- Create the set of arguments for 'my_method'
			create j_args.make(2)
			j_args.put_int (2, 1)
			j_args.put_string ("String test", 2)

			io.put_string ("Calling `my_method' with (2, %"String test%")%N")

				-- Call to the void method referenced by 'fid'
			instance_of_class_test.void_method (fid, j_args)

			fid := instance_of_class_test.field_id ("my_integer", "I")
				-- 'value' contains the value of the field referenced by 'fid'
			value := instance_of_class_test.integer_attribute (fid)

			io.put_string ("Value of `my_integer' after call to `my_method' is " + value.out + "%N")

				--| Access to a static attribute using directly the JAVA_CLASS
			fid := class_test.field_id ("my_static_integer", "I")
			value := class_test.integer_attribute (fid)

			io.put_string ("Value of `my_static_integer' after call to `my_method' is " + value.out + "%N")
			
			jni.destroy_vm
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


end -- class ROOT_CLASS

