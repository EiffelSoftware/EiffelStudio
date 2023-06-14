note
	description: "[
		we also have psuedo-indexes for the various streams
		these are like regular indexes except streams are unambiguous so we don't need to shift
		and add a tag
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GUID

inherit
	PE_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make_with_index

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := 0
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			Result := large (a_sizes[{PE_TABLE_CONSTANTS}.t_guid + 1])
		end

end
