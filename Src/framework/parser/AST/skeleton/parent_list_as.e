indexing
	description: "Object that represents a list of PARENT_AS nodes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
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
	make_filled

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_parent_list_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			elseif inherit_keyword_index /= 0 then
				Result := inherit_keyword (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
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

	inherit_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "inherit" associated with current AST node.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := inherit_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	lcurly_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Symbol '{' associated with current AST node if non-conforming inheritance is specified.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := lcurly_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	rcurly_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Symbol '}' associated with current AST node if non-conforming inheritance is specified.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rcurly_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	none_id_as (a_list: LEAF_AS_LIST): ID_AS
			-- 'NONE' ID_AS used for specifying non-conforming inheritance.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := none_id_as_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	set_inheritance_tokens (a_inherit_keyword: like inherit_keyword; a_left_curly_symbol: like lcurly_symbol; a_none_id_as: like none_id_as; a_right_curly_symbol: like rcurly_symbol) is
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end
