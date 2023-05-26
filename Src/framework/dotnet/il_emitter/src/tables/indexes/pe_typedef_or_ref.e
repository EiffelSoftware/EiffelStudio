note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPEDEF_OR_REF

inherit

	PE_INDEX_BASE
		rename
			make as make_base
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make_with_tag_and_index,
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Enum: tags

	TagBits: INTEGER = 2
	TypeDef: INTEGER = 0
	TypeRef: INTEGER = 1
	TypeSpec: INTEGER = 2

feature -- Operations

	get_index_shift: INTEGER
			-- <Precursor>
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_64]): BOOLEAN
			-- <Precursor>
		do
			Result :=  large(a_sizes[{PE_TABLES}.tTypeDef + 1].to_natural_32) or else
					large(a_sizes[{PE_TABLES}.tTypeRef + 1].to_natural_32) or else
					large(a_sizes[{PE_TABLES}.tTypeSpec + 1].to_natural_32)
		end

end
