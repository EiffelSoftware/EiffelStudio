indexing

	description: "This class provides a mapping between Java and Eiffel objects"

class JAVA_OBJECT_TABLE 

creation
	
	make

feature

	item (jobject: POINTER): JAVA_OBJECT is
			-- find a Eiffel proxy for an Java object
		require
			jobject_not_void: jobject /= default_pointer
		do
			Result := table.item (jobject.hash_code)
		end

	put (object: JAVA_OBJECT) is
			-- Add a new object to the table
		require
			jobject_not_void: (object /= Void) and then (object.java_object_id /= default_pointer)
		local
			it: JAVA_OBJECT
			ex: EXCEPTIONS
		do
			it := table.item (object.java_object_id.hash_code)
			if it = Void then
				table.put (object, object.java_object_id.hash_code)
			elseif (it /= object) then
				!!ex
				ex.raise ("Attempted to insert duplicate Eiffel object")
			end
		ensure
			inserted: table.has (object.java_object_id.hash_code)
		end

feature {NONE}

	make is
			-- create a table for Eiffel proxies of Java object
		do
			!!table.make (511)
		end

	table: HASH_TABLE [JAVA_OBJECT, INTEGER]
			-- table of objects

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

