indexing
	
	description: "Access to Java array of booleans. In Java it would %
                 %be declared as 'boolean arr[]'"

class JAVA_BOOLEAN_ARRAY

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
			jarray := c_new_boolean_array (jni.envp, size)
		ensure
			array_ok: jarray /= default_pointer	
		end

	item (index: INTEGER): BOOLEAN is
			-- item at "index"
		require
			valid_index (index)
		do
			Result := c_get_boolean_array_element (jni.envp, jarray, index )					
		end

	put (litem: BOOLEAN; index: INTEGER) is
			-- replace the item at "index"
		require
			valid_index (index)
		do
			c_set_boolean_array_element (jni.envp, jarray, index, litem)
		end

end
