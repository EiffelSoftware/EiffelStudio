note
	description: "TUPLE with different is_equal that checks the values"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	EQUALITY_TUPLE [G -> TUPLE create default_create end]

inherit
	ANY
		redefine
			default_create,
			is_equal
		end

create
	default_create,
	make

convert
	make ({G, attached G})

feature {NONE} -- Initialization

	default_create
			-- Process instances of classes with no creation clause.
		do
			Precursor {ANY}
			create item
		end

	make (a_tuple: G)
			-- Initialize wrapper with implementation item
		require
			not_void: a_tuple /= Void
		do
			item := a_tuple
		ensure
			item_set: item = a_tuple
		end

feature -- Access

	item: attached G
			-- Implementation item

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does table contain the same information as `other'?
		local
			l_item, l_other: detachable ANY
			l_count, i: INTEGER
		do
			l_count := item.count
			Result := l_count = other.item.count
			if Result then
				from i := 1 until i > l_count loop
					l_item := item.item (i)
					l_other := other.item [i]
					Result := equal (l_item, l_other)
					i := i + 1
				end
			end
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
