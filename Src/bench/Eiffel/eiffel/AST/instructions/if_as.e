indexing
	description	: "Abstract description of a conditional instruction, %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class IF_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots, byte_node
		end

feature {AST_FACTORY} -- Initialization

	initialize (cnd: like condition; cmp: like compound;
		ei: like elsif_list; e: like else_part; s, l: INTEGER) is
			-- Create a new IF AST node.
		require
			cnd_not_void: cnd /= Void
		do
			condition := cnd
			compound := cmp
			elsif_list := ei
			else_part := e
			start_position := s
			line_number := l
		ensure
			condition_set: condition = cnd
			compound_set: compound = cmp
			elsif_list_set: elsif_list = ei
			else_part_set: else_part = e
			start_position_set: start_position = s
			line_number_set: line_number = l
		end

feature -- Attributes

	condition: EXPR_AS
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

	elsif_list: EIFFEL_LIST [ELSIF_AS]
			-- Elsif list

	else_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- Else part

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1 -- condition test
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
			end
			if elsif_list /= Void then
				Result := Result + elsif_list.number_of_breakpoint_slots
			end
			if else_part /= Void then
				Result := Result + else_part.number_of_breakpoint_slots
			end
		end

feature -- Comparison 

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (condition, other.condition) and then
				equivalent (else_part, other.else_part) and then
				equivalent (elsif_list, other.elsif_list)
		end

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check on conditional instruction
		local
			current_context: TYPE_A
			vwbe1: VWBE1
		do
				-- Type check the test
			condition.type_check
	
				-- Check conformance to boolean
			current_context := context.item
			if 	not current_context.is_boolean then
				create vwbe1
				context.init_error (vwbe1)
				vwbe1.set_type (current_context)
				Error_handler.insert_error (vwbe1)
			end

				-- Update the type stack
			context.pop (1)

				-- Type check on compound
			if compound /= Void then
				compound.type_check
			end
				-- Type check on alternaltives compounds
			if elsif_list /= Void then
				elsif_list.type_check
			end
				-- Type check on default compound
			if else_part /= Void then
				else_part.type_check
			end

		end

	byte_node: IF_B is
			-- Associated byte node
		do
			create Result
			Result.set_condition (condition.byte_node)
			if compound /= Void then
				Result.set_compound (compound.byte_node)
			end
			if elsif_list /= Void then
				Result.set_elsif_list (elsif_list.byte_node)
			end
			if else_part /= Void then
				Result.set_else_part (else_part.byte_node)
			end
			Result.set_line_number (line_number)
		end
			
feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_If_keyword)
			ctxt.put_space
			ctxt.new_expression
			ctxt.format_ast (condition)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_Then_keyword)
			if compound /= Void then
				ctxt.indent
				ctxt.new_line
				ctxt.set_new_line_between_tokens
				ctxt.format_ast (compound)
				ctxt.exdent
			end
			ctxt.new_line
			if elsif_list /= Void then
				ctxt.set_separator (ti_Empty)
				ctxt.set_no_new_line_between_tokens
				ctxt.format_ast (elsif_list)
				ctxt.set_separator (Void)
			end
			if else_part /= Void then
				ctxt.put_text_item (ti_Else_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.set_new_line_between_tokens
				ctxt.format_ast (else_part)
				ctxt.exdent
				ctxt.new_line
			end
			ctxt.put_text_item (ti_End_keyword)
		end
		 			   
feature {IF_AS} -- Replication

	set_condition (c: like condition) is
			-- Set `condition' to `c'.
		require
			valid_arg: c /= Void
		do
			condition := c
		end

	set_compound (c: like compound) is
			-- Set `compound' to `c'.
		do
			compound := c
		end

	set_elsif_list (e: like elsif_list) is
			-- Set `elsif_list' to `e'.
		do
			elsif_list := e
		end

	set_else_part (e: like else_part) is
			-- Set `else_part' to `e'.
		do
			else_part := e
		end

end -- class IF_AS
