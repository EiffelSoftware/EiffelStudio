indexing
	description: "Context for third pass"
	date: "$Date$"
	revision: "$Revision$"

class
	AST_CONTEXT 

inherit
	ARRAYED_STACK [TYPE_A]
		rename
			make as stack_make
		export
			{ANY} valid_index
			{ACCESS_FEAT_AS, PRECURSOR_AS, AST_CONTEXT} i_th
		end

	SHARED_SERVER
		undefine
			is_equal, copy
		end

	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			is_equal, copy
		end

create
	make
	
create {AST_CONTEXT}
	make_filled

feature {NONE} -- Initialization

	make is
			-- Create instance of AST_CONTEXT.	
		do
			stack_make (50)
			create locals.make (10)
			create access_line.make
			create array_line.make
			create tuple_line.make
			create typed_pointer_line.make
			create interval_line.make
			create creation_infos.make
			create creation_types.make
			create parameters.make
			create supplier_ids.make
			create instruction_line.make
			create separate_calls.make (1, 0)
		end
	
feature -- Access

	current_class: CLASS_C
			-- Current analyzed class.

	actual_class_type: CL_TYPE_A
			-- Actual type of `current_class'.

	feature_table: FEATURE_TABLE
			-- Current feature table

	current_feature: FEATURE_I
			-- Current analyzed feature.

	locals: HASH_TABLE [LOCAL_INFO, STRING]
			-- Current local variables of the analyzed feature

	has_loop: BOOLEAN
			-- Does the current FEATURE_AS node contain a loop construct?

	access_line: ACCESS_LINE
			-- List of access encountered by the type checker: then the
			-- building of the byte code takes those access.

	array_line: LINE [MULTI_TYPE_A]
			-- Line of manifest array types

	tuple_line: LINE [TUPLE_TYPE_A]
			-- Line of manifest tuple types

	typed_pointer_line: LINE [TYPE_A]
			-- Line of TYPED_POINTER types use with `$' operator.

	interval_line: LINE [INTERVAL_B]
			-- Line of intervals

	creation_infos: LINE [CREATE_INFO]
			-- How a type should be created?

	creation_types: LINE [TYPE_I]
			-- Creation information types

	parameters: LINE [TYPE_A]
			-- Features with arguments encountered during type check

	depend_unit_level: INTEGER_8
			-- Current level used to create new instances of DEPEND_UNIT.

	is_checking_postcondition: BOOLEAN is
			-- Are we currently checking a postcondition.
			-- Needed to ensure that old expression only appears in
			-- postconditions
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_ensure_flag) =
				{DEPEND_UNIT}.is_in_ensure_flag
		end

	is_checking_invariant: BOOLEAN is
			-- Level of analysis for access, When analyzing an access id,
			-- (instance of ACCESS_ID_AS), locals, arguments
			-- are not taken into account if set to True.
			-- Useful for analyzing class invariant.
			-- [Set on when analyzing invariants].
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_invariant_flag) =
				{DEPEND_UNIT}.is_in_invariant_flag
		end

	is_ignoring_export: BOOLEAN
			-- Do we ignore export validity for feature access ?
			-- Useful for expression evaluation

	level3: BOOLEAN
			-- Level for analysis of feature rescue clause: usefull for
			-- validating `retry' instruction
			--[Set on when analyzing rescue clause]

	is_checking_precondition: BOOLEAN is
			-- Level for analysis of precondition
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_require_flag) =
				{DEPEND_UNIT}.is_in_require_flag
		end

	is_checking_check: BOOLEAN is
			-- Level for analyzis of check clauses
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_check_flag) =
				{DEPEND_UNIT}.is_in_check_flag
		end

	is_in_assignment: BOOLEAN is
			-- Level for analysis of target of an assignment
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_assignment_flag) =
				{DEPEND_UNIT}.is_in_assignment_flag
		end

	is_in_creation: BOOLEAN is
			-- Level for analyzis of target of a creation
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_creation_flag) =
				{DEPEND_UNIT}.is_in_creation_flag
		end

	check_for_special_error: BOOLEAN
			-- Flag for checking the vape error and vaol error
			
	supplier_ids: FEATURE_DEPENDANCE
			-- Supplier units

	is_in_creation_expression: BOOLEAN
			-- Are we type checking a creation expression?
			-- Usefull, for not checking VAPE error in precondition
			-- using creation expression, since type checking 
			-- on CREATION_EXPR_AS will report a not sufficiently
			-- exported creation routine.
			
	is_in_creation_call: BOOLEAN
			-- Are we type checking the call to the creation routine?

	last_conversion_info: CONVERSION_INFO
			-- Information about last conversion

	once_manifest_string_number: INTEGER
			-- Total number of once manifest strings from the beginning
			-- of the current routine or of the current class invariant

feature -- Setting

	set_current_class (cl: CLASS_C) is
			-- Assign `cl' to `current_class'.
		require
			cl_not_void: cl /= Void
		do
			current_class := cl
			actual_class_type := cl.actual_type
			feature_table := cl.feature_table
		ensure
			current_class_set: current_class = cl
		end
		
	set_current_class_with_actual_type (cl: CLASS_C; ct: CL_TYPE_A) is
			-- Assign `cl' to `current_class' and `ct' to `actual_class_type'
		require
			cl_not_void: cl /= Void
		do
			current_class := cl
			if ct /= Void then
				actual_class_type := ct
			else
				actual_class_type := cl.actual_type
			end
			feature_table := cl.feature_table
		ensure
			current_class_set: current_class = cl
		end		

	set_current_feature (f: FEATURE_I) is
			-- Assign `f' to `current_feature'.
		require
			f_not_void: f /= Void
		do
			current_feature := f
			once_manifest_string_number := 0
		ensure
			current_feature_set: current_feature = f
			no_once_manifest_strings: once_manifest_string_number = 0
		end

	set_is_checking_postcondition (b: BOOLEAN) is
			-- Assign `b' to `is_checking_postcondition'.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_ensure_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_ensure_flag.bit_not
			end
		ensure
			is_checking_postcondition_set: is_checking_postcondition = b
		end

	set_is_checking_invariant (b: BOOLEAN) is
			-- Assign `b' to `is_checking_invariant'.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_invariant_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_invariant_flag.bit_not
			end
		ensure
			is_checking_invariant_set: is_checking_invariant = b
		end

	set_is_ignoring_export (b: BOOLEAN) is
			-- Assign `b' to `is_ignoring_export'.
		do
			is_ignoring_export := b
		ensure
			is_ignoring_export_set: is_ignoring_export = b
		end

	set_level3 (b: BOOLEAN) is
			-- Assign `b' to `level3'.
		do
			level3 := b;
		end;

	set_is_in_creation_expression (b: BOOLEAN) is
			-- Assign `b' to `is_in_creation_expression'.
		do
			is_in_creation_expression := b
		ensure
			is_in_creation_expression_set: is_in_creation_expression = b
		end

	set_is_in_creation_call (b: BOOLEAN) is
			-- Assign `b' to `is_in_creation_call'.
		do
			is_in_creation_call := b
		ensure
			is_in_creation_call_set: is_in_creation_call = b
		end

	set_is_checking_precondition (b: BOOLEAN) is
			-- Assign `b' to `is_checking_precondition'.
			-- Also set `b' to check_for_vape.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_require_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_require_flag.bit_not
			end
				-- FIXME: Manu: 03/20/2004: It is not normal that we
				-- set `check_for_special_error'.
			check_for_special_error := b
		ensure
			is_checking_precondition_set: is_checking_precondition = b
		end

	set_is_checking_check (b: BOOLEAN) is
			-- Assign `b' to `is_checking_check'.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_check_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_check_flag.bit_not
			end
		ensure
			is_checking_check_set: is_checking_check = b
		end

	set_is_in_assignment (b: BOOLEAN) is
			-- Assign `b' to `is_in_assignment'.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_assignment_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_assignment_flag.bit_not
			end
		ensure
			is_in_assignment_set: is_in_assignment = b
		end
	
	set_is_in_creation (b: BOOLEAN) is
			-- Assign `b' to `is_in_creation'.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_creation_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_creation_flag.bit_not
			end
		ensure
			is_in_creation_set: is_in_creation = b
		end
	
	check_for_vape: BOOLEAN is
			-- Is Current checking for vape error?
		do
			Result := check_for_special_error
		end;

	set_check_for_vaol (b: BOOLEAN) is
			-- Assign `b' to `check_for_special_error'.
		do
			check_for_special_error := b;
		end;

	check_for_vaol: BOOLEAN is
			-- Is Current checking for vaol error?
		do
			Result := check_for_special_error
		end;

	set_has_loop (v: BOOLEAN) is
			-- Assign `v' to `has_loop'.
		do
			has_loop := v
		ensure
			has_loop_set: has_loop = v
		end

	set_locals (l: like locals) is
			-- Assign `l' to `locals'.
		do
			locals := l;
		end;

	set_last_conversion_info (l: like last_conversion_info) is
			-- Assign `l' to `last_conversion_info'.
		do
			last_conversion_info := l
		ensure
			last_conversion_info_set: last_conversion_info = l
		end
		
	add_once_manifest_string is
			-- Register a once manifest string
		do
			once_manifest_string_number := once_manifest_string_number + 1
		ensure
			added_once_manifest_string: once_manifest_string_number = old once_manifest_string_number + 1
		end

	feature_name_id: INTEGER is
			-- Name of the current feature analyzed
		require
			feature_exists: current_feature /= Void or else is_checking_invariant
		do
			if not is_checking_invariant then
					-- Not checking invariant
				Result := current_feature.feature_name_id
			else
				Result := Names_heap.invariant_name_id
			end;
		end;

	feature_type: TYPE_A is
			-- Type of the current analyzed feature
		do
			Result := current_feature.type.actual_type;
		end;

	last_class: CLASS_C is
			-- Class associated to the type on the stack
		require
			not is_empty;
		do
			Result := last_constrained_type.associated_class;
		end;

	begin_expression is
			-- Put actual type of current analyzed class onto the
			-- type stack
		do
			put (actual_class_type)
		end

	expression_begining: BOOLEAN is
			-- Is the analysis on the beginning of an expression ?
		do
			Result := last_class = current_class
		end

	last_constrained_type: TYPE_A is
			-- Constrained type onto the stack
		local
			formal_type: FORMAL_A
		do
			Result := item
			if Result.is_formal then
				formal_type ?= Result
				Result := current_class.constraint (formal_type.position)
			end
		end

	init_error (e: FEATURE_ERROR) is
			-- Initialize `e'.
		require
			good_argument: not (e = Void)
		do
			e.set_class (current_class)
			if current_feature /= Void then
				e.set_feature (current_feature)
			end
		end

	init_byte_code (byte_code: BYTE_CODE) is
			-- Initialiaze `byte_code'.
		require
			current_feature /= Void;
		local
			local_dec: ARRAY [TYPE_I]
			local_info: LOCAL_INFO
			local_count: INTEGER
			argument_count: INTEGER
			i: INTEGER
			arguments: FEAT_ARG
			rout_id: INTEGER
			escaped: STRING
		do
				-- Name
			if current_feature.is_infix or current_feature.is_prefix then
				create escaped.make (current_feature.feature_name.count + 5)
				(create {STRING_CONVERTER}).escape_string (escaped, current_feature.feature_name)
				Names_heap.put (escaped)
				byte_code.set_escaped_feature_name_id (Names_heap.found_item)
			else
				byte_code.set_escaped_feature_name_id (feature_name_id)
			end
			byte_code.set_feature_name_id (feature_name_id)

				-- Feature id
			byte_code.set_body_index (current_feature.body_index)
				-- Result type if any
			byte_code.set_result_type (current_feature.type.actual_type.type_i)
				-- Routine id
			rout_id := current_feature.rout_id_set.first
			byte_code.set_rout_id (rout_id)
				-- Pattern id
			byte_code.set_pattern_id (current_feature.pattern_id)
				-- Local variable declarations
			local_count := locals.count
			if local_count > 0 then
				from
					locals.start
					create local_dec.make (1, local_count)
				until
					locals.after
				loop
					local_info := locals.item_for_iteration
					local_dec.put (local_info.type.type_i, local_info.position)
					locals.forth
				end
				byte_code.set_locals (local_dec)
			end
				-- Arguments declarations
			argument_count := current_feature.argument_count
			if argument_count > 0 then
				from
					arguments := current_feature.arguments
					i := 1
					create local_dec.make (1, argument_count)
				until
					i > argument_count
				loop
					local_dec.put (arguments.i_th (i).actual_type.type_i, i)
					i := i + 1
				end
				byte_code.set_arguments (local_dec)
			end
		end

feature -- Managing the type stack

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
				locals.after or else Result /= Void
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
			array_line.start;	
			tuple_line.start;	
			typed_pointer_line.start;	
			interval_line.start;
			creation_infos.start;
			creation_types.start;
			parameters.start;
			instruction_line.start
		end;

	clear1 is
			-- Clear the structure: to use while changing of analyzed 
			-- current_class.
		do
			current_class := Void;
			actual_class_type := Void;
			feature_table := Void;
			clear2;
		end;

	clear2 is
			-- Clear `current_feature' context: to use while changing of current
			-- analyzed feature.
		do
			current_feature := Void;
			locals.clear_all;
			access_line.wipe_out;
			array_line.wipe_out;
			tuple_line.wipe_out;
			typed_pointer_line.wipe_out;
			interval_line.wipe_out;
			creation_infos.wipe_out;
			creation_types.wipe_out;
			parameters.wipe_out;
			instruction_line.wipe_out;
			last_conversion_info := Void
			depend_unit_level := 0
			level3 := False;
			check_for_special_error := False;
			supplier_ids.wipe_out;
			separate_calls.make (1, 0)
			wipe_out;
		end;

feature -- Concurrent Eiffel

	separate_call_on_argument (i: INTEGER): BOOLEAN is
			-- Is argument `i' used in a separate call?
		do
			if i <= separate_calls.upper then
				Result := separate_calls @ i
			end
		end

	set_separate_call_on_argument (arg_name: ID_AS) is
			-- Record argument `i' as been used in separate call.
		require
			feature_has_argument: current_feature.argument_position (arg_name) /= 0
		do
			separate_calls.force (True, current_feature.argument_position (arg_name))
		end

feature {STD_BYTE_CODE} -- Concurrent Eiffel

	separate_calls: ARRAY [BOOLEAN]
			-- Record separate calls on arguments

feature -- Debugging

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
				io.error.put_character ('%T');
				i_th (i).trace;
				io.error.put_new_line;
				i := i - 1;
			end;
		end;

feature -- Debugger

	instruction_line: LINE [AST_EIFFEL];
			 -- List of instructions encountered sequentially in the compound.

invariant
	locals_not_void: locals /= Void

end
