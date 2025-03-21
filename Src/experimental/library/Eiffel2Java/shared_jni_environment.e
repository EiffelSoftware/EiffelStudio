note
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

	jni: JNI_ENVIRONMENT
			-- Standard JNI enviroment. It uses value of
			-- CLASS_PATH environment variable to initialize JVM.
		local
			class_path: detachable STRING
			jvm: JAVA_VM
			exec: EXECUTION_ENVIRONMENT
		once
			create exec
				-- First obtain the value of the CLASSPATH environment
				-- variable
			if attached exec.item ("CLASSPATH") as l_item then
				class_path := l_item.as_string_8
			end
			if class_path = Void then
					-- Default to current directory
				class_path := "."
			end
			debug ("java_vm")
				io.error.putstring ("CLASSPATH=")
				io.error.putstring (class_path)
				io.error.new_line
			end

				-- Next create the JVM and the JNI environment
			create jvm.make (class_path)
			create Result.make (jvm)
			debug ("java_vm")
				io.error.putstring ("Created a Java VM OK.%N")
			end
		ensure
			jni_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end

