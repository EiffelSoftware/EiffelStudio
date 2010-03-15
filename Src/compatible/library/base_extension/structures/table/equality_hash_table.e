note
	description: "HASH_TABLE with different is_equal that checks the values."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EQUALITY_HASH_TABLE [G, H -> HASHABLE]

inherit
	HASH_TABLE [G, H]
		redefine
			is_equal
		end

create
	make

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does table contain the same information as `other'?
		local
			a, b: like Current
		do
			a := Current
			b := other

			from
				Result := a.count = b.count
				a.start
			until
				not Result or a.after
			loop
				Result := equal (a.item_for_iteration, b.item (a.key_for_iteration))
				a.forth
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
