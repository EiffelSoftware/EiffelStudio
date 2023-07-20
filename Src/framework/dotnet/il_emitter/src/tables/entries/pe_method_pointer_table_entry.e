note
	description: "[
		Object representing The MethodPointer table
		Conceptually, each row in the MethodPointer table targets a MethodDef table row.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_POINTER_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

	DEBUG_OUTPUT

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_method_index: NATURAL_32)
		do
			create method_index.make_with_index (a_method_index)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.method_index = method_index
				)
		end

feature -- Access

	method_index: PE_METHOD_POINTER_INDEX
			-- an index into the Method table

feature -- Status report	

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{MethodPtr} => "
			Result := Result + method_index.debug_output
		end

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tmethodptr
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
			-- <Precursor>
		local
			l_bytes: NATURAL_32
		do
				-- Write the method_index
				-- to the buffer and update the number of bytes.
			l_bytes := method_index.render (a_sizes, a_dest, l_bytes)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Get the method_index and
				-- update the number of bytes.

			l_bytes := l_bytes + method_index.get (a_sizes, a_src, l_bytes)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
