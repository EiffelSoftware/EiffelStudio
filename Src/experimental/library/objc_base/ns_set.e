note
	description: "Wrapper around {NS_SET}."
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SET [G -> detachable NS_OBJECT create share_from_pointer end]

inherit
	NS_OBJECT
		rename
			item as object_item
		end

create
	make_from_pointer,
	share_from_pointer

feature -- Access

	to_array: NS_ARRAY [detachable G]
			-- Current list of item
		require
			exists: exists
		do
			create Result.share_from_pointer (c_all_objects (object_item))
		end

	item: detachable G
			-- Any item of Current
		require
			exists: exists
		local
			l_object: POINTER
		do
			l_object := c_any_object (object_item)
			if l_object /= default_pointer then
				create Result.share_from_pointer (l_object)
			end
		end

	linear_representation: ARRAYED_LIST [detachable G]
			-- Elements of Current
		require
			exists: exists
		local
			l_array: like to_array
			i, nb: like ns_uinteger
		do
			create Result.make (count.to_integer_32)
			from
				l_array := to_array
				nb := count
			until
				i = nb
			loop
				Result.extend (l_array.item (i))
				i := i + 1
			end
		end

feature -- Measurements

	count: like ns_uinteger
		require
			exists: exists
		do
			Result := c_count (object_item)
		end

feature {NONE} -- Externals

	c_all_objects (a_set_ptr: POINTER): POINTER
		external
			"C inline use <Foundation/NSSet.h>"
		alias
			"return [(NSSet *) $a_set_ptr allObjects];"
		end

	c_any_object (a_set_ptr: POINTER): POINTER
		external
			"C inline use <Foundation/NSSet.h>"
		alias
			"return [(NSSet *) $a_set_ptr anyObject];"
		end

	c_count (a_set_ptr: POINTER): like ns_uinteger
		external
			"C inline use <Foundation/NSSet.h>"
		alias
			"return [(NSSet *) $a_set_ptr count];"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
