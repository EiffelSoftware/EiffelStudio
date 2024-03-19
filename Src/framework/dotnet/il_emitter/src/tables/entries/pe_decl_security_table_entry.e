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

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tDeclSecurity
		end

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write action to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_natural_16 (a_dest, action, 0)

				-- Intialize the number of bytes written
			l_bytes := 2

				-- Write parent and premission set to the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + permission_set.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end

	rendering_size (a_sizes: SPECIAL [NATURAL_32]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Intialize the number of bytes.
			l_bytes := 2

				-- Read parent and premission_set from the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.rendering_size (a_sizes)
			l_bytes := l_bytes + permission_set.rendering_size (a_sizes)

				-- Return the number of bytes readed
			Result := l_bytes
		end

end
