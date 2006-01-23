indexing
	description: "This class is used to initially load the JVM into %
                 %the running program"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_VM

create {SHARED_JNI_ENVIRONMENT}
	make

feature {NONE} -- Initialization

	make (class_path: STRING) is 
			-- Create a JVM execution environment and specify a CLASSPATH
		require
			class_path_valid: class_path /= Void
		local
			err: INTEGER
			l_envp, l_jvmp: POINTER
			l_options: ARRAY [JAVA_VM_OPTION]
			l_option: JAVA_VM_OPTION
			l_ex: EXCEPTIONS
		do
			create default_vm_args.make
			default_vm_args.set_version ({JAVA_VM_INIT_ARGS}.Jni_version_1_4)
			
			create l_options.make (1, 1)
			create l_option.make
			l_option.set_option_string ("-Djava.class.path=" + class_path)
			l_options.put (l_option, 1)
			
			default_vm_args.set_options (l_options)
			
				-- Store attribute into local variable as `$' operator is safer on
				-- local variables and not on attributes.
			l_envp := envp
			l_jvmp := jvmp
			err := c_create_jvm ($l_jvmp, $l_envp, default_vm_args.item)
			envp := l_envp
			jvmp := l_jvmp
			
			if err /= 0 then
				debug ("java_vm")
					io.error.putstring ("*** Failed to load JVM=")
					io.error.putint (err)
					io.error.putstring ("  *** CLASSPATH=")
					io.error.putstring (class_path)
					io.error.new_line
				end
				
				create l_ex
				l_ex.raise ("Failed to load java VM")
			else
				create jni.make (Current)
				debug ("java_vm")
					io.error.putstring ("Created a Java VM OK.%N")
				end
			end
		end

feature {SHARED_JNI_ENVIRONMENT} -- Access

	jni: JNI_ENVIRONMENT
			-- Java environment information.

feature {JNI_ENVIRONMENT} -- Access

	envp: POINTER
			-- Environment pointer.

feature -- Disposal

	destroy_vm is
			-- Destroy the JVM
		local
			err: INTEGER
		do
			err := c_destroy_jvm (jvmp)
			if err /= 0 then
				debug ("java_vm")
					io.error.putstring ("*** Failed to destroy JVM=")
					io.error.putint (err)
					io.error.new_line
				end
			end
		end

feature -- Thread

	attach_current_thread is
			-- Attach to current thread of execution.
		local
			err: INTEGER
			l_envp: POINTER
		do
			l_envp := envp
			err := c_attach_current_thread (jvmp, $l_envp, default_vm_args.item)
			envp := l_envp
			if err /= 0 then
				debug ("java_vm")
					io.error.putstring ("Could not attach the current thread, err = ")
					io.error.putint (err)
					io.error.new_line
				end
			else
				debug ("java_vm")
					io.error.putstring ("Current thead attached successfully!!!")
					io.error.new_line
				end
			end
		end

	detach_current_thread is
			-- Detach from current thread of execution.
		local
			err: INTEGER
		do
			err := c_detach_current_thread (jvmp)
			if err /= 0 then
				debug ("java_vm")
					io.error.putstring ("Could not detach the current thread, err = ")
					io.error.putint (err)
					io.error.new_line
				end
			else
				debug ("java_vm")
					io.error.putstring ("Current thead detached successfully!!!")
					io.error.new_line
				end
			end
		end

feature {NONE} -- Implementation

	default_vm_args: JAVA_VM_INIT_ARGS
			-- Pointer to default arguments for JVM.

	jvmp: POINTER 
			-- Pointer to current JVM.

feature {NONE} -- externals

	c_create_jvm (jvm: POINTER; env: POINTER; args: POINTER): INTEGER is
		external
			"C signature (JavaVM **, void **, void *): EIF_INTEGER use %"jni.h%""
		alias
			"JNI_CreateJavaVM"
		end

	c_destroy_jvm (jvm: POINTER): INTEGER is
		external
			"C++ JavaVM use %"jni.h%""
		alias
			"DestroyJavaVM"
		end

	c_attach_current_thread (jvm: POINTER; env: POINTER; args: POINTER): INTEGER is
		external
			"C++ JavaVM signature (void **, void *): EIF_INTEGER use %"jni.h%""
		alias
			"AttachCurrentThread"
		end

	c_detach_current_thread (jvm: POINTER): INTEGER is
		external
			"C++ JavaVM use %"jni.h%""
		alias
			"DetachCurrentThread"
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

