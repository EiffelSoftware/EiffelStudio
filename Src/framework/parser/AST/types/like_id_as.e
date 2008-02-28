indexing
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
			first_token, last_token
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (a: like anchor; l_as: like like_keyword; m_as: like attachment_mark; a_m: like has_attached_mark; d_m: like has_detachable_mark) is
			-- Create a new LIKE_ID AST node.
		require
			a_not_void: a /= Void
			correct_attachment_status: not (a_m and d_m)
		do
			anchor := a
			if m_as /= Void then
				attachment_mark_index := m_as.index
			end
			if l_as /= Void then
				like_keyword_index := l_as.index
			end
			has_attached_mark := a_m
			has_detachable_mark := d_m
		ensure
			anchor_set: anchor = a
			like_keyword_set: l_as /= Void implies like_keyword_index = l_as.index
			attachment_mark_set: m_as /= Void implies attachment_mark_index = m_as.index
			has_attached_mark_set: has_attached_mark = a_m
			has_detachable_mark_set: has_detachable_mark = d_m
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_like_id_as (Current)
		end

feature -- Status

	has_attached_mark: BOOLEAN
			-- Is attached mark specified?

	has_detachable_mark: BOOLEAN
			-- Is detachable mark specified?

feature -- Roundtrip

	attachment_mark_index: INTEGER
			-- Index of attachment symbol (if any)

	like_keyword_index: INTEGER
			-- Index of keyword "like" associated with this structure		

	like_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Keyword "like" associated with this structure		
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := like_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	attachment_mark (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Attachment symbol (if any)
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := attachment_mark_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Attributes

	anchor: ID_AS
			-- Anchor name

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				if a_list /= Void and attachment_mark_index /= 0 then
					Result := attachment_mark (a_list)
				elseif a_list /= Void and like_keyword_index /= 0 then
					Result := like_keyword (a_list)
				else
					Result := anchor.first_token (a_list)
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := anchor.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (anchor, other.anchor) and then
				has_attached_mark = other.has_attached_mark and then
				has_detachable_mark = other.has_detachable_mark
		end

feature -- Output

	dump: STRING is
			-- Dump string
		do
			create Result.make (7 + anchor.name.count)
			if has_attached_mark then
				Result.append_character ('!')
			else
				Result.append_character ('?')
			end
			Result.append ("like ")
			Result.append (anchor.name)
		end

feature {LIKE_ID_AS} -- Replication

	set_anchor (a: like anchor) is
		do
			anchor := a
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class LIKE_ID_AS
