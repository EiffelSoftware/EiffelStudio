-- List used in abstract syntax trees.

class EIFFEL_LIST [T->AST_EIFFEL]

inherit

	AST_EIFFEL
		rename
			position as text_position
		undefine
			pass_address, twin
		redefine
			byte_node, type_check,
			find_breakable,
			format,
			fill_calls_list, replicate
		end;
	CONSTRUCT_LIST [T]

creation

	make

feature -- Type check, byte code and dead code removal


	type_check is
			-- Type check iteration
		local
			i, nb: INTEGER;
		do
			from
				nb := count;
				i := 1;
			until
				i > nb
			loop
				i_th (i).type_check;
				i := i + 1
			end;
		end;

	byte_node: BYTE_LIST [BYTE_NODE] is
			-- Byte code list
		local
			i, nb: INTEGER;
		do
			from
				nb := count;
				!!Result.make (nb);
				i := 1;
			until
				i > nb
			loop
				Result.put_i_th (i_th (i).byte_node, i);
				i := i + 1;
			end;
		end;

feature -- Debugger
 
	find_breakable is
			-- Look for breakable instructions.
		local
			i, l_count: INTEGER;
		do
			from
				i := 1;
				l_count := count;
			until
				i > l_count
			loop
				i_th (i).find_breakable;
				i := i + 1
			end;
		end;


feature -- Formatter

	format (ctxt : FORMAT_CONTEXT) is
		local
			i, l_count: INTEGER;
			failure: BOOLEAN;
			not_first:  BOOLEAN;
			must_abort: BOOLEAN;
		do
			ctxt.begin;
			must_abort := ctxt.must_abort_on_failure;
			from	
				i := 1;
				l_count := count;
			until
				i > l_count or failure
			loop
				ctxt.begin;
				if not_first then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				i_th(i).format(ctxt);
				if not ctxt.last_was_printed then
					ctxt.rollback;
					if must_abort then
						failure := true;	
						not_first := false;
					end;
				else
					ctxt.commit;
					not_first := true;
				end;	
				i := i + 1
			end;
			if not not_first then
				ctxt.rollback;
			else
				ctxt.commit;
			end;
		end;

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: like l;
			i, l_count: INTEGER;
		do
			from
				!!new_list.make;
				i := 1;
				l_count := count;
			until
				i > l_count
			loop
				i_th (i).fill_calls_list (new_list);
				l.merge (new_list);
				new_list.make;
				i := i + 1;
			end
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		local
			i, l_count: INTEGER;
		do
			Result := twin;
			from 
				i := 1;
				l_count := count;
			until
				i > l_count
			loop
				Result.put_i_th (i_th (i).replicate (ctxt.new_ctxt), i);
				i := i + 1;
			end;
		end;
		

end



			
