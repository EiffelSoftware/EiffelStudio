note

	description:

		"Abstract base for C struct, union and enum types"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class EWG_C_AST_COMPOSITE_DATA_TYPE

inherit

	EWG_C_AST_COMPOSITE_TYPE
		redefine
			is_composite_data_type
		end

feature

	is_composite_data_type: BOOLEAN 
		do
			Result := True
		end

end
