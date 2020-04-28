note

	description:

		"Represents a config rule's matching clause"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_CONFIG_MATCHING_CLAUSE

inherit

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	EWG_CONFIG_SHARED_CONSTRUCT_TYPE_NAMES

create

	make

feature {NONE} -- Initialization

	make
		do
			construct_type_code := construct_type_names.any_code
		end

feature {ANY} -- Access

	construct_type_code: INTEGER
			-- Construct types matched by this clause;
			-- See EWG_CONFIG_SHARED_CONSTRUCT_TYPE_NAMES

feature {ANY} -- Setting

	set_header_file_name_regexp (a_header_file_name_regexp: STRING)
		require
			a_header_file_name_regexp_not_void: a_header_file_name_regexp /= Void
		local
			l_header_file_name_regexp: like header_file_name_regexp
		do
			create l_header_file_name_regexp.make
			l_header_file_name_regexp.compile (a_header_file_name_regexp)
			-- TODO: this should be a precondition
				check
					compiled: l_header_file_name_regexp.is_compiled
				end
			header_file_name_regexp := l_header_file_name_regexp
		ensure
			-- TODO: doesnt work anymore this way (since regexp support)
--			header_file_name_regexp_set: header_file_name_regexp = a_header_file_name_regexp
		end

	set_c_identifier_regexp (a_c_identifier_regexp: STRING)
		require
			a_c_identifier_regexp_not_void: a_c_identifier_regexp /= Void
		local
			l_c_identifier_regexp: like c_identifier_regexp
		do
			create l_c_identifier_regexp.make
			l_c_identifier_regexp.compile (a_c_identifier_regexp)
			-- TODO: this should be a precondition
				check
					compiled: l_c_identifier_regexp.is_compiled
				end
			c_identifier_regexp := l_c_identifier_regexp
		ensure
			-- TODO: doesnt work anymore this way (since regexp support)
--			c_identifier_regexp_set: c_identifier_regexp = a_c_identifier_regexp
		end

	set_construct_type_code (a_construct_type_code: like construct_type_code)
			-- Make `a_construct_type_code' the new `construct_type_code'.
		require
			valid_a_construct_type_code: construct_type_names.is_valid_construct_type_code (a_construct_type_code)
		do
			construct_type_code := a_construct_type_code
		ensure
			construct_type_code_set: construct_type_code = a_construct_type_code
		end

feature {ANY} -- Operations

	is_matching_type (a_type: EWG_C_AST_TYPE): BOOLEAN
			-- Does `a_type' match the matching criteria from `Current'?
		require
			a_type_not_void: a_type /= Void
		do
			Result := True
			if not match_text (a_type.header_file_name, header_file_name_regexp) then
				Result := False
			end

			if
				not match_text (a_type.skip_consts.name, c_identifier_regexp)
			then
				Result := False
			end

			if construct_type_code = construct_type_names.any_code then
				-- Everything is accepted
			elseif construct_type_code = construct_type_names.none_code then
				-- Nothing will be accepted
				Result := False
			elseif construct_type_code = construct_type_names.struct_code then
				-- Only structs will be accepted
				if not a_type.based_type_recursive.is_struct_type then
					Result := False
				end
			elseif construct_type_code = construct_type_names.union_code then
				-- Only unions will be accepted
				if not a_type.based_type_recursive.is_union_type then
					Result := False
				end
			elseif construct_type_code = construct_type_names.enum_code then
				-- Only enums will be accepted
				if not a_type.based_type_recursive.is_enum_type then
					Result := False
				end
			elseif construct_type_code = construct_type_names.function_code then
				-- Only functions will be accepted
				Result := False
			elseif construct_type_code = construct_type_names.callback_code then
				-- Only callbacks will be accepted
				if not (a_type.based_type_recursive.is_callback or a_type.skip_wrapper_irrelevant_types.is_callback) then
					Result := False
				end
			else
				check
					dead_end: False
				end
			end

		end

	is_matching_declaration (a_declaration: EWG_C_AST_DECLARATION): BOOLEAN
			-- Does `a_declaration' match the matching criteria from `Current'?
		require
			a_declaration_not_void: a_declaration /= Void
		do
			Result := True
			if not match_text (a_declaration.header_file_name, header_file_name_regexp) then
				Result := False
			end

			if not match_text (a_declaration.declarator, c_identifier_regexp) then
				Result := False
			end

			if construct_type_code = construct_type_names.any_code then
				-- Everything is accepted
			elseif construct_type_code = construct_type_names.none_code then
				-- Nothing will be accepted
				Result := False
			elseif construct_type_code = construct_type_names.struct_code then
				-- Only structs will be accepted
				Result := False
			elseif construct_type_code = construct_type_names.union_code then
				-- Only unions will be accepted
				Result := False
			elseif construct_type_code = construct_type_names.enum_code then
				-- Only enums will be accepted
				Result := False
			elseif construct_type_code = construct_type_names.function_code then
				-- Only functions will be accepted
				if not a_declaration.is_function_declaration then
					Result := False
				end
			elseif construct_type_code = construct_type_names.callback_code then
				-- Only callbacks will be accepted
				Result := False
			else
					check
						dead_end: False
					end
			end
		end

	is_matching_header_and_contant_name (a_header: STRING; a_constant_name: STRING): BOOLEAN
			-- Does `a_declaration' match the matching criteria from `Current'?
		require
			a_header_not_void: a_header /= Void
			a_constant_name: a_constant_name /= Void
		do
			Result := True
			if not match_text (a_header, header_file_name_regexp) then
				Result := False
			end

			if not match_text (a_constant_name, c_identifier_regexp) then
				Result := False
			end
		end

feature {NONE}

	match_text (a_text: detachable STRING; a_regexp: detachable RX_PCRE_REGULAR_EXPRESSION): BOOLEAN
		do
			if a_regexp /= Void then
				if a_text /= Void then
					Result := a_regexp.recognizes (a_text)
				else
					Result := False -- pattern, no text -> never match
				end
			else
				Result := True -- no pattern -> always match
			end
		end

feature {NONE}

	header_file_name_regexp: detachable RX_PCRE_REGULAR_EXPRESSION
			-- Header file name the construct has to be in; Note that
			-- construct has to be declared directly in that header, not
			-- pulled in via an "#include" statement.  If `Void', any
			-- header file matches.  Will be interpreted as a regular
			-- expression.

	c_identifier_regexp: detachable RX_PCRE_REGULAR_EXPRESSION
			-- Identifier of the construct to match; If `Void' any name
			-- matches.  Will be interpreted as a regular expression.

invariant

	header_file_name_regexp_not_void_implies_compiled: attached header_file_name_regexp as l_header_file_name_regexp implies l_header_file_name_regexp.is_compiled
	c_identifier_regexp_not_void_implies_compiled: attached c_identifier_regexp as l_c_identifier_regexp implies l_c_identifier_regexp.is_compiled
	valid_construct_type_code: construct_type_names.is_valid_construct_type_code (construct_type_code)

end
