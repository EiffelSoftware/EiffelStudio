-- Byte code for a routine.

deferred class BYTE_CODE 

inherit

	IDABLE
		rename
			id as byte_id
		export
			{NONE} all
		end;
	BYTE_NODE
		redefine
			make_byte_code, enlarge_tree
		end;
	SHARED_ENCODER;
	SHARED_C_LEVEL;
	SHARED_PATTERN_TABLE;
	ASSERT_TYPE;

feature 

	byte_id: INTEGER;
			-- Id of byte code

	set_byte_id (i: INTEGER) is
			-- Assign `i' to `byte_id'.
		do
			byte_id := i;
		end;

	feature_name: STRING;
			-- Name of the feature to which the current byte code tree
			-- belongs to

	body_index: INTEGER;
			-- Feature body index

	rout_id: INTEGER;
			-- Routine id of the feature

	pattern_id: INTEGER;
			-- Pattern id of the feature

	-- The corresponding C name of the generated feature in the concatenation
	-- of the body id (which is the id for the byte code server) and of
	-- the current type id in final mode only. for the workbench mode, we
	-- used the feature id instead of the body id.

	arguments: ARRAY [TYPE_I];
			-- List of argument types of the feature: can be Void

	result_type: TYPE_I;
			-- Result type of the feature: can be Void.

	locals: ARRAY [TYPE_I];
			-- List of local types of the feature: can be Void.

	precondition: BYTE_LIST [BYTE_NODE];
			-- List of ASSERT_B instances: can be Void.

	postcondition: BYTE_LIST [BYTE_NODE];
			-- List of ASSERT_B instances: can be Void.

	rescue_clause: BYTE_LIST [BYTE_NODE];
			-- List of INSTR_B instances: can be Void.

	compound: BYTE_LIST [BYTE_NODE] is
			-- Compound byte code
		do
			-- Do nothing: to be redefined in STD_BYTE_CODE
		end; -- compound

	is_once: BOOLEAN is
			-- Is the current byte code relative to a once feature ?
		do
			-- Do nothing
		end;

	is_external: BOOLEAN is
			-- Is the current byte code relative to an external feature ?
		do
			-- Do nothing
		end;

	is_deferred: BOOLEAN is
			-- Is the current byte code relative to a deferred feature ?
		do
			-- Do nothing
		end;

	body_id: INTEGER is
			-- Body id to the associated feature
		do
			Result := System.body_index_table.item (body_index);
		end;

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

	set_body_index (i: INTEGER) is
			-- Assign `i' to `body_index'.
		do
			body_index := i;
		end;

	set_rout_id (i: INTEGER) is
			-- Assign `i' to `rout_id'.
		do
			rout_id := i;
		end;

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i;
		end;

	set_result_type (t: TYPE_I) is
			-- Assign `t' to `result_type'.
		do
			result_type := t;
		end;

	set_precondition (var: like precondition) is
			-- Assign `var' to `precondition'.
		do
			precondition := var
		end;

	set_postcondition (var: like postcondition) is
			-- Assign `var' to `postcondition'.
		do
			postcondition := var
		end;

	set_rescue_clause (var: like rescue_clause) is
			-- Assign `var' to `rescue_clause'.
		do
			rescue_clause := var
		end;

	set_arguments (a: like arguments) is
			-- Assing `a' to `arguments'.
		do
			arguments := a
		end;

	set_locals (l: like locals) is
			-- Assign `l' to `locals'.
		do
			locals := l;
		end;

	enlarge_tree is
			-- Enlarges byte code tree for C code generation
		do
			if precondition /= Void then
				precondition.enlarge_tree;
			end;
			if compound /= Void then
				compound.enlarge_tree;
			end;
			if postcondition /= Void then
				postcondition.enlarge_tree;
			end;
			if rescue_clause /= Void then
				rescue_clause.enlarge_tree;
			end;
		end;

	feature_origin: INTEGER is
			-- Value of the dynamic type where the feature is written
		do
			Result := context.class_type.type_id - 1;
		end;

	generate_arguments is
			-- Generate C arguments, if any, in the definition.
		local
			i, count: INTEGER;
		do
			generated_file.putstring ("Current");
			if arguments /= Void then
				from
					i := arguments.lower;
					count := arguments.count;
				until
					i > count
				loop
					generated_file.putstring (", ");
					generated_file.putstring ("arg");
					generated_file.putint (i);
					i := i + 1;
				end;
			end;
		end;

	generate_arg_declarations is
			-- Declare C parameters, if any, as part of the definition.
		local
			arg: TYPE_I;
			i, count: INTEGER;
			exp_arg: ARGUMENT_BL;
		do
			generated_file.putstring ("char *Current;");
			generated_file.new_line;
			if arguments /= Void then
				from
					i := arguments.lower;
					count := arguments.count;
				until
					i > count
				loop
					arg := real_type (arguments.item (i));
					arg.c_type.generate (generated_file);
					generated_file.putstring ("arg");
					generated_file.putint (i);
					generated_file.putchar (';');
					if arg.is_expanded then
						context.inc_exp_args;
							-- Force inclusion in GC hooks.
						context.force_gc_hooks;
						context.Arg_var.set_position (i);
						context.set_local_index (context.Arg_var.register_name,
							context.Arg_var.enlarged);
					end;
					generated_file.new_line;
					i := i + 1;
				end;
			end;
		end;

	finish_compound is
			-- Generate the end of the compound
		do
			-- Do nothing
		end;

	generate_old_variables is
			-- Generate value for old variables
		local
			old_expressions: LINKED_LIST [UN_OLD_BL];
		do
			old_expressions := context.old_expressions;
			if context.has_postcondition and then old_expressions /= Void
			then
				from
					old_expressions.start;
				until
					old_expressions.offright
				loop
					old_expressions.item.initialize;
					old_expressions.forth;
				end;
			end;
		end;

feature -- Byte code generation

	
	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code
		require else
			not_external: not is_external
		local
			i, nb: INTEGER;
			r_type: TYPE_I;	
			local_list: LINKED_LIST [TYPE_I];
		do
			Temp_byte_code_array.clear;
			
				-- Header for debuggable byte code.
			if context.debug_mode then
				Temp_byte_code_array.append (Bc_debuggable);
				Temp_byte_code_array.append_integer (body_id);	
			else
				Temp_byte_code_array.append (Bc_start);
			end;

				-- Routine id
			Temp_byte_code_array.append_integer (rout_id);

				-- Result SK value
			r_type := context.real_type(result_type);
			Temp_byte_code_array.append_integer (r_type.sk_value);

				-- Argument number
			Temp_byte_code_array.append_short_integer (argument_count);

				-- Once mark
			if is_once then
				Temp_byte_code_array.append ('%/001/');
					-- Once not done
				Temp_byte_code_array.append ('%U');
					-- Allocate space for storeing a result instance in
					-- the byte code itself
				Temp_byte_code_array.allocate_space (r_type);
			else
				Temp_byte_code_array.append ('%U');
			end;

			from
				i := 1;
				nb := local_count;
			until
				i > nb
			loop
					-- Local SK value
				Context.add_local (context.real_type (locals.item (i)));
				i := i + 1;
			end;

				-- Feature name
			ba.append_raw_string (feature_name);

				-- Dynamic type where the feature is written in
			ba.append_short_integer (context.current_type.type_id - 1);

				-- Resue offset if any.
			if rescue_clause /= Void then
				ba.append ('%/001/');
				ba.mark_forward;
			else
				ba.append ('%U');
			end;

				-- Record retry offset
			ba.mark_retry;

				-- Compound byte code
			make_body_code (ba);

			ba.append (Bc_null);

			if rescue_clause /= Void then
				ba.write_forward;
				ba.append (Bc_rescue);
				rescue_clause.make_byte_code (ba);
				ba.append (Bc_end_rescue);
			end;

			from
				local_list := context.local_list;
				Temp_byte_code_array.append_short_integer (local_list.count);
				local_list.start
			until
				local_list.offright
			loop
				Temp_byte_code_array.append_integer (local_list.item.sk_value);
				local_list.forth;
			end;

				-- Expanded Clone
			if arguments /= Void then
				from
					i := 1;
					nb := arguments.count;
				until
					i > nb
				loop
					if context.real_type (arguments.item (i)).is_expanded
					then
						Temp_byte_code_array.append (Bc_clone_arg);
						Temp_byte_code_array.append_short_integer (i);
					end;
					i := i + 1;
				end;
			end;
			Temp_byte_code_array.append (Bc_no_clone_arg);

			context.byte_prepend (ba, Temp_byte_code_array);

				-- Clean the context
			local_list.wipe_out;
		end;

	make_body_code (ba: BYTE_ARRAY) is
			-- Generate compound byte code
		require
			good_argument: ba /= Void
		deferred
		end;

	argument_count: INTEGER is
			-- Number of formal arguments
		do
			if arguments /= Void then
				Result := arguments.count;
			end;
		end;

	local_count: INTEGER is
			-- Number of local variables
		do
			if locals /= Void then
				Result := locals.count;
			end;
		end;

	Temp_byte_code_array: BYTE_ARRAY is
			-- Temporary byte code array
		once
			!!Result.make
		end;

end
