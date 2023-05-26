note
	description: "[
					Object representing the table FieldMarshal
					The FieldMarshal table has two columns. It ‘links’ an existing row in the Field or Param table, to
			information in the Blob heap that defines how that field or parameter (which, as usual, covers the
			method return, as parameter number 0) shall be marshalled when calling to or from unmanaged code
			via PInvoke dispatch.
			Note that FieldMarshal information is used only by code paths that arbitrate operation with unmanaged
			code. In order to execute such paths, the caller, on most platforms, would be installed with elevated
			security permission. Once it invokes unmanaged code, it lies outside the regime that the CLI can
			check—it is simply trusted not to violate the type system.
		]"
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=FieldMarshal", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=252&zoom=100,116,324", "protocol=uri"

class
	PE_FIELD_MARSHAL_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Intialization

	make_with_data (a_parent: PE_FIELD_MARSHAL; a_native_type: NATURAL_64)
		do
			parent := a_parent
			create native_type.make_with_index (a_native_type)
		end

feature -- Access

	parent: PE_FIELD_MARSHAL
		-- index a valid row in the Field or Param table

	native_type: PE_BLOB
		--  index a non-null 'blob' in the Blob heap

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tfieldmarshal.to_integer_32
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
