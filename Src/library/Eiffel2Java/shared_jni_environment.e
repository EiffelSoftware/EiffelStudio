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
			cpp := exec.get ($(("CLASSPATH").to_c))
			if cpp = default_pointer then
				!!ex
				ex.raise ("Can't get CLASSPATH")
			end
			!!class_path.make (100)
			class_path.from_c (cpp)
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
