indexing
	description: "List used in abstract syntax trees. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_LIST [T -> AST_EIFFEL]

inherit
	AST_EIFFEL
		rename
			position as text_position
		undefine
			pass_address, copy, setup, consistent, is_equal
		redefine
			byte_node, type_check,
			find_breakable, format,
			fill_calls_list, replicate,
			number_of_stop_points, is_equivalent
		end

	CONSTRUCT_LIST [T]
		export
			{ANY} area
		redefine
			make, make_filled
		end

creation
	make, make_filled

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
			{CONSTRUCT_LIST} Precursor (n)
			compare_objects
		end

	make_filled (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
			{CONSTRUCT_LIST} Precursor (n)
			compare_objects
		end

feature -- Access

	number_of_stop_points: INTEGER is
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
				Result := Result + l_area.item (i).number_of_stop_points
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

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check iteration
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
				l_area.item (i).type_check
				i := i + 1
			end
		end

	byte_node: BYTE_LIST [BYTE_NODE] is
			-- Byte code list
		local
			l_area: SPECIAL [T]
			r_area: SPECIAL [BYTE_NODE]
			i, nb: INTEGER
		do
			from
				nb := count
				!! Result.make_filled (nb)
				r_area := Result.area
				l_area := area
			until
				i = nb
			loop
				r_area.put (l_area.item (i).byte_node, i)
				i := i + 1
			end
		end

	reversed_byte_node: BYTE_LIST [BYTE_NODE] is
			-- Byte code list generated in reverse order
		local
			l_area: SPECIAL [T]
			r_area: SPECIAL [BYTE_NODE]
			i, nb, max: INTEGER
		do
			from
				nb := count
				!! Result.make_filled (nb)
				r_area := Result.area
				l_area := area
				max := nb - 1
			until
				i = nb
			loop
				r_area.put (l_area.item (i).byte_node, max - i)
				i := i + 1
			end
		end

feature -- Debugger
 
	find_breakable is
			-- Look for breakable instructions.
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.item (i).find_breakable
				i := i + 1
			end
		end

feature -- Formatter

	format (ctxt : FORMAT_CONTEXT) is
		local
			i, l_count: INTEGER
			failure: BOOLEAN
			not_first:  BOOLEAN
			must_abort: BOOLEAN
		do
			ctxt.begin
			must_abort := ctxt.must_abort_on_failure
			from	
				i := 1
				l_count := count
			until
				i > l_count or failure
			loop
				if not_first then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				i_th(i).format(ctxt)
				if not ctxt.last_was_printed then
					ctxt.rollback
					if must_abort then
						failure := true;	
						not_first := false
					end
				else
					ctxt.commit
					not_first := true
				end;	
				i := i + 1
			end
			if l_count > 0 and then not not_first then
				ctxt.rollback
			else
				ctxt.commit
			end
		end

	reversed_format (ctxt : FORMAT_CONTEXT) is
			-- Build the structured text of the list in the reverse order.
		local
			i: INTEGER
			failure: BOOLEAN
			not_first:  BOOLEAN
			must_abort: BOOLEAN
		do
			ctxt.begin
			must_abort := ctxt.must_abort_on_failure
			from	
				i := count
			until
				i < 1 or failure
			loop
				if not_first then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				i_th(i).format(ctxt)
				if not ctxt.last_was_printed then
					ctxt.rollback
					if must_abort then
						failure := true;	
						not_first := false
					end
				else
					ctxt.commit
					not_first := true
				end;	
				i := i - 1
			end
			if i > 0 and then not not_first then
				ctxt.rollback
			else
				ctxt.commit
			end
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: like l
			i, nb: INTEGER
			l_area: SPECIAL [T]
		do
			from
				!! new_list.make
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.item (i).fill_calls_list (new_list)
				l.merge (new_list)
				new_list.make
				i := i + 1
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		local
			l_area, r_area: SPECIAL [T]
			i, nb: INTEGER
		do
			Result := clone (Current)
			l_area := area
			r_area := Result.area
			from 
				nb := count
			until
				i = nb
			loop
				r_area.put (l_area.item (i).replicate (ctxt.new_ctxt), i)
				i := i + 1
			end
		end

feature {AST_EIFFEL, FORMAT_CONTEXT} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			i, l_count: INTEGER
		do
			ctxt.begin
			from
				i := 1
				l_count := count
			until
				i > l_count
			loop
				if i > 1 then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				i_th (i).simple_format (ctxt)
				ctxt.commit
				i := i + 1
			end
			ctxt.commit
		end

	reversed_simple_format (ctxt: FORMAT_CONTEXT) is
			-- Format the items in reversed order.
			-- Needed for inspect statement, items are
			-- stored in reversed order.
		local
			i: INTEGER
			l_count: INTEGER
		do
			ctxt.begin
			from
				l_count := count
				i := l_count
			until
				i < 1
			loop
				if i < l_count then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				i_th (i).simple_format (ctxt)
				ctxt.commit
				i := i - 1
			end
			ctxt.commit
		end

end -- class EIFFEL_LIST
