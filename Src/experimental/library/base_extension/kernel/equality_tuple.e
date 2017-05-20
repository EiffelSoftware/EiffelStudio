note
	description: "TUPLE with different is_equal that checks the values."

class
	EQUALITY_TUPLE [G -> TUPLE]

obsolete "Use TUPLE instead and call {TUPLE}.compare_objects. [2014-Jan-31]"

inherit
	ANY
		redefine
			is_equal
		end

create
	make

convert
	make ({G})

feature {NONE} -- Initialization

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

	item: G
			-- Implementation item

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does table contain the same information as `other'?
		local
			l_count, i: INTEGER
		do
			l_count := item.count
			Result := l_count = other.item.count
			if Result then
				from i := 1 until not Result or else i > l_count loop
					Result := item.item (i) ~ other.item [i]
					i := i + 1
				end
			end
		end

note
	date: "$Date$";
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
