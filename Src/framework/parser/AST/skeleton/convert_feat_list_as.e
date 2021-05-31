note
	description: "Object that represents a CONVERT_FEAT_AS list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERT_FEAT_LIST_AS

inherit
	EIFFEL_LIST [CONVERT_FEAT_AS]
		redefine
			process, first_token
		end

create
	make, make_filled_with

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_convert_feat_list_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				Result := Precursor (a_list)
			elseif convert_keyword_index /= 0 then
				Result := convert_keyword (a_list)
			end
		end

feature -- Roundtrip

	convert_keyword_index: INTEGER
			-- Index of keyword "convert" associated with current AST node

	convert_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "convert" associated with current AST node
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, convert_keyword_index)
		end

	set_convert_keyword (a_keyword: detachable KEYWORD_AS)
			-- Set `convert_keyword' with `a_keyword'.
		do
			if a_keyword /= Void then
				convert_keyword_index := a_keyword.index
			end
		ensure
			convert_keyword_set: a_keyword /= Void implies convert_keyword_index = a_keyword.index
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
