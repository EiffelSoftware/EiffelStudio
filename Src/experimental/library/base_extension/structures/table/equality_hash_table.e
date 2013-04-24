note
	description: "HASH_TABLE with different is_equal that checks the values."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EQUALITY_HASH_TABLE [G -> detachable ANY, H -> HASHABLE]

obsolete
	"[2013/01/10] Use `{HASH_TABLE}.make_equal'"

inherit
	HASH_TABLE [G, H]
		rename
			make as table_make,
			make_equal as make
		end

create
	make

create {EQUALITY_HASH_TABLE}
	table_make

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
