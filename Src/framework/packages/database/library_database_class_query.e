note
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_DATABASE_CLASS_QUERY

inherit
	LIBRARY_DATABASE_QUERY

create
	make

feature {NONE} -- Initialization

	make (db: LIBRARY_DATABASE; a_class_pattern: READABLE_STRING_32)
		do
			database := db
			create items.make (0)
			pattern := a_class_pattern
		end

feature -- Execution

	execute
			-- Execute Current query `pattern' on `database', and store results into `items'.
		local
			l_pattern: READABLE_STRING_32
			l_info: detachable LIBRARY_INFO
			l_items: like items
			k: KMP_WILD
			lst: detachable ARRAYED_LIST [READABLE_STRING_32]
		do
			l_pattern := pattern
			l_items := items
			l_items.wipe_out

			pattern_has_wildchar := l_pattern.has ('*') or l_pattern.has ('?')

			if pattern_has_wildchar then
				create k.make (l_pattern, "_")
				k.disable_case_sensitive
				across
					database.items as ic
				loop
					l_info := ic
					lst := Void
					across
						l_info.classes as ic_classes
					loop
						k.set_text (ic_classes)
						if k.pattern_matches then
							if lst = Void then
								create lst.make (1)
								l_items.force (lst, ic)
							end
							lst.force (ic_classes)
						end
					end
				end
			else
				across
					database.items as ic
				loop
					l_info := ic
					across
						l_info.classes as ic_classes
					until
						l_info = Void
					loop
						if l_pattern.is_case_insensitive_equal (ic_classes) then
							l_items.force (<<ic_classes>>, ic)
							l_info := Void -- Exit this loop.
						end
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
