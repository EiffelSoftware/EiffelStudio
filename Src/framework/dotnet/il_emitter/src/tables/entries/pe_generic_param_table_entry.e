note
	description: "Object representing the GenericParam table."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=GenericParam", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=254&zoom=100,116,309", "protocol=uri"

class
	PE_GENERIC_PARAM_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_number: NATURAL_16; a_flags: NATURAL_16; a_owner: PE_TYPE_OR_METHOD_DEF; a_name: NATURAL_64)
		do
			number := a_number
			flags := a_flags
			owner := a_owner
			create name.make_with_index (a_name)
		end

feature -- Status

	token_searching_supported: BOOLEAN = True

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (

					e.number = number and then
					e.flags = flags and then
					e.owner.is_equal (owner) and then
					e.name.is_equal (name)
				)
		end

feature -- Access

	number: NATURAL_16
			-- Defined as word two bytes.
			-- the 2-byte index of the generic parameter, numbered left-to-right, from zero.

	flags: NATURAL_16
			-- Defined as word two bytes.
			-- a 2-byte bitmask of type GenericParamAttributes
			-- see https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=277&zoom=100,116,488

	owner: PE_TYPE_OR_METHOD_DEF
			-- an index into the TypeDef or MethodDef table, specifying the Type or
			-- Method to which this generic parameter applies; more precisely, a
			-- TypeOrMethodDef coded index.

	name: PE_STRING
			-- a non-null index into the String heap, giving the name for the generic parameter.

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tGenericParam.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, number, 0)
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, flags, 2)
			l_bytes := 4

			l_bytes := l_bytes + owner.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + name.render (a_sizes, a_dest, l_bytes.to_integer_32)

			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			number := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, 0)
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, 2)
			l_bytes := 4

			l_bytes := l_bytes + owner.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + name.get (a_sizes, a_src, l_bytes.to_integer_32)

			Result := l_bytes
		end

end

