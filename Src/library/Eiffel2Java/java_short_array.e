indexing

	description: "Access to Java array of shorts (in Eiffel shorts %
                 %are respresente as INTEGER)"

class JAVA_SHORT_ARRAY

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
			jarray := c_new_short_array (jni.envp, size)
		ensure
			array_ok: jarray /= default_pointer	
		end

	item (index: INTEGER): INTEGER is
			-- item at "index"
		require
			valid_index (index)
		do
			Result := c_get_short_array_element (jni.envp, jarray, index -1)					
		end

	put (litem: INTEGER; index: INTEGER) is
			-- put item at "index"
		require
			valid_index (index)
		do
			c_set_short_array_element (jni.envp, jarray, index-1, litem)
		end

end
