indexing

	description: "Access to array of Java objects"

class JAVA_OBJECT_ARRAY

inherit

	JAVA_ARRAY

creation
	
	make
	
feature

	make (size: INTEGER; element_name: STRING) is
			-- create a new Java array and an Eiffel accessor object
			-- Note: Java arrays are indexed from zero
		require
			size_ok: size > 0
			element_ok: element_name /= Void
		local
			element_type : JAVA_CLASS
		do
			element_type := jni.find_class (element_name)
			jarray := c_new_object_array (jni.envp, size, element_type.java_class_id, default_pointer)
		ensure
			array_ok: jarray /= default_pointer	
		end

	item (index: INTEGER): JAVA_OBJECT is
			-- object at index-th position
		require
			valid_index (index)
		local
			jo: POINTER		   
		do
			jo := c_get_object_array_element (jni.envp, jarray, index)
			-- find the correspponding Eiffel object or create a new one
			if jo /= default_pointer then
				Result := jni.java_object_table.item (jo.hash_code)
				if Result = Void then
					!!Result.make_from_pointer (jo)
				end
			end
		end

	put (litem: JAVA_OBJECT; index: INTEGER) is
			-- put an object at index
		require
			valid_index (index)
		do
			c_set_object_array_element (jni.envp, jarray, index, litem.java_object_id)
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

