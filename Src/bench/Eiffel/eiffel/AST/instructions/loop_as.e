indexing
	description	: "Abstract description of an Eiffel loop instruction. %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class LOOP_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots,
			byte_node, 
			fill_calls_list, 
			replicate
		end
	
	SHARED_OPTIMIZATION_TABLES

feature {AST_FACTORY} -- Initialization

	initialize (f: like from_part; i: like invariant_part;
		v: like variant_part; s: like stop;
		c: like compound; p, l: INTEGER) is
			-- Create a new LOOP AST node.
		require
			s_not_void: s /= Void
		do
			from_part := f
			invariant_part := i
			variant_part := v
			stop := s
			compound := c
			start_position := p
			line_number := l
		ensure
			from_part_set: from_part = f
			invariant_part_set: invariant_part = i
			variant_part_set: variant_part = v
			stop_set: stop = s
			compound_set: compound = c
			start_position_set: start_position = p
			line_number_set: line_number = l
		end

feature -- Attributes

	from_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- from compound

	invariant_part: EIFFEL_LIST [TAGGED_AS]
			-- invariant list

	variant_part: VARIANT_AS
			-- Variant list

	stop: EXPR_AS
			-- Stop test

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Loop compound

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
				-- "from" part
			if from_part /= Void then
				Result := Result + from_part.number_of_breakpoint_slots
			end

				-- "invariant" part
			if invariant_part /= Void then
				Result := Result + invariant_part.number_of_breakpoint_slots
			end
				-- "variant" part
			if variant_part /= Void then
				Result := Result + variant_part.number_of_breakpoint_slots
			end

				-- "until" part
			Result := Result + 1

				-- "loop" part
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (from_part, other.from_part) and then
				equivalent (invariant_part, other.invariant_part) and then
				equivalent (stop, other.stop) and then
				equivalent (variant_part, other.variant_part)
		end

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check a loop instruction
		local
			current_context: TYPE_A
			vwbe4: VWBE4
		do
			if from_part /= Void then
					-- Type check the from part
				from_part.type_check
			end
			if invariant_part /= Void then
					-- Type check the invariant loop
				invariant_part.type_check
			end
			if variant_part /= Void then
					-- Type check th variant loop
				variant_part.type_check
			end
				-- Type check the exit test.
			stop.type_check
				-- Check if if is a boolean expression
			current_context := context.item
			if not current_context.is_boolean then
				create vwbe4
				context.init_error (vwbe4)
				vwbe4.set_type (current_context)
				Error_handler.insert_error (vwbe4)
			end

				-- Update the type stack
			context.pop (1)

			if compound /= Void then
					-- Type check the loop compound
				compound.type_check
			end

debug ("OPTIMIZATION")
	io.error.putstring ("Recording loop in class ")
	io.error.putstring (context.a_class.name)
	io.error.putstring (" (")
	io.error.putint (context.a_class.class_id)
	io.error.putstring ("), feature ")
	io.error.putstring (context.a_feature.feature_name)
	io.error.putstring (" (")
	io.error.putint (context.a_feature.body_index)
	io.error.putstring (")%N")
end
				-- Record loop for optimizations in final mode
			optimization_tables.force (create {OPTIMIZE_UNIT}. make (context.a_class.class_id,
				context.a_feature.body_index))
		end

	byte_node: LOOP_B is
			-- Associated byte code
		do
				-- Current feature has a loop.
			context.set_has_loop (True)

			create Result
			if from_part /= Void then
				Result.set_from_part (from_part.byte_node)
			end
			if invariant_part /= Void then
				Result.set_invariant_part (invariant_part.byte_node)
			end
			if variant_part /= Void then
				Result.set_variant_part (variant_part.byte_node)
			end
			Result.set_stop (stop.byte_node)
			if compound /= Void then
				Result.set_compound (compound.byte_node)
			end
			Result.set_line_number (line_number)
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: CALLS_LIST
		do
			if from_part /= Void then
				from_part.fill_calls_list (l)
			end
			if invariant_part /= Void then
				invariant_part.fill_calls_list (l)
			end
			if variant_part /= Void then
				variant_part.fill_calls_list (l)
			end
			!!new_list.make
			stop.fill_calls_list (new_list)
			l.merge (new_list)
			if compound /= Void then
				compound.fill_calls_list (l)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current)
			if from_part /= Void then
				Result.set_from_part (
					from_part.replicate (ctxt))
			end
			if invariant_part /= Void then
				Result.set_invariant_part (
					invariant_part.replicate (ctxt))
			end
			if variant_part /= Void then
				Result.set_variant_part (
					variant_part.replicate (ctxt))
			end
			Result.set_stop (stop.replicate (ctxt))
			if compound /= Void then
				Result.set_compound(
					compound.replicate (ctxt))
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_From_keyword)
			ctxt.set_separator (Void)
			ctxt.set_new_line_between_tokens
			if from_part /= Void then
				ctxt.indent
				ctxt.new_line
				ctxt.format_ast (from_part)
				ctxt.new_line
				ctxt.exdent
			else
				ctxt.new_line
			end
			if invariant_part /= Void then
				ctxt.put_text_item (ti_Invariant_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.format_ast (invariant_part)
				ctxt.new_line
				ctxt.exdent
			end
			if variant_part /= Void then
				ctxt.put_text_item (ti_Variant_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.format_ast (variant_part)
				ctxt.new_line
				ctxt.exdent
			end
			ctxt.put_text_item (ti_Until_keyword)
			ctxt.indent
			ctxt.new_line
			ctxt.new_expression
			ctxt.put_breakable
			ctxt.format_ast (stop)
			ctxt.exdent
			ctxt.new_line
			ctxt.put_text_item (ti_Loop_keyword)
			if compound /= Void then
				ctxt.indent
				ctxt.new_line
				ctxt.format_ast (compound)
				ctxt.exdent
			end
			ctxt.new_line
			ctxt.put_text_item (ti_End_keyword)
		end

feature {LOOP_AS} -- Replication

	set_from_part (f: like from_part) is
		do
			from_part := f
		end

	set_invariant_part (i: like invariant_part) is
		do
			invariant_part := i
		end

	set_variant_part (v: like variant_part) is
		do
			variant_part := v
		end

	set_stop (s: like stop) is
		require
			valid_s: s /= Void
		do
			stop := s
		end

	set_compound (c: like compound) is
		do
			compound := c
		end
			
end -- class LOOP_AS
