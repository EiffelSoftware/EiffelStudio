indexing
	description	: "List used in abstract syntax trees. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class EIFFEL_LIST [reference T -> AST_EIFFEL]

inherit
	AST_EIFFEL
		undefine
			copy, is_equal
		redefine
			is_equivalent
		end

	CONSTRUCT_LIST [T]
		export
			{ANY} area
		redefine
			make, make_filled
		end

create
	make, make_filled

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
				-- We always use 1 for lower so we can optimize array setup.
			lower := 1
			upper := n
			create area.make (n)
			object_comparison := True
		end

	make_filled (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
				-- We always use 1 for lower so we can optimize array setup.
			lower := 1
			upper := n
			count := n
			create area.make (n)
			object_comparison := True
		end

feature -- Roundtrip

	separator_list: CONSTRUCT_LIST [INTEGER]
			-- List to store terminals that appear in between every 2 items of this list

	separator_list_i_th (i: INTEGER; a_list: LEAF_AS_LIST): LEAF_AS is
			-- Terminals at position `i' in `separator_list' using `a_list'.
		require
			valid_index: separator_list.valid_index (i)
			a_list_not_void: a_list /= Void
		local
			n: INTEGER
		do
			n := separator_list.i_th (i)
			if a_list.valid_index (n) then
				Result ?= a_list.i_th (n)
			end
		end

	reverse_extend_separator (l_as: LEAF_AS) is
			-- Add `l_as' into `separator_list'.
		do
			if separator_list = Void then
				if capacity >= 2 then
					create separator_list.make (capacity - 1)
				else
						-- One should never get here as this will yield in a call on void.
					check one_should_never_get_here: false end
				end
			end
			separator_list.reverse_extend (l_as.index)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_eiffel_list (Current)
		end

feature -- Access

	reversed_first: T is
		require
			not_empty: not is_empty
		do
			Result := area.item (capacity - count)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if not is_empty then
					Result := area.item (0).first_token (a_list)
				else
					Result := Void
				end
			else
				if not is_empty then
					Result := i_th (1).first_token (a_list)
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if not is_empty then
					Result := area.item (count - 1).last_token (a_list)
				else
					Result := Void
				end
			else
				if not is_empty then
					Result := i_th (count).last_token (a_list)
				end
			end
		end

feature -- Element change

	merge_after_position (p: INTEGER; other: LIST [T]) is
			-- Merge `other' after position `p', i.e. replace
			-- items after `p' with items from `other'.
		require
			other_fits: other.count <= count - p
		local
			i, max: INTEGER
			cur: CURSOR
			l_area: SPECIAL [T]
		do
			from
				l_area := area
				i := p
				max := p + other.count
				cur := other.cursor
				other.start
			until
				i = max
			loop
				l_area.put (other.item, i)
				other.forth
				i := i + 1
			end

			other.go_to (cur)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			l_area, o_area: SPECIAL [T]
			i, nb: INTEGER
		do
			nb := other.count
			if count = nb then
				from
					l_area := area
					o_area := other.area
					Result := True
				until
					not Result or else i = nb
				loop
					Result := equivalent (l_area.item (i), o_area.item (i))
					i := i + 1
				end
			end
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

end -- class EIFFEL_LIST
