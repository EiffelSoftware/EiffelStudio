note
	description: "Object that represents a region of tokens of an AST node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_TOKEN_REGION

create
	make

feature{NONE} -- Implementation

	make (a_start_index, a_end_index: INTEGER)
			-- Create a region between indexes `a_start_index' and `a_end_index'.
		require
			valid_start: a_start_index >= 1
			valid_bounds: a_start_index <= a_end_index
		do
			start_index := a_start_index
			end_index := a_end_index
		ensure
			start_index_set: start_index = a_start_index
			end_index_set: end_index = a_end_index
		end

	make_empty
			-- Create an empty region.
		do
			start_index := 1
			end_index := 0
		ensure
			start_index_set: start_index = 1
			end_index_set: end_index = 0
		end

feature -- Status reporting

	is_empty: BOOLEAN
			-- Is region empty?
		do
			Result := start_index = end_index - 1
		end

	is_valid_region (a_start_index, a_end_index: INTEGER): BOOLEAN
			-- Is region specified by `a_start_index' and `a_end_index' valid?
		obsolete
			"Do not use since per invariant this is always true."
		do
			Result := True
		end

	is_overlap_region (other: like Current): BOOLEAN
			-- Is `other' overlap with current?
			-- False for empty sets.
		do
			if other.is_empty or else is_empty then
				Result := False
			else
				Result := (other.start_index < start_index and other.end_index > start_index and other.end_index < end_index) or
					 (other.start_index > start_index and other.start_index < end_index and other.end_index > end_index)
			end
		end

	is_disjoint_region (other: like Current): BOOLEAN
			-- Is `other' disjoint from current?
			-- True for empty sets.
		require
			other_not_void: other /= Void
		do
			if other.is_empty or else is_empty then
				Result := True
			else
				Result := other.end_index < start_index or other.start_index > end_index
			end
		end

	is_sub_region (other: like Current): BOOLEAN
			-- Is current a sub region of `other'?
			-- False for empty sets.
		require
			other_not_void: other /= Void
		do
			if other.is_empty or is_empty then
				Result := False
			else
				Result := start_index >= other.start_index and end_index <= other.end_index
			end
		end

	is_true_sub_region (other: like Current): BOOLEAN
			-- Is current a true sub region of `other'?
			-- False for empty sets.
		require
			other_not_void: other /= Void
		do
			if other.is_empty or else is_empty then
				Result := False
			else
				Result := start_index > other.start_index and end_index < other.end_index
			end
		end

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to current?
		require
			other_not_void: other /= Void
		do
			Result := start_index = other.start_index and end_index = other.end_index
		ensure
			equal: Result implies (start_index = other.start_index and end_index = other.end_index)
		end

feature -- Access

	start_index: INTEGER
			-- Start index (in LEAF_AS_LIST)of current region

	end_index: INTEGER;
			-- End index (in LEAF_AS_LIST)of current region

invariant
	definition: start_index <= end_index + 1
	empty_implies_one_bound: start_index = end_index + 1 implies start_index = 1

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
