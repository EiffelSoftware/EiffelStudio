indexing
	description: "Shared JNI environment. Since one JNI is needed per %
                 %thread we limit Eiffel to having one thread that %
                 %deals with Java."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_JNI_ENVIRONMENT

feature -- Access

	jni: JNI_ENVIRONMENT is
			-- Standard JNI enviroment. It uses value of
			-- CLASS_PATH environment variable to initialize JVM.
		local
			class_path: STRING
			jvm: JAVA_VM
			exec: EXECUTION_ENVIRONMENT
		once
			create exec
				-- First obtain the value of the CLASSPATH environment 
				-- variable
			class_path := exec.get ("CLASSPATH")
			if class_path = Void then
					-- Default to current directory
				class_path := "."
			end
			debug ("java_vm")
				io.error.putstring ("CLASSPATH=")
				io.error.putstring (class_path)
				io.error.new_line
			end

				-- Next create the JVM and get the JNI environment
			create jvm.make (class_path)
			Result := jvm.jni
		ensure
			jni_not_void: Result /= Void
		end

end

--|----------------------------------------------------------------
--| Eiffel2Java: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

