note
	description: "Summary description for {CMS_MOTION_LIST_ATTACHMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_LIST_ATTACHMENT

inherit

	CMS_IDEABLE

feature -- Access

	id: INTEGER_64
			-- Attachment ID

	interaction: INTEGER
			-- Associated Wish list interaction

	name: detachable READABLE_STRING_32
			-- file name

	blob: detachable READABLE_STRING_8
			-- file content.

	bytes_count: INTEGER
			-- size.

feature -- Element change

	set_id (a_id: INTEGER_64)
		do
			id := a_id
		end

	set_name (a_name: like name)
			-- Set `name' to `a_name'
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_blob (b: like blob)
			-- Set `blob' to `b'
		do
			blob := b
		ensure
			blob_set: blob = b
		end

	set_bytes_count (c: like bytes_count)
			-- Set `bytes_count' to `c'
		do
			bytes_count := c
		ensure
			bytes_count_set: bytes_count = c
		end

end
