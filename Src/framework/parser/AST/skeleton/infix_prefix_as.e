note
	description: "Abstract description of an Eiffel infixed or prefixed feature name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INFIX_PREFIX_AS

inherit
	FEATURE_NAME
		rename
			internal_alias_name as internal_name,
			is_binary as is_infix,
			is_unary as is_prefix
		export
			{AST_VISITOR} frozen_keyword
		redefine
			alias_name,
			is_equivalent,
			is_infix, is_prefix, visual_name

		end

create
	initialize

feature {NONE} -- Initialization

	initialize (op: like alias_name; inf: BOOLEAN; l: like infix_prefix_keyword)
			-- Create a new INFIX AST node.
			-- `inf' is `is_infix', `l' is a start location.
		require
			op_not_void: op /= Void
		do
			is_infix := inf
			alias_name := op
			if is_infix then
				create internal_name.initialize (infix_feature_name_with_symbol (alias_name.value))
			else
				create internal_name.initialize (prefix_feature_name_with_symbol (alias_name.value))
			end
			internal_name.set_index (op.index)
			if l /= Void then
				internal_name.set_position (l.line, l.column, l.position, op.position - l.position + op.location_count,
					l.character_column, l.character_position, op.character_position - l.character_position + l.character_count)
			end
			infix_prefix_keyword := l
		ensure
			infix_prefix_keyword_set: infix_prefix_keyword = l
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_infix_prefix_as (Current)
		end

feature -- Roundtrip

	infix_prefix_keyword: detachable KEYWORD_AS
		-- Keyword "infix" or "prefix" associated with this structure.

	index: INTEGER
			-- <Precursor>
		do
			if attached infix_prefix_keyword as k then
				Result := k.index
			end
		end

feature -- Properties

	is_infix: BOOLEAN
			-- is the feature name an infixed notation ?

	is_prefix: BOOLEAN
			-- Is the feature a prefix notation?
		do
			Result := not is_infix
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equal (internal_name, other.internal_name) and
				is_infix = other.is_infix and
				is_frozen = other.is_frozen
		end

feature -- Access

	alias_name: STRING_AS
			-- Operator name associated with the feature

	internal_name: ID_AS
			-- Internal name used by the compiler

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	visual_name: STRING
			-- Visual name of fix operator
		do
			Result := alias_name.value
		end

feature -- Conveniences

	is_less alias "<" (other: FEATURE_NAME): BOOLEAN
		do
			if attached {INFIX_PREFIX_AS} other as l_infix_feature then
				Result := visual_name < l_infix_feature.visual_name
			elseif attached {FEAT_NAME_ID_AS} other then
				Result := False
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := frozen_keyword
			if Result = Void or else Result.is_null then
				Result := infix_prefix_keyword
				if Result = Void then
					Result := alias_name.first_token (a_list)
				end
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := alias_name.last_token (a_list)
		end

invariant
	alias_name_not_void: alias_name /= Void

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

end
