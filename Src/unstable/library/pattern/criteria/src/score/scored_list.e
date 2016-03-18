note
	description: "Summary description for {SCORED_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	SCORED_LIST [G]

--inherit
--	ARRAYED_LIST [G]
--		redefine
--			make
--		end

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
--			Precursor (n)
			create scores.make (n)
		end


feature -- Access

	scores: ARRAYED_LIST [REAL]

feature -- Element change

--	put (a_item: G; a_score: REAL)
--		local
--			i: INTEGER
--		do
--			extend (a_item)
--			scores.extend (a_score)
--		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
