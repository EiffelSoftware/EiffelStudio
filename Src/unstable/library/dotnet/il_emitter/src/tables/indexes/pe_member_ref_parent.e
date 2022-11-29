note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MEMBER_REF_PARENT

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

		-- memberrefparent
	TagBits: INTEGER = 3
	TypeDef: INTEGER = 0
	TypeRef: INTEGER = 1
	ModuleRef: INTEGER = 2
	MethodDef: INTEGER = 3
	TypeSpec: INTEGER = 4

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_64]): BOOLEAN
		do
			to_implement ("Add implementation")
		end

end

