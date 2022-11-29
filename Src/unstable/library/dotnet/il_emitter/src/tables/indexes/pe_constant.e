note
	description: "Summary description for {PE_CONSTANT}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CONSTANT

inherit

	PE_INDEX_BASE
		rename
			make as make_base
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make_with_tag_and_index

create
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Enum: tags

		-- HasConstant
	TagBits: INTEGER = 2
	FieldDef: INTEGER = 0
	ParamDef: INTEGER = 1
			--TagProperty : INTEGER =2
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
