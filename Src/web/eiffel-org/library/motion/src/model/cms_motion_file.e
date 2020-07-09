note
	description: "Summary description for {CMS_MOTION_FILE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_FILE

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_32; a_size: INTEGER_64; a_content: READABLE_STRING_8)
			-- Create an object instance.
			-- Set `name' to `a_name'
			-- Set `size' to `a_size'
			-- Set `content' to `a_content'.
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

	id: INTEGER_64
		-- ID related to Motion list item.

	name: READABLE_STRING_32
		-- File name.

	size: INTEGER_64
		-- Size of the current size.	

	content: READABLE_STRING_8
		-- String representation of the current file.

feature -- Element Change

	set_id (a_id: like id)
			-- Set `id' with `a_id'.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end
end
