indexing

	description: "This class is used to initially load the JVM into %
                 %the running program"

class JAVA_VM

inherit

	EXCEPTIONS

creation

	make

feature

	make is 
			-- Create a Java VM
		do
			default_vm_args := get_default_vm_args
		end

	create_vm (class_path: STRING): JNI_ENVIRONMENT is
			-- Create a JVM execution environment and specify a CLASSPATH
		require
			class_path_valid: class_path /= Void
		local
			err: INTEGER
		do
			err := create_jvm ($jvmp, $envp, default_vm_args, $(class_path.to_c))
			if err /= 0 then
				io.putstring ("*** Failed to load JVM=")
				io.putint (err)
				io.putstring ("  *** CLASSPATH=")
				io.putstring (class_path)
				io.new_line
				raise ("failed to load java VM")
			else
				!!Result.make (envp, Current)
				debug ("java")
					io.putstring ("Created a Java VM OK.%N")
				end
			end
		end

	destroy_vm is
			-- destroy the JVM
		local
			err: INTEGER
		do
			err := destroy_jvm ($jvmp)
			if err /= 0 then
				io.putstring ("*** Failed to destroy JVM=")
				io.putint (err)
				io.new_line
			else
				io.putstring ("*** JVM destroyed%N")
			end
		end

	attach_current_thread is
		local
			err: INTEGER
		do
			err := c_attach_current_thread ($jvmp, $envp, default_vm_args)
			if err /= 0 then
				io.putstring ("Could not attach the current thread, err = ")
				io.putint (err)
				io.new_line
			else
				io.putstring ("Current thead attached successfully!!!")
				io.new_line
			end
		end

	detach_current_thread is
		local
			err: INTEGER
		do
			err := c_detach_current_thread ($jvmp, $envp, default_vm_args)
			if err /= 0 then
				io.putstring ("Could not detach the current thread, err = ")
				io.putint (err)
				io.new_line
			else
				io.putstring ("Current thead detached successfully!!!")
				io.new_line
			end
		end

feature {NONE}

	default_vm_args: POINTER
			-- pointer to the default arguments for the JVM

	jvmp: POINTER 
			-- pointer to this JVM

	envp: POINTER
			-- environment pointer

feature {NONE} -- externals

	get_default_vm_args: POINTER is
		external "C"
		end

	create_jvm (jvm: POINTER; env: POINTER; args: POINTER; class_path: POINTER): INTEGER is
		external "C"
		end

	destroy_jvm (jvm: POINTER): INTEGER is
		external "C"
		end

	c_attach_current_thread (jvm: POINTER; env: POINTER; args: POINTER): INTEGER is
		external "C"
		end

	c_detach_current_thread (jvm: POINTER; env: POINTER; args: POINTER): INTEGER is
		external "C"
		end

end
