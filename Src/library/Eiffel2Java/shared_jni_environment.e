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
		once
			-- First obtain the value of the CLASSPATH environment 
			-- variable
			cpp := getenv ($(("CLASSPATH").to_c))
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

			io.putstring ("#############################%N")
			io.putstring ("# Access to a once feature%N")
			io.putstring ("#############################%N")

			Result := jvm.create_vm (class_path)
		ensure
			Result /= Void
		end

feature {NONE}

	getenv (str: POINTER): POINTER is
		external "C"
		end

end
