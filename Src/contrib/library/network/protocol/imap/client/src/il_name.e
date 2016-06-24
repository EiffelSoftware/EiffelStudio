note
	description: "A mailbox name"
	author: "Basile Maret"
	EIS: "name=LIST command", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-6.3.8"
	EIS: "name=LIST response", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7.2.2"
	EIS: "name=LSUB command", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-6.3.9"
	EIS: "name=LSUB response", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7.2.3"

class
	IL_NAME

create
	make_with_raw_path

feature {NONE} -- Initialization

	make_with_raw_path (a_raw_path: STRING)
			-- Create a new name with `a_raw_path'
		require
			a_raw_path_not_empty: a_raw_path /= Void and then not a_raw_path.is_empty
		do
			create name.make_empty
			raw_path := a_raw_path
			create {LINKED_LIST [STRING]} path.make
			create {LINKED_LIST [STRING]} attributes.make
		end

feature -- Access

	name: STRING
			-- The name of the mailbox without the path

	raw_path: STRING
			-- The name of the mailbox with the path as received in the server response

	path: LIST [STRING]
			-- The list of mailbox names making the path in which the mailbox is

	hierarchy_delimiter: CHARACTER
			-- The character used to delimit the mailbox names in the raw_path

	attributes: LIST [STRING]
			-- A list of the attributes of the mailbox

feature -- Basic Operations

	set_name (a_name: STRING)
			-- Set `name' to `a_name'
		require
			name_not_empty: a_name /= Void and then not a_name.is_empty
		do
			name := a_name
		end

	set_hierarchy_delimiter (a_hierarchy_delimiter: CHARACTER)
			-- Set `hierarchy_delimiter' to `a_hierarchy_delimiter'
		do
			hierarchy_delimiter := a_hierarchy_delimiter
		end

	add_path_level (a_folder_name: STRING)
			-- Add `a_folder_name' to the list `path'
		require
			a_folder_name_not_empty: a_folder_name /= Void and then not a_folder_name.is_empty
		do
			path.extend (a_folder_name)
		end

	add_attribute (a_attribute: STRING)
			-- Add `a_attribute' to `attributes'
		require
			a_attribute_not_empty: a_attribute /= Void and then not a_attribute.is_empty
		do
			attributes.extend (a_attribute)
		end

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
