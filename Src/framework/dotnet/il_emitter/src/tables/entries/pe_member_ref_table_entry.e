note
	description: "[
			Object representing he MemberRef table combines two sorts of references, to Methods and to Fields of a class, known as
			‘MethodRef’ and ‘FieldRef’, respectively
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=MemberRef", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=258", "protocol=uri"

class
	PE_MEMBER_REF_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
		end

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
			-- class  column in the spec.

	name_index: PE_STRING
			-- index in the string heap.

	signature_index: PE_BLOB
			-- index in the blob heap.

feature -- Status

	token_from_tables (tables: MD_TABLES): NATURAL_64
			-- If Current was already defined in `tables` return the associated token.
		local
			n: NATURAL_64
		do
			n := 0
			across
				tables as i
			until
				Result /= {NATURAL_64} 0
			loop
				n := n + 1
				if
					attached {like Current} i as e and then
					e.parent_index.is_equal (parent_index) and then
					e.name_index.is_equal (name_index) and then
					e.signature_index.is_equal (signature_index)
				then
					Result := n
				end
			end
		end

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tmemberref.to_integer_32
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
