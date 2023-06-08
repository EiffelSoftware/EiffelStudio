note
	description: "Summary description for {PE_DECL_SECURITY_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_DECL_SECURITY_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_action: NATURAL_16; a_parent: PE_DECL_SECURITY; a_permission_set: NATURAL)
		do
			action := a_action
			parent := a_parent
			create permission_set.make_with_index (a_permission_set)
		end

feature -- Access

	action: NATURAL_16
			-- Defined as a word two bytes.

	parent: PE_DECL_SECURITY

	permission_set: PE_BLOB

feature -- Status report 

	token_searching_supported: BOOLEAN = False

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tDeclSecurity.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write action to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, action, 0)

				-- Intialize the number of bytes written
			l_bytes := 2

				-- Write parent and premission set to the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + permission_set.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the action (from a_src)  to action
			action := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, 0)

				-- Intialize the number of bytes.
			l_bytes := 2

				-- Read parent and premission_set from the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + permission_set.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed
			Result := l_bytes
		end

end
