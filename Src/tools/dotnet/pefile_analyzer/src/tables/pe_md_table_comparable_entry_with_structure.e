note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_MD_TABLE_COMPARABLE_ENTRY_WITH_STRUCTURE

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE
		undefine
			is_equal
		end

	PE_MD_TABLE_COMPARABLE_ENTRY
		undefine
			make,
			to_string, to_string_array, byte_size_to_string_array,
			description_as_array, description,
			dump
		end

end
