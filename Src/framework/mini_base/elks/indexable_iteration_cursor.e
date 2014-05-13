note
	description: "Concrete version of an external iteration cursor for {INDEXABLE}."
	library: "EiffelBase: Library of reusable components for Eiffel."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	INDEXABLE_ITERATION_CURSOR [G]

inherit
	ITERATION_CURSOR [G]

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize cursor using structure.
		do
		end

feature -- Access

	item: G
		do
			check False then
			end
		end

	after: BOOLEAN
		do

		end

	forth
		do
			
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
