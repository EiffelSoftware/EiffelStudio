indexing
	description	: "Abstract description of the content of a standard %
				  %feature. Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class ROUTINE_AS

inherit
	CONTENT_AS
		redefine
			is_require_else, is_ensure_then,
			has_rescue, has_precondition, has_postcondition,
			check_local_names, 
			type_check, byte_node,
			fill_calls_list, replicate, local_table, format,
			local_table_for_format, create_default_rescue, is_empty,
			number_of_precondition_slots,
			number_of_postcondition_slots,
			number_of_breakpoint_slots
		end

	SHARED_INSTANTIATOR

	SHARED_EVALUATOR

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature {AST_FACTORY} -- Initialization

	initialize (o: like obsolete_message; pr: like precondition;
		l: like locals; b: like routine_body; po: like postcondition;
		r: like rescue_clause; p: INTEGER) is
			-- Create a new ROUTINE AST node.
		require
			b_not_void: b /= Void
		do
			obsolete_message := o
			precondition := pr
			locals := l
			routine_body := b
			postcondition := po
			rescue_clause := r
			body_start_position := p
		ensure
			obsolete_message_set: obsolete_message = o
			precondition_set: precondition = pr
			locals_set: locals = l
			routine_body_set: routine_body = b
			postcondition_set: postcondition = po
			rescue_clause_set: rescue_clause = r
			body_start_position_set: body_start_position = p
		end

feature -- Attributes

	body_start_position: INTEGER
			-- Position at the start of the main body (after the comments)

	obsolete_message: STRING_AS
			-- Obsolete clause message
			-- (Void if was not present)

	precondition: REQUIRE_AS
			-- Precondition list

	locals: EIFFEL_LIST [TYPE_DEC_AS]
			-- Local declarations

	routine_body: ROUT_BODY_AS
			-- Routine body

	postcondition: ENSURE_AS
			-- Routine postconditions

	rescue_clause: EIFFEL_LIST [INSTRUCTION_AS]
			-- Rescue compound

feature -- Properties

	is_require_else: BOOLEAN is
			-- Is the precondition block of the content preceeded by
			-- `require else' ?
			--|Note: It is valid to not include a precondition in 
			--|a redefined feature (it is equivalent to "require else False")
		do
			Result := precondition = Void or else precondition.is_else
		end

	is_ensure_then: BOOLEAN is
			-- Is the postcondition block of the content preceeded by
			-- `ensure then' ?
			--|Note: It is valid to not include a postcondition in 
			--|a redefined feature (it is equivalent to "ensure then True"
		do
			Result := postcondition = Void or else postcondition.is_then
		end

	has_precondition: BOOLEAN is
			-- Has the routine content a preconditions ?
		do
			Result := not (	precondition = Void
							or else
							precondition.assertions = Void)
		end

	has_postcondition: BOOLEAN is
			-- Has the routine content postconditions ?
		do
			Result := not (	postcondition = Void
							or else
							postcondition.assertions = Void)
		end

	has_rescue: BOOLEAN is
			-- Has the routine a non-empty rescue clause ?
		do
			Result := (rescue_clause /= Void) and then
					  not rescue_clause.is_empty
		end

	is_deferred: BOOLEAN is
			-- Is the routine body a deferred one ?
		do
			Result := routine_body.is_deferred
		end

	is_once: BOOLEAN is
			-- Is the routine body a once one ?
		do
			Result := routine_body.is_once
		end

	is_external: BOOLEAN is
			-- Is the routine body an external one ?
		do
			Result := routine_body.is_external
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST (pre/post condition
			-- included but the ones inherited)
		do
				-- At least one stoppoint, the one corresponding
				-- to the feature end.
			Result := 1 

				-- Add the body stop points
			if routine_body /= Void then
				Result := Result + routine_body.number_of_breakpoint_slots
			end

				-- Add the rescue stop points
			if has_rescue then
				Result := Result + rescue_clause.number_of_breakpoint_slots
			end

				-- Add the pre/postconditions slots
			Result := Result + number_of_precondition_slots + number_of_postcondition_slots
		end

	number_of_precondition_slots: INTEGER is
			-- Number of preconditions
			-- (inherited assertions are not taken into account)
		do
			if has_precondition then
				Result := precondition.number_of_breakpoint_slots
			end
		end

	number_of_postcondition_slots: INTEGER is
			-- Number of postconditions
			-- (inherited assertions are not taken into account)
		do
			if has_postcondition then
				Result := postcondition.number_of_breakpoint_slots
			end
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this routine has instruction `i'?
		do
			Result := routine_body.has_instruction (i)
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this routine.
		do	
			Result := routine_body.index_of_instruction (i)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_body_equiv (other) and is_assertion_equiv (other)
		end

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		do
			Result := equivalent (routine_body, other.routine_body) and then
				equivalent (locals, other.locals) and then
				equivalent (rescue_clause, other.rescue_clause) and then
				equivalent (obsolete_message, other.obsolete_message)
		end
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require else
			valid_other: other /= Void
		do
			Result := equivalent (precondition, other.precondition) and then
				equivalent (postcondition, other.postcondition)
		end

feature -- test for empty body

	is_empty : BOOLEAN is
		do
			Result := (routine_body = Void) or else (routine_body.is_empty)
		end

feature -- default rescue

	create_default_rescue (def_resc_name : STRING) is
		local
			def_resc_id   : ID_AS
			def_resc_call : ACCESS_ID_AS
			def_resc_instr: INSTR_CALL_AS
		do
			if rescue_clause = Void and then
			   not (routine_body.is_deferred or routine_body.is_external) then
				create def_resc_id.make (1)
				def_resc_id.load (def_resc_name)
				create def_resc_call
				def_resc_call.set_feature_name (def_resc_id)
				create def_resc_instr
				def_resc_instr.set_call (def_resc_call)
				create rescue_clause.make (1)
				rescue_clause.extend (def_resc_instr)
			end
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on a routine body
		local
			vxrc: VXRC
		do
				-- Check local variables
			if locals /= Void then
				check_locals
			end
				-- Check preconditions
			if precondition /= Void then
					-- Set access id level analysis to `level1': locals
					-- are not taken into account
				context.set_level1 (False)
					-- Set Result access analysis level to `level4': Result
					-- cannot be found in preconditions
				context.set_level4 (True)
				precondition.type_check
					-- Reset the levels to default values
				context.set_level1 (False)
				context.set_level4 (False)
			end
			routine_body.type_check
				-- Check postconditions
			if postcondition /= Void then
					-- Set access id level analysis to `level1': locals
					-- are not taken into account
				context.set_level1 (True)
				postcondition.type_check
					-- Reset the level
				context.set_level1 (False)
			end


				-- Check rescue-clause
			if rescue_clause /= Void then
					-- A deferred or external feature cannot have a rescue
					-- clause
				if	routine_body.is_deferred
					or else
					routine_body.is_external	
				then
					!!vxrc
					context.init_error (vxrc)
					vxrc.set_deferred (routine_body.is_deferred)
					Error_handler.insert_error (vxrc)
				else
						 -- Set mark of context
					context.set_level3 (True)
					rescue_clause.type_check
					context.set_level3 (False)
				end
			end
		end

	byte_node: BYTE_CODE is
			-- Associated byte code
		local
			precond_code: BYTE_LIST [BYTE_NODE]
		do
			if precondition /= Void then
				precond_code := precondition.byte_node
			end

			Result := routine_body.byte_node
			context.init_byte_code (Result)
			Result.set_precondition (precond_code)

			if postcondition /= Void then
				Result.set_postcondition (postcondition.byte_node)
			end
			if rescue_clause /= Void then
				Result.set_rescue_clause (rescue_clause.byte_node)
			end
		end

	check_local_names is
			-- Check conflicts between local names and feature names
		local
			id_list: ARRAYED_LIST [INTEGER]
			f_table: FEATURE_TABLE
			vrle1: VRLE1
			local_name_id: INTEGER
		do
			if locals /= Void then
				from
					f_table := context.feature_table
					locals.start
				until
					locals.after
				loop
					from
						id_list := locals.item.id_list
						id_list.start
					until
						id_list.after
					loop
						local_name_id := id_list.item
						if f_table.has_id (local_name_id) then
								-- The local name is a feature name of the
								-- current analyzed class.
							!!vrle1
							context.init_error (vrle1)
							vrle1.set_local_name (local_name_id)
							Error_handler.insert_error (vrle1)
						end
						id_list.forth
					end
					locals.forth
				end
			end
		end

	check_locals is
			-- Check validity of local declarations: a local variable
			-- name cannot be a final name of the current feature table or
			-- an argument name of the current analyzed feature.
			-- Also an external or a deferred routine cannot have
			-- locals.
		local
			id_list: ARRAYED_LIST [INTEGER]
			local_type: TYPE
			local_class_c: CLASS_C
			local_name_id: INTEGER
			local_name: STRING
			solved_type: TYPE_A
			context_class: CLASS_C
			gen_type: GEN_TYPE_A
			track_local: BOOLEAN
			counter: INTEGER
			local_info: LOCAL_INFO
			context_locals: EXTEND_TABLE [LOCAL_INFO, STRING]
			vrle1: VRLE1
			vrle2: VRLE2
			vtug: VTUG
			vtec1: VTEC1
			vtec2: VTEC2
			vtcg3: VTCG3
			vreg: VREG
			curr_feat: FEATURE_I
			vrrr2: VRRR2
		do
			context_class := context.current_class
			if (is_deferred or is_external) then
				create vrrr2
				context.init_error (vrrr2)
				vrrr2.set_is_deferred (is_deferred)
				Error_handler.insert_error (vrrr2)
			else
				from
					curr_feat := context.current_feature
					track_local := curr_feat.written_in = context_class.class_id
					--	and then
					--	context_class.changed
					context_locals := context.locals
					locals.start
				until
					locals.after
				loop
					from
						id_list := locals.item.id_list
						local_type := locals.item.type
	
							-- Compute actual type for local
						Local_evaluator.set_local_name (id_list.first)
						solved_type := Local_evaluator.evaluated_type
							(local_type, context.feature_table, curr_feat)
						check	
								-- If anchored type cannot be evaluated, the
								-- argument type evaluator will trigger an
								-- exception
							solved_type_exists: solved_type /= Void
						end
	
						id_list.start
					until
						id_list.after
					loop
						local_name_id := id_list.item
						local_name := Names_heap.item (local_name_id)
						if curr_feat.has_argument_name (local_name_id) then
								-- The local name is an argument name of the
								-- current analyzed feature
							create vrle2
							context.init_error (vrle2)
							vrle2.set_local_name (local_name_id)
							Error_handler.insert_error (vrle2)
						elseif
							context.feature_table.has_id (local_name_id)
						then
								-- The local name is a feature name of the
								-- current analyzed class.
							create vrle1
							context.init_error (vrle1)
							vrle1.set_local_name (local_name_id)
							Error_handler.insert_error (vrle1)
						end
							-- Build the local table in the context
						counter := counter + 1
						create local_info
							-- Check an expanded local type
						if 	solved_type.has_expanded then
							if	solved_type.expanded_deferred then
								!!vtec1
								context.init_error (vtec1)
								vtec1.set_entity_name (local_name)
								Error_handler.insert_error (vtec1)
							elseif not solved_type.valid_expanded_creation (context_class) then
								!!vtec2
								context.init_error (vtec2)
								vtec2.set_entity_name (local_name)
								Error_handler.insert_error (vtec2)
							end
						end
							-- Check a generic local type
						if not solved_type.good_generics then
							vtug := solved_type.error_generics
							vtug.set_class (context_class)
							vtug.set_feature (curr_feat)
							vtug.set_entity_name (local_name)
							Error_handler.insert_error (vtug)
								-- Cannot go on here
							Error_handler.raise_error
						end
							-- Check constraint genericity
						solved_type.reset_constraint_error_list
						solved_type.check_constraints (context_class)
						if not solved_type.constraint_error_list.is_empty then
							create vtcg3
							vtcg3.set_class (context_class)
							vtcg3.set_feature (curr_feat)
							vtcg3.set_entity_name (local_name)
							vtcg3.set_error_list (solved_type.constraint_error_list)
							Error_handler.insert_error (vtcg3)
						end
	
						local_info.set_type (solved_type)
						local_info.set_position (counter)
						if context_locals.has (local_name) then
								-- Error: two locals withe the same name
							create vreg
							vreg.set_entity_name (local_name)
							context.init_error (vreg)
							Error_handler.insert_error (vreg)
						else
							context_locals.put (local_info, local_name)
						end
							-- We do NOT want to update the type in the instantiator
							-- if there is an error!!!! (Xavier)
						Error_handler.checksum

							-- Update instantiator for changed class
						if track_local then
							gen_type ?= solved_type.actual_type
							if gen_type /= Void then
								Instantiator.dispatch (gen_type, context_class)
							end
						end
						id_list.forth
					end
	
					local_class_c := solved_type.associated_class
					if local_class_c /= Void then
							-- Add the supplier in the feature_dependance list
						context.supplier_ids.add_supplier (local_class_c)
					end
	
					if solved_type /= Void then
						solved_type.check_for_obsolete_class (context_class)
					end
					locals.forth
				end
			end
		end

	local_table (a_feature: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Local table for dead code removal
		local
			feat_tbl: FEATURE_TABLE
			id_list: ARRAYED_LIST [INTEGER]
			solved_type: TYPE_A
			local_info: LOCAL_INFO
			local_name_id: INTEGER
			local_type: TYPE
		do
			if locals /= Void then
				from
					create Result.make (2 * locals.count)
					feat_tbl := a_feature.written_class.feature_table
					locals.start
				until
					locals.after
				loop
					from
						local_type := locals.item.type
						id_list := locals.item.id_list
						Local_evaluator.set_local_name (id_list.first)
						solved_type := Local_evaluator.evaluated_type
											(local_type, feat_tbl, a_feature)
						id_list.start
					until
						id_list.after
					loop
						local_name_id := id_list.item
						create local_info
						local_info.set_type (solved_type)
						Result.put (local_info, Names_heap.item (local_name_id))
						id_list.forth
					end
					locals.forth
				end
			else
				Result := Empty_local_table
			end
		end

	Empty_local_table: EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Empty local table
		once
			create Result.make (1)
		end

feature -- Format Context

	local_table_for_format (a_feature: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Local table for format context
		local
			feat_tbl: FEATURE_TABLE
			id_list: ARRAYED_LIST [INTEGER]
			solved_type: TYPE_A
			local_info: LOCAL_INFO
			local_name_id: INTEGER
			local_type: TYPE
		do
			if locals /= Void then
				from
					create Result.make (2 * locals.count)
					if a_feature /= Void then
						feat_tbl := a_feature.written_class.feature_table
					end
					locals.start
				until
					locals.after
				loop
					local_type := locals.item.type
					id_list := locals.item.id_list
					if feat_tbl /= Void then
						Local_evaluator.set_local_name (id_list.first)
						solved_type := Local_evaluator.evaluated_type_for_format
										(local_type, feat_tbl, a_feature)
					elseif not local_type.has_like then
						solved_type := local_type.solved_type (Void, Void)
					end
					if solved_type = Void then
						from
							id_list.start
						until
							id_list.after
						loop
							local_name_id := id_list.item
							Result.put (Void, Names_heap.item (local_name_id))
							id_list.forth
						end
					else
						from
							id_list.start
						until
							id_list.after
						loop
							local_name_id := id_list.item
							!!local_info
							local_info.set_type (solved_type)
							Result.put (local_info, Names_heap.item (local_name_id))
							id_list.forth
						end
					end
					locals.forth
				end
			end
		end

feature	-- Replication
	
	fill_calls_list (l: CALLS_LIST) is
			-- find call to Current
		do
			if precondition /= Void then
				precondition.fill_calls_list (l)
			end
			routine_body.fill_calls_list (l)
			if postcondition /= Void then
				postcondition.fill_calls_list (l)
			end
			if rescue_clause /= Void then
				rescue_clause.fill_calls_list (l)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- adapt to replication
		do
			Result := clone (Current)
			if precondition /= Void then
				Result.set_precondition	(
					precondition.replicate (ctxt))
			end
			if locals /= Void then
				Result.set_locals (
					locals.replicate (ctxt))
			end
			Result.set_routine_body (routine_body.replicate (ctxt))
			if postcondition /= Void then
				Result.set_postcondition (
					postcondition.replicate (ctxt))
			end
			if rescue_clause /= Void then
				Result.set_rescue_clause (
					rescue_clause.replicate (ctxt))
			end
		end

feature -- Context format

	format (ctxt: FORMAT_CONTEXT) is
			-- Format routine ast to `ctxt'.
		local
			chained_assert: CHAINED_ASSERTIONS
			comments: EIFFEL_COMMENTS
		do
			if ctxt.is_feature_short then
				ctxt.new_line
			else
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Is_keyword)
				ctxt.new_line
				if obsolete_message /= Void then
					ctxt.indent
					ctxt.put_text_item (ti_Obsolete_keyword)
					ctxt.put_space
					obsolete_message.format (ctxt)
					ctxt.new_line
					ctxt.exdent
				end
			end
			ctxt.indent
			ctxt.indent
			comments := ctxt.feature_comments
			if comments /= Void then
				ctxt.put_comments (comments)
			end
			ctxt.put_origin_comment
			ctxt.exdent
			ctxt.set_first_assertion (true)
			chained_assert := ctxt.chained_assertion
			if chained_assert /= Void then
				chained_assert.format_precondition (ctxt)
			elseif precondition /= Void then
				ctxt.set_in_assertion
				precondition.format (ctxt)
				ctxt.set_not_in_assertion
			end
			if not ctxt.is_feature_short then
				if locals /= Void then
					ctxt.put_text_item (ti_Local_keyword)
					ctxt.set_separator (Void)
					ctxt.indent
					ctxt.set_new_line_between_tokens
					ctxt.new_line
					locals.format (ctxt)
					ctxt.new_line
					ctxt.exdent
				end
				if routine_body /= Void then
					routine_body.format (ctxt)
				end
			end
			ctxt.set_first_assertion (true)
			if chained_assert /= Void then
				chained_assert.format_postcondition (ctxt)
			elseif postcondition /= Void then
				ctxt.set_in_assertion
				postcondition.format (ctxt)
				ctxt.set_not_in_assertion
			end
			if not ctxt.is_feature_short then
				if rescue_clause /= Void then
					ctxt.put_text_item (ti_Rescue_keyword)
					ctxt.indent
					ctxt.new_line
					ctxt.set_separator (Void)
					ctxt.set_new_line_between_tokens
					rescue_clause.format (ctxt)
					ctxt.exdent
					ctxt.new_line
				end
				if
					not is_deferred and
					not is_external
				then
						-- Put the final breakable mark (the one before the final end).
					ctxt.put_breakable
				end
				ctxt.put_text_item (ti_End_keyword)
			end
			ctxt.exdent
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			comments: EIFFEL_COMMENTS
		do
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_Is_keyword)
			ctxt.new_line

			if obsolete_message /= Void then
				ctxt.indent
				ctxt.put_text_item (ti_Obsolete_keyword)
				ctxt.put_space
				obsolete_message.simple_format (ctxt)
				ctxt.new_line
				ctxt.exdent
			end

			comments := ctxt.feature_comments
			if comments /= Void then
				ctxt.indent
				ctxt.indent
				ctxt.put_comments (comments)
				ctxt.exdent
				ctxt.exdent
			end

			ctxt.indent
			if precondition /= Void then
				precondition.simple_format (ctxt)
			end
			if locals /= Void then
				ctxt.put_text_item (ti_Local_keyword)
				ctxt.set_separator (ti_Empty)
				ctxt.indent
				ctxt.set_new_line_between_tokens
				ctxt.new_line
				locals.simple_format (ctxt)
				ctxt.new_line
				ctxt.exdent
			end
			if routine_body /= Void then
				routine_body.simple_format (ctxt)
			end
			if postcondition /= Void then
				postcondition.simple_format (ctxt)
			end
			if rescue_clause /= Void then
				ctxt.put_text_item (ti_Rescue_keyword)
				ctxt.indent
				ctxt.new_line
				rescue_clause.simple_format (ctxt)
				ctxt.new_line
				ctxt.exdent
				ctxt.put_breakable
			end
			ctxt.put_text_item (ti_End_keyword)
			ctxt.exdent
		end

feature	{ROUTINE_AS, FEATURE_AS, ROUTINE_MERGER, USER_CMD, CMD} -- Replication and for flattening of a routine

	set_precondition (p: like precondition) is
		do
			precondition := p
		end

	set_locals (l: like locals) is
		do
			locals := l
		end

	set_routine_body (r: like routine_body) is
		require
			valid_arg: r /= Void
		do
			routine_body := r
		end

	set_postcondition (p: like postcondition) is
		do
			postcondition := p
		end

	set_rescue_clause (r: like rescue_clause) is
		do	
			rescue_clause := r
		end

	set_obsolete_message (m: like obsolete_message) is
		do	
			obsolete_message := m
		end

end -- class ROUTINE_AS
