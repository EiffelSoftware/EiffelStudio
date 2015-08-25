note
	description: "Abstract description for qualified anchored type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	QUALIFIED_ANCHORED_TYPE_AS

inherit
	TYPE_AS
		redefine
			first_token, has_anchor, last_token
		end

create
	make_anchored,
	make_explicit

feature {NONE} -- Initialization

	make_anchored (t: like qualifier; d: detachable SYMBOL_AS; f: ID_AS)
			-- Create an anchored type of the form "t.f" where "t" is known to be an anchored type.
		require
			t_attached: attached t
			t_anchored: attached {LIKE_CUR_AS} t or attached {LIKE_ID_AS} t
			f_attached: attached f
		do
			qualifier := t
			create chain.make (1)
			extend (d, f)
		ensure
			qualifier_set: qualifier = t
			chain_attached: attached chain
			chain_of_one_element: chain.count = 1
			name_set: chain.last.name = f
			separator_set: attached d implies attached chain.separator_list as s and then s.last = d.index
		end

	make_explicit (l: like like_keyword; t: like qualifier; d: detachable SYMBOL_AS; f: ID_AS)
			-- Create an anchored type of the form "like {t}.f".
		require
			t_attached: attached t
			f_attached: attached f
		do
			if attached l then
				like_keyword_index := l.index
			end
			qualifier := t
			create chain.make (1)
			extend (d, f)
		ensure
			like_keyword_set: attached l implies like_keyword_index = l.index
			qualifier_set: qualifier = t
			chain_attached: attached chain
			chain_of_one_element: chain.count = 1
			name_set: chain.last.name = f
			separator_set: attached d implies attached chain.separator_list as s and then s.last = d.index
		end

feature -- Status

	has_anchor: BOOLEAN = True
			-- <Precursor>

feature -- Modification

	extend (d: detachable SYMBOL_AS; i: ID_AS)
			-- Add a new element to the end of the anchor chain.
			-- E.g., a calling with ".d" on "like a.b.c" produces "like a.b.c.d".
		require
			attached_i: i /= Void
		do
			if attached d then
				chain.extend_separator (d)
			end
			chain.extend (create {FEATURE_ID_AS}.make (i))
		ensure
			extended: chain.last.name = i
			separator_list_extended: attached d implies attached chain.separator_list as s and then s.last = d.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- <Precursor>
		do
			v.process_qualified_anchored_type_as (Current)
		end

feature -- Roundtrip

	like_keyword_index: INTEGER
			-- Index of keyword "like" associated with this structure (0 if none)

	like_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "like" associated with this structure (if any)
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := like_keyword_index
			if i /= 0 and then a_list.valid_index (i) and then attached {like like_keyword} a_list.i_th (i) as r then
				Result := r
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := like_keyword_index
		end

feature -- Attributes

	qualifier: TYPE_AS
			-- First part of the chain, including explicit or anchored type
			-- E.g., "like a" for "like a.b.c.d" and "{A}" for "like {A}.b.c.d"

	chain: EIFFEL_LIST [FEATURE_ID_AS]
			-- Last part of the anchored type, including all feature names in the chain
			-- E.g.: "b, c, d" for "like a.b.c.d" and "like {A}.b.c.d"

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := Precursor (a_list)
			if Result = Void then
				if a_list /= Void then
					Result := like_keyword (a_list)
				end
				if Result = Void then
					Result := qualifier.first_token (a_list)
				end
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := chain.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result :=
				equivalent (qualifier, other.qualifier) and then
				equivalent (chain, other.chain) and then
				has_same_marks (other)
		end

feature -- Output

	dump: STRING
			-- Dump string
		do
			create Result.make (8)
			dump_marks (Result)
			if attached {LIKE_CUR_AS} qualifier as q then
				Result.append_string (q.dump)
			elseif attached {LIKE_ID_AS} qualifier as q then
				Result.append_string (q.dump)
			else
				Result.append_string ("like {")
				Result.append_string (qualifier.dump)
				Result.append_character ('}')
			end
			chain.do_all (
				agent (i: FEATURE_ID_AS; s: STRING)
					do
						s.append_character ('.')
						s.append_string (i.name.name)
					end
				(?, Result)
			)
		end

invariant
	qualifier_attached: attached qualifier
	chain_attached: attached chain
	chain_not_empty: not chain.is_empty

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
