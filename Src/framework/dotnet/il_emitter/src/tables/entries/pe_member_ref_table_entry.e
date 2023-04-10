note
	description: "[
		Object representing he MemberRef table combines two sorts of references, to Methods and to Fields of a class, known as
		‘MethodRef’ and ‘FieldRef’, respectively
		]"
	date: "$Date$"
	revision: "$Revision$"
	see: "II.22.25 MemberRef : 0x0A "

class
	PE_MEMBER_REF_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Intialization	

	make_with_data (a_parent_index: PE_MEMBER_REF_PARENT; a_name_index: NATURAL_64; a_signature_index: NATURAL_64)
		do
			parent_index := a_parent_index
			create name_index.make_with_index (a_name_index)
			create signature_index.make_with_index (a_signature_index)
		end

feature -- Access

	parent_index: PE_MEMBER_REF_PARENT
		-- class  column in the spec

	name_index: PE_STRING

	signature_index: PE_BLOB

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tmemberref.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write the parent_index to the buffer and update the number
				-- of bytes.
			l_bytes := parent_index.render (a_sizes, a_dest, 0)

				-- Write the name_index to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Write the signature_index to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes + signature_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Get the parent_index to the buffer and update the number
				-- of bytes.
			l_bytes := parent_index.get (a_sizes, a_src, 0)

				-- Get the name_index to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes + name_index.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Get the signature_index to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes + signature_index.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed
			Result := l_bytes
		end


end
