note
	description: "Summary description for {REPORT_ATTACHMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_ATTACHMENT

create
	make

feature {NONE} -- Initialization

	make (a_id: like id; int: ESA_REPORT_INTERACTION; a_name: like name)
		do
			id := a_id
			interaction := int
			name := a_name
		end

feature -- Access

	id: INTEGER
		-- Attachment ID

	interaction: ESA_REPORT_INTERACTION

	name: READABLE_STRING_32
			-- file name

	blob: detachable READABLE_STRING_8

	bytes_count: INTEGER

feature -- Element change

	set_name (a_name: like name)
		do
			name := a_name
		end

	set_blob (b: like blob)
		do
			blob := b
		end

	set_bytes_count (c: like bytes_count)
		do
			bytes_count := c
		end

end
