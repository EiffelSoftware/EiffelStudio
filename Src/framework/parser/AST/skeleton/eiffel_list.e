note
	description: "List used in abstract syntax trees."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_LIST [T -> AST_EIFFEL]

inherit
	AST_EIFFEL
		undefine
			copy, is_equal
		end

	CONSTRUCT_LIST [T]
		export
			{ANY} area, do_all_with_index
		redefine
			make, make_filled, make_filled_with
		end

create
	make,
	make_filled_with,
	make_from_iterable

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Creation of the list with the comparison set on object.
		do
			Precursor (n)
			object_comparison := True
		end

	make_filled (n: INTEGER)
			-- <Precursor>
		obsolete "Use `make` or `make_filled_with` instead. [2021-05-31]"
		do
			Precursor (n)
			object_comparison := True
		end

	make_filled_with (v: T; n: INTEGER)
			-- <Precursor>
		do
			Precursor (v, n)
			object_comparison := True
		ensure then
			object_comparison
		end

feature -- Roundtrip

	separator_list: detachable CONSTRUCT_LIST [INTEGER]
			-- List to store terminals that appear before the first or in between every 2 items of this list.
		note
			option: stable
		attribute
		end

	separator_list_i_th (i: INTEGER; a_list: LEAF_AS_LIST): detachable LEAF_AS
			-- Terminals at position `i' in `separator_list' using `a_list'.
		require
			valid_index: attached separator_list as l_sep implies l_sep.valid_index (i)
			a_list_not_void: a_list /= Void
		local
			n: INTEGER
		do
			if attached separator_list as l_sep then
				n := l_sep.i_th (i)
				if a_list.valid_index (n) then
					Result := a_list.i_th (n)
				end
			end
		end

	reverse_extend_separator (a: LEAF_AS)
			-- Put `a` to `separator_list` in reverse order.
		require
			capacity > 1
		local
			l: like separator_list
		do
			l := separator_list
			if attached l then
				l.reverse_extend (a.index)
			else
				create l.make_filled_with (a.index, capacity - 1)
				separator_list := l
			end
		end

	extend_separator (l: LEAF_AS)
			-- Add `l' at the end of the `separator_list'.
		require
			l_attached: attached l
		local
			l_sep: like separator_list
		do
			l_sep := separator_list
			if l_sep = Void then
				create l_sep.make (1)
				separator_list := l_sep
			end
			l_sep.extend (l.index)
		ensure
			separator_list_attached: attached separator_list
			l_added: separator_list.last = l.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_eiffel_list (Current)
		end

feature -- Access

	reversed_first: T
		require
			not_empty: not is_empty
		do
			Result := area.item (insertion_position)
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
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

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
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

	merge_after_position (p: INTEGER; other: LIST [T])
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

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
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
