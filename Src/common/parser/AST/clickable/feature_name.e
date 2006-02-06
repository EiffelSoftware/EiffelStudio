indexing

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

	internal_name_id: INTEGER is
			-- `internal_name' ID in NAMES_HEAP.
		local
			l_names_heap: like Names_heap
		do
			l_names_heap := Names_heap
			l_names_heap.put (internal_name)
			Result := l_names_heap.found_item
		end

	internal_name: ID_AS is
			-- Internal name used by the compiler.
		deferred
		end

feature -- Status report

	is_frozen: BOOLEAN is
			-- Is the name of the feature frozen?
		do
			Result := frozen_keyword /= Void
		ensure
			definition: Result = (frozen_keyword /= Void)
		end

	is_infix: BOOLEAN is
			-- Is the feature name an infixed notation?
		do
		end

	is_prefix: BOOLEAN is
			-- Is the feature name a prefixed notation?
		do
		end

	is_bracket: BOOLEAN is
			-- Is feature alias (if any) bracket?
		do
		end

	is_binary: BOOLEAN is
			-- Is feature alias (if any) a binary operator?
		do
		end

	is_unary: BOOLEAN is
			-- Is feature alias (if any) an unary operator?
		do
		end

	is_feature: BOOLEAN is True
			-- Does the Current AST represent a feature?

	visual_name: STRING is
			-- Named used in Eiffel code
		do
			Result := internal_name
		ensure
			result_not_void: Result /= Void
		end

	internal_alias_name_id: INTEGER is
			-- `internal_alias_name' ID in NAMES_HEAP
		local
			l_names_heap: like Names_heap
		do
			if alias_name /= Void then
				l_names_heap := Names_heap
				l_names_heap.put (internal_alias_name)
				Result := l_names_heap.found_item
			end
		ensure
			has_alias: alias_name /= Void implies Result > 0
			has_no_alias: alias_name = Void implies Result = 0
		end

	internal_alias_name: STRING is
			-- Operator associated with the feature (if any)
			-- augmented with information about its arity
		deferred
		ensure
			consistent_result: (Result /= Void) = (alias_name /= Void)
		end

	alias_name: STRING_AS is
			-- Operator name associated with the feature (if any)
		deferred
		end

	has_convert_mark: BOOLEAN is
			-- Is operator marked with "convert"?
		do
		end

feature -- Status setting

	set_is_binary is
			-- Mark alias operator as binary.
		require
			has_alias: alias_name /= Void
			not_is_bracket: not is_bracket
			not_is_prefix: not is_prefix
			is_valid_binary: is_valid_binary_operator (alias_name.value)
		do
		ensure
			is_binary: is_binary
		end

	set_is_unary is
			-- Mark alias operator as unary.
		require
			has_alias: alias_name /= Void
			not_is_bracket: not is_bracket
			not_is_infix: not is_infix
			is_valid_unary: is_valid_unary_operator (alias_name.value)
		do
		ensure
			is_unary: is_unary
		end

	set_frozen_keyword (l: KEYWORD_AS) is
			-- Set location of the associated "frozen" keyword to `l'.
		require
			l_not_void: l /= Void
		do
			frozen_keyword := l
		ensure
			frozen_keyword_set: frozen_keyword = l
		end

feature -- Comparison

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		deferred
		end

feature -- Location

	frozen_keyword: KEYWORD_AS
			-- Keyword "frozen" (if any)

feature {NONE} -- Implementation: helper functions

	get_internal_alias_name: STRING is
			-- Internal alias name augmented with arity information
			-- in the form "prefix ..." or "infix ..."
		require
			is_operator: is_binary or is_unary
			alias_name_not_void: alias_name /= Void
		do
			if is_binary then
				Result := infix_feature_name_with_symbol (alias_name.value)
			else
				Result := prefix_feature_name_with_symbol (alias_name.value)
			end
		ensure
			result_not_void: Result /= Void
		end

invariant
	consistent_operator_status: not (is_bracket and is_binary) and not (is_bracket and is_unary) and not (is_binary and is_unary)
	consistent_operator_name: (is_bracket or is_binary or is_unary) = (alias_name /= Void)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class FEATURE_NAME
