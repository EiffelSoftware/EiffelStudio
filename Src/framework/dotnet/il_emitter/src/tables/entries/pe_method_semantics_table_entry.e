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
			same_As
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_semantics: NATURAL_16; a_method: NATURAL_32; a_association: PE_SEMANTICS)
		do
			semantics := a_semantics
			create method.make_with_index (a_method)
			association := a_association
		end

feature -- Status

	token_searching_supported: BOOLEAN = True

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
				-- TODO: not sure if we have support for events.
				-- So we only need to check for duplication of Properties.
			Result := Precursor (e)
				or else (
					e.semantics = semantics and then
					e.method.is_equal (method) and then
					e.association.is_equal (association)
				)
		end

	less_than (o: like Current): BOOLEAN
			-- Is Current less than `a_other` in associated table?
		do
			Result := association.less_than_index (o.association)
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

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tMethodSemantics
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write semantics to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest, semantics, 0)

				-- Intialize the number of bytes written
			l_bytes := 2

				-- Write method and association to the buffer and update the number of bytes.
			l_bytes := l_bytes + method.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + association.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Set the semantiics (from a_src)  to semantics
			semantics := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, 0)

				-- Intialize the number of bytes.
			l_bytes := 2

				-- Read method and association from the buffer and update the number of bytes.
			l_bytes := l_bytes + method.get (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + association.get (a_sizes, a_src, l_bytes)
				-- Return the number of bytes readed
			Result := l_bytes
		end

end

