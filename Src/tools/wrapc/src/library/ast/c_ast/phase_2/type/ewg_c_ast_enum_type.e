note

	description:

		"Objects representing C enums"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_AST_ENUM_TYPE

inherit

	EWG_C_AST_COMPOSITE_DATA_TYPE
		redefine
			corresponding_eiffel_type,
			corresponding_eiffel_type_api,
			is_same_type,
			is_enum_type
		end

create

	make

feature

	corresponding_eiffel_type: STRING
			-- An enum are represented as INTEGER in Eiffel.
		do
			Result := "INTEGER"
		end

	corresponding_eiffel_type_api: STRING
			-- An enum are represented as INTEGER in Eiffel.
		do
			Result := "INTEGER"
		end

	is_enum_type: BOOLEAN
		do
			Result := True
		end

feature


	is_same_type (other: EWG_C_AST_TYPE): BOOLEAN
		do
			if attached {EWG_C_AST_ENUM_TYPE} other as other_enum then
				Result := Current = other_enum or else is_same_composite_type (other_enum)
			end
		end

feature -- Visitor Pattern

	process (a_processor: EWG_C_AST_TYPE_PROCESSOR)
			-- Process `Current' using `a_processor'.
		do
			a_processor.process_enum_type (Current)
		end

end
