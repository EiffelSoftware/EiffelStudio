indexing
	description: "System's root class";
	note: "Initial version automatically generated"

class
	ROOT_CLASS

inherit

	SHARED_JNI_ENVIRONMENT

creation
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
			j_args.push_int (2)
			j_args.push_string("String test")

			io.put_string ("Calling `my_method' with (2, %"String test%")%N")

				-- Call to the void method referenced by 'fid'
			instance_of_class_test.void_method (fid, j_args)

			fid := instance_of_class_test.field_id ("my_integer", "I")
				-- 'value' contains the value of the field referenced by 'fid'
			value := instance_of_class_test.integer_attribute (fid)

			io.put_string ("Value of `my_integer' after call to `my_method' is " + value.out + "%N")
		end -- make

end -- class ROOT_CLASS

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

