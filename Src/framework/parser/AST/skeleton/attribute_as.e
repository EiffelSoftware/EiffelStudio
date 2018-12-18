note
	description: "AST representation of an attribute body."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ATTRIBUTE_AS

inherit
	INTERNAL_AS
		redefine
			is_attribute
		end

create
	make

feature{NONE} -- Initialization

	make (c: like compound; l_as: like attribute_keyword)
			-- Create new DO AST node.
		do
			initialize (c)
			if l_as /= Void then
				attribute_keyword_index := l_as.index
			end
		ensure
			attribute_keyword_set: l_as /= Void implies attribute_keyword_index = l_as.index
		end

feature -- Properties

	is_attribute: BOOLEAN = True
			-- <Precursor>

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_attribute_as (Current)
		end

feature -- Roundtrip

	attribute_keyword_index: INTEGER
			-- Index of keyword "do" associated with this structure.

	attribute_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "do" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, attribute_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := attribute_keyword_index
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				if attached compound as l_compound then
					Result := l_compound.first_token (a_list)
				end
			elseif attribute_keyword_index /= 0 then
				Result := attribute_keyword (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached compound as l_compound then
				Result := l_compound.last_token (a_list)
			elseif a_list = Void then
					-- Non-roundtrip mode
				Result := Void
			elseif attribute_keyword_index /= 0 then
				Result := attribute_keyword (a_list)
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
