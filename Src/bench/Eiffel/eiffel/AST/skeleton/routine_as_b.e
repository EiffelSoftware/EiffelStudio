-- Abstract description of the content of a standard feature

class ROUTINE_AS

inherit

	CONTENT_AS
		redefine
			is_require_else, is_ensure_then,
			has_precondition, has_postcondition, has_rescue,
			type_check, byte_node
		end;
	SHARED_INSTANTIATOR;
	SHARED_CONSTRAINT_ERROR;
	SHARED_EVALUATOR;

feature -- Attributes

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
			precondition ?= yacc_arg (0);
			locals ?= yacc_arg (1);
			routine_body ?= yacc_arg (2);
			postcondition ?= yacc_arg (3);
			rescue_clause ?= yacc_arg (4);
		ensure then
			routine_body /= Void
		end;

feature -- Conveniences

	is_require_else: BOOLEAN is
			-- Is the precondition block of the content preceeded by
			-- `require else' ?
		do
			Result := precondition = Void or else precondition.is_else;
		end;

	is_ensure_then: BOOLEAN is
			-- Is the postcondition block of the content preceeded by
			-- `ensure then' ?
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
				precondition.type_check;
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

	check_locals is
			-- Check validity of local declarations: a local variable
			-- name cannot be a final name of the current feature table or
			-- an argument name of the current analyzed feature.
		local
			id_list: EIFFEL_LIST [ID_AS];
			local_type: TYPE;
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
			vtug3: VTUG3;
			vtec3: VTEC3;
			vtgg3: VTGG3;
			vreg2: VREG2;
		do
			from
				context_class := context.a_class;
				track_local :=
					context.a_feature.written_in = context_class.id
					and then
					context_class.changed;
				context_locals := context.locals;
				locals.start
			until
				locals.offright
			loop
				from
					id_list := locals.item.id_list;
					local_type := locals.item.type;

						-- Compute actual type for local
					Local_evaluator.set_local_name (id_list.first);
					solved_type := Local_evaluator.evaluated_type
						(local_type, context.feature_table, context.a_feature);
					check	
							-- If anchored type cannot be evaluated, the
							-- argument type evaluator will trigger an
							-- exception
						solved_type_exists: solved_type /= Void;
					end;

					id_list.start;
				until
					id_list.offright
				loop
					local_name := id_list.item;
					if context.feature_table.has (local_name) then
							-- The local name is a feature name of the
							-- current analyzed class.
						!!vrle1;
						context.init_error (vrle1);
						vrle1.set_local_name (local_name);
						Error_handler.insert_error (vrle1);
					elseif
						context.a_feature.has_argument_name (local_name)
					then
							-- The local name is an argument name of the
							-- current analyzed feature
						!!vrle2;
						context.init_error (vrle2);
						vrle2.set_local_name (local_name);
						Error_handler.insert_error (vrle2);
					end;
						-- Build the local table in the context
					counter := counter + 1;
					!!local_info;
						-- Check an expanded local type
					if 	solved_type.has_expanded
						and then
						not	(solved_type.good_expanded1)
					then
						!!vtec3;
						vtec3.set_class_id (context_class.id);
						vtec3.set_body_id (context.a_feature.body_id);
						vtec3.set_entity_name (local_name);
						Error_handler.insert_error (vtec3);
					end;
						-- Check a generic local type
					if not solved_type.good_generics then
						!!vtug3;
						vtug3.set_class_id (context_class.id);
						vtug3.set_body_id (context.a_feature.body_id);
						vtug3.set_entity_name (local_name);
						vtug3.set_type (solved_type);
						Error_handler.insert_error (vtug3);
							-- Cannot go on here
						Error_handler.raise_error;
					end;
						-- Check constraint genericity
					solved_type.check_constraints (context.a_class);
					if not Constraint_error_list.empty then
						!!vtgg3;
						vtgg3.set_class_id (context_class.id);
						vtgg3.set_body_id (context.a_feature.body_id);
						vtgg3.set_entity_name (local_name);
						vtgg3.set_error_list
							(deep_clone (Constraint_error_list));
						Error_handler.insert_error (vtgg3);
					end;

					local_info.set_type (solved_type);
					local_info.set_position (counter);
					if context_locals.has (local_name) then
							-- Error: two locals withe the same name
						!!vreg2;
						vreg2.set_local_name (local_name);
						context.init_error (vreg2);
						Error_handler.insert_error (vreg2);
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
				locals.forth;
			end;
		end;

	local_table (a_feature: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Local table for dead code removal
		require
			good_argument: a_feature /= Void;
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
					locals.offright
				loop
					from
						local_type := locals.item.type;
						id_list := locals.item.id_list;
						Local_evaluator.set_local_name (id_list.first);
						solved_type := Local_evaluator.evaluated_type
											(local_type, feat_tbl, a_feature);
						id_list.start;
					until
						id_list.offright
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

end
