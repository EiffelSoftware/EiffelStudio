indexing
	description: "Shared JNI environment. Since one JNI is needed per %
                 %thread we limit Eiffel to having one thread that %
                 %deals with Java."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

