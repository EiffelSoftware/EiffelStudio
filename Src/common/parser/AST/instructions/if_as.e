-- Abstract description of a conditional instruction

class IF_AS

inherit
	
	INSTRUCTION_AS
		redefine
			type_check, byte_node,
			find_breakable
		end

feature -- Attributes

	condition: EXPR_AS;
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

	elsif_list: EIFFEL_LIST [ELSIF_AS];
			-- Elsif list

	else_part: EIFFEL_LIST [INSTRUCTION_AS];
			-- Else part

feature -- Initialization

	set is
			-- Yacc initialization
		do
			condition ?= yacc_arg (0);
			compound ?= yacc_arg (1);
			elsif_list ?= yacc_arg (2);
			else_part ?= yacc_arg (3);
		ensure then
			condition_exists: condition /= Void;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on conditional instruction
		local
			current_context: TYPE_A;
			vwbe1: VWBE1;
		do
				-- Type check the test
			condition.type_check;
	
				-- Check conformance to boolean
			current_context := context.item;
			if 	not current_context.conform_to (Boolean_type) then
				!!vwbe1;
				context.init_error (vwbe1);
				vwbe1.set_conditional (Current);
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
			if compound /= Void then
				compound.find_breakable;
			end;
			if elsif_list /= Void then
				elsif_list.find_breakable;
			end;
			if else_part /= Void then
				else_part.find_breakable;
			end;
		end;

end
