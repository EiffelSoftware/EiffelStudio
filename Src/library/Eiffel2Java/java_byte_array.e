indexing

	description: "Access to Java array of bytes. Bytes are %
                 %represented as CHARACTER in Eiffel."

class JAVA_BYTE_ARRAY

inherit

	JAVA_ARRAY 

creation
	
	make
	
feature

	make (size: INTEGER ) is
			-- create a new Java array and an Eiffel accessor object
			-- Note: Java arrays are indexed from zero
		require
			size_ok: size > 0		
		do
			jarray := c_new_byte_array (jni.envp, size)
		ensure
			array_ok: jarray /= default_pointer	
		end

	item (index: INTEGER): CHARACTER is
			-- item at "index"
		require
			valid_index (index)
		do
			Result := c_get_byte_array_element (jni.envp, jarray, index )					
		end

	put (litem: CHARACTER; index: INTEGER) is
			-- put new item at "index"
		require
			valid_index (index)
		do
			c_set_byte_array_element (jni.envp, jarray, index, litem)
		end

end
