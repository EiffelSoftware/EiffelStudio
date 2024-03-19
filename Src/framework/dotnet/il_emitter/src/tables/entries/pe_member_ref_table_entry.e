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
			same_as
		end

create
	make_with_data

feature {NONE} -- Intialization

	make_with_data (a_parent_index: PE_MEMBER_REF_PARENT; a_name_index: NATURAL_32; a_signature_index: NATURAL_32)
		do
			parent_index := a_parent_index
			create name_index.make_with_index (a_name_index)
			create signature_index.make_with_index (a_signature_index)
		end

feature -- Access

	parent_index: PE_MEMBER_REF_PARENT
			-- "Class"  column in the spec.

	name_index: PE_STRING
			-- index in the string heap.

	signature_index: PE_BLOB
			-- index in the blob heap.

feature -- Status

	token_searching_supported: BOOLEAN = True

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| The MemberRef table shall contain no duplicates, where duplicate rows have the
			--| same Class (parent in this impl), Name, and Signature
		do
			Result := Precursor (e)
				or else (
					e.parent_index.is_equal (parent_index) and then
					e.name_index.is_equal (name_index) and then
					e.signature_index.is_equal (signature_index)
				)
		end

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tmemberref
		end

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write the parent_index to the buffer and update the number
				-- of bytes.
			l_bytes := parent_index.render (a_sizes, a_dest, 0)

				-- Write the name_index to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes)

				-- Write the signature_index to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes + signature_index.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end

	rendering_size (a_sizes: SPECIAL [NATURAL_32]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Get the parent_index to the buffer and update the number
				-- of bytes.
			l_bytes := parent_index.rendering_size (a_sizes)

				-- Get the name_index to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes + name_index.rendering_size (a_sizes)

				-- Get the signature_index to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes + signature_index.rendering_size (a_sizes)

				-- Return the number of bytes readed
			Result := l_bytes
		end

end
