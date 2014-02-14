note

	description:
		"Abstract class for an Eiffel feature name: id or %
		%infix/prefix notation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class FEATURE_NAME

inherit
	AST_EIFFEL
		undefine
			is_equal
		end

	COMPARABLE

	CLICKABLE_AST
		rename
			feature_name as internal_name
		undefine
			is_equal, internal_name
		redefine
			is_feature
		end

	EIFFEL_SYNTAX_CHECKER
		export
			{NONE} all
			{ANY} is_valid_binary_operator, is_valid_unary_operator
		undefine
			is_equal
		end

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		undefine
			is_equal
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			is_equal
		end

-- Undefined is_equal of AST_EIFFEL and CLICKABLE_AST because these are
-- not consistent with infix < operator
-- < is defined by the terms of < of feature name and is_equal
-- (from ANY is c_standard_is_equal)

feature -- Stoning

	internal_name: ID_AS
			-- Internal name used by the compiler.
		deferred
		end

feature -- Status report

	is_frozen: BOOLEAN
			-- Is the name of the feature frozen?
		do
			Result := frozen_keyword /= Void
		end

	is_infix: BOOLEAN
			-- Is the feature name an infixed notation?
		do
		end

	is_prefix: BOOLEAN
			-- Is the feature name a prefixed notation?
		do
		end

	is_bracket: BOOLEAN
			-- Is feature alias (if any) bracket?
		do
		end

	is_parentheses: BOOLEAN
			-- Is feature alias (if any) parentheses?
		do
		end

	is_binary: BOOLEAN
			-- Is feature alias (if any) a binary operator?
		do
		end

	is_unary: BOOLEAN
			-- Is feature alias (if any) an unary operator?
		do
		end

	is_feature: BOOLEAN = True
			-- Does the Current AST represent a feature?

	internal_alias_name_id: INTEGER
			-- `internal_alias_name' ID in NAMES_HEAP
		do
			if attached internal_alias_name as l_alias then
				Result := l_alias.name_id
			end
		ensure
			has_alias: alias_name /= Void implies Result > 0
			has_no_alias: alias_name = Void implies Result = 0
		end

	internal_alias_name: detachable ID_AS
			-- Operator associated with the feature (if any)
			-- augmented with information about its arity
		deferred
		ensure
			consistent_result: (Result /= Void) = (alias_name /= Void)
		end

	alias_name: detachable STRING_AS
			-- Operator name associated with the feature (if any)
		deferred
		end

	has_convert_mark: BOOLEAN
			-- Is operator marked with "convert"?
		do
		end

	is_valid_unary: BOOLEAN
			-- Is the value of the feature name valid unary operator?
		do
			Result := attached alias_name as l_name and then is_valid_unary_operator (l_name.value)
		end

	is_valid_binary: BOOLEAN
			-- Is the value of the feature name valid unary operator?
		do
			Result := attached alias_name as l_name and then is_valid_binary_operator (l_name.value)
		end

feature -- Status report

	visual_name_32: detachable STRING_32
			-- Named used in Eiffel code
		do
			if attached visual_name as l_name then
				Result := encoding_converter.utf8_to_utf32 (l_name)
			end
		ensure
			result_not_void: Result /= Void
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Status report

	visual_name: STRING
			-- Named used in Eiffel code
		do
			Result := internal_name.name
		ensure
			result_not_void: Result /= Void
		end

feature -- Status setting

	set_is_binary
			-- Mark alias operator as binary.
		require
			has_alias: alias_name /= Void
			not_is_bracket: not is_bracket
			not_is_parentheses: not is_parentheses
			not_is_prefix: not is_prefix
			is_valid_binary: is_valid_binary
		do
		ensure
			is_binary: is_binary
		end

	set_is_unary
			-- Mark alias operator as unary.
		require
			has_alias: alias_name /= Void
			not_is_bracket: not is_bracket
			not_is_parentheses: not is_parentheses
			not_is_infix: not is_infix
			is_valid_unary: is_valid_unary
		do
		ensure
			is_unary: is_unary
		end

	set_frozen_keyword (l: like frozen_keyword)
			-- Set location of the associated "frozen" keyword to `l'.
		do
			frozen_keyword := l
		ensure
			frozen_keyword_set: frozen_keyword = l
		end

feature -- Comparison

	is_less alias "<" (other: FEATURE_NAME): BOOLEAN
		deferred
		end

feature -- Location

	frozen_keyword: detachable KEYWORD_AS
			-- Keyword "frozen" (if any)

invariant
	consistent_operator_status:
		not (is_bracket and is_binary) and
		not (is_bracket and is_unary) and
		not (is_bracket and is_parentheses) and
		not (is_parentheses and is_binary) and
		not (is_parentheses and is_unary) and
		not (is_binary and is_unary)
	consistent_operator_name: (is_bracket or is_parentheses or is_binary or is_unary) = (alias_name /= Void)

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class FEATURE_NAME
