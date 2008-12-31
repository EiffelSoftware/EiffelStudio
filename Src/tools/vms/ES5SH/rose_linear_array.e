note
	description: "Multiple purpose array which is linear, extendable, sortable and iterable"
	attention: "[
		You must have an EXCELLENT reason to modify this class, especially if:
		- you are adding/removing an attribute
		- adding an ancestor
		Keep in mind that a non negligeable amount of instances of this object will
		typically be present in any system from the RC
	]"
	author: "Mark Howard"
	date: "$Date$"
	revision: "$Revision$"
	archive: "$Archive: /Beta/Kernel/Containers/rose_linear_array.e $"

class
	ROSE_LINEAR_ARRAY [G]

inherit
	SORTABLE_ARRAY [G]
		redefine
			binary_search,
			linear_search
		end
		
create
	make, make_empty, make_from_array, make_from_linear

feature -- Access

	infix "+" (a_other: LINEAR [G]): like Current
			-- Union of 'Current' and 'a_other'
		require
			valid_other: a_other /= Void
		do
			Result := clone (Current)
			if a_other /= Void  then
				from a_other.start until a_other.off loop
					Result.extend (a_other.item)
					a_other.forth
				end
			end
		end

	subset (a_indices: ARRAY [INTEGER]): like Current
			-- Subset composed of items at 'a_indices' from this array
		local
			i, j, k: INTEGER
		do
			k := a_indices.count
			create Result.make (1,k)
			from i := 1 until i > k loop
				j := a_indices.item (i)
				if not valid_index (j) then
					(create {EXCEPTIONS}).raise ("Invalid index given to ROSE_LINEAR_ARRAY.subset")
				end
				Result.put (item (j),i)
				i := i + 1
			end
		end

	values_intersect (a_linear: LINEAR [G]): BOOLEAN
		do
			from a_linear.start until Result or else a_linear.off loop
				Result := has_value (a_linear.item)
				a_linear.forth
			end
		end

	references_intersect (a_linear: LINEAR [G]): BOOLEAN
		do
			from a_linear.start until Result or else a_linear.off loop
				Result := has_reference (a_linear.item)
				a_linear.forth
			end
		end

	min_max (a_comparison: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]): PAIR [G,G]
		do
			if not is_empty then
				from
					start
					create Result.make (item (lower),item (lower))
				until
					off
				loop
					if a_comparison.item ([current_item,Result.first]) then
						Result.set_first (current_item)
					end
					if a_comparison.item ([Result.second,current_item]) then
						Result.set_second (current_item)
					end
					forth
				end
			end
		end

	ordered_quotient (a_order : FUNCTION [ANY,TUPLE [G,G],BOOLEAN]; a_equivalent: FUNCTION [ANY,TUPLE [G,G],BOOLEAN]): ROSE_LINEAR_ARRAY [ROSE_LINEAR_ARRAY [G]]
		local
			l_array : ROSE_LINEAR_ARRAY [G]
		do
			create l_array.make_from_array (Current)
			l_array.sort_by (a_order)
			Result := l_array.quotient (a_equivalent)
		end

	quotient (a_equivalent: FUNCTION [ANY,TUPLE [G,G],BOOLEAN]): ROSE_LINEAR_ARRAY [ROSE_LINEAR_ARRAY [G]]
		local
			l_last: G
			l_array: ROSE_LINEAR_ARRAY [G]
		do
			create Result.make_empty
			from start until off loop
				if index = lower then
					create l_array.make_empty
					l_array.extend (current_item)
					Result.extend (l_array)
				else
					if a_equivalent.item ([current_item,l_last]) then
						l_array.extend (current_item)
					else
						create l_array.make_empty
						Result.extend (l_array)
						l_array.extend (current_item)
					end
				end
				l_last := current_item
				forth
			end
		end

feature -- Basic operations

	comparison: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]

	sort_by (a_comparison: FUNCTION [ANY, TUPLE [G, G], BOOLEAN])
			-- Sort this array using 'a_comparison'.
		do
			comparison := a_comparison
			sort
			comparison := Void
		end

	sort_by_and_remember (a_routine: FUNCTION [ANY, TUPLE [G, G], BOOLEAN])
			-- Sort this array using 'a_comparison', and remember 'a_comparison' for further searching
		require
			need_comparison: a_routine /= Void or comparison /= Void
		do
			if a_routine /= Void then
				comparison := a_routine
			end
			sort
		end

	binary_search (a_g: G)
		do
			Precursor (a_g)
			index := found_index
		end

	linear_search (a_g: G)
		do
			Precursor (a_g)
			index := found_index
		end

	merge_values (a_linear: LINEAR [G])
		do
			from a_linear.start until a_linear.off loop
				if not has_value (a_linear.item) then
					extend (a_linear.item)
				end
				a_linear.forth
			end
		end

	merge_references (a_linear: LINEAR [G])
		do
			from a_linear.start until a_linear.off loop
				if not has_reference (a_linear.item) then
					extend (a_linear.item)
				end
				a_linear.forth
			end
		end

	union_values (a_linear: LINEAR [G]): like Current
		do
			Result := clone (Current)
			Result.merge_values (a_linear)
		end

	union_references (a_linear: LINEAR [G]): like Current
		do
			Result := clone (Current)
			Result.merge_references (a_linear)
		end

	selected_items(a_ixs : ARRAY[INTEGER]) : like Current
		local
			i, l_ix : INTEGER
		do
			if a_ixs /= Void then
				create Result.make(1, a_ixs.count)
				from i := 1 until i > a_ixs.count loop
					l_ix := a_ixs.item(i)
					if valid_index(l_ix) then
						Result.put(item(l_ix), i)
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Comparison

	less_than (a, b: G): BOOLEAN
		do
			if a /= Void and b /= Void then
				Result := comparison.item ([a,b])
			elseif a /= Void and b = Void then
				Result := True
			else
				Result := False
			end
		end

end -- class ROSE_LINEAR_ARRAY
