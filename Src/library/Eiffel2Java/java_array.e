indexing
	
	description: "parent of all Java array classes that contains the %
                 %common routines to all arrays. Not to be used directly,%
                 % instead use the class with array of specific type."

class JAVA_ARRAY

inherit

	SHARED_JNI_ENVIRONMENT
	JAVA_EXTERNALS

creation {NONE} -- prevent people from creating instances of this type

	make_from_pointer

feature

	make_from_pointer (p: POINTER) is
			-- make an Eiffel array accessor out of a pointer to a 
			-- Java array
		require
			valid: p /= default_pointer
		do
			jarray := p
		end

	count : INTEGER is
			-- number of cells in this array
		do
			Result := c_get_array_length (jni.envp,jarray)
		end

	valid_index (index: INTEGER): BOOLEAN is
			-- index is valid if it's between 0..count-1
		do
			Result := (index >= 0) and (index < count)
		end

feature {JAVA_ARGS}

	jarray: POINTER

invariant

	jarray /= default_pointer

end  --class






