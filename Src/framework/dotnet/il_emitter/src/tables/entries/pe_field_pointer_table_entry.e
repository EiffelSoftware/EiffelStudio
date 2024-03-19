note
	description: "[
		Object representing The FieldPointer table
		Conceptually, each row in the FieldPointer table targets a Field table row.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_POINTER_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

	DEBUG_OUTPUT

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_field_index: NATURAL_32)
		do
			create field_index.make_with_index (a_field_index)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.field_index = field_index
				)
		end

feature -- Access

	field_index: PE_FIELD_POINTER_INDEX
			-- an index into the Field table

feature -- Status report	

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{FieldPtr} => "
			Result := Result + field_index.debug_output
		end

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tfieldptr
		end

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
			-- <Precursor>
		local
			l_bytes: NATURAL_32
		do
				-- Write the field_index
				-- to the buffer and update the number of bytes.
			l_bytes := field_index.render (a_sizes, a_dest, l_bytes)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	rendering_size (a_sizes: SPECIAL [NATURAL_32]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Get the field_index and
				-- update the number of bytes.

			l_bytes := l_bytes + field_index.rendering_size (a_sizes)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
