-- Inherited details of assertions. Used for the generation
-- of chain assertions.

class INHERITED_ASSERTION

inherit

	SHARED_BYTE_CONTEXT;
	BYTE_CONST;
	
creation

	make

feature -- Creation

	make is
			-- Make lists
		do
			!!precondition_list.make;
			!!precondition_types.make;
			!!prec_arg_list.make;
			!!postcondition_list.make;
			!!postcondition_types.make;
			!!post_result_list.make;
			!!post_arg_list.make;
			!!old_expression_list.make;
		end;

feature -- Assertion

	saved_class_type: CLASS_TYPE;
			-- Saved class type

	saved_arguments: ARRAY [TYPE_I];
			-- Saved byte_code arguments

	saved_result_type: TYPE_I;
			-- Saved byte_code arguments

	saved_old_expressions: LINKED_LIST [UN_OLD_B];
			-- Saved old expressions

	restore_current_context is 
			-- Restore details of current context.
		do
			Context.set_class_type (saved_class_type);
			Context.byte_code.set_arguments (saved_arguments);	
			Context.byte_code.set_result_type (saved_result_type);	
			Context.byte_code.set_old_expressions (saved_old_expressions);	
		end;

	init is
			-- Save current context.
		require
			not_initialzed: saved_class_type = Void and then
							saved_arguments = Void and then
							saved_result_type = Void
		do
			saved_class_type := Context.class_type;
			saved_arguments := Context.byte_code.arguments;
			saved_result_type := Context.byte_code.result_type;
			saved_old_expressions := Context.byte_code.old_expressions;
		end;

	has_assertion: BOOLEAN is
			-- Does Current have inhertied assertions?
		do
			Result := has_precondition or else
						has_postcondition
		end;

	wipe_out is
			-- Wipe out inherited details.
		do
debug ("ASSERTIONS")
	trace
end;
			precondition_list.wipe_out;
			precondition_types.wipe_out;
			prec_arg_list.wipe_out;
			postcondition_list.wipe_out;
			postcondition_types.wipe_out;
			post_result_list.wipe_out;
			post_arg_list.wipe_out;
			old_expression_list.wipe_out;
			saved_class_type := Void;
			saved_arguments := Void;
			saved_result_type := Void;
		end;

	enlarge_tree is
			-- Enlarges inherited assertion byte code 
			-- tree for C code generation.
		require
			types_and_assert_count_same: valid_count
		local
			old_expr: LINKED_LIST [UN_OLD_B]
		do
			from
				precondition_start;
			until
				precondition_after
			loop
				precondition_context_init;
				Context.set_assertion_type (Context.In_precondition);
				precondition_list.item.enlarge_tree;
				Context.set_assertion_type (0);
				precondition_forth;
			end;
			from
				postcondition_start
			until
				postcondition_after	
			loop
				postcondition_context_init;
				old_expr := old_expression_list.item;
				if old_expr /= Void then
					Context.byte_code.clear_old_expressions;
				end;
				postcondition_list.item.enlarge_tree;
					--! Need to replace old expressions with
					--! enlarged old expressions for C generation
					--! later on.
				if old_expr /= Void then
					old_expression_list.put (Context.byte_code.old_expressions);
				end;
				postcondition_forth;	
			end;
			restore_current_context;
		end;

	valid_count: BOOLEAN is
			-- Are types count the same as the assertion count?
		do
			Result := (valid_prec_count and then valid_post_count);
		end;

	valid_prec_count: BOOLEAN is
			-- Are types count the same as the precondition count?
		do
			Result := 	(precondition_list.count 
							= precondition_types.count)
		end;

	valid_post_count: BOOLEAN is
			-- Are types count the same as the postcondition count?
		do
			Result := 	(postcondition_list.count 
							= postcondition_types.count)
		end;

	restored: BOOLEAN is
			-- Was Byte Context restored?
		do
			Result := (Context.class_type = saved_class_type) 
						and then (Context.byte_code.arguments = saved_arguments)
						and then (Context.byte_code.result_type = saved_result_type)
		end;

feature -- Inherited precondition

	precondition_list: LINKED_LIST [BYTE_LIST [BYTE_NODE]];
			-- List of inherited precondition 

	prec_arg_list: LINKED_LIST [ARRAY[TYPE_I]];
			-- List of inherited arguments corresponding to assertion

	precondition_types: LINKED_LIST [CLASS_TYPE];
			-- List of class types associated with precondition

	has_precondition: BOOLEAN is
			-- Does Current have inherited preconditions?
		do
			Result := (precondition_types.count > 0);
		end;

	add_precondition_type (ct: CLASS_TYPE; bc: BYTE_CODE) is
			-- Add class type `ct' and byte code `bc' to
			-- precondition details.
		require
			valid_arg1: ct /= Void;
			valid_arg2: bc /= Void;
			valid_prec: bc.precondition /= Void;
			not_have_ct: not has_prec_type (ct);
		do
			precondition_types.extend (ct);
			precondition_list.extend (bc.precondition);
			prec_arg_list.extend (bc.arguments);
		end;

	has_prec_type (ct: CLASS_TYPE): BOOLEAN is
			-- Does precondition_types have `ct'?
		do
			Result := precondition_types.has (ct)
		end;

	make_precondition_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for inherited precondition.
		require
			types_and_assert_count_same: valid_prec_count;
			has_precondition: has_precondition
		do
			if Context.is_prec_first_block then
				--! Inherited precondition not first block
				context.set_is_prec_first_block (False);
			else
				context.set_is_prec_first_block (True);
			end;
			from
				precondition_start;
				precondition_context_init;	
				precondition_list.item.make_byte_code (ba);
				from 
				until 
					ba.forward_marks4.count = 0 
				loop 
					ba.write_forward4;
				end;
				ba.append (Bc_goto_body);
				ba.mark_forward;
				context.set_is_prec_first_block (False);
				precondition_forth
			until
				precondition_after
			loop
				precondition_context_init;	
				precondition_list.item.make_byte_code (ba);
				from 
				until 
					ba.forward_marks4.count = 0 
				loop 
					ba.write_forward4;
				end;
				ba.append (Bc_goto_body);
				ba.mark_forward;
				precondition_forth
			end;
			restore_current_context;
		ensure
			context_restored: restored
		end;

	write_forward (ba: BYTE_ARRAY) is
			-- Write forward for each precondition.
		local
			count, i: INTEGER
		do
			from
				count := precondition_types.count;
				i := 1;
			until
				i > count	
			loop
				ba.write_forward;
				i := i + 1;
			end;
		end;

	analyze_precondition is
			-- Analyze inherited preconditions
		require
			types_and_assert_count_same: valid_prec_count
		do
			from
				precondition_start
			until
				precondition_after	
			loop
				precondition_context_init;
				precondition_list.item.analyze;
				precondition_forth;
			end;
			restore_current_context;
		ensure
			context_restored: restored
		end;

	generate_precondition is
			-- Generate inherited postcondition .
		require
			types_and_assert_count_same: valid_prec_count;
			has_prec: has_precondition
		do
			if Context.is_prec_first_block then
				--! Inherited precondition not first block
				context.set_is_prec_first_block (False);
			else
				context.set_is_prec_first_block (True);
			end;
			from
				precondition_start;
				generate_precondition_clause;
				context.set_is_prec_first_block (False);
				precondition_forth;
			until
				precondition_after	
			loop
				generate_precondition_clause;
				precondition_forth;
			end;
			restore_current_context;
		ensure
			context_restored: restored
		end;

	generate_precondition_clause is
			-- Generate preconditions of a clause.
		local
			buffer: GENERATION_BUFFER
		do
			buffer := Context.buffer;
			precondition_context_init;
			Context.inc_label;
			precondition_list.item.generate;
			if not Context.is_prec_first_block then
				buffer.putstring ("RTCK;");
				buffer.new_line;
			end;
			buffer.putstring ("RTJB;");
			buffer.new_line;
			buffer.exdent;
			if has_separate_call_in_precondition then
				context.print_concurrent_label;
				buffer.putchar (':');
				buffer.indent;
				buffer.putstring (" CURSSFC;");
				buffer.new_line;
				buffer.exdent;
			end;
			context.print_current_label;
			buffer.putchar (':');
			buffer.new_line;
			buffer.indent;
		end;

	precondition_start is
			-- Move cursor to start of precondition details lists.
		do
			precondition_list.start;
			prec_arg_list.start;
			precondition_types.start;	
		end;

	precondition_after: BOOLEAN is
			-- Are lists' position after?
		do
			Result := precondition_list.after
		end;

	precondition_forth is
			-- Move cursor one position to right 
			-- for precondition details lists.
		do
			precondition_list.forth;
			prec_arg_list.forth;
			precondition_types.forth;	
		end;

	precondition_context_init is
			-- Initialize the byte context according
			-- to current assertion class type.
		do
			Context.set_class_type (precondition_types.item);
			Context.byte_code.set_arguments (prec_arg_list.item);
		end;

feature -- inherited postcondition

	postcondition_list: LINKED_LIST [BYTE_LIST [BYTE_NODE]];
			-- List of inherited postcondition

	post_arg_list: LINKED_LIST [ARRAY [TYPE_I]];
			-- List of inherited arguments corresponding to assertion

	post_result_list: LINKED_LIST [TYPE_I];
			-- List of inherited result type corresponding to assertion

	old_expression_list: LINKED_LIST [LINKED_LIST [UN_OLD_B]];
			-- List of inherited old expression corresponding to assertion

	postcondition_types: LINKED_LIST [CLASS_TYPE];
			-- List of class types associated with postcondition

	add_postcondition_type (ct: CLASS_TYPE; bc: BYTE_CODE) is
			-- Add class type `ct' and byte code `bc' to
			-- postcondition details.
		require
			valid_arg1: ct /= Void;
			valid_arg2: bc /= Void;
			valid_post: bc.postcondition /= Void;
			not_have_ct: not has_post_type (ct);
		do
			postcondition_types.extend (ct);
			postcondition_list.extend (bc.postcondition);
			post_arg_list.extend (bc.arguments);
			post_result_list.extend (bc.result_type);
			old_expression_list.extend (bc.old_expressions);
		end;

	has_post_type (ct: CLASS_TYPE): BOOLEAN is
			-- Does postcondition_types have `ct'?
		do
			Result := postcondition_types.has (ct)
		end;

	has_postcondition: BOOLEAN is
			-- Does Current have inhertied postconditions?
		do
			Result := (postcondition_types.count > 0);
		end;

	has_old_expression: BOOLEAN is
			-- Does Current have inhertied postconditions?
		do
			from
				old_expression_list.start
			until
				Result or else old_expression_list.after
			loop
				Result := (old_expression_list.item /= Void);
				old_expression_list.forth
			end;
		end;

	analyze_old_expressions is
			-- Analyze inherited old expressions
		require
			types_and_assert_count_same: valid_post_count
		local
			old_expressions: LINKED_LIST [UN_OLD_B];
			old_exp: UN_OLD_BL;
		do
			from
				postcondition_start
			until
				postcondition_after	
			loop
				postcondition_context_init;
				old_expressions := old_expression_list.item;
				if old_expressions /= Void then
					--! Old expressions can be void
					postcondition_context_init;
					from
						old_expressions.start
					until
						old_expressions.after
					loop
						old_exp ?= old_expressions.item; -- Cannot fail
						old_exp.special_analyze;
						old_expressions.forth;
					end;
				end;
				postcondition_forth
			end;
			restore_current_context;
		ensure
			context_restored: restored
		end;

	analyze_postcondition is
			-- Analyze inherited postconditions
		require
			types_and_assert_count_same: valid_post_count
		do
			from
				postcondition_start
			until
				postcondition_after	
			loop
				postcondition_context_init;
				postcondition_list.item.analyze;
				postcondition_forth
			end;
			restore_current_context;
		ensure
			context_restored: restored
		end;

	generate_postcondition is
			-- Generate inherited postcondition .
		require
			types_and_assert_count_same: valid_post_count
		do
			from
				postcondition_start
			until
				postcondition_after	
			loop
				postcondition_context_init;
				postcondition_list.item.generate;
				postcondition_forth;
			end;
			restore_current_context;
		ensure
			context_restored: restored
		end;

	make_postcondition_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for inherited postcondition.
		require
			types_and_assert_count_same: valid_post_count
		do
			from
				postcondition_start
			until
				postcondition_after
			loop
				postcondition_context_init;
				postcondition_list.item.make_byte_code (ba);
				postcondition_forth;
			end;
			restore_current_context;
		end;

	setup_local_variables (pos: INTEGER) is
			-- Set up the local variable type for
			-- old expressions. 
		local
			old_expressions: LINKED_LIST [UN_OLD_B];
			item: UN_OLD_B;
			position: INTEGER
		do
			position := pos;
			from
				postcondition_start
			until
				postcondition_after
			loop
				old_expressions := old_expression_list.item;
				if old_expressions /= Void then
					--! Old expressions can be void
					postcondition_context_init;
					from
						old_expressions.start
					until
						old_expressions.after
					loop
						item := old_expressions.item;
						Context.add_local
								(context.real_type (item.type));
						item.set_position (position);
						position := position + 1;
						old_expressions.forth;
					end;
				end;
				postcondition_forth;
			end;
			restore_current_context;
		ensure
			context_restored: restored
		end;

	make_old_exp_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for inherited old expressions.
		require
			types_and_assert_count_same: valid_post_count
		local
			old_expressions: LINKED_LIST [UN_OLD_B];
		do
			from
				postcondition_start
			until
				postcondition_after
			loop
				old_expressions := old_expression_list.item;
				if old_expressions /= Void then
					--! Old expressions can be void
					postcondition_context_init;
					from
						old_expressions.start
					until
						old_expressions.after
					loop
						old_expressions.item.make_initial_byte_code (ba);
						old_expressions.forth;
					end;
				end;
				postcondition_forth;
			end;
			restore_current_context;
		ensure
			context_restored: restored
		end;

	generate_old_variables is
			-- Generate value for old variables
		require
			types_and_assert_count_same: valid_post_count
		local
			old_expressions: LINKED_LIST [UN_OLD_B];
			item: UN_OLD_BL
		do
			from
				postcondition_start
			until
				postcondition_after
			loop
				old_expressions := old_expression_list.item;
				if old_expressions /= Void then
					--! Old expressions can be void
					postcondition_context_init;
					from
						old_expressions.start
					until
						old_expressions.after
					loop
						item ?= old_expressions.item; -- Cannot fail
						item.initialize;
						old_expressions.forth
					end;
				end;
				postcondition_forth;
			end;
			restore_current_context;
		ensure
			context_restored: restored
		end;

	postcondition_start is
			-- Move cursor to start of postcondition details lists.
		do
			postcondition_list.start;
			post_arg_list.start;
			postcondition_types.start;	
			old_expression_list.start;	
			post_result_list.start;	
		end;

	postcondition_after: BOOLEAN is
			-- Are lists' position after?
		do
			Result := postcondition_list.after
		end;

	postcondition_forth is
			-- Move cursor one position to right 
			-- for postondition details lists.
		do
			postcondition_list.forth;
			post_arg_list.forth;
			postcondition_types.forth;	
			old_expression_list.forth;	
			post_result_list.forth;	
		end;

	postcondition_context_init is
			-- Initialize the byte context according
			-- to current assertion class type.
		do
			Context.set_class_type (postcondition_types.item);
			Context.byte_code.set_arguments (post_arg_list.item);
			Context.byte_code.set_result_type (post_result_list.item);
			Context.byte_code.set_old_expressions (old_expression_list.item);
		end;

	trace is
		local
			c: CLASS_C
		do
			if has_precondition then
				io.putstring ("Precondition for feature:");
				io.putstring (Context.byte_code.feature_name);
				io.new_line;
				from
					precondition_start
				until
					precondition_after	
				loop
					precondition_context_init;
					c := precondition_types.item.associated_class;
					io.putstring ("  precursor class - ");
					io.putstring (c.name);
					io.new_line;
					precondition_forth;
				end;
			end;
			if has_postcondition then
				io.putstring ("Postcondition for feature:");
				io.putstring (Context.byte_code.feature_name);
				io.new_line;
				from
					postcondition_start
				until
					postcondition_after	
				loop
					postcondition_context_init;
					c := postcondition_types.item.associated_class;
					io.putstring ("  precursor class - ");
					io.putstring (c.name);
					io.new_line;
					postcondition_forth;
				end;
			end;
		end;

feature -- Concurrent Eiffel

	std_obj: STD_BYTE_CODE
		-- the corresponding STD_BYTE_CODE object which call the 
		-- "generate_precondition" feature of the class.

		-- FIXME!!!

	has_separate_call_in_precondition: BOOLEAN
		-- is there separate feature call in the prtecondition of 
		-- object "std_obj"?

	set_std_obj (obj: STD_BYTE_CODE) is
		do
			std_obj := obj;
		end

	set_has_separate_call_in_precondition (v: BOOLEAN) is
		do
			has_separate_call_in_precondition := v;
		end

end
