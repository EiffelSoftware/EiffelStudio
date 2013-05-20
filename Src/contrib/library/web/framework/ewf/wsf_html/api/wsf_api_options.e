note
	description: "Summary description for {WSF_API_OPTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_API_OPTIONS

inherit
	TABLE_ITERABLE [detachable ANY, STRING]

create
	make,
	make_from_manifest

convert
	make_from_manifest ({ ARRAY [TUPLE [key: STRING; value: detachable ANY]],
						  ARRAY [TUPLE [STRING_8, ARRAY [TUPLE [STRING_8, STRING_32]]]],
						  ARRAY [TUPLE [STRING_8, ARRAY [TUPLE [STRING_8, STRING_8]]]]
						})

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			create table.make (n)
		end

	make_from_manifest (lst: ARRAY [TUPLE [key: STRING; value: detachable ANY]])
		do
			make (lst.count)
			across
				lst as c
			loop
				force (c.item.value, c.item.key)
			end
		end

feature -- Access

	item (k: STRING): detachable ANY
		do
			Result := table.item (k)
		end

	force (v: detachable ANY; k: STRING)
		do
			table.force (v, k)
		end

	boolean_item (k: STRING; dft: BOOLEAN): BOOLEAN
		do
			if attached {BOOLEAN} item (k) as b then
				Result := b
			else
				Result := dft
			end
		end

	string_general_item (k: STRING): detachable READABLE_STRING_GENERAL
		do
			if attached {READABLE_STRING_GENERAL} item (k) as s then
				Result := s
			end
		end

	string_item, string_8_item (k: STRING): detachable READABLE_STRING_8
		do
			if attached {READABLE_STRING_8} item (k) as s then
				Result := s
			end
		end

	table: HASH_TABLE [detachable ANY, STRING]

feature -- Change

	import (a_opts: WSF_API_OPTIONS)
		do
			across
				a_opts as c
			loop
				force (c.item, c.key)
			end
		end

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [detachable ANY, STRING]
			-- Fresh cursor associated with current structure
		do
			Result := table.new_cursor
		end

invariant

end
