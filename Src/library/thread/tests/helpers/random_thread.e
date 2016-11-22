note
	description: "[
		Threads creating strings of random length.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RANDOM_THREAD

inherit
	THREAD

create
	make

feature

	execute
		local
			l_random: RANDOM
			i, l_item_count, l_count: INTEGER
		do
			l_item_count := 100_000
			create l_random.set_seed (47)

			from
				i := 1
				l_random.start
			until
				i > 100_000
			loop
				l_count := l_random.item \\ l_item_count
				create string.make (l_count)
				i := i + 1
				l_random.forth
			end
		end

	string: detachable STRING

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
