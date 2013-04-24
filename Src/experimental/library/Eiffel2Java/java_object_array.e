note
	description: "Access to array of Java objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_OBJECT_ARRAY

inherit
	JAVA_ARRAY

create
	make,
	make_from_pointer

feature -- Initialization

	make (size: INTEGER; element_name: STRING)
			-- create a new Java array and an Eiffel accessor object
			-- Note: Java arrays are indexed from zero
		require
			size_ok: size > 0
			element_ok: element_name /= Void
			element_exists: jni.find_class (element_name) /= Void
		local
			element_type: detachable JAVA_CLASS
			l_jarray: like jarray
		do
			element_type := jni.find_class (element_name)
			check element_type_not_void: element_type /= Void end -- Implied by the precondition.
			l_jarray := jni.new_object_array (size, element_type.java_class_id, default_pointer)
			check l_jarray_not_default: l_jarray /= default_pointer end
			make_from_pointer (l_jarray)
		end

feature -- Access

	item (index: INTEGER): detachable JAVA_OBJECT
			-- object at index-th position
		require
			valid_index: valid_index (index)
		local
			jo: POINTER
		do
			jo := jni.get_object_array_element (jarray, index)
				-- Find the correspponding Eiffel object or create a new one
			if jo /= default_pointer then
				Result := jni.java_object_table.item (jo)
				if Result = Void then
					create Result.make_from_pointer (jo)
				end
			end
		end

feature -- Element change

	put (an_item: JAVA_OBJECT; index: INTEGER)
			-- put an object at index
		require
			an_item_not_void: an_item /= Void
			valid_index: valid_index (index)
		do
			jni.set_object_array_element (jarray, index, an_item.java_object_id)
		ensure
			inserted: equal (item (index), an_item)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end

