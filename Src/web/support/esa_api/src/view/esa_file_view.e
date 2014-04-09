note
	description: "Summary description for {ESA_FILE_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_FILE_VIEW

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_32; a_size: INTEGER; a_content: STRING)
		do
			name := a_name
			size := a_size
			content := a_content
		ensure
			name_set: name = a_name
			size_set: size = a_size
			content_set: content = a_content
		end

feature -- Access

	id: INTEGER
		-- Unique file id.

	name: READABLE_STRING_32
		-- File name.

	size: INTEGER
		-- Size of the current size.	

	content: STRING
		-- String representation of the current file.

feature -- Element Change

	set_id (a_id: like id)
			-- Set `id' with `a_id'
		do
			id := a_id
		ensure
			id_set: id = a_id
		end
end
