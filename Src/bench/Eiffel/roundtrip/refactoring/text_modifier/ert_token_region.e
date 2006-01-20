indexing
	description: "Object that represents a region of tokens of an AST node"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_TOKEN_REGION

create
	make

feature{NONE} -- Implementation

	make (a_start_index, a_end_index: INTEGER) is
			--
		require
			valid_region: is_valid_region (a_start_index, a_end_index)
		do
			start_index := a_start_index
			end_index := a_end_index
		ensure
			start_index_set: start_index = a_start_index
			end_index_set: end_index = a_end_index
		end

feature -- Status reporting

	is_valid_region (a_start_index, a_end_index: INTEGER): BOOLEAN is
			-- Is region specified by `a_start_index' and `a_end_index' valid?
		do
			Result := a_start_index > 0 and a_end_index >= a_start_index
		end

	is_overlap_region (other: like Current): BOOLEAN is
			-- Is `other' overlap with current?
		do
			Result := (other.start_index < start_index and other.end_index > start_index and other.end_index < end_index) or
					 (other.start_index > start_index and other.start_index < end_index and other.end_index > end_index)
		end

	is_disjoint_region (other: like Current): BOOLEAN is
			-- Is `other' disjoint from current?
		require
			other_not_void: other /= Void
			other_valid: is_valid_region (other.start_index, other.end_index)
		do
			Result := other.end_index < start_index or other.start_index > end_index
		end

	is_sub_region (other: like Current): BOOLEAN is
			-- Is current a sub region of `other'?
		require
			other_not_void: other /= Void
			other_valid: is_valid_region (other.start_index, other.end_index)
		do
			Result := start_index >= other.start_index and end_index <= other.end_index
		end

	is_true_sub_region (other: like Current): BOOLEAN is
			-- Is current a true sub region of `other'?
		require
			other_not_void: other /= Void
			other_valid: is_valid_region (other.start_index, other.end_index)
		do
			Result := start_index > other.start_index and end_index < other.end_index
		end

	is_equivalent (other: like Current): BOOLEAN is
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

	end_index: INTEGER
			-- End index (in LEAF_AS_LIST)of current region

end
