note
	description: "Abstract description for `like id' type. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LIKE_ID_AS

inherit
	TYPE_AS
		redefine
			first_token, has_anchor, last_token
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (a: like anchor; l_as: like like_keyword)
			-- Create a new LIKE_ID AST node.
		require
			a_not_void: a /= Void
		do
			anchor := a
			if l_as /= Void then
				like_keyword_index := l_as.index
			end
		ensure
			anchor_set: anchor = a
			like_keyword_set: l_as /= Void implies like_keyword_index = l_as.index
		end

feature -- Status

	has_anchor: BOOLEAN = True
			-- <Precursor>

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_like_id_as (Current)
		end

feature -- Roundtrip

	like_keyword_index: INTEGER
			-- Index of keyword "like" associated with this structure		

	like_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "like" associated with this structure		
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, like_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := like_keyword_index
		end

feature -- Attributes

	anchor: ID_AS
			-- Anchor name

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := Precursor (a_list)
			if Result = Void then
				if a_list /= Void and like_keyword_index /= 0 then
					Result := like_keyword (a_list)
				else
					Result := anchor.first_token (a_list)
				end
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := anchor.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (anchor, other.anchor) and then
				has_same_marks (other)
		end

feature -- Output

	dump: STRING
			-- Dump string
		do
			create Result.make (7 + anchor.name.count)
			dump_marks (Result)
			Result.append ("like ")
			Result.append (anchor.name)
		end

feature {LIKE_ID_AS} -- Replication

	set_anchor (a: like anchor)
		do
			anchor := a
		end

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

end -- class LIKE_ID_AS
