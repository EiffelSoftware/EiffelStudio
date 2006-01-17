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
			number_of_breakpoint_slots, is_equivalent
		end

	CONSTRUCT_LIST [T]
		export
			{ANY} area
		redefine
			make, make_filled
		end

	PRE_POST_AS
		undefine
			copy, is_equal
		end

create
	make, make_filled

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
			Precursor {CONSTRUCT_LIST} (n)
			compare_objects
		end

	make_filled (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
			Precursor {CONSTRUCT_LIST} (n)
			compare_objects
		end

feature -- Roundtrip

	separator_list: CONSTRUCT_LIST [AST_EIFFEL]
		-- List to store terminals that appear in between every 2 items of this list

	reverse_extend_separator (l_as: AST_EIFFEL) is
			-- Add `l_as' into `separator_list'.
		do
			if separator_list = Void then
				if capacity >= 2 then
					create separator_list.make (capacity - 1)
				end
			end
			separator_list.reverse_extend (l_as)
		end

	valid_remove_items (item_list: LIST [INTEGER]): BOOLEAN is
			-- Are items in `item_list' valid to be removed?
			-- e.g. items are not duplicated in `item_list' and item index are not too small or too large.
		require
			item_list /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
			l_item: INTEGER
		do
			create l_list.make (item_list.count)
			from
				item_list.start
				Result := True
			until
				item_list.after or not Result
			loop
				l_item := item_list.item
				Result := l_item >= 1 and l_item <= count and not l_list.has (l_item)
				if Result then
					l_list.extend (l_item)
					item_list.forth
				end
			end
		end

	can_remove_items (item_list: LIST [INTEGER]; a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can items specified in `item_list' be removed?
		require
			item_list_not_void: item_list /= Void
			item_list_not_empty: not item_list.is_empty
		local
			l_list: SORTED_TWO_WAY_LIST [INTEGER]
			l_sep_list: ARRAYED_LIST [INTEGER]
			l_cnt: INTEGER
			l_index: INTEGER
			l_sep_index: INTEGER
		do
			Result := valid_remove_items (item_list)
			if Result then
				l_list := sorted_remove_items (item_list)
				create l_sep_list.make (l_list.count)
				check
					separator_valid: separator_list /= Void implies separator_list.count = count - 1
				end
				l_cnt := 0
				if separator_list /= Void then
					l_cnt := separator_list.count
				end
				from
					l_list.start
				until
					l_list.after or not Result
				loop
					l_index := l_list.item
					Result := l_index <= count and then i_th (l_index).can_remove_all_text (a_list)
					if Result then
						if l_cnt > 0 then
							l_sep_index := last_to_be_removed_separator (l_index, l_sep_list)
							Result := Result and separator_list.i_th (l_sep_index).can_remove_all_text (a_list)
							if Result and not l_sep_list.has (l_sep_index) then
								l_sep_list.extend (l_sep_index)
							end
						end
					end
					l_list.forth
				end
			end
		end

	remove_items (item_list: LIST [INTEGER]; a_list: LEAF_AS_LIST) is
			-- Remove all items specified in `item_list'.
		require
			item_list_not_void: item_list /= Void
			item_list_not_empty: not item_list.is_empty
			items_can_be_removed: can_remove_items (item_list, a_list)
		local
			l_list: SORTED_TWO_WAY_LIST [INTEGER]
			l_sep_list: ARRAYED_LIST [INTEGER]
			l_cnt: INTEGER
			l_index: INTEGER
			l_sep_index: INTEGER
		do
			l_list := sorted_remove_items (item_list)
			create l_sep_list.make (l_list.count)
			l_cnt := 0
			if separator_list /= Void then
				l_cnt := separator_list.count
			end
			from
				l_list.start
			until
				l_list.after
			loop
				l_index := l_list.item
				i_th (l_index).remove_all_text (a_list)
				if l_cnt > 0 then
					l_sep_index := last_to_be_removed_separator (l_index, l_sep_list)
					if not l_sep_list.has (l_sep_index) then
						l_sep_list.extend (l_sep_index)
						separator_list.i_th (l_sep_index).remove_all_text (a_list)
					end
				end
				l_list.forth
			end
		end



feature{NONE} -- Roundtrip/Implementation

	sorted_remove_items (item_list: LIST [INTEGER]): SORTED_TWO_WAY_LIST [INTEGER] is
			-- Sorted `item_list'
		require
			item_list_not_void: item_list /= Void
			item_list_not_empty: not item_list.is_empty
			items_valid: valid_remove_items (item_list)
		do
			create Result.make
			from
				item_list.start
			until
				item_list.after
			loop
				Result.put_front (item_list.item)
				item_list.forth
			end
			Result.sort
		end

	last_to_be_removed_separator (attached_position: INTEGER; removed_separator_list: LIST [INTEGER]): INTEGER is
			-- Last separator that should be removed
		require
			attached_position_valid: attached_position >= 1 and attached_position <= count
			removed_separator_list_valid: removed_separator_list /= Void
		do
			if attached_position < count then
				Result := attached_position
			else
				from
					Result := attached_position - 1
				until
					Result = 1 or not removed_separator_list.has (Result)
				loop
					Result := Result - 1
				end
			end
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_eiffel_list (Current)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		local
			i, nb: INTEGER
			l_area: SPECIAL [T]
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				Result := Result + l_area.item (i).number_of_breakpoint_slots
				i := i + 1
			end
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if not is_empty then
					Result := area.item (0).complete_start_location (a_list)
				else
					Result := null_location
				end
			else
				if pre_as_list /= Void and then not pre_as_list.is_empty then
					Result := pre_as_list.complete_start_location (a_list)
				elseif not is_empty then
					Result := i_th (1).complete_start_location (a_list)
				elseif post_as_list /= Void and then not post_as_list.is_empty then
					Result := post_as_list.i_th (1).complete_start_location (a_list)
				else
					check
						should_not_arrive_here: False
					end
				end
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if not is_empty then
					Result := area.item (count - 1).complete_end_location (a_list)
				else
					Result := null_location
				end
			else
				if post_as_list /= Void and then not post_as_list.is_empty then
					Result := post_as_list.complete_end_location (a_list)
				elseif not is_empty then
					Result := i_th (count).complete_end_location (a_list)
				elseif pre_as_list /= Void and then not pre_as_list.is_empty then
					Result := pre_as_list.i_th (pre_as_list.count).complete_end_location (a_list)
				else
					check
						should_not_arrive_here: False
					end
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
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
