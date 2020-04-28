note

	description:

		"C alias types"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_AST_ALIAS_TYPE

inherit

	EWG_C_AST_BASED_TYPE
		rename
			make as make_based_type
		redefine
			is_same_type,
			is_unicode_char_pointer_type,
			skip_aliases,
			skip_consts_and_aliases,
			is_alias_type,
			corresponding_eiffel_type,
			corresponding_eiffel_type_api,
			skip_consts_aliases_and_arrays,
			skip_consts_aliases_and_pointers
		end

create

	make

feature

	make (a_name: STRING; a_header_file_name: STRING; a_base: EWG_C_AST_TYPE)
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_base_not_void: a_base /= Void
		do
			make_based_type (a_name, a_header_file_name, a_base)
		ensure
			a_name_set: name = a_name
			a_header_file_name_set: header_file_name = a_header_file_name
			a_base_set: base = a_base
		end

feature

	skip_consts_and_aliases: EWG_C_AST_TYPE
		do
			Result := base.skip_consts_and_aliases
		end

	skip_aliases: EWG_C_AST_TYPE
		do
			Result := base.skip_aliases
		end

	skip_consts_aliases_and_arrays: EWG_C_AST_TYPE
		do
			Result := base.skip_consts_aliases_and_arrays
		end

	skip_consts_aliases_and_pointers: EWG_C_AST_TYPE
		do
			Result := base.skip_consts_aliases_and_pointers
		end

	append_anonymous_hash_string_to_string (a_string: STRING)
		do
				check
					alias_is_always_named: False
				end
		end

feature -- Visitor Pattern

	process (a_processor: EWG_C_AST_TYPE_PROCESSOR)
			-- Process `Current' using `a_processor'.
		do
			a_processor.process_alias_type (Current)
		end

feature


	corresponding_eiffel_type: STRING
			-- Return the name of the Eiffel type that
			-- corresponds to `Current'.
		do
			Result := base.corresponding_eiffel_type
		end

	corresponding_eiffel_type_api: STRING
		do
			Result := base.corresponding_eiffel_type_api
		end

	is_same_type (other: EWG_C_AST_TYPE): BOOLEAN
		do
			if attached {EWG_C_AST_ALIAS_TYPE} other as other_alias then
				Result := Current = other_alias or else (attached name as l_name and then attached other_alias.name as other_name and then (STRING_.same_string (l_name, other_name) and
					is_same_based_type (other_alias)))
			end
		end

	is_alias_type: BOOLEAN
		do
			Result := True
		end

	is_unicode_char_pointer_type: BOOLEAN
		do
			if attached name as l_name then
				Result := l_name.has_substring ("wchar_t")
			end
		end

invariant

	not_anonymous: not is_anonymous

end
