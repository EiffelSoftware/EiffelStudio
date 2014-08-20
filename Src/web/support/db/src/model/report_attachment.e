note
	description: "Object that represent reports attachements"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_ATTACHMENT

create
	make

feature {NONE} -- Initialization

	make (a_id: like id; int: REPORT_INTERACTION; a_name: like name)
			-- Create an object instance with
			-- Set `id' to `a_id'
			-- Set `interaction' to `int'
			-- Set `name' to `a_name'
		do
			id := a_id
			interaction := int
			name := a_name
		ensure
			id_set: id = a_id
			interaction_set: interaction = int
			name_set: name = a_name
		end

feature -- Access

	id: INTEGER
			-- Attachment ID

	interaction: REPORT_INTERACTION
			-- Associated Report Interaction.

	name: READABLE_STRING_32
			-- file name

	blob: detachable READABLE_STRING_8
			-- file content.

	bytes_count: INTEGER
			-- size.

feature -- Element change

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
