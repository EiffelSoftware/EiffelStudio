indexing

	description:
			"Abstract description of an Eiffel loop instruction. %
			%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class LOOP_AS_B

inherit

	LOOP_AS
		redefine
			from_part, compound, stop,
			variant_part, invariant_part
		end;

	INSTRUCTION_AS_B
		undefine
			number_of_stop_points
		redefine
			byte_node, find_breakable, fill_calls_list, replicate
		end;
	
	SHARED_OPTIMIZATION_TABLES

feature -- Attributes

	from_part: EIFFEL_LIST_B [INSTRUCTION_AS_B];
			-- from compound

	invariant_part: EIFFEL_LIST_B [TAGGED_AS_B];
			-- invariant list

	variant_part: VARIANT_AS_B;
			-- Variant list

	stop: EXPR_AS_B;
			-- Stop test

	compound: EIFFEL_LIST_B [INSTRUCTION_AS_B];
			-- Loop compound

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check a loop instruction
		local
			current_context: TYPE_A;
			vwbe4: VWBE4;
			body_index: BODY_INDEX;
			opt_unit: OPTIMIZE_UNIT
		do
			if from_part /= Void then
					-- Type check the from part
				from_part.type_check;
			end;
			if invariant_part /= Void then
					-- Type check the invariant loop
				invariant_part.type_check;
			end;
			if variant_part /= Void then
					-- Type check th variant loop
				variant_part.type_check;
			end;
				-- Type check the exit test.
			stop.type_check;
				-- Check if if is a boolean expression
			current_context := context.item;
			if not current_context.is_boolean then
				!!vwbe4;
				context.init_error (vwbe4);
				vwbe4.set_type (current_context);
				Error_handler.insert_error (vwbe4);
			end;

				-- Update the type stack
			context.pop (1);

			if compound /= Void then
					-- Type check the loop compound
				compound.type_check;
			end;

				-- Record the loop for optimizations in final mode
			body_index := context.a_feature.body_index;
debug ("OPTIMIZATION")
	io.error.putstring ("Recording loop in class ");
	io.error.putstring (context.a_class.name);
	io.error.putstring (" (");
	context.a_class.id.trace;
	io.error.putstring ("), feature ");
	io.error.putstring (context.a_feature.feature_name);
	io.error.putstring (" (");
	body_index.trace;
	io.error.putstring (")%N");
end;
			!!opt_unit.make (context.a_class.id, body_index);
			optimization_tables.feature_set.extend (opt_unit);
		end;

	byte_node: LOOP_B is
			-- Associated byte code
		do
			!!Result;
			if from_part /= Void then
				Result.set_from_part (from_part.byte_node);
			end;
			if invariant_part /= Void then
				Result.set_invariant_part (invariant_part.byte_node);
			end;
			if variant_part /= Void then
				Result.set_variant_part (variant_part.byte_node);
			end;
			Result.set_stop (stop.byte_node);
			if compound /= Void then
				Result.set_compound (compound.byte_node);
			end;
			Result.set_line_number (line_number)
		end;

feature -- Debugger

	find_breakable is
			-- Look for breakable instruction;
			-- Put a breakable point on each compound exit.
		do
			record_break_node;
			if from_part /= Void then
				from_part.find_breakable;
			end;
			record_break_node;
			if compound /= Void then
				compound.find_breakable;
			end;
			record_break_node;
		end;

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: CALLS_LIST;
		do
			if from_part /= void then
				from_part.fill_calls_list (l);
			end;
			if invariant_part /= void then
				invariant_part.fill_calls_list (l);
			end;
			if variant_part /= void then
				variant_part.fill_calls_list (l);
			end;
			!!new_list.make;
			stop.fill_calls_list (new_list);
			l.merge (new_list);
			if compound /= void then
				compound.fill_calls_list (l);
			end;
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current);
			if from_part /= void then
				Result.set_from_part (
					from_part.replicate (ctxt));
			end;
			if invariant_part /= void then
				Result.set_invariant_part (
					invariant_part.replicate (ctxt))
			end;
			if variant_part /= void then
				Result.set_variant_part (
					variant_part.replicate (ctxt));
			end;
			Result.set_stop (stop.replicate (ctxt));
			if compound /= void then
				Result.set_compound(
					compound.replicate (ctxt));
			end;
		end;
			
end -- class LOOP_AS_B
