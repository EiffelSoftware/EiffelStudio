note

	description: "An AST node for an Eiffel feature name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FEATURE_NAME

inherit
	AST_EIFFEL
		redefine
			is_equal
		end

	COMPARABLE
		redefine
			is_equal
		end

	CLICKABLE_AST
		redefine
			feature_name,
			is_equal,
			is_feature
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		redefine
			is_equal
		end

inherit {NONE}

	PREFIX_INFIX_NAMES
		export
			{NONE} all
			{ANY}
				extract_alias_name_32
		redefine
			is_equal
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_name)
			-- Create a new FEATURE_NAME AST node.
		require
			attached f
		do
			feature_name := f
		ensure
			feature_name = f
		end

feature -- Stoning

	feature_name: ID_AS
			-- Feature name.

feature -- Status report

	is_frozen: BOOLEAN
			-- Is the name of the feature frozen?
		do
			Result := frozen_keyword /= Void
		end

	has_bracket_alias: BOOLEAN
			-- Is feature alias (if any) bracket?
		do
		end

	has_parentheses_alias: BOOLEAN
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

feature -- Access

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
			Result := feature_name.name
		ensure
			result_not_void: Result /= Void
		end

feature -- Status setting

	set_frozen_keyword (l: like frozen_keyword)
			-- Set location of the associated "frozen" keyword to `l'.
		do
			frozen_keyword := l
		ensure
			frozen_keyword_set: frozen_keyword = l
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := is_frozen = other.is_frozen and then
				equivalent (feature_name, other.feature_name)
		end

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
				-- The implementation should be consistent with the implementation of `is_less`.
			Result := feature_name.name_id = other.feature_name.name_id
		end

	is_less alias "<" (other: FEATURE_NAME): BOOLEAN
			-- <Precursor>
		do
			Result := feature_name.name < other.feature_name.name
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_feature_name (Current)
		end

feature -- Location

	frozen_keyword: detachable KEYWORD_AS
			-- Keyword "frozen" (if any)

feature -- Roundtrip

	index: INTEGER
			-- <Precursor>
		do
			Result := feature_name.index
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			Result := frozen_keyword
			if Result = Void or else Result.is_null then
				Result := feature_name.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			Result := feature_name.last_token (a_list)
		end

invariant
	consistent_operator_status:
		not (has_bracket_alias and is_binary) and
		not (has_bracket_alias and is_unary) and
		not (has_bracket_alias and has_parentheses_alias) and
		not (has_parentheses_alias and is_binary) and
		not (has_parentheses_alias and is_unary) and
		not (is_binary and is_unary)

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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

end
