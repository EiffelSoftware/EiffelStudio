note
	description: "[
			This class is the base class for pointer index rendering
			(index value in FieldPointer or MethodPointer tables)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_POINTER_INDEX

inherit
	PE_INDEX_BASE
		redefine
			has_index_overflow,
			accepts
		end

create
	make_with_index

feature -- Operations

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
			-- Always use 4-bytes
		do
			Result := False
		end

feature -- Visitor

	accepts (vis: MD_VISITOR)
		do
			vis.visit_pointer_index (Current)
		end

end
