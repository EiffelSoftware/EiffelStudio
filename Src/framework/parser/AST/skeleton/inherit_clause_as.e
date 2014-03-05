note
	description: "Object that represents an inherit clause: rename, export, undefine, redefine or select"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INHERIT_CLAUSE_AS [G -> EIFFEL_LIST [AST_EIFFEL]]

inherit
	AST_EIFFEL

	EIFFEL_LIST_WRAPPER_AS [G]

feature{NONE} -- Initialization

	make (l: like content; k_as: like clause_keyword)
			-- Initialize.
		require
			l_valid: l /= Void and then not l.is_empty
		do
			content := l
			if k_as /= Void then
				clause_keyword_index := k_as.index
			end
		ensure
			content_set: content = l
			clause_keyword_set: k_as /= Void implies clause_keyword_index = k_as.index
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and clause_keyword_index /= 0 then
				Result := clause_keyword (a_list)
			end
			if Result = Void or else Result.is_null then
				Result := content.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := content.last_token (a_list)
			if (Result = Void or else Result.is_null) and a_list /= Void and clause_keyword_index /= 0 then
				Result := clause_keyword (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := content.is_equivalent (other.content)
		end

feature -- Roundtrip

	clause_keyword_index: INTEGER
			-- Index of keyword "rename", "export", "undefine", "redefine" or "select" associated with current AST node

	clause_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "rename", "export", "undefine", "redefine" or "select" associated with current AST node
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, clause_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := clause_keyword_index
		end

invariant
	content_not_empty: not content.is_empty

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
