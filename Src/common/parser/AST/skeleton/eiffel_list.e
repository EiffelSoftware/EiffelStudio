indexing

	description: 
		"List used in abstract syntax trees.";
	date: "$Date$";
	revision: "$Revision$"

class EIFFEL_LIST [T->AST_EIFFEL]

inherit
	AST_EIFFEL
		rename
			position as text_position
		undefine
			pass_address, copy, setup, consistent, is_equal
		redefine
			number_of_stop_points, is_equivalent
		end

	CONSTRUCT_LIST [T]
		redefine
			make, make_filled
		end

creation {ARRAY_AS, TUPLE_AS, PARENT_AS, UN_STRIP_AS, YACC_EIFFEL, COMPILER_EXPORTER}
	make, make_filled

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
			{CONSTRUCT_LIST} precursor (n)
			compare_objects
		end

	make_filled (n: INTEGER) is
			-- Creation of the list with the comparison set on object
		do
			{CONSTRUCT_LIST} precursor (n)
			compare_objects
		end

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		local
			i, l_count: INTEGER;
		do
			from
				i := 1;
				l_count := count;
			until
				i > l_count
			loop
				Result := Result + i_th (i).number_of_stop_points;
				i := i + 1
			end;
		end

feature -- Element change

	merge_after_position (p: INTEGER; other: LIST [T]) is
			-- Merge `other' after position `p', i.e. replace
			-- items after `p' with items from `other'.
		require
			other_fits: other.count <= count - p
		local
			pos: INTEGER
			cur: CURSOR
		do
			from
				pos := p + 1
				cur := other.cursor
				other.start
			until
				pos = p + other.count + 1
			loop
				put_i_th (other.item, pos)
				other.forth
				pos := pos + 1
			end

			other.go_to (cur)
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			i, nb: INTEGER
		do
			nb := other.count
			if count = nb then
				from
					i := 1
					Result := True
				until
					not Result or else i > nb
				loop
					Result := equivalent (i_th (i),
						other.i_th (i))
					i := i + 1
				end
			end
		end

feature {AST_EIFFEL, FORMAT_CONTEXT} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			i, l_count: INTEGER;
		do
			ctxt.begin;
			from
				i := 1;
				l_count := count;
			until
				i > l_count
			loop
				if i > 1 then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				ctxt.begin;
				i_th (i).simple_format (ctxt);
				ctxt.commit;
				i := i + 1
			end;
			ctxt.commit;
		end;

	reversed_simple_format (ctxt: FORMAT_CONTEXT) is
			-- Format the items in reversed order.
			-- Needed for inspect statement, items are
			-- stored in reversed order.
		local
			i: INTEGER;
			l_count: INTEGER
		do
			ctxt.begin
			from
				l_count := count;
				i := l_count;
			until
				i < 1
			loop
				if i < l_count then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				ctxt.begin;
				i_th (i).simple_format (ctxt);
				ctxt.commit;
				i := i - 1
			end;
			ctxt.commit;
		end;

end -- class EIFFEL_LIST

