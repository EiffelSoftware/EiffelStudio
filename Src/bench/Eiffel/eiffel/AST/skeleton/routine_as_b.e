indexing

	description:
			"Abstract description of the content of a standard %
			%feature. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_AS_B

inherit

	ROUTINE_AS
		redefine
			obsolete_message, precondition,
			locals, routine_body, postcondition,
			rescue_clause, check_local_names
		end;

	CONTENT_AS_B
		undefine
			is_require_else, is_ensure_then,
			has_rescue, has_precondition, has_postcondition,
			check_local_names, number_of_stop_points
		redefine
			type_check, byte_node, find_breakable, 
			fill_calls_list, replicate, local_table, format,
			local_table_for_format
		end;

	SHARED_INSTANTIATOR;

	SHARED_CONSTRAINT_ERROR;

	SHARED_EVALUATOR;

feature -- Attributes

	obsolete_message: STRING_AS_B;
			-- Obsolete clause message
			-- (Void if was not present)

	precondition: REQUIRE_AS_B;
			-- Precondition list

	locals: EIFFEL_LIST_B [TYPE_DEC_AS_B];
			-- Local declarations

	routine_body: ROUT_BODY_AS_B;
			-- Routine body

	postcondition: ENSURE_AS_B;
			-- Routine postconditions

	rescue_clause: EIFFEL_LIST_B [INSTRUCTION_AS_B];
			-- Rescue compound

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
			id_list: EIFFEL_LIST_B [ID_AS_B];
			f_table: FEATURE_TABLE;
			vrle1: VRLE1;
			local_name: ID_AS_B;
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
			id_list: EIFFEL_LIST_B [ID_AS_B];
			local_type: TYPE_B;
			local_class_c: CLASS_C;
			local_name: ID_AS_B;
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
						equal (curr_feat.written_in, context_class.id);
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
							-- We do NOT want to update the type in the instantiator
							-- if there is an error!!!! (Xavier)
						Error_handler.checksum;

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
			id_list: EIFFEL_LIST_B [ID_AS_B];
			solved_type: TYPE_A;
			local_info: LOCAL_INFO;
			local_name: STRING;
			local_type: TYPE_B;
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

feature -- Format Context

	local_table_for_format (a_feature: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Local table for format context
		local
			feat_tbl: FEATURE_TABLE;
			id_list: EIFFEL_LIST_B [ID_AS_B];
			solved_type: TYPE_A;
			local_info: LOCAL_INFO;
			local_name: STRING;
			local_type: TYPE_B;
		do
			if locals /= Void then
				from
					!! Result.make (2 * locals.count);
					if a_feature /= Void then
						feat_tbl := a_feature.written_class.feature_table;
					end;
					locals.start
				until
					locals.after
				loop
					local_type := locals.item.type;
					id_list := locals.item.id_list;
					if feat_tbl /= Void then
						Local_evaluator.set_local_name (id_list.first);
						solved_type := Local_evaluator.evaluated_type_for_format
										(local_type, feat_tbl, a_feature);
					elseif not local_type.has_like then
						solved_type := local_type.solved_type (Void, Void)
					end;
					if solved_type = Void then
						from
							id_list.start;
						until
							id_list.after
						loop
							local_name := id_list.item;
							Result.put (Void, local_name);
							id_list.forth;
						end;
					else
						from
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
					end;
					locals.forth;
				end;
			end;
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
				record_break_node
			end;
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
			Result := clone (Current);
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

feature -- Context format

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Format routine ast to `ctxt'.
		local
			chained_assert: CHAINED_ASSERTIONS;
			comments: EIFFEL_COMMENTS
		do
			if ctxt.is_feature_short then
				ctxt.new_line
			else
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_Is_keyword);
				ctxt.new_line;
				if obsolete_message /= Void then
					ctxt.indent;
					ctxt.put_text_item (ti_Obsolete_keyword);
					ctxt.put_space;
					obsolete_message.format (ctxt);
					ctxt.new_line;
					ctxt.exdent;
				end;
			end;
			ctxt.indent;
			ctxt.indent;
			comments := ctxt.feature_comments;
			if comments /= Void then
				ctxt.put_comments (comments);
			end;
			ctxt.put_origin_comment;
			ctxt.exdent;
			ctxt.set_first_assertion (true);
			chained_assert := ctxt.chained_assertion;
			if chained_assert /= Void then
				chained_assert.format_precondition (ctxt);
			elseif precondition /= void then
				ctxt.set_in_assertion;
				precondition.format (ctxt);
				ctxt.set_not_in_assertion;
			end;
			if not ctxt.is_feature_short then
				if locals /= void then
					ctxt.put_text_item (ti_Local_keyword);
					ctxt.set_separator (ti_Semi_colon);
					ctxt.indent;
					ctxt.set_new_line_between_tokens;
					ctxt.new_line;
					locals.format (ctxt);
					ctxt.new_line;
					ctxt.exdent;
				end;
				if routine_body /= Void then
					routine_body.format (ctxt)
				end
			end;
			ctxt.set_first_assertion (true);
			if chained_assert /= void then
				chained_assert.format_postcondition (ctxt);
			elseif postcondition /= void then
				ctxt.set_in_assertion;
				postcondition.format (ctxt);
				ctxt.set_not_in_assertion;
			end;
			if not ctxt.is_feature_short then
				if rescue_clause /= void then
					ctxt.put_text_item (ti_Rescue_keyword);
					ctxt.indent;
					ctxt.new_line;
					ctxt.set_separator (ti_Semi_colon);
					ctxt.set_new_line_between_tokens;
					rescue_clause.format (ctxt);
					ctxt.exdent;
					ctxt.new_line;
					ctxt.put_breakable;
				end
				ctxt.put_text_item (ti_End_keyword);
			end;
			ctxt.exdent;
		end;

feature -- Case storage

	store_information (f: S_FEATURE_DATA) is
			-- Store pre and post information into `f'.
		require
			valid_f: f /= Void
		do
			if precondition /= Void and then 
									precondition.assertions /= Void then
				f.set_preconditions (precondition.storage_info);
			end;
			if postcondition /= Void and then 
									postcondition.assertions /= Void then
				f.set_postconditions (postcondition.storage_info);
			end;
		end;

end -- class ROUTINE_AS_B
