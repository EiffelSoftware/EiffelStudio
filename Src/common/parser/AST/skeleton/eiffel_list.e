indexing
	description	: "List used in abstract syntax trees. Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class EIFFEL_LIST [reference T -> AST_EIFFEL]

inherit
	AST_EIFFEL
		undefine
			copy, is_equal
		redefine
			number_of_breakpoint_slots, is_equivalent,
			start_location, end_location
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
			Precursor {CONSTRUCT_LIST} (n)
			compare_objects
		end

	make_filled (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
			Precursor {CONSTRUCT_LIST} (n)
			compare_objects
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_eiffel_list (Current)
		end

feature -- Access

	start_location: LOCATION_AS is
			-- 
		do
			if not is_empty then
				Result := area.item (0).start_location
			else
				Result := null_location
			end
		end
		
	end_location: LOCATION_AS is
			-- 
		do
			if not is_empty then
				Result := area.item (count - 1).end_location
			else
				Result := null_location
			end
		end

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

end -- class EIFFEL_LIST
