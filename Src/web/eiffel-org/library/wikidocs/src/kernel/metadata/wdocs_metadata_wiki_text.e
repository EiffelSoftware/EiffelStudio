note
	description: "Summary description for {WDOCS_METADATA_WIKI_TEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_METADATA_WIKI_TEXT

inherit
	WDOCS_METADATA_WIKI

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (str: READABLE_STRING_8)
		do
			text := str
		end

	text: READABLE_STRING_8

feature -- Status report

	exists: BOOLEAN
			-- Is metadata file exists?
		do
			Result := True
		end

feature {NONE} -- Implementation

	parse (a_items: STRING_TABLE [READABLE_STRING_32]; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL])
		local
			n: INTEGER
			l_line: STRING_8
			i,j: INTEGER
		do
			is_parsing_done := False
			from
				i := 1
				n := text.count
			until
				i > n or is_parsing_done
			loop
				j := text.index_of ('%N', i)
				if j > 0 then
					l_line := text.substring (i, j - 1)
					i := j + 1
				else
					l_line := text.substring (i, n)
					i := n + 1
				end
				parse_line (l_line, a_items, a_restricted_names)
			end
		end

end
