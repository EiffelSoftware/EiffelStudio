note
	description: "Objects representing The MethodSemantics table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=MethodSemantics", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=263&zoom=100,116,764", "protocol=uri"

class
	PE_METHOD_SEMANTICS_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_semantics: NATURAL_16; a_method: NATURAL_64; a_association: PE_SEMANTICS)
		do
			semantics := a_semantics
			create method.make_with_index (a_method)
			association := a_association
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
					e.semantics = semantics and then
					e.method.is_equal (method) and then
					e.association.is_equal (association)
				then
					Result := n
				end
			end
		end

feature -- Access

	semantics: NATURAL_16
			-- Defined as a word two bytes.
			-- see MethodSemanticsAttributes https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=279&zoom=100,116,684

	method: PE_METHOD_LIST
			-- an index into the MethodDef table

	association: PE_SEMANTICS
			-- an index into the Event or Property table
			-- more precisely, a HasSemantics index.

feature -- Flags

	Setter: INTEGER = 1
	Getter: INTEGER = 2
	Other: INTEGER = 4
	AddOn: INTEGER = 8
	RemoveOn: INTEGER = 16
	Fire: INTEGER = 32

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tMethodSemantics.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write semantics to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, semantics, 0)

				-- Intialize the number of bytes written
			l_bytes := 2

				-- Write method and association to the buffer and update the number of bytes.
			l_bytes := l_bytes + method.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + association.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the semantiics (from a_src)  to semantics
			semantics := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, 0)

				-- Intialize the number of bytes.
			l_bytes := 2

				-- Read method and association from the buffer and update the number of bytes.
			l_bytes := l_bytes + method.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + association.get (a_sizes, a_src, l_bytes.to_integer_32)
				-- Return the number of bytes readed
			Result := l_bytes
		end

end

