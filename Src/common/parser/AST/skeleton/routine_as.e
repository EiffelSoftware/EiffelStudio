-- Abstract description of the content of a standard feature

class ROUTINE_AS

inherit

	CONTENT_AS
		redefine
			is_require_else, is_ensure_then,
			has_precondition, has_postcondition, has_rescue,
			type_check, byte_node, check_local_names,
			find_breakable, 
			fill_calls_list, replicate, local_table
		end;
	SHARED_INSTANTIATOR;
	SHARED_CONSTRAINT_ERROR;
	SHARED_EVALUATOR;

feature -- Attributes

	obsolete_message: STRING_AS;
			-- Obsolete clause message
			-- (Void if was not present)

	precondition: REQUIRE_AS;
			-- Precondition list

	locals: EIFFEL_LIST [TYPE_DEC_AS];
			-- Local declarations

	routine_body: ROUT_BODY_AS;
			-- Routine body

	postcondition: ENSURE_AS;
			-- Routine postconditions

	rescue_clause: EIFFEL_LIST [INSTRUCTION_AS];
			-- Rescue compound

feature -- Initialization

	set is
			-- Yacc initialization
		do
			obsolete_message ?= yacc_arg (0);
			precondition ?= yacc_arg (1);
			locals ?= yacc_arg (2);
			routine_body ?= yacc_arg (3);
			postcondition ?= yacc_arg (4);
			rescue_clause ?= yacc_arg (5);
		ensure then
			routine_body /= Void
		end;

feature -- Conveniences

	is_require_else: BOOLEAN is
			-- Is the precondition block of the content preceeded by
			-- `require else' ?
			--|Note: It is valid to not include a precondition in 
			--|a redefined feature (it is equivalent to "require else False")
		do
			Result := precondition = Void or else precondition.is_else;
		end;

	is_ensure_then: BOOLEAN is
			-- Is the postcondition block of the content preceeded by
			-- `ensure then' ?
			--|Note: It is valid to not include a postcondition in 
			--|a redefined feature (it is equivalent to "ensure then True"
		do
			Result := postcondition = Void or else postcondition.is_then;
		end;

	has_precondition: BOOLEAN is
			-- Has the routine content a preconditions ?
		do
			Result := not (	precondition = Void
							or else
							precondition.assertions = Void)
		end;

	has_postcondition: BOOLEAN is
			-- Has the routine content postconditions ?
		do
			Result := not (	postcondition = Void
							or else
							postcondition.assertions = Void)
		end;

	has_rescue: BOOLEAN is
			-- Has the routine a rescue clause ?
		do
			Result := rescue_clause /= Void;
		end;

	is_deferred: BOOLEAN is
			-- Is the routine body a deferred one ?
		do
			Result := routine_body.is_deferred;
		end;

	is_once: BOOLEAN is
			-- Is the routine body a once one ?
		do
			Result := routine_body.is_once;
		end;

	is_external: BOOLEAN is
			-- Is the routine body an external one ?
		do
			Result := routine_body.is_external;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on a routine body
		local
			vxrc: VXRC;
		do
				-- Check local variables
			if locals /= Void then
				check_locals;
			end;
				-- Check preconditions
			if precondition /= Void then
					-- Set access id level analysis to `level1': locals
					-- are not taken into account
				context.set_level1 (False);
					-- Set Result access analysis level to `level4': Result
					-- cannot be found in preconditions
				context.set_level4 (True);
				precondition.type_check;
					-- Reset the levels to default values
				context.set_level1 (False);
				context.set_level4 (False);
			end;
			routine_body.type_check;
				-- Check postconditions
			if postcondition /= Void then
					-- Set access id level analysis to `level1': locals
					-- are not taken into account
				context.set_level1 (True);
				postcondition.type_check;
					-- Reset the level
				context.set_level1 (False);
			end;
				-- Check rescue-clause
			if rescue_clause /= Void then
					-- A deferred or external feature cannot have a rescue
					-- clause
				if	routine_body.is_deferred
					or else
					routine_body.is_external	
				then
					!!vxrc;
					context.init_error (vxrc);
					vxrc.set_deferred (routine_body.is_deferred);
					Error_handler.insert_error (vxrc);
				else
						 -- Set mark of context
					context.set_level3 (True);
					rescue_clause.type_check;
					context.set_level3 (False);
				end;
			end;
		end;

	byte_node: BYTE_CODE is
			-- Associated byte code
		local
			precond_code: BYTE_LIST [BYTE_NODE];
		do
			if precondition /= Void then
				precond_code := precondition.byte_node;
			end;

			Result := routine_body.byte_node;
			context.init_byte_code (Result);
			Result.set_precondition (precond_code);

			if postcondition /= Void then
				Result.set_postcondition (postcondition.byte_node);
			end;
			if rescue_clause /= Void then
				Result.set_rescue_clause (rescue_clause.byte_node);
			end;
		end;

	check_local_names is
			-- Check conflicts between local names and feature names
		local
			id_list: EIFFEL_LIST [ID_AS];
			f_table: FEATURE_TABLE;
			vrle1: VRLE1;
			local_name: ID_AS;
		do
			if locals /= Void then
				from
					f_table := context.feature_table;
					locals.start
				until
					locals.after
				loop
					from
						id_list := locals.item.id_list;
						id_list.start;
					until
						id_list.after
					loop
						local_name := id_list.item;
						if
							f_table.has (local_name)
						then
								-- The local name is a feature name of the
								-- current analyzed class.
							!!vrle1;
							context.init_error (vrle1);
							vrle1.set_local_name (local_name);
							Error_handler.insert_error (vrle1);
						end;
						id_list.forth;
					end;
					locals.forth;
				end;
			end;
		end;

	check_locals is
			-- Check validity of local declarations: a local variable
			-- name cannot be a final name of the current feature table or
			-- an argument name of the current analyzed feature.
			-- Also an external or a deferred routine cannot have
			-- locals.
		local
			id_list: EIFFEL_LIST [ID_AS];
			local_type: TYPE;
			local_class_c: CLASS_C;
			local_name: ID_AS;
			solved_type: TYPE_A;
			context_class: CLASS_C;
			gen_type: GEN_TYPE_A;
			track_local: BOOLEAN;
			counter: INTEGER;
			local_info: LOCAL_INFO;
			context_locals: EXTEND_TABLE [LOCAL_INFO, STRING];
			vrle1: VRLE1;
			vrle2: VRLE2;
			vtug: VTUG;
			vtec1: VTEC1;
			vtec2: VTEC2;
			vtgg3: VTGG3;
			vreg: VREG;
			curr_feat: FEATURE_I;
			vrrr2: VRRR2
		do
			context_class := context.a_class;
			if (is_deferred or is_external) then
				!!vrrr2;
				context.init_error (vrrr2);
				vrrr2.set_is_deferred (is_deferred);
				Error_handler.insert_error (vrrr2);
			else
				from
					curr_feat := context.a_feature;
					track_local :=
						curr_feat.written_in = context_class.id;
					--	and then
					--	context_class.changed;
					context_locals := context.locals;
					locals.start
				until
					locals.after
				loop
					from
						id_list := locals.item.id_list;
						local_type := locals.item.type;
	
							-- Compute actual type for local
						Local_evaluator.set_local_name (id_list.first);
						solved_type := Local_evaluator.evaluated_type
							(local_type, context.feature_table, curr_feat);
						check	
								-- If anchored type cannot be evaluated, the
								-- argument type evaluator will trigger an
								-- exception
							solved_type_exists: solved_type /= Void;
						end;
	
						id_list.start;
					until
						id_list.after
					loop
						local_name := id_list.item;
						if 
							curr_feat.has_argument_name (local_name)
						then
								-- The local name is an argument name of the
								-- current analyzed feature
							!!vrle2;
							context.init_error (vrle2);
							vrle2.set_local_name (local_name);
							Error_handler.insert_error (vrle2);
						elseif
							context.feature_table.has (local_name)
						then
								-- The local name is a feature name of the
								-- current analyzed class.
							!!vrle1;
							context.init_error (vrle1);
							vrle1.set_local_name (local_name);
							Error_handler.insert_error (vrle1);
						end;
							-- Build the local table in the context
						counter := counter + 1;
						!!local_info;
							-- Check an expanded local type
						if 	solved_type.has_expanded then
							if	solved_type.expanded_deferred then
								!!vtec1;
								context.init_error (vtec1);
								vtec1.set_entity_name (local_name);
								Error_handler.insert_error (vtec1);
							elseif not solved_type.valid_expanded_creation (context_class) then
								!!vtec2;
								context.init_error (vtec2);
								vtec2.set_entity_name (local_name);
								Error_handler.insert_error (vtec2);
							end;
						end;
							-- Check a generic local type
						if not solved_type.good_generics then
							vtug := solved_type.error_generics;;
							vtug.set_class (context_class);
							vtug.set_feature (curr_feat);
							vtug.set_entity_name (local_name);
							Error_handler.insert_error (vtug);
								-- Cannot go on here
							Error_handler.raise_error;
						end;
							-- Check constraint genericity
						solved_type.check_constraints (context.a_class);
						if not Constraint_error_list.empty then
							!!vtgg3;
							vtgg3.set_class (context_class);
							vtgg3.set_feature (curr_feat);
							vtgg3.set_entity_name (local_name);
							vtgg3.set_error_list
								(deep_clone (Constraint_error_list));
							Error_handler.insert_error (vtgg3);
						end;
	
						local_info.set_type (solved_type);
						local_info.set_position (counter);
						if context_locals.has (local_name) then
								-- Error: two locals withe the same name
							!!vreg;
							vreg.set_entity_name (local_name);
							context.init_error (vreg);
							Error_handler.insert_error (vreg);
						else
							context_locals.put (local_info, local_name);
						end;
							-- Update instantiator for changed class
						if track_local then
							gen_type ?= solved_type.actual_type;
							if gen_type /= Void then
								Instantiator.dispatch (gen_type, context_class);
							end;
						end;
						id_list.forth;
					end;
	
					local_class_c := solved_type.associated_class;
					if local_class_c /= Void then
							-- Add the supplier in the feature_dependance list
						context.supplier_ids.add_supplier (local_class_c);
					end;
	
					if solved_type /= Void then
						solved_type.check_for_obsolete_class (context_class)
					end;
					locals.forth;
				end;
			end;
		end;

	local_table (a_feature: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Local table for dead code removal
		local
			feat_tbl: FEATURE_TABLE;
			id_list: EIFFEL_LIST [ID_AS];
			solved_type: TYPE_A;
			local_info: LOCAL_INFO;
			local_name: STRING;
			local_type: TYPE;
		do
			if locals /= Void then
				from
					!!Result.make (2 * locals.count);
					feat_tbl := a_feature.written_class.feature_table;
					locals.start
				until
					locals.after
				loop
					from
						local_type := locals.item.type;
						id_list := locals.item.id_list;
						Local_evaluator.set_local_name (id_list.first);
						solved_type := Local_evaluator.evaluated_type
											(local_type, feat_tbl, a_feature);
						id_list.start;
					until
						id_list.after
					loop
						local_name := id_list.item;
						!!local_info;
						local_info.set_type (solved_type);
						Result.put (local_info, local_name);
						id_list.forth;
					end;
					locals.forth;
				end;
			else
				Result := Empty_local_table;
			end;
		end;

	Empty_local_table: EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Empty local table
		once
			!!Result.make (1)
		end;

feature -- Debugger
 
	find_breakable is
			-- Look for breakable instructions.
		do
				-- Order matters.
			if routine_body /= Void then
				routine_body.find_breakable;
			end;
			if rescue_clause /= Void then
				rescue_clause.find_breakable;
			end;
		end;

feature -- Equivalent

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require else
			valid_other: other /= Void
		do
			Result := 	deep_equal (routine_body, other.routine_body) and then
                        deep_equal (locals, other.locals) and then
                        deep_equal (rescue_clause, other.rescue_clause) and then
            			deep_equal (obsolete_message, other.obsolete_message)
		end;
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require else
			valid_other: other /= Void
		do
			Result :=   deep_equal (precondition, other.precondition) and then
				deep_equal (postcondition, other.postcondition)
		end;

feature	-- Replication
	
	fill_calls_list (l: CALLS_LIST) is
			-- find call to Current
		do
			if precondition /= void then
				precondition.fill_calls_list (l);
			end;
			routine_body.fill_calls_list (l);
			if postcondition /= void then
				postcondition.fill_calls_list (l)
			end;
			if rescue_clause /= void then
				rescue_clause.fill_calls_list (l)
			end
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- adapt to replication
		do
			Result := twin;
			if precondition /= void then
				Result.set_precondition	(
					precondition.replicate (ctxt))
			end;
			if locals /= void then
				Result.set_locals (
					locals.replicate (ctxt))
			end;
			Result.set_routine_body (routine_body.replicate (ctxt));
			if postcondition /= void then
				Result.set_postcondition (
					postcondition.replicate (ctxt))
			end;
			if rescue_clause /= void then
				Result.set_rescue_clause (
					rescue_clause.replicate (ctxt))
			end;
		end;

feature	{ROUTINE_AS, FEATURE_AS}  -- Replication and for flattening of a routine

	set_precondition (p: like precondition) is
		do
			precondition := p
		end;

	set_locals (l: like locals) is
		do
			locals := l
		end;

	set_routine_body (r: like routine_body) is
		require
			valid_arg: r /= Void
		do
			routine_body := r
		end;

	set_postcondition (p: like postcondition) is
		do
			postcondition := p
		end;

	set_rescue_clause (r: like rescue_clause) is
		do	
			rescue_clause := r
		end;

	set_obsolete_message (m: like obsolete_message) is
		do	
			obsolete_message := m
		end;

end
