-- List used in abstract syntax trees.

class EIFFEL_LIST [T->AST_EIFFEL]

inherit

	AST_EIFFEL
		rename
			position as text_position
		undefine
			pass_address, copy, setup, consistent, is_equal
		redefine
			simple_format
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

feature -- Element change

	merge_after_position (p: INTEGER; other: LIST [T]) is
			-- Merge `other' after position `p', i.e. replace
			-- items after `p' with items from `other'.
		require
			--valid_position: valid_index (p)
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

feature -- Formatter

	make (n: INTEGER) is
		do
			cl_make (n)
			compare_objects
		end;

	simple_format (ctxt : FORMAT_CONTEXT) is
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
				ctxt.begin;
				if i > 1 then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				i_th(i).simple_format(ctxt);
				ctxt.commit;
				i := i + 1
			end;
			ctxt.commit;
				-- Reset the cursor to the start if
				-- we do an equiv on the ast structures
				-- after we format (for index)
			start;
		end;

	reversed_simple_format (ctxt: FORMAT_CONTEXT) is
			-- Format the items in reversed order.
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
				ctxt.begin;
				if i < l_count then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				i_th(i).simple_format(ctxt);
				ctxt.commit;
				i := i - 1
			end;
			ctxt.commit;
		end;

end

