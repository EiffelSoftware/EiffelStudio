note
	description: "Summary description for {PE_FIELD_MARSHAL_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_MARSHAL_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Intialization

	make_with_data (a_parent: PE_FIELD_MARSHAL; a_native_type: NATURAL)
		do
			parent := a_parent
			create native_type.make_with_index (a_native_type)
		end

feature -- Access

	parent: PE_FIELD_MARSHAL

	native_type: PE_BLOB

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tfieldmarshal.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write parent and native_type to the buffer and update
				-- the number of bytes
			l_bytes := parent.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + native_type.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Read parent and native_type  from the buffer and update
				-- the number of bytes
			l_bytes := parent.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + native_type.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed
			Result := l_bytes
		end

end
