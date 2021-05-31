note
	description: "Object that represents a list of PARENT_AS nodes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PARENT_LIST_AS

inherit
	EIFFEL_LIST [PARENT_AS]
		redefine
			process, first_token, last_token
		end

create
	make,
	make_filled_with

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_parent_list_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				Result := Precursor (a_list)
			elseif inherit_keyword_index /= 0 then
				Result := inherit_keyword (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				Result := Precursor (a_list)
				if (Result = Void or else Result.is_null) and inherit_keyword_index /= 0 then
					Result := inherit_keyword (a_list)
				end
			end
		end

feature -- Roundtrip

	inherit_keyword_index: INTEGER
			-- Keyword "inherit" associated with current AST node.

	lcurly_symbol_index, rcurly_symbol_index: INTEGER
			-- Index in a match list for symbol '{' associated with current AST
			-- node if non-conforming inheritance is specified.

	none_id_as_index: INTEGER
			-- 'NONE' ID_AS used for specifying non-conforming inheritance.

	inherit_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "inherit" associated with current AST node.
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, inherit_keyword_index)
		end

	lcurly_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol '{' associated with current AST node if non-conforming inheritance is specified.
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, lcurly_symbol_index)
		end

	rcurly_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol '}' associated with current AST node if non-conforming inheritance is specified.
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, rcurly_symbol_index)
		end

	none_id_as (a_list: LEAF_AS_LIST): detachable ID_AS
			-- 'NONE' ID_AS used for specifying non-conforming inheritance.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := none_id_as_index
			if a_list.valid_index (i) then
					-- It is not an ID_AS, because the roundtrip parser does not store ID_AS
					-- but LEAF_STUB_AS, so we reconstruct the associated ID_AS from the LEAF_STUB_AS.
				if attached {LEAF_STUB_AS} a_list.i_th (i) as l_leaf and then attached l_leaf.literal_text (a_list) as l_text then
					create Result.initialize (l_text)
					Result.set_position (l_leaf.line, l_leaf.column, l_leaf.position, l_leaf.location_count,
						l_leaf.character_column, l_leaf.character_position, l_leaf.character_count)
					Result.set_index (l_leaf.index)
				end
			end
		end

	set_inheritance_tokens (a_inherit_keyword: like inherit_keyword; a_left_curly_symbol: like lcurly_symbol; a_none_id_as: like none_id_as; a_right_curly_symbol: like rcurly_symbol)
			-- Set tokens associated with inheritance clause.
		do
			if a_inherit_keyword /= Void then
				inherit_keyword_index := a_inherit_keyword.index
			end
			if a_left_curly_symbol /= Void then
				lcurly_symbol_index := a_left_curly_symbol.index
			end
			if a_none_id_as /= Void then
				none_id_as_index := a_none_id_as.index
			end
			if a_right_curly_symbol /= Void then
				rcurly_symbol_index := a_right_curly_symbol.index
			end
		ensure
			inherit_keyword_set: a_inherit_keyword /= Void implies inherit_keyword_index = a_inherit_keyword.index
			lcurly_symbol_set: a_left_curly_symbol /= Void implies lcurly_symbol_index = a_left_curly_symbol.index
			none_id_as_set: a_none_id_as /= Void implies none_id_as_index = a_none_id_as.index
			rcurly_symbol_set: a_right_curly_symbol /= Void implies rcurly_symbol_index = a_right_curly_symbol.index
		end

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
