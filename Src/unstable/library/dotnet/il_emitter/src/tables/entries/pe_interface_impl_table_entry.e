note
	description: "Summary description for {PE_INTERFACE_IMPL_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_INTERFACE_IMPL_TABLE_ENTRY

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

	make_with_data (a_cls: NATURAL; a_interface: PE_TYPEDEF_OR_REF)
		do
			create class_.make_with_index (a_cls)
			interface := a_interface
		end

feature -- Access

	class_: PE_TYPE_DEF

	interface: PE_TYPEDEF_OR_REF

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tinterfaceimpl.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write the class_ to the buffer and update the number
				-- of bytes.
			l_bytes := class_.render (a_sizes, a_dest, 0)

				-- Write the interface to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes +  interface.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Get the class_ from the buffer and update the number
				-- of bytes.
			l_bytes := class_.get (a_sizes, a_Src, 0)

				-- Read the interface to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes + interface.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed
			Result := l_bytes
		end


end
