note
	description: "An external iteration for {NS_ARRAY} to allow iteration in across loops."

class NS_ARRAY_ITERATION_CURSOR [T -> detachable NS_OBJECT create share_from_pointer end]

inherit

	ITERATION_CURSOR [detachable T]

create {NS_ARRAY}

	make

feature {NONE} -- Creation

	make (t: NS_ARRAY [T])
			-- Initialize the cursor with a target `t`
		do
			target := t
		ensure
			target_set: target = t
			is_started: index = 0
		end

feature -- Access

	item: detachable T
			-- <Precursor>
		do
			Result := target [index]
		end

feature -- Status report	

	after: BOOLEAN
			-- <Precursor>
		do
			Result := index >= target.count
		end

feature -- Cursor movement

	forth
			-- <Precursor>
		do
			index := index + 1
		end

feature {NONE} -- Access

	target: NS_ARRAY [T]
			-- The structure to iterate over.

	index: like {NS_ARRAY [T]}.ns_uinteger
			-- Current iteration index.

;note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
