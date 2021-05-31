note
	description: "Check validity of a TYPE_A object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_A_CHECKER

inherit
	TYPE_A_VISITOR

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

	SHARED_DEGREES
	SHARED_INSTANTIATOR

	SHARED_TMP_SERVER
		export
			{NONE} all
		end

feature -- Status report

	has_error_reporting: BOOLEAN
			-- Can current report error?
		do
			Result := error_handler /= Void
		end

	solved (a_unevaluated_type: TYPE_A; a_type_as: TYPE_AS): TYPE_A
			-- Check that validity of `a_unevaluated_type' in current context
			-- as initialized by `init' or `init_with_feature_table'.
		require
			a_unevaluated_type_not_void: a_unevaluated_type /= Void
			has_error_reporting: not has_error_reporting
		do
			like_control.reset
			associated_type_ast := a_type_as
			last_type := current_actual_type
			a_unevaluated_type.process (Current)
			Result := last_type
			last_type := Void
			associated_type_ast := Void
		end

	check_and_solved (a_unevaluated_type: TYPE_A; a_type_as: TYPE_AS): TYPE_A
			-- Check that validity of `a_unevaluated_type' in current context
			-- as initialized by `init' or `init_with_feature_table'.
		require
			a_unevaluated_type_not_void: a_unevaluated_type /= Void
			has_error_reporting: has_error_reporting
		do
			like_control.reset
			associated_type_ast := a_type_as
			last_type := current_actual_type
			a_unevaluated_type.process (Current)
			Result := last_type
			last_type := Void
			associated_type_ast := Void
		end

	is_delayed: BOOLEAN
			-- May type evaluation be delayed?

feature -- Settings

	init_for_checking (a_feature: FEATURE_I; a_class: CLASS_C; a_suppliers: FEATURE_DEPENDANCE; a_error_handler: ERROR_HANDLER)
			-- Initialize Current with `a_feature', `a_class' and `suppliers'.
			-- `suppliers' will be updated if not Void.
		require
			a_feature_not_void: a_feature /= Void
			a_class_not_void: a_class /= Void
		do
			current_feature := a_feature
			current_class := a_class
			current_actual_type := a_class.actual_type
			current_feature_table := a_class.feature_table
			suppliers := a_suppliers
			error_handler := a_error_handler
			set_is_delayed (False)
		ensure
			current_feature_set: current_feature = a_feature
			current_class_set: current_class = a_class
			current_actual_type_set: attached current_actual_type as t and then t.same_as (a_class.actual_type)
			current_feature_table_set: current_feature_table = current_class.feature_table
			suppliers_set: suppliers = a_suppliers
			error_handler_set: error_handler = a_error_handler
			not_is_delayed: not is_delayed
		end

	init_with_feature_table (a_feature: FEATURE_I; a_feat_tbl: FEATURE_TABLE; a_error_handler: ERROR_HANDLER)
			-- Initialize Current to start type checking of the given feature within the given feature table.
		require
			a_feature_not_void: a_feature /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
		do
			current_feature := a_feature
			current_class := a_feat_tbl.associated_class
			current_actual_type := current_class.actual_type
			current_feature_table := a_feat_tbl
			suppliers := Void
			error_handler := a_error_handler
			set_is_delayed (False)
		ensure
			current_feature_set: current_feature = a_feature
			current_class_set: current_class = a_feat_tbl.associated_class
			current_actual_type_set: attached current_actual_type as t and then t.same_as (current_class.actual_type)
			current_feature_table_set: current_feature_table = a_feat_tbl
			suppliers_set: suppliers = Void
			error_handler_set: error_handler = a_error_handler
			not_is_delayed: not is_delayed
		end

	set_is_delayed (value: BOOLEAN)
			-- Set `is_delayed' to `value'.
		do
			is_delayed := value
		ensure
			is_delayed_set: is_delayed = value
		end

feature {NONE} -- Implementation: Access

	last_type: TYPE_A
			-- Last resolved type of checker

	associated_type_ast: TYPE_AS
			-- Top type being checked by Current

	current_feature_table: FEATURE_TABLE
			-- Feature table where current type is resolved,
			-- it is or will be associated with `current_class'

	current_feature: FEATURE_I
			-- Feature where current type is resolved

	current_class: CLASS_C
			-- Current class where current type is resolved
			-- May change during processing when context is switched,
			-- e.g. because of qualified anchored type.

	current_actual_type: CL_TYPE_A
			-- Actual type of `current_class'

	suppliers: FEATURE_DEPENDANCE
			-- Dependances if they need to be recorded.

	error_handler: ERROR_HANDLER
			-- Medium used to report error. If not set, no errors are reported
			-- and `last_type' will be set to Void.

	like_control: LIKE_CONTROLER
			-- Controler of anchors. A once to avoid object creation.
		once
			create Result.make
		ensure
			like_control_not_void: Result /= Void
		end

feature -- Special checking

	check_type_validity (a_type: TYPE_A; a_type_node: TYPE_AS)
			-- Check validity of `a_type' linked to `a_type_node'.
		require
			has_error_reporting: has_error_reporting
		local
			l_vtec: VTEC
			l_vtug: VTUG
			l_vtcg3: VTCG3
			l_vgcc3: VGCC3
			l_has_error: BOOLEAN
		do
			if a_type = Void then
					-- Cannot create instance of `a_type' from `a_type_node'.
					--| Most probably a BITS_SYMBOLS_AS
				fixme ("Check when this could happen and then update the validity code as this one %
					%is not the correct one (VGCC3 stands for creation, not for type in general")
				create l_vgcc3
				l_vgcc3.set_class (current_class)
				l_vgcc3.set_feature (current_feature)
				if a_type_node /= Void then
					l_vgcc3.set_is_symbol
					l_vgcc3.set_symbol_name (a_type_node.dump)
					l_vgcc3.set_location (a_type_node.start_location)
				end
				error_handler.insert_error (l_vgcc3)
			else
				if a_type.has_expanded then
					if a_type.expanded_deferred then
						create {VTEC1} l_vtec
					elseif system.il_generation and then not a_type.is_ancestor_valid then
							-- Expanded type cannot be based on a class with external ancestor.
						create {VTEC3} l_vtec
					elseif is_delayed implies system.any_class.compiled_class.degree_4_processed then
							-- Class ANY needs to have an up-to-date feature table,
							-- so that the feature "default_create" can be looked up.
						if not a_type.valid_expanded_creation (current_class) then
							create {VTEC2} l_vtec
						end
					else
							-- Check `VTEC2' when class "ANY" is ready.
						degree_4.put_action (
							agent (t: TYPE_A; f: like current_feature; c: like current_class; l: TYPE_AS)
								local
									v: VTEC2
								do
									if not t.valid_expanded_creation (c) then
										create v
										v.set_class (c)
										v.set_feature (f)
										if l /= Void then
											v.set_location (l.start_location)
										end
										error_handler.insert_error (v)
									end
								end
							(a_type, current_feature, current_class, a_type_node)
						)
					end
					if l_vtec /= Void then
							-- Report error.
						l_vtec.set_class (current_class)
						l_vtec.set_feature (current_feature)
						if a_type_node /= Void then
							l_vtec.set_location (a_type_node.start_location)
						end
						error_handler.insert_error (l_vtec)
						l_has_error := True
					end
				end
				if not l_has_error then
					if not a_type.good_generics then
						l_vtug := a_type.error_generics
						l_vtug.set_class (current_class)
						l_vtug.set_feature (current_feature)
						if a_type_node /= Void then
							l_vtug.set_location (a_type_node.start_location)
						end
						error_handler.insert_error (l_vtug)
					else
						a_type.reset_constraint_error_list
							-- We check creation readyness if the type is expanded. See ECMA 356 2nd edition: section 8.12.12/
						a_type.check_constraints (current_class,current_feature, a_type.is_expanded)
						if not a_type.constraint_error_list.is_empty then
							create l_vtcg3
							l_vtcg3.set_class (current_class)
							l_vtcg3.set_feature (current_feature)
							l_vtcg3.set_error_list (a_type.constraint_error_list)
							if a_type_node /= Void then
								l_vtcg3.set_location (a_type_node.start_location)
							end
							error_handler.insert_error (l_vtcg3)
						else
							a_type.check_labels (current_class, a_type_node)
						end
					end
				end
			end
		end

	check_constraint_type (a_context_class: CLASS_C; a_type: TYPE_AS; a_error_handler: ERROR_HANDLER)
			-- Is `a_type' a valid constraint for `a_context_class'?
			--| We check whether the `a_type' exists in the very same group as `a_context_class'.
			--| In case `a_type' is generic, we check that all actual generic parameters meet their constraints.
			--| Example:
			--| class A[G -> LIST[INTEGER]] end
			--| `a_type' is LIST
			--| `a_context_class' is A
			--| * Check that LIST is in the same group (cluster, library) as A.
			--| * Check that INTEGER fullfils the constraint of LIST's first and only generic.
		require
			a_context_class_not_void: a_context_class /= Void
			a_type_not_void: a_type /= Void
			a_error_handler_not_void: a_error_handler /= Void
		local
			l_associated_class: CLASS_C
			l_cl_generics: EIFFEL_LIST [FORMAL_DEC_AS]
			l_class_i: CLASS_I
			l_cluster: CONF_GROUP
			l_vtct: VTCT
			l_has_error: BOOLEAN
			l_error_level: NATURAL
			l_t1, l_t2: TYPE_AS
			l_t1_a, l_t2_a: TYPE_A
			l_pos: INTEGER
			l_cursor1, l_cursor2: INTEGER
			l_is_tuple_type : BOOLEAN
			l_type_a: TYPE_A
			l_generics: TYPE_LIST_AS
		do
			l_type_a := type_a_generator.evaluate_type (a_type, a_context_class)
				-- Type was previously checked in `{CLASS_C}.check_types_in_constraint'
			check not l_type_a.has_like and l_type_a.is_class_valid end
				-- Check if there is no anchor (has_like) and no bit symbol (is_class_valid) in the constraint type.
			if attached {CLASS_TYPE_AS} a_type as l_class_type then
				l_cluster := a_context_class.group
				l_class_i := universe.class_named (l_class_type.class_name.name, l_cluster)
				if l_class_i = Void then
					fixme ("Produce better error message: Say that it was not found in the current cluster if it exists in another cluster.")
					create l_vtct
					l_vtct.set_class (a_context_class)
					l_vtct.set_class_name (l_class_type.class_name.name)
					l_vtct.set_location (l_class_type.start_location)
					a_error_handler.insert_error (l_vtct)
				else
					l_associated_class := l_class_i.compiled_class
					l_is_tuple_type := l_associated_class.is_tuple
					l_cl_generics := l_associated_class.generics
						-- The generic parameters to check (INTEGER in the example above).
					if attached l_class_type.generics as l_class_type_generics then
						if not l_is_tuple_type then
							l_cl_generics := l_cl_generics.twin
							if attached {GEN_TYPE_A} l_type_a as l_gen_type then
								from
									l_cursor1 := l_class_type_generics.index
									l_class_type_generics.start
									if
										a_context_class.lace_class.is_obsolete_routine_type and then
										(l_associated_class.class_id = system.routine_class_id or
										l_associated_class.class_id = system.procedure_class_id or
										l_associated_class.class_id = system.predicate_class_id or
										l_associated_class.class_id = system.function_class_id)
									then
											-- Ignore the first actual parameter.
										l_class_type_generics.forth
									end
									l_cl_generics.start
									l_pos := 1
								until
									l_class_type_generics.after or else l_has_error
								loop
									l_error_level := a_error_handler.error_level
									l_t1 := l_class_type_generics.item
									check_constraint_type (a_context_class, l_t1, a_error_handler)
									l_has_error := a_error_handler.error_level /= l_error_level
									if not l_has_error then
										l_t1_a := type_a_generator.evaluate_type (l_t1, a_context_class)
										from
											l_cursor2 := l_cl_generics.item.constraints.index
											l_cl_generics.item.constraints.start
										until
											l_cl_generics.item.constraints.after or l_has_error
										loop
											l_t2 := l_cl_generics.item.constraints.item.type
											if l_t2 /= Void then
												l_t2_a := type_a_generator.evaluate_type (l_t2, l_associated_class)
												l_t2_a := l_t2_a.instantiated_in (l_type_a)
												if l_t2_a /= Void then
													l_t1_a.check_const_gen_conformance
														(l_gen_type, l_t2_a, a_context_class, l_pos)
													l_has_error := a_error_handler.error_level /= l_error_level
												end
											end
											l_cl_generics.item.constraints.forth
										end
										l_cl_generics.item.constraints.go_i_th (l_cursor2)
									end
									l_pos := l_pos + 1
									l_class_type_generics.forth
									l_cl_generics.forth
								end
								l_class_type_generics.go_i_th (l_cursor1)
							else
								check
									from_postcondition_of_l_class_type_generics: False
								end
							end
						else
								-- TUPLE: has no generics
							from
								l_generics := l_class_type.generics
								l_generics.start
								l_pos := l_generics.index
							until
								l_generics.after or else l_has_error
							loop
								l_error_level := a_error_handler.error_level
								l_t1 := l_generics.item
								check_constraint_type (a_context_class, l_t1, a_error_handler)
								l_has_error := a_error_handler.error_level /= l_error_level
								l_generics.forth
							end
							l_generics.go_i_th (l_pos)
						end
					end
				end
			end
		end

feature {TYPE_A} -- Visitors

	process_boolean_a (a_type: BOOLEAN_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_character_a (a_type: CHARACTER_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_cl_type_a (a_type: CL_TYPE_A)
			-- Process `a_type'.
		do
			last_type := a_type
			if a_type.is_true_expanded then
				check
					has_associated_class: a_type.has_associated_class
				end
				record_exp_dependance (a_type.base_class)
			end
		end

	process_formal_a (a_type: FORMAL_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_gen_type_a (a_type: GEN_TYPE_A)
			-- Process `a_type'.
		local
			l_generics: ARRAYED_LIST [TYPE_A]
			i, nb: INTEGER
			l_has_error: BOOLEAN
			t: TYPE_A
		do
			t := last_type
			process_cl_type_a (a_type)
			l_generics := a_type.generics
			nb := l_generics.count
			if nb > 0 then
				from
					i := l_generics.lower
					nb := l_generics.upper
				until
					i > nb
				loop
						-- Restore context type before processing next generic type.
					last_type := t
					l_generics.i_th (i).process (Current)
					l_has_error := l_has_error or else last_type = Void
					if not l_has_error then
						l_generics.put_i_th (last_type, i)
					end
					i := i + 1
				end
			end
			if not l_has_error then
				last_type := a_type
			else
				last_type := Void
			end
		end

	process_integer_a (a_type: INTEGER_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_like_argument (a_type: LIKE_ARGUMENT)
			-- Process `a_type'.
		do
			update_like_argument (current_feature, a_type)
		end

	process_like_current (a_type: LIKE_CURRENT)
			-- Process `a_type'.
		do
			a_type.set_actual_type (current_actual_type)
			last_type := a_type
		end

	process_like_feature (a_type: LIKE_FEATURE)
			-- Process `a_type'.
		local
			l_anchor_feature, l_orig_feat: FEATURE_I
			l_veen: VEEN
			l_orig_class_id: INTEGER
			is_postponed: BOOLEAN
		do
				-- Find feature associated with `a_type'. It might not be
				-- found in case anchors has disappeared. It might also
				-- be invalid (check done in `update_like_feature') in case
				-- it is not a function anymore.
			l_orig_class_id := a_type.class_id
			if current_class.class_id = l_orig_class_id then
				l_anchor_feature := current_feature_table.item_id (a_type.feature_name_id)
			else
				check attached System.class_of_id (l_orig_class_id) as c then
						-- Make sure the feature table of `c' is up-to-date.
					if is_delayed implies c.degree_4_processed then
							-- Feature table is ready.
						l_orig_feat := c.feature_table.item_id (a_type.feature_name_id)
						if l_orig_feat /= Void then
							l_anchor_feature := current_feature_table.feature_of_rout_id (l_orig_feat.rout_id_set.first)
						end
					else
							-- Postpone type evaluation.
						last_type := Void
						is_postponed := True
					end
				end
			end
			if l_anchor_feature /= Void then
					-- Check if anchor feature type is up-to-date.
				if is_delayed and then l_anchor_feature.is_type_evaluation_delayed then
						-- Delay type evaluation.
					last_type := Void
				else
						-- Update `a_type' with new information.
					a_type.make (l_anchor_feature, current_class.class_id)
					update_like_feature (l_anchor_feature, a_type)
				end
			elseif not is_postponed then
				last_type := Void
				if has_error_reporting then
					create l_veen
					l_veen.set_class (current_class)
					l_veen.set_feature (current_feature)
					l_veen.set_identifier (a_type.feature_name)
					error_handler.insert_error (l_veen)
				end
			end
		end

	process_local (a_type: LOCAL_TYPE_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_manifest_integer_a (a_type: MANIFEST_INTEGER_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_manifest_natural_64_a (a_type: MANIFEST_NATURAL_64_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_manifest_real_a (a_type: MANIFEST_REAL_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_named_tuple_type_a (a_type: NAMED_TUPLE_TYPE_A)
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_native_array_type_a (a_type: NATIVE_ARRAY_TYPE_A)
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_natural_a (a_type: NATURAL_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_none_a (a_type: NONE_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_pointer_a (a_type: POINTER_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_qualified_anchored_type_a (a_type: QUALIFIED_ANCHORED_TYPE_A)
			-- Process `a_type'.
		do
			if a_type.class_id = current_class.class_id then
				update_immediate_qualified_anchored_type (a_type)
			else
				update_inherited_qualified_anchored_type (a_type)
			end
		end

	process_real_a (a_type: REAL_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_tuple_type_a (a_type: TUPLE_TYPE_A)
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_typed_pointer_a (a_type: TYPED_POINTER_A)
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_unevaluated_like_type (a_type: UNEVALUATED_LIKE_TYPE)
			-- Process `a_type'.
		local
			l_anchor_feature: FEATURE_I
			l_argument_position: INTEGER
			l_like_argument: LIKE_ARGUMENT
			l_like_feature: LIKE_FEATURE
			l_veen: VEEN
		do
				-- Check if the parent's feature table is up-to-date.
			if
				is_delayed and then
				current_feature.written_in /= current_class.class_id and then
				not current_feature.written_class.degree_4_processed
			then
					-- Delay type evaluation.
				last_type := Void
			else
				l_anchor_feature := current_feature_table.item_id (a_type.anchor_name_id)
				if l_anchor_feature /= Void then
						-- Check if anchor feature type is up-to-date.
					if is_delayed and then l_anchor_feature.is_type_evaluation_delayed then
							-- Delay type evaluation.
						last_type := Void
					else
							-- Create instance of `{LIKE_FEATURE}'.
						create l_like_feature.make (l_anchor_feature, current_class.class_id)
						l_like_feature.set_marks_from (a_type)
						update_like_feature (l_anchor_feature, l_like_feature)
					end
				else
					l_argument_position := current_feature.argument_position (a_type.anchor_name_id)
					if l_argument_position = 0 then
						last_type := Void
						if has_error_reporting then
							create l_veen
							l_veen.set_class (current_class)
							l_veen.set_feature (current_feature)
							l_veen.set_identifier (a_type.anchor)
							if associated_type_ast /= Void then
								l_veen.set_location (associated_type_ast.start_location)
							end
							error_handler.insert_error (l_veen)
						end
					else
						create l_like_argument
						l_like_argument.set_position (l_argument_position)
						l_like_argument.set_marks_from (a_type)
						update_like_argument (current_feature, l_like_argument)
					end
				end
			end
		end

	process_unevaluated_qualified_anchored_type (t: UNEVALUATED_QUALIFIED_ANCHORED_TYPE)
			-- Process `t'.
		local
			r: QUALIFIED_ANCHORED_TYPE_A
		do
			create r.make (t.qualifier, t.chain, current_class.class_id)
			r.set_marks_from (t)
			update_immediate_qualified_anchored_type (r)
		end

	process_unknown (t: UNKNOWN_TYPE_A)
			-- <Precursor>
		do
			last_type := t
		end

	process_void_a (a_type: VOID_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

feature {NONE} -- Implementation

	update_like_argument (a_feature: FEATURE_I; a_type: LIKE_ARGUMENT)
			-- Given `a_feature' to which `a_type' anchors to, verify that
			-- `a_type' is valid, and update `a_type' accordingly.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		local
			l_vtat1a: VTAT1A
			l_like_control: like like_control
		do
			l_like_control := like_control
				-- Found argument
			if l_like_control.has_argument (a_type.position) then
					-- Cycle involving anchors on arguments
				last_type := Void
				if has_error_reporting then
					create l_vtat1a
					l_vtat1a.set_type (a_type)
					l_vtat1a.set_class (current_class)
					l_vtat1a.set_argument_name (a_feature.arguments.item_name_32 (a_type.position))
					l_vtat1a.set_feature (a_feature)
					error_handler.insert_error (l_vtat1a)
				end
			else
				l_like_control.put_argument (a_type.position)
				a_feature.arguments.i_th (a_type.position).process (Current)
				l_like_control.remove_argument
				if last_type /= Void then
					a_type.set_actual_type (last_type)
					last_type := a_type
				end
			end
		end

	update_like_feature (a_feature: FEATURE_I; a_type: LIKE_FEATURE)
			-- Given `a_feature' to which `a_type' anchors to, verify that
			-- `a_type' is valid, and update `a_type' accordingly.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		do
			process_anchor (a_feature, a_type)
			if attached last_type as a then
				a_type.set_actual_type (a.actual_type)
				if attached suppliers as s then
						-- There is a dependance between `current_feature' and
						-- the `a_feature'.
						-- Record it for the propagation of the recompilations
					s.extend_depend_unit_with_level (current_class.class_id, a_feature, 0)
				end
				last_type := a_type
			end
		ensure
			last_type_set: last_type = Void or else last_type = a_type
		end

	update_immediate_qualified_anchored_type (t: QUALIFIED_ANCHORED_TYPE_A)
			-- Update qualified anchored type written in the current class.
		require
			t_attached: attached t
			t_immediate: t.class_id = current_class.class_id
		local
			l_veen: VEEN
			q: detachable TYPE_A
			i: INTEGER
			saved_class: like current_class
			saved_actual_type: like current_actual_type
			saved_feature_table: like current_feature_table
			saved_feature: like current_feature
			routine_id: SPECIAL [INTEGER]
			n: INTEGER
			e: like error_handler.error_level
			ast: detachable QUALIFIED_ANCHORED_TYPE_AS
			saved_ast: like associated_type_ast
		do
			if attached error_handler as h then
				e := h.error_level
			end
				-- Synchronize `associated_type_ast' to avoid updating wrong AST nodes (if this happens).
			saved_ast := associated_type_ast
			if attached {QUALIFIED_ANCHORED_TYPE_AS} saved_ast as ast_node then
				associated_type_ast := ast_node.qualifier
			else
				associated_type_ast := Void
			end
			t.qualifier.process (Current)
			associated_type_ast := saved_ast
			if is_delayed then
				last_type := Void
			else
				q := last_type
			end
			if attached q then
				t.set_qualifier (q)
				if attached {QUALIFIED_ANCHORED_TYPE_AS} associated_type_ast as ast_node then
					ast := ast_node
				end
				n := t.chain.count
				create routine_id.make_filled (0, n)
				from
				until
					not attached q or else i >= n
				loop
					if has_error_reporting then
							-- Verify that the type is valid in current context
							-- as it makes no sense to continue processing otherwise.
						check_type_validity (q, associated_type_ast)
					end
					if
						attached error_handler as h and then h.error_level /= e
					then
							-- The type is not valid in current context.
						q := Void
					else
							-- Register intermediate type with instantiator.
						instantiator.dispatch (q.conformance_type, current_class)
						feature_finder.find (t.chain [i], q, current_class)
						if
							attached feature_finder.found_feature as f and then
							attached feature_finder.found_site as p and then
							attached p.base_class as c
						then
							saved_class := current_class
							saved_actual_type := current_actual_type
							saved_feature_table := current_feature_table
							saved_feature := current_feature
								-- We have already saved `associated_type_ast' in `saved_ast'.
							if ast /= Void then
								associated_type_ast := ast.qualifier
							else
								associated_type_ast := Void
							end
							current_class := f.written_class
							current_actual_type := current_class.actual_type
							current_feature_table := current_class.feature_table
							current_feature := current_class.feature_of_rout_id_set (f.rout_id_set)
							process_anchor (current_feature, t)
							if attached last_type as r and then current_class /= c then
									-- `r' references a type, relative to parent.
									-- Let's make it relative to current class.
								last_type := r.instantiation_in (create {LIKE_CURRENT}.make (c.actual_type), f.written_in)
							end
							current_class := saved_class
							current_actual_type := saved_actual_type
							current_feature_table := saved_feature_table
							current_feature := saved_feature
							associated_type_ast := saved_ast
							if attached last_type as r then
									-- Evaluate type of `f' in the current context.
									-- Use formal generic constraint instead of the formal generic itself.
									-- Avoid using `instantiated_in' to preserve `like Current' status.
									-- Use `r.actual_type' instead of just `r' to avoid recomputing qualified anchored types (if any)
									-- that are not ready yet for use (test#anchor033).
									-- Use `{TYPE_A}.recomputed_in' to correctly recompute anchors relative to the context class,
									-- e.g. when they depend on formal generics of the context class (test#anchor079).
								q := r.actual_type.recomputed_in (q, current_class.class_id, p, c.class_id).actual_type
									-- Record supplier for recompilation.
								degree_4.add_qualified_supplier (f, c, current_class)
									-- Register intermediate type with instantiator.
								instantiator.dispatch (q.conformance_type, current_class)
									-- Record routine ID that is used to update the type in descendants.
								routine_id [i] := f.rout_id_set.first
								if attached ast and then tmp_ast_server.is_loaded (current_class.class_id) then
										-- Update AST with the type information for refactoring.
									ast.chain [i + 1].set_routine_ids (f.rout_id_set)
									ast.chain [i + 1].set_class_id (c.class_id)
									tmp_ast_server.touch (current_class.class_id)
								end
								if attached suppliers as s then
										-- There is a dependance between `current_feature' and `f'.
										-- Record it for the propagation of the recompilations.
									s.extend_depend_unit_with_level (c.class_id, f, 0)
								end
							end
						elseif has_error_reporting then
							create l_veen
							l_veen.set_class (current_class)
							l_veen.set_feature (current_feature)
							l_veen.set_identifier (system.names.item (t.chain [i]))
							error_handler.insert_error (l_veen)
								-- Stop processing of the chain.
							q := Void
						end
					end
					i := i + 1
				end
				if attached q then
					t.set_actual_type (q.actual_type)
					t.set_routine_id (routine_id)
					last_type := t
				else
					last_type := Void
				end
			end
		ensure
			last_type_set: last_type = Void or else last_type = t
		end

	update_inherited_qualified_anchored_type (t: QUALIFIED_ANCHORED_TYPE_A)
		require
			t_attached: attached t
			t_inherited: t.class_id /= current_class.class_id
		local
			l_veen: VEEN
			q: TYPE_A
			i: INTEGER
			saved_class: like current_class
			saved_actual_type: like current_actual_type
			saved_feature_table: like current_feature_table
			saved_feature: like current_feature
			name: SPECIAL [INTEGER]
			n: INTEGER
		do
			t.qualifier.process (Current)
			if is_delayed then
				last_type := Void
			else
				q := last_type
			end
			if attached q then
				t.set_qualifier (q)
				n := t.chain.count
				create name.make_filled (0, n)
				from
						-- Register intermediate type with instantiator.
					instantiator.dispatch (q.conformance_type, current_class)
				until
					not attached q or else i >= n
				loop
					feature_finder.find_by_routine_id (t.routine_id [i], q, current_class)
					if
						attached feature_finder.found_feature as f and then
						attached feature_finder.found_site as p and then
						attached p.base_class as c
					then
						saved_class := current_class
						saved_actual_type := current_actual_type
						saved_feature_table := current_feature_table
						saved_feature := current_feature
						current_class := f.written_class
						current_actual_type := current_class.actual_type
						current_feature_table := current_class.feature_table
						current_feature := current_class.feature_of_rout_id_set (f.rout_id_set)
						process_anchor (current_feature, t)
						if attached last_type as r and then current_class /= c then
								-- `r' references a type, relative to parent.
								-- Let's make it relative to current class.
							last_type := r.instantiation_in (create {LIKE_CURRENT}.make (c.actual_type), f.written_in)
						end
						current_class := saved_class
						current_actual_type := saved_actual_type
						current_feature_table := saved_feature_table
						current_feature := saved_feature
						if attached last_type as r then
								-- Evaluate type of `f' in the current context.
								-- Use formal generic constraint instead of the formal general itself.
								-- Avoid using `instantiated_in' to preserve `like Current' status.
							q := r.recomputed_in (q, current_class.class_id, p, c.class_id)
								-- Record supplier for recompilation.
							degree_4.add_qualified_supplier (f, c, current_class)
								-- Register intermediate type with instantiator.
							instantiator.dispatch (q.conformance_type, current_class)
								-- Save name of the routine.
							name [i] := f.feature_name_id
							if attached suppliers as s then
									-- There is a dependance between `current_feature' and `f'.
									-- Record it for the propagation of the recompilations
								s.extend_depend_unit_with_level (current_class.class_id, f, 0)
							end
						end
					elseif has_error_reporting then
						create l_veen
						l_veen.set_class (current_class)
						l_veen.set_feature (current_feature)
						l_veen.set_identifier (system.names.item (t.chain [i]))
						error_handler.insert_error (l_veen)
							-- Stop processing of the chain.
						q := Void
					end
					i := i + 1
				end
				if attached q then
					t.set_actual_type (q.actual_type)
					t.set_chain (name, current_class)
					last_type := t
				else
					last_type := Void
				end
			end
		ensure
			last_type_set: last_type = Void or else last_type = t
		end

	process_anchor (f: FEATURE_I; t: TYPE_A)
			-- Process anchor `f' being a part of type `t' and record it's type in `last_type'.
			-- Report cyclic anchors if `has_error_reporting'.
		require
			f_attached: attached f
		local
			l_like_control: like like_control
			l_vtat1: VTAT1
		do
			l_like_control := like_control
			if l_like_control.has_feature (f) then
					-- Error because of cycle
				last_type := Void
				if has_error_reporting then
					create l_vtat1.make (t, f.feature_name_32)
					l_vtat1.set_class (current_class)
					l_vtat1.set_feature (current_feature)
					error_handler.insert_error (l_vtat1)
				end
			else
				l_like_control.put_feature (f)
					-- Process type referenced by anchor.
				f.type.process (Current)
					-- Update anchored type controler
				l_like_control.remove_feature
				if attached last_type as a and then a.is_void then
					last_type := Void
					if has_error_reporting then
						fixme ("What is the error for an anchor to a procedure")
						create l_vtat1.make (t, f.feature_name_32)
						l_vtat1.set_class (current_class)
						l_vtat1.set_feature (current_feature)
						error_handler.insert_error (l_vtat1)
					end
				end
			end
		end

	record_exp_dependance (a_class: CLASS_C)
		local
			d: DEPEND_UNIT
			f: FEATURE_I
		do
				-- Only mark the class if it is used during a
				-- compilation not when querying the actual
				-- type
			current_class.set_has_expanded
			a_class.set_is_used_as_expanded
			if suppliers /= Void then
				create d.make_expanded_unit (a_class.class_id)
				suppliers.extend (d)
				f := a_class.creation_feature
				if f /= Void then
					create d.make (a_class.class_id, f)
					suppliers.extend (d)
				end
			end
		end

feature {NONE} -- Lookup

	feature_finder: TYPE_A_FEATURE_FINDER
			-- Lookup facility
		once
			create Result
		ensure
			feature_finder_attached: Result /= Void
		end

invariant
	is_current_actual_type_correct: attached current_class as c implies attached current_actual_type as t and then t.same_as (current_class.actual_type)

note
	ca_ignore: "CA033", "CA033 — very long class"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
