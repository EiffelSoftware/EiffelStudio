indexing
	description: "Text Paragraph"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	PARAGRAPH

inherit
	B_345_TREE [EDITOR_LINE]
		rename
			prepend_data as prepend_line,
			append_data as append_line,
			first_data as first_line,
			last_data as last_line
		end

create
	make

feature -- Access

	first_line_number: INTEGER is 1

feature -- Basic Operations

--	list is
--		local
--			cl: EDITOR_LINE
--		do
--			from
--				cl := first_line
--			until
--				cl = last_line
--			loop
--				cl.list
--				cl := cl.next
--			end
--		end

end -- PARAGRAPH
