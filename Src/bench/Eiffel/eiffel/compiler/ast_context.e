-- Context for third pass

class AST_CONTEXT 

inherit

	EXTEND_STACK [TYPE_A]
		rename
			make as extend_stack_make
		export
			{ACCESS_FEAT_AS} i_th
		end;
	SHARED_SERVER
		undefine
			twin
		end;


creation

	make
	
feature 

	a_class: CLASS_C;
			-- Current analyzed a_class

	actual_class_type: CL_TYPE_A;
			-- Actual type of `a_class'

	feature_table: FEATURE_TABLE;
			-- Current a_feature table

	a_feature: FEATURE_I;
			-- Current analyzed a_feature

	locals: EXTEND_TABLE [LOCAL_INFO, STRING];
			-- Current local variables of the analyzed feature

	access_line: ACCESS_LINE;
			-- List of access encountered by the type checker: then the
			-- building of the byte code takes those access.

	multi_line: LINE [MULTI_TYPE_A];
			-- Line of manifest array types

	interval_line: LINE [INTERVAL_B];
			-- Line of intervals

	creation_types: LINE [CREATE_INFO];
			-- Creation information types

	
	parameters: LINE [TYPE_A];
			-- Features with arguments encountered during type check

	level1: BOOLEAN;
			-- Level for checking old expression wich should be only in
			-- postconditions
			-- [Set on when type chking postconditions].

	level2: BOOLEAN;
			-- Level of analysis for access, When analyzing an access id,
			-- (instance of ACCESS_ID_AS), locals, arguments
			-- are not taken into account if set to True.
			-- Useful for analyzing class invariant.
			-- [Set on when analyzing invariants].

	level3: BOOLEAN;
			-- Level for analysis of feature rescue clause: usefull for
			-- validating `retry' instruction
			--[Set on when analyzing rescue clause]

	level4: BOOLEAN;
			-- Level for analysis of precondition
			

	supplier_ids: FEATURE_DEPENDANCE;
			-- Supplier units

	make is
		do
			extend_stack_make;
			!!locals.make (10);
			!!access_line.make;
			!!multi_line.make;
			!!interval_line.make;
			!!creation_types.make;
			!!parameters.make;
			!!supplier_ids.make;
			!! instruction_line.make
		end;

	set_a_class (cl: CLASS_C) is
			-- Assign `cl' to `a_class'.
		do
			a_class := cl;
			actual_class_type := cl.actual_type;
			feature_table := cl.feature_table;
		end;

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		do
			a_feature := f;
		end;

	set_level1 (b: BOOLEAN) is
			-- Assign `b' to `level1'.
		do
			level1 := b;
		end;

	set_level2 (b: BOOLEAN) is
			-- Assign `b' to `level2'.
		do
			level2 := b;
		end;

	set_level3 (b: BOOLEAN) is
			-- Assign `b' to `level3'.
		do
			level3 := b;
		end;

	set_level4 (b: BOOLEAN) is
			-- Assign `b' to `level4'.
		do
			level4 := b;
		end;

	set_locals (l: like locals) is
			-- Assign `l' to `locals'.
		do
			locals := l;
		end;

	feature_name: STRING is
			-- Name of the current feature analyzed
		require
			feature_exists: a_feature /= Void or else level2
		do
			if not level2 then
					-- Not checking invariant
				Result := a_feature.feature_name;
			else
				Result := "invariant";
			end;
		end;

	feature_type: TYPE_A is
			-- Type of the current analyzed feature
		do
			Result := a_feature.type.actual_type;
		end;

	last_class: CLASS_C is
			-- Class associated to the type on the stack
		require
			not empty;
		do
			Result := last_constrained_type.associated_class;
		end;

	begin_expression is
			-- Put actual type of current analyzed class onto the
			-- type stack
		do
			put (actual_class_type);
		end;

	expression_begining: BOOLEAN is
			-- Is the analysis on the beginning of an expression ?
		do
			Result := last_class = a_class;
		end;

	last_constrained_type: TYPE_A is
			-- Constrained type onto the stack
		do
			Result := item;	
			if Result.is_formal then
				Result := a_class.constraint (Result.base_type);
			end;
		end;

	init_error (e: FEATURE_ERROR) is
			-- Initialize `e'.
		require
			good_argument: not (e = Void);
		do
			e.set_class_id (a_class.id);
			if a_feature /= Void then
				e.set_feature_name (a_feature.feature_name);
			end;
		end;

	init_byte_code (byte_code: BYTE_CODE) is
			-- Initialiaze `byte_code'.
		require
			a_feature /= Void;
		local
			local_dec: ARRAY [TYPE_I];
			local_info: LOCAL_INFO;
			redef_body_id, local_count, argument_count, i, nb: INTEGER;
			arguments: FEAT_ARG;
			redef_bodies: ARRAY [INTEGER];
			redef_byte: BYTE_CODE;
			rout_id: INTEGER;
		do
				-- Name
			byte_code.set_feature_name (feature_name);
				-- Feature id
			byte_code.set_body_index (a_feature.body_index);
				-- Result type if any
			byte_code.set_result_type (a_feature.type.actual_type.type_i);
				-- Routine id
			rout_id := a_feature.rout_id_set.first;
			if rout_id < 0 then
				rout_id := - rout_id;
			end;
			byte_code.set_rout_id (rout_id);
				-- Pattern id
			byte_code.set_pattern_id (a_feature.pattern_id);
				-- Local variable declarations
			local_count := locals.count;
			if local_count > 0 then
				from
					locals.start;
					!!local_dec.make (1, local_count);
				until
					locals.offright
				loop
					local_info := locals.item_for_iteration;
					local_dec.put (local_info.type.type_i, local_info.position);
					locals.forth;
				end;
				byte_code.set_locals (local_dec);
			end;
				-- Arguments declarations
			argument_count := a_feature.argument_count;
			if argument_count > 0 then
				from
					arguments := a_feature.arguments;
					i := 1;
					!!local_dec.make (1, argument_count);
				until
					i > argument_count
				loop
					local_dec.put (arguments.i_th (i).actual_type.type_i, i);
					i := i + 1;
				end;
				byte_code.set_arguments (local_dec);
			end;
		end;

-- Managing the type stack

	pop (n: INTEGER) is
			-- Pop `n' element of the stack
		require
			positive_argument: n >= 0;
			stack_big_enough: count >= n;
		local
			i: INTEGER;
		do
			from
				i := 1;
			until
				i > n
			loop
				remove;
				i := i + 1;
			end;
		end;

	local_ith (i: INTEGER): LOCAL_INFO is
			-- I-th local information
		require
			locals /= Void;
		local
			local_info: LOCAL_INFO;
		do
			from
				locals.start
			until
				locals.offright or else Result /= Void
			loop
				local_info := locals.item_for_iteration;
				if local_info.position = i then
					Result := local_info;
				end;
				locals.forth;
			end;
		end;

	start_lines is
			-- Start all the lines computed by `type_check'.
		do
			access_line.start;
			multi_line.start;	
			interval_line.start;
			creation_types.start;
			parameters.start;
			instruction_line.start
		end;

	clear1 is
			-- Clear the structure: to use while changing of analyzed 
			-- a_class.
		do
			a_class := Void;
			actual_class_type := Void;
			feature_table := Void;
			clear2;
		end;

	clear2 is
			-- Clear a_feature context: to use while changing of current
			-- analyzed a_feature
		do
			a_feature := Void;
			locals.clear_all;
			access_line.wipe_out;
			multi_line.wipe_out;
			interval_line.wipe_out;
			creation_types.wipe_out;
			parameters.wipe_out;
			instruction_line.wipe_out;
			level1 := False;
			level2 := False;
			level3 := False;
			level4 := False;
			supplier_ids.wipe_out;
			wipe_out;
		end;

	trace is
			-- Trace the type stack
		local
			i: INTEGER;
		do
			from
				i := count;
			until
				i < 1
			loop
				io.error.putchar ('%T');
				i_th (i).trace;
				io.error.new_line;
				i := i - 1;
			end;
		end;

feature -- Debugger

	instruction_line: LINE [AST_EIFFEL];
			 -- List of instructions encountered sequentially in the compound.

end
