note
	description: "[
		we also have psuedo-indexes for the various streams
		these are like regular indexes except streams are unambiguous so we don't need to shift
		and add a tag
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_US

inherit
	PE_INDEX_BASE
		redefine
			has_index_overflow
		end

create {PE_INDEX_BASE}
	make_with_index

feature -- Operations

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			Result := large (a_sizes[{PE_TABLE_CONSTANTS}.T_US + 1].to_natural_32)
		end

end
