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
			ex: EXCEPTIONS
			exec: EXECUTION_ENVIRONMENT
		once
			create exec
				-- First obtain the value of the CLASSPATH environment 
				-- variable
			class_path := exec.get ("CLASSPATH")
			if class_path = Void then
				create ex
				ex.raise ("Can't get CLASSPATH")
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

