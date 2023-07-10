note
	description: "[
		we also have psuedo-indexes for the various streams
		these are like regular indexes except streams are unambiguous so we don't need to shift
		and add a tag
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_STRING

inherit
	PE_INDEX_BASE
		redefine
			has_index_overflow
		end

create
	make_with_index

feature -- Operations

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			debug ("refactor_fixme")
				fixme ("Todo double check if we need + 1 in this case.")
			end
			Result := large(a_sizes[{PE_TABLE_CONSTANTS}.t_string + 1])
		end

end
