-- Abstract description of a multi_branch instruction

class INSPECT_AS

inherit

	INSTRUCTION_AS
		redefine
			type_check, byte_node
		end;
	SHARED_INSPECT

feature -- Attributes

	switch: EXPR_AS;
			-- Expression to inspect

	case_list: EIFFEL_LIST [CASE_AS];
			-- Alternatives

	else_part: EIFFEL_LIST [INSTRUCTION_AS];
			-- Else part

feature -- Initialization

	set is
			-- Yacc alternatives
		do
			switch ?= yacc_arg (0);
			case_list ?= yacc_arg (1);
			else_part ?= yacc_arg (2);
		ensure then
			switch_exists: switch /= Void
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a multi-branch instruction
		local
			current_item: TYPE_A;
			vomb1: VOMB1;
		do
			switch.type_check;

				-- Initialization of the multi-branch controler
			Inspect_control.wipe_out;
			Inspect_control.set_node (Current);
			Inspect_control.set_feature_table (context.a_class.feature_table);

				-- Type check if it is an expression conform either to
				-- and integer or to a character
			current_item := context.item;
			if current_item.conform_to (Integer_type) then		
				Inspect_control.set_integer_type;
			elseif	current_item.conform_to (Character_type) then
				Inspect_control.set_character_type;
			else
					-- Error
				!!vomb1;
				context.init_error (vomb1);
				vomb1.set_multi_branch (Current);
				Error_handler.insert_error (vomb1);
					-- Cannot go on here
				Error_handler.raise_error;
			end;

				-- Update type stack
			context.pop (1);

			if case_list /= Void then
				case_list.type_check;
			end;

			if else_part /= Void then
				else_part.type_check;
			end;
		end;

	byte_node: INSPECT_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_switch (switch.byte_node);
			if case_list /= Void then
				Result.set_case_list (case_list.byte_node);
			end;
			if else_part /= Void then
				Result.set_else_part (else_part.byte_node);
			end;
		end;

end
