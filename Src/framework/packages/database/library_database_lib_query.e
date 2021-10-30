note
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_DATABASE_LIB_QUERY

inherit
	LIBRARY_DATABASE_QUERY

create
	make

feature {NONE} -- Initialization

	make (db: LIBRARY_DATABASE; a_lib_pattern: READABLE_STRING_32)
		do
			database := db
			create items.make (0)
			pattern := a_lib_pattern
		end

feature -- Execution

	execute
		local
			l_pattern: READABLE_STRING_32
			l_info: detachable LIBRARY_INFO
			l_items: like items
			k: KMP_WILD
			l_empty: ARRAY [READABLE_STRING_32]
		do
			l_pattern := pattern
			l_items := items
			l_items.wipe_out

			pattern_has_wildchar := l_pattern.has ('*') or l_pattern.has ('?')
			create l_empty.make_empty

			if pattern_has_wildchar then
				create k.make (l_pattern, "_")
				k.disable_case_sensitive
				across
					database.items as ic
				loop
					l_info := ic
					k.set_text (l_info.name)
					if k.pattern_matches then
						l_items.force (l_empty, l_info)
					end
				end
			else
				across
					database.items as ic
				loop
					l_info := ic
					if l_pattern.is_case_insensitive_equal (l_info.name) then
						l_items.force (l_empty, l_info)
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
