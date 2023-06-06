note
	description: "Object representing The InterfaceImpl table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Interface Impl", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=257&zoom=100,116,256", "protocol=uri"

class
	PE_INTERFACE_IMPL_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
		end

create
	make_with_data

feature {NONE} -- Intialization	

	make_with_data (a_cls: NATURAL_64; a_interface: PE_TYPEDEF_OR_REF)
		do
			create class_.make_with_index (a_cls)
			interface := a_interface
		end

feature -- Status

	token_from_tables (tables: MD_TABLES): NATURAL_64
			-- If Current was already defined in `tables` return the associated token.
		local
			lst: LIST [PE_TABLE_ENTRY_BASE]
			n: NATURAL_64
		do
			lst := tables.table
			n := 0
			across
				lst as i
			until
				Result /= {NATURAL_64} 0
			loop
				n := n + 1
				if
					attached {like Current} i as e and then
					e.class_.is_equal (class_) and then
					e.interface.is_equal (interface)
				then
					Result := n
				end
			end
		end

feature -- Access

	class_: PE_TYPE_DEF
			-- an index into the TypeDef table

	interface: PE_TYPEDEF_OR_REF
			-- an index into the TypeDef, TypeRef, or TypeSpec table

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tinterfaceimpl.to_integer_32
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
