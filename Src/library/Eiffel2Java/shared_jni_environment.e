indexing

	description: "Shared JNI environment. Since one JNI is needed per %
                 %thread we limit Eiffel to having one thread that %
                 %deals with Java."

class SHARED_JNI_ENVIRONMENT

feature

	jni: JNI_ENVIRONMENT is
			-- returns the standard JNI enviroment. It uses the value of
			-- CLASS_PATH environment variable to initialize the JVM
		local
			cpp: POINTER
			class_path: STRING
			jvm: JAVA_VM
			ex: EXCEPTIONS
			exec: EXECUTION_ENVIRONMENT
		once
			create exec
				-- First obtain the value of the CLASSPATH environment 
				-- variable
			class_path := exec.get ("CLASSPATH")
			if class_path = void or else class_path.count = 0 then
				!!ex
				ex.raise ("Can't get CLASSPATH")
			end
			debug ("java")
				io.putstring ("CLASSPATH=")
				io.putstring (class_path)
				io.new_line
			end

				-- Next create the JVM and get the JNI environment
			!!jvm.make
			Result := jvm.create_vm (class_path)
		ensure
			Result /= Void
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

