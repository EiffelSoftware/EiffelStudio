indexing

	description: "Holds information abouy JNI environment. %
                 %Potentially many JNI environments can exists at once,%
                 % but more than one was never tested"

class JNI_ENVIRONMENT

inherit

	JAVA_EXTERNALS

creation {JAVA_VM}

	make

feature

	find_class (name: STRING): JAVA_CLASS is
			-- Load in the Java class with the given name
		require
			name_valid: name /= Void
		local
			clsp: POINTER
		do
			clsp := jni_find_class (envp, $(name.to_c));
			Result := find_class_by_pointer (clsp)
		end

	find_class_by_pointer (classp: POINTER): JAVA_CLASS is
			-- Get a Java class Eiffel proxy given pointer to the 
			-- Java class. Create a new one if needed
		require
			classp /= default_pointer
		do
			Result := java_class_table.item (classp.hash_code)
			if Result = Void then
				if classp /= default_pointer then
					!!Result.make (classp)
					java_class_table.put (Result, classp.hash_code)
				end
			end
		end

	find_class_pointer (name: STRING): POINTER is
			-- find class pointer only (used during creation in descendants)
		local
			cls: JAVA_CLASS
		do
			Result := jni_find_class (envp, $(name.to_c));
		end

	destroy_vm is
			-- destroy the JVM and reclaim its ressources
			-- !! can only be used in the main thread when it is the
			-- last remaining thread
		do	
			jvm.destroy_vm
		end

feature -- Exception mechanism

	check_for_exceptions is
			-- Check if a Java exception occurred, raise Java exception occurred
		do
			c_check_for_exceptions (envp)
		end

	throw_java_exception (jthrowable: JAVA_OBJECT) is
			-- throw the exception 'jthrowable' (must be a java.lang.Throwable object)
		do
			c_throw_java_exception (envp, $jthrowable)
		end

	throw_custom_exception (jclass: JAVA_CLASS; msg: STRING) is
			-- Constructs an exception object from the specified class 'jclass'
			-- with the message specified by 'msg' and causes that exception 
			-- to be thrown. 
		do
			c_throw_custom_exception (envp, jclass.java_class_id, $(msg.to_c))
		end

feature  -- Thread Mechanism

	attach_current_thread is
		do
			jvm.attach_current_thread
		end

	detach_current_thread is
		do
			jvm.detach_current_thread
		end

feature {JAVA_CLASS, JAVA_OBJECT, JAVA_ARGS, JAVA_ARRAY}

	envp: POINTER
			-- pointer to the JNI environment, needed for all 
			-- external calls

	jvm: JAVA_VM
			-- JVM that goes with the JNI enviroment

	java_class_table: HASH_TABLE [JAVA_CLASS, INTEGER]
			-- table of classes we have loaded - keyed by java_class_id

	java_object_table: HASH_TABLE [JAVA_OBJECT, INTEGER]
			-- table of Eiffel objects representing Java objects

feature {NONE}

	make (env: POINTER; vm: JAVA_VM) is
			-- create new JNI environment
		require
			env_valid: env /= default_pointer
		do
			envp := env
			jvm := vm
			!!java_class_table.make (101)
			!!java_object_table.make (127)
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

