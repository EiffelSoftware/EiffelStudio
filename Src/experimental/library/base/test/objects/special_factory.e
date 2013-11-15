note
	description: "A factory class for generating different SPECIAL objects."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	SPECIAL_FACTORY

feature -- Constants

	Default_size: INTEGER = 5
			-- The default size for any SPECIAL object.

feature -- Access

	all_special: ARRAYED_LIST [SPECIAL[detachable ANY]]
			-- All objects of type SPECIAL.
		do
			create Result.make (50)
			Result.append (all_basic_special)
			Result.append (all_reference_special)
			Result.append (all_copysemantics_special)
		end

feature -- Basic types

	all_basic_special: ARRAYED_LIST [SPECIAL[detachable ANY]]
			-- Return a collection of SPECIAL[XX], where XX is of a basic type.
		do
			create Result.make (14)

				-- Integers
			Result.extend (create {SPECIAL[INTEGER_8]}.make_filled (1, Default_size))
			Result.extend (create {SPECIAL[INTEGER_16]}.make_filled (1, Default_size))
			Result.extend (create {SPECIAL[INTEGER_32]}.make_filled (1, Default_size))
			Result.extend (create {SPECIAL[INTEGER_64]}.make_filled (1, Default_size))

				-- Naturals
			Result.extend (create {SPECIAL[NATURAL_8]}.make_filled (1, Default_size))
			Result.extend (create {SPECIAL[NATURAL_16]}.make_filled (1, Default_size))
			Result.extend (create {SPECIAL[NATURAL_32]}.make_filled (1, Default_size))
			Result.extend (create {SPECIAL[NATURAL_64]}.make_filled (1, Default_size))

				-- Reals
			Result.extend (create {SPECIAL[REAL_32]}.make_filled (1, Default_size))
			Result.extend (create {SPECIAL[REAL_64]}.make_filled (1, Default_size))

				-- Characters
			Result.extend (create {SPECIAL[CHARACTER_8]}.make_filled ('a', Default_size))
			Result.extend (create {SPECIAL[CHARACTER_32]}.make_filled ('a', Default_size))

				-- Boolean
			Result.extend (create {SPECIAL[BOOLEAN]}.make_filled (True, Default_size))

				-- Pointer
			Result.extend (create {SPECIAL[POINTER]}.make_filled (default_pointer, Default_size))
		end

feature -- Reference types

	all_reference_special: ARRAYED_LIST [SPECIAL[detachable ANY]]
			-- All reference special objects.
		do
			create Result.make (7)
			Result.extend (empty_special)
			Result.extend (void_special)
			Result.extend (same_any_special)
			Result.extend (different_any_special)
			Result.extend (object_graph_special)
			Result.extend (special_special_same_any)
			Result.extend (special_special_different_any)
		end

	empty_special: SPECIAL [detachable ANY]
			-- An empty SPECIAL.
		do
			create Result.make_empty (Default_size)
		end

	void_special: SPECIAL [detachable ANY]
			-- A SPECIAL containing only Void.
		do
			create Result.make_filled (Void, Default_size)
		end

	same_any_special: SPECIAL [ANY]
			-- A SPECIAL filled with the same ANY object.
		do
			create Result.make_filled (create {ANY}, Default_size)
		end

	different_any_special: SPECIAL [ANY]
			-- A SPECIAL filled with different ANY objects.
		do
			across
				1 |..| Default_size as index
			from
				create Result.make_empty (Default_size)
			loop
				Result.extend (create {ANY})
			end
		end

	object_graph_special: SPECIAL [OBJECT_GRAPH_ITEM]
			-- A SPECIAL filled with OBJECT_GRAPH_ITEMs all sharing a common object.
		local
			shared, new: OBJECT_GRAPH_ITEM
		do
			across
				1 |..| Default_size as index
			from
				create Result.make_empty (Default_size)
				create shared
			loop
				create new
				new.first := shared
				Result.extend (new)
			end
		end

	special_special_same_any: SPECIAL [SPECIAL [ANY]]
			-- A SPECIAL containing SPECIAL[ANY] object, where the ANY object is always the same.
		local
			any: ANY
			inner: SPECIAL[ANY]
		do
			across
				1 |..| Default_size as index
			from
				create Result.make_empty (Default_size)
				create any
			loop
				create inner.make_filled (any, Default_size)
				Result.extend (inner)
			end
		end


	special_special_different_any: SPECIAL [SPECIAL [ANY]]
			-- A SPECIAL containing SPECIAL[ANY] object, where the ANY object is always different.
		local
			inner: SPECIAL[ANY]
		do
			across
				1 |..| Default_size as index
			from
				create Result.make_empty (Default_size)
			loop

				across
					1 |..| Default_size as index2
				from
					create inner.make_empty (Default_size)
				loop
					inner.extend (create {ANY})
				end

				Result.extend (inner)
			end
		end


feature -- Copy-semantics references

	all_copysemantics_special: ARRAYED_LIST [SPECIAL[detachable ANY]]
			-- All SPECIAL objects containing copy-semantics objects.
		do
			create Result.make (5)
			Result.extend (special_any_with_integer)
			Result.extend (special_any_with_expanded)
			Result.extend (special_with_expanded)
			Result.extend (special_with_expanded_and_copysemantics)
		end

	special_any_with_integer: SPECIAL[ANY]
			-- A SPECIAL[ANY] filled with integer values.
		do
			across
				1 |..| Default_size as index
			from
				create Result.make_empty (Default_size)
			loop
				Result.extend (index.item)
			end
		end

	special_any_with_expanded: SPECIAL[ANY]
			-- A SPECIAL[ANY] with a userdefined expanded object.
		local
			cell: E_DOUBLE_CELL [detachable ANY, detachable ANY]
		do
			cell.first := create {ANY}
			cell.second := create {ANY}

			across
				1 |..| Default_size as index
			from
				create Result.make_empty (Default_size)
			loop
				Result.extend (cell)
			end
		end

	special_with_expanded: SPECIAL[ E_DOUBLE_CELL [detachable ANY, detachable ANY]]
			-- A SPECIAL with a user-defined expanded object.
		local
			cell: E_DOUBLE_CELL [detachable ANY, detachable ANY]
		do
			cell.first := create {ANY}
			cell.second := create {ANY}

			create Result.make_filled (cell, Default_size)
		end

	special_with_expanded_and_copysemantics: SPECIAL[ E_DOUBLE_CELL [detachable ANY, detachable ANY]]
			-- A SPECIAL containing a user-defined expanded object, containing a copy-semantics object.
		local
			cell: E_DOUBLE_CELL [detachable ANY, detachable ANY]
		do
			cell.first := 42
			cell.second := create {ANY}

			create Result.make_filled (cell, Default_size)
		end

end
