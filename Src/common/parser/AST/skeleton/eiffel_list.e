indexing

	description: "List used in abstract syntax trees.";
	date: "$Date$";
	revision: "$Revision$"

class EIFFEL_LIST [T->AST_EIFFEL]

inherit

	AST_EIFFEL
		rename
			position as text_position
		undefine
			pass_address, copy, setup, consistent, is_equal
		end;
	CONSTRUCT_LIST [T]
		rename
			make as cl_make
		end;
	CONSTRUCT_LIST [T]
		redefine
			make
		select
			make
		end;

creation

	make

feature

	make (n: INTEGER) is
		do
			cl_make (n)
			compare_objects
		end;

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

feature -- Simple formatting

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
