indexing

	description:
			"Abstract description of a conditional instruction, %
			%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class IF_AS_B

inherit

	IF_AS
		redefine
			condition, compound,
			elsif_list, else_part
		end;	

	INSTRUCTION_AS_B
		undefine
			number_of_stop_points
		redefine
			byte_node, find_breakable, fill_calls_list, replicate
		end

feature -- Attributes

	condition: EXPR_AS_B;
			-- Conditional expression

	compound: EIFFEL_LIST_B [INSTRUCTION_AS_B];
			-- Compound

	elsif_list: EIFFEL_LIST_B [ELSIF_AS_B];
			-- Elsif list

	else_part: EIFFEL_LIST_B [INSTRUCTION_AS_B];
			-- Else part

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check on conditional instruction
		local
			current_context: TYPE_A;
			vwbe1: VWBE1;
		do
				-- Type check the test
			condition.type_check;
	
				-- Check conformance to boolean
			current_context := context.item;
			if 	not current_context.is_boolean then
				!!vwbe1;
				context.init_error (vwbe1);
				vwbe1.set_type (current_context);
				Error_handler.insert_error (vwbe1);
			end;

				-- Update the type stack
			context.pop (1);

				-- Type check on compound
			if compound /= Void then
				compound.type_check;
			end;
				-- Type check on alternaltives compounds
			if elsif_list /= Void then
				elsif_list.type_check;
			end;
				-- Type check on default compound
			if else_part /= Void then
				else_part.type_check;
			end;

		end;

	byte_node: IF_B is
			-- Associated byte node
		do
			!!Result;
			Result.set_condition (condition.byte_node);
			if compound /= Void then
				Result.set_compound (compound.byte_node);
			end;
			if elsif_list /= Void then
				Result.set_elsif_list (elsif_list.byte_node);
			end;
			if else_part /= Void then
				Result.set_else_part (else_part.byte_node);
			end;
		end;
			
feature -- Debugger

	find_breakable is
			-- Look for breakable instructions
		do
			record_break_node;
			if compound /= Void then
				compound.find_breakable;
			end;
			record_break_node;
			if elsif_list /= Void then
				elsif_list.find_breakable;
			end;
			if else_part /= Void then
				else_part.find_breakable;
				record_break_node;
			end;
		end;

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current
		local
			new_list: like l;
		do
			!!new_list.make;
			condition.fill_calls_list (new_list);
			l.merge (new_list);
			if compound /= void then
				compound.fill_calls_list (l);
			end;
			if elsif_list /= void then
				elsif_list.fill_calls_list (l);
			end;
			if else_part /= void then
				else_part.fill_calls_list (l);
			end;
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current);
			Result.set_condition (condition.replicate (ctxt));
			if compound /= void then
				Result.set_compound (
					compound.replicate (ctxt));
			end;
			if elsif_list /= void then
				Result.set_elsif_list (
					elsif_list.replicate (ctxt));
			end;
			if else_part /= void then
				Result.set_else_part (
					else_part.replicate (ctxt));
			end;
		end;

end -- class IF_AS_B
