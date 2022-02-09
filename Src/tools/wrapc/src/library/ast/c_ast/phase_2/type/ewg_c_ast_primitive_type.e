note

	description:

		"Objects representing C primitive types (like 'int' or 'double')"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_AST_PRIMITIVE_TYPE

inherit

	EWG_C_AST_SIMPLE_TYPE
		redefine
			corresponding_eiffel_type,
			corresponding_eiffel_type_api,
			is_primitive_type
		end

create

	make

feature

	corresponding_eiffel_type: STRING
			-- TODO: not taking care of INTEGER_* yet (waiting for Visual Eiffel)
		do
			-- TODO: handle __int8, __int16, __int32 and __int64
			-- TODO: Take care of how different platforms handle C types.
			if attached name as l_name then
				if l_name.has_substring ("int") or
					--l_name.has_substring ("signed") or -- includes 'unsigned'
					l_name.has_substring ("short") or
					l_name.has_substring ("_Bool") then -- TODO: this should really be mapped to BOOLEAN. Needs changes all over the place probably.
					Result := "INTEGER"
				elseif l_name.has_substring ("long") then
					Result := "INTEGER_64"
				elseif l_name.has_substring ("char") then
					Result := "CHARACTER"
				elseif l_name.has_substring ("double") then
					Result := "REAL_64"
				elseif l_name.has_substring ("float") then
					Result := "REAL"
				elseif l_name.is_case_insensitive_equal ("unsigned") then
					Result := "NATURAL"  -- unsigned is a short cut for unsigned int.
				elseif l_name.has_substring ("void") then
					Result := "WHAT_SHOULD_I_DO_WITH_VOID"
				else
					check
						dead_end: False
					end
					Result := "UNKNOWN"
					-- TODO: double check what to do with this
					-- or just return detachable STRING
				end
				-- Check for unsigned
				if l_name.has_substring ("unsigned") then
					if Result.same_string ("INTEGER_64") then
						Result := "NATURAL_64"
					elseif Result.same_string ("INTEGER") or else Result.same_string ("CHARACTER")then
						Result := "NATURAL"
					end
				end
			else
				Result := "UNKNOWN"
					-- TODO: double check what to do with this
					-- or just return detachable STRING
			end
		end

	corresponding_eiffel_type_api: STRING
		do
			Result := corresponding_eiffel_type
		end

	append_anonymous_hash_string_to_string (a_string: STRING)
		do
				check
					primitive_type_always_named: False
				end
		end

	is_primitive_type: BOOLEAN
		do
			Result := True
		end

	is_char_type: BOOLEAN
			-- Is this type 'char'?
		do
			if attached name as l_name then
				Result := l_name.has_substring ("char")
			end
		end

	is_int_type: BOOLEAN
		do
			if attached name as l_name then
				Result := l_name.has_substring ("int")
			end
		end

	is_long_type: BOOLEAN
		do
			if attached name as l_name then
				Result := l_name.has_substring ("long")
			end
		end

	is_double_type: BOOLEAN
		do
			if attached name as l_name then
				Result := l_name.has_substring ("double")
			end
		end

	is_float_type: BOOLEAN
		do
			if attached name as l_name then
				Result := l_name.has_substring ("float")
			end
		end

	is_short_type: BOOLEAN
		do
			if attached name as l_name then
				Result := l_name.has_substring ("short")
			end
		end

feature -- Visitor Pattern

	process (a_processor: EWG_C_AST_TYPE_PROCESSOR)
			-- Process `Current' using `a_processor'.
		do
			a_processor.process_primitive_type (Current)
		end

invariant

	not_anoymous: not is_anonymous

end
