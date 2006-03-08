indexing
	description: "Check validity of a TYPE_A object."
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

feature -- Status report

	has_error_reporting: BOOLEAN is
			-- Can current report error?
		do
			Result := error_handler /= Void
		end

	solved (a_unevaluated_type: TYPE_A; a_type_as: TYPE_AS): TYPE_A is
			-- Check that validity of `a_unevaluated_type' in current context
			-- as initialized by `init' or `init_with_feature_table'.
		require
			a_unevaluated_type_not_void: a_unevaluated_type /= Void
			has_error_reporting: not has_error_reporting
		do
			like_control.turn_off
			associated_type_ast := a_type_as
			a_unevaluated_type.process (Current)
			Result := last_type
			last_type := Void
			associated_type_ast := Void
		end
	check_and_solved (a_unevaluated_type: TYPE_A; a_type_as: TYPE_AS): TYPE_A is
			-- Check that validity of `a_unevaluated_type' in current context
			-- as initialized by `init' or `init_with_feature_table'.
		require
			a_unevaluated_type_not_void: a_unevaluated_type /= Void
			has_error_reporting: has_error_reporting
		do
			error_handler.mark
			like_control.turn_off
			associated_type_ast := a_type_as
			a_unevaluated_type.process (Current)
			Result := last_type
			last_type := Void
			associated_type_ast := Void
			if error_handler.new_error then
				error_handler.checksum
			end
		end

feature -- Settings

	init_for_checking (a_feature: FEATURE_I; a_class: CLASS_C; a_suppliers: FEATURE_DEPENDANCE; a_error_handler: ERROR_HANDLER) is
			-- Initialize Current with `a_feature', `a_class' and `suppliers'.
			-- `suppliers' will be updated if not Void.
		require
			a_feature_not_void: a_feature /= Void
			a_class_not_void: a_class /= Void
		do
			current_feature := a_feature
			current_class := a_class
			current_feature_table := a_class.feature_table
			suppliers := a_suppliers
			error_handler := a_error_handler
		ensure
			current_feature_set: current_feature = a_feature
			current_class_set: current_class = a_class
			current_feature_table_set: current_feature_table = current_class.feature_table
			suppliers_set: suppliers = a_suppliers
			error_handler_set: error_handler = a_error_handler
		end

	init_with_feature_table (a_feature: FEATURE_I; a_feat_tbl: FEATURE_TABLE; a_suppliers: FEATURE_DEPENDANCE; a_error_handler: ERROR_HANDLER) is
			-- Initialize Current with `a_feature', `a_feat_tbl' and `suppliers'.
			-- `suppliers' will be updated if not Void.
		require
			a_feature_not_void: a_feature /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
		do
			current_feature := a_feature
			current_class := a_feat_tbl.associated_class
			current_feature_table := a_feat_tbl
			suppliers := a_suppliers
			error_handler := a_error_handler
		ensure
			current_feature_set: current_feature = a_feature
			current_class_set: current_class = a_feat_tbl.associated_class
			current_feature_table_set: current_feature_table = a_feat_tbl
			suppliers_set: suppliers = a_suppliers
			error_handler_set: error_handler = a_error_handler
		end

feature {NONE} -- Implementation: Access

	last_type: TYPE_A
			-- Last resolved type of checker

	associated_type_ast: TYPE_AS
			-- Top type being checked by Current

	current_feature_table: FEATURE_TABLE
			-- Feature table where current type is resolved

	current_feature: FEATURE_I
			-- Feature where current type is resolved

	current_class: CLASS_C
			-- Current class where current type is resolved

	suppliers: FEATURE_DEPENDANCE
			-- Dependances if they need to be recorded.

	error_handler: ERROR_HANDLER
			-- Medium used to report error. If not set, no errors are reported
			-- and `last_type' will be set to Void.

	like_control: LIKE_CONTROLER is
			-- Controler of anchors. A once to avoid object creation.
		once
			create Result.make
		ensure
			like_control_not_void: Result /= Void
		end

feature -- Special checking

	check_type_validity (a_type: TYPE_A; a_type_node: TYPE_AS) is
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
					elseif not a_type.valid_expanded_creation (current_class) then
						create {VTEC2} l_vtec
					elseif system.il_generation and then not a_type.is_ancestor_valid then
							-- Expanded type cannot be based on a class with external ancestor.
						create {VTEC3} l_vtec
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
						a_type.check_constraints (current_class)
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
			error_handler.checksum
		end

	check_constraint_type (a_context_class: CLASS_C; a_type: TYPE_AS; a_error_handler: ERROR_HANDLER) is
			-- Is `a_type' a valid constraint for `a_context_class'?
		require
			a_context_class_not_void: a_context_class /= Void
			a_type_not_void: a_type /= Void
			a_error_handler_not_void: a_error_handler /= Void
		local
			l_class_type: CLASS_TYPE_AS
			l_associated_class: CLASS_C
			l_temp, l_cl_generics: EIFFEL_LIST [FORMAL_DEC_AS]
			l_class_i: CLASS_I
			l_cluster: CLUSTER_I
			l_vcfg3: VCFG3
			l_vtct: VTCT
			l_vtug: VTUG
			l_has_error: BOOLEAN
			l_nb_errors: INTEGER
			l_t1, l_t2: TYPE_AS
			l_t1_a, l_t2_a: TYPE_A
			l_pos: INTEGER
			l_is_tuple_type : BOOLEAN
			l_gen_type: GEN_TYPE_A
			l_type_a: TYPE_A
		do
			l_class_type ?= a_type
			l_type_a := type_a_generator.evaluate_type (a_type, a_context_class)
						-- Check if there is no anchor and no bit symbol in the constraint type.
			if not l_type_a.is_valid or else l_type_a.has_like then
				create l_vcfg3
				l_vcfg3.set_class (a_context_class)
				l_vcfg3.set_formal_name ("Constraint genericity")
				l_vcfg3.set_location (a_type.start_location)
				a_error_handler.insert_error (l_vcfg3)
			elseif l_class_type /= Void then
				l_cluster := a_context_class.cluster
				l_class_i := universe.class_named (l_class_type.class_name, l_cluster)
				if l_class_i = Void then
					create l_vtct
					l_vtct.set_class (a_context_class)
					l_vtct.set_class_name (l_class_type.class_name)
					l_vtct.set_location (l_class_type.start_location)
					a_error_handler.insert_error (l_vtct)
					a_error_handler.raise_error
				else
					l_associated_class := l_class_i.compiled_class
					l_is_tuple_type := l_associated_class.is_tuple
					l_cl_generics := l_associated_class.generics
						-- TUPLEs can have any number of generics
					if not l_is_tuple_type then
						if l_class_type.generics /= Void then
							if (l_cl_generics = Void) then
								create {VTUG1} l_vtug
							elseif (l_cl_generics.count /= l_class_type.generics.count) then
								create {VTUG2} l_vtug
							end
						elseif l_cl_generics /= Void then
							create {VTUG2} l_vtug
						end
					end
					if l_vtug /= Void then
						l_vtug.set_class (a_context_class)
						l_vtug.set_type (l_type_a)
						l_vtug.set_base_class (l_associated_class)
						l_vtug.set_location (l_class_type.class_name)
						a_error_handler.insert_error (l_vtug)
					elseif l_class_type.generics /= Void then
						if not l_is_tuple_type then
							from
								l_temp := l_cl_generics
								create l_cl_generics.make_filled (l_temp.count)
								l_pos := l_temp.index
								l_temp.start
							until
								l_temp.after
							loop
								l_cl_generics.put_i_th (l_temp.item, l_temp.index)
								l_temp.forth
							end
							l_temp.go_i_th (l_pos)
							from
								l_gen_type ?= l_type_a
								check
										-- Should be not Void since we have
										-- some generic parameters
									l_gen_type_not_void: l_gen_type /= Void
								end
								l_class_type.generics.start
								l_cl_generics.start
								l_pos := 1
							until
								l_class_type.generics.after or else l_has_error
							loop
								l_nb_errors := a_error_handler.nb_errors
								l_t1 := l_class_type.generics.item
								check_constraint_type (a_context_class, l_t1, a_error_handler)
								l_has_error := a_error_handler.nb_errors /= l_nb_errors
								if not l_has_error then
									l_t1_a := type_a_generator.evaluate_type (l_t1, a_context_class)
									l_t2 := l_cl_generics.item.constraint
									if l_t2 /= Void then
										l_t2_a := type_a_generator.evaluate_type (l_t2, a_context_class)
										if l_t2_a /= Void then
											l_t1_a.check_const_gen_conformance
												(l_gen_type, l_t2_a, a_context_class, l_pos)
											l_has_error := a_error_handler.new_error
										end
									end
								end
								l_pos := l_pos + 1
								l_class_type.generics.forth
								l_cl_generics.forth
							end
						else
								-- TUPLE: has no generics
							from
								l_class_type.generics.start
							until
								l_class_type.generics.after or else l_has_error
							loop
								l_nb_errors := a_error_handler.nb_errors
								l_t1 := l_class_type.generics.item
								check_constraint_type (a_context_class, l_t1, a_error_handler)
								l_has_error := a_error_handler.nb_errors /= l_nb_errors
								l_class_type.generics.forth
							end
						end
					end
				end
			end
		end

feature {TYPE_A} -- Visitors

	process_bits_a (a_type: BITS_A) is
			-- Process `a_type'.
		local
			l_vtbt: VTBT
		do
			if a_type.bit_count <= 0 or else a_type.bit_count > {EIFFEL_SCANNER_SKELETON}.maximum_bit_constant then
				last_type := Void
				if has_error_reporting then
					create l_vtbt
					l_vtbt.set_class (current_class)
					l_vtbt.set_feature (current_feature)
					l_vtbt.set_value (a_type.bit_count)
					if associated_type_ast /= Void then
						l_vtbt.set_location (associated_type_ast.start_location)
					end
					error_handler.insert_error (l_vtbt)
				end
			else
				last_type := a_type
			end
		end

	process_bits_symbol_a (a_type: BITS_SYMBOL_A) is
			-- Process `a_type'.
		local
			l_anchor_feature: FEATURE_I
			vtbt: VTBT
			l_veen: VEEN
			constant: CONSTANT_I
			bits_value: INTEGER
			error: BOOLEAN
			int_value: INTEGER_CONSTANT
		do
			if current_class.class_id /= a_type.current_class_id then
				l_anchor_feature := system.class_of_id (a_type.current_class_id).feature_table.
					item_id (a_type.feature_name_id)
			else
				l_anchor_feature := current_feature_table.item_id (a_type.feature_name_id)
			end
			if l_anchor_feature = Void then
				last_type := Void
				if has_error_reporting then
					create l_veen
					l_veen.set_class (System.current_class)
					l_veen.set_feature (current_feature)
					l_veen.set_identifier (a_type.feature_name)
					error_handler.insert_error (l_veen)
				end
			else
				constant ?= l_anchor_feature
				error := constant = Void
				if not error then
					int_value ?= constant.value
					error := int_value = Void
					if not error then
						bits_value := int_value.integer_32_value
						error :=
							bits_value <= 0 or else
							bits_value > {EIFFEL_SCANNER_SKELETON}.Maximum_bit_constant
					end
				end
				if error then
					last_type := Void
					if has_error_reporting then
						create vtbt
						vtbt.set_class (current_feature_table.associated_class)
						vtbt.set_feature (current_feature)
						vtbt.set_value (bits_value)
						error_handler.insert_error (vtbt)
					end
				else
					a_type.set_rout_id (l_anchor_feature.rout_id_set.first)
					a_type.set_bit_count (bits_value)
					last_type := a_type
				end
			end
		end

	process_boolean_a (a_type: BOOLEAN_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_character_a (a_type: CHARACTER_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_cl_type_a (a_type: CL_TYPE_A) is
			-- Process `a_type'.
		do
			last_type := a_type
			if a_type.is_expanded and not a_type.is_basic then
				check
					has_associated_class: a_type.has_associated_class
				end
				record_exp_dependance (a_type.associated_class)
			end
		end

	process_formal_a (a_type: FORMAL_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_gen_type_a (a_type: GEN_TYPE_A) is
			-- Process `a_type'.
		local
			l_generics: ARRAY [TYPE_A]
			i, nb: INTEGER
			l_has_error: BOOLEAN
		do
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
					l_generics.item (i).process (Current)
					l_has_error := l_has_error or else last_type = Void
					if not l_has_error then
						l_generics.put (last_type, i)
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

	process_integer_a (a_type: INTEGER_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_like_argument (a_type: LIKE_ARGUMENT) is
			-- Process `a_type'.
		do
			update_like_argument (current_feature, a_type)
		end

	process_like_current (a_type: LIKE_CURRENT) is
			-- Process `a_type'.
		do
			last_type := a_type
			a_type.set_actual_type (current_class.actual_type)
		end

	process_like_feature (a_type: LIKE_FEATURE) is
			-- Process `a_type'.
		local
			l_anchor_feature, l_orig_feat: FEATURE_I
			l_veen: VEEN
		do
				-- Find feature associated with `a_type'. It might not be
				-- found in case anchors has disappeared. It might also
				-- be invalid (check done in `update_like_feature' in case
				-- it is not a function anymore.
			if current_class.class_id /= a_type.class_id then
				l_orig_feat := System.class_of_id (a_type.class_id).feature_table.item_id (a_type.feature_name_id)
				if l_orig_feat /= Void then
					l_anchor_feature := current_feature_table.
						origin_table.item (l_orig_feat.rout_id_set.first)
				end
			else
				l_anchor_feature := current_feature_table.item_id (a_type.feature_name_id)
			end
			if l_anchor_feature /= Void then
					-- Update `a_type' with new information.
				a_type.make (l_anchor_feature, current_class.class_id)
				update_like_feature (l_anchor_feature, a_type)
			else
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

	process_manifest_integer_a (a_type: MANIFEST_INTEGER_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_manifest_natural_64_a (a_type: MANIFEST_NATURAL_64_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_named_tuple_type_a (a_type: NAMED_TUPLE_TYPE_A) is
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_native_array_type_a (a_type: NATIVE_ARRAY_TYPE_A) is
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_natural_a (a_type: NATURAL_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_none_a (a_type: NONE_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_open_type_a (a_type: OPEN_TYPE_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_pointer_a (a_type: POINTER_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_real_32_A (a_type: REAL_32_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_real_64_a (a_type: REAL_64_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_tuple_type_a (a_type: TUPLE_TYPE_A) is
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_typed_pointer_a (a_type: TYPED_POINTER_A) is
			-- Process `a_type'.
		do
			process_gen_type_a (a_type)
		end

	process_unevaluated_bits_symbol_a (a_type: UNEVALUATED_BITS_SYMBOL_A) is
			-- Process `a_type'.
		local
			l_vtbt: VTBT
			l_veen: VEEN
			l_constant: CONSTANT_I
			l_value: INTEGER
			l_has_error: BOOLEAN
			l_int_value: INTEGER_CONSTANT
			l_depend_unit: DEPEND_UNIT
		do
			if not current_feature_table.has_id (a_type.symbol_name_id) then
				last_type := Void
				if has_error_reporting then
					create l_veen
					l_veen.set_class (current_class)
					l_veen.set_feature (current_feature)
					l_veen.set_identifier (a_type.symbol)
					if associated_type_ast /= Void then
						l_veen.set_location (associated_type_ast.start_location)
					end
					error_handler.insert_error (l_veen)
				end
			else
				l_constant ?= current_feature_table.item_id (a_type.symbol_name_id)
				l_has_error := l_constant = Void
				if not l_has_error then
					l_int_value ?= l_constant.value
					l_has_error := l_int_value = Void
					if not l_has_error then
						l_value := l_int_value.integer_32_value
						l_has_error :=
							l_value <= 0 or else
							l_value > {EIFFEL_SCANNER_SKELETON}.Maximum_bit_constant
					end
				end
				if l_has_error then
					last_type := Void
					if has_error_reporting then
						create l_vtbt
						l_vtbt.set_class (current_class)
						l_vtbt.set_feature (current_feature)
						l_vtbt.set_value (l_value)
						if associated_type_ast /= Void then
							l_vtbt.set_location (associated_type_ast.start_location)
						end
						error_handler.insert_error (l_vtbt)
					end
				else
					check
						positive_bits_value: l_value > 0
					end
					create {BITS_SYMBOL_A} last_type.make (l_constant, l_value)
					if suppliers /= Void then
						create l_depend_unit.make (current_class.class_id, l_constant)
						suppliers.extend (l_depend_unit)
					end
				end
			end
		end

	process_unevaluated_like_type (a_type: UNEVALUATED_LIKE_TYPE) is
			-- Process `a_type'.
		local
			l_anchor_feature: FEATURE_I
			l_argument_position: INTEGER
			l_like_argument: LIKE_ARGUMENT
			l_like_feature: LIKE_FEATURE
			l_veen: VEEN
		do
			l_anchor_feature := current_feature_table.item_id (a_type.anchor_name_id)
			if l_anchor_feature /= Void then
					-- Create instance of LIKE_FEATURE
				create l_like_feature.make (l_anchor_feature, current_class.class_id)
				update_like_feature (l_anchor_feature, l_like_feature)
			else
				l_argument_position := current_feature.argument_position (a_type.anchor)
				if l_argument_position /= 0 then
					create l_like_argument
					l_like_argument.set_position (l_argument_position)
					update_like_argument (current_feature, l_like_argument)
				else
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
				end
			end
		end

	process_void_a (a_type: VOID_A) is
			-- Process `a_type'.
		do
			last_type := a_type
		end

feature {NONE} -- Implementation

	update_like_argument (a_feature: FEATURE_I; a_type: LIKE_ARGUMENT) is
			-- Given `a_feature' to which `a_type' anchors to, verify that
			-- `a_type' is valid, and update `a_type' accordingly.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		local
			l_anchor_type: TYPE_A
			l_vtat1a: VTAT1A
			l_controler_state: BOOLEAN
		do
				-- Found argument
			l_controler_state := like_control.is_on
			if l_controler_state and like_control.has_argument (a_type.position) then
					-- Cycle involving anchors on arguments
				last_type := Void
				if has_error_reporting then
					create l_vtat1a
					l_vtat1a.set_type (a_type)
					l_vtat1a.set_class (current_class)
					l_vtat1a.set_argument_name (a_feature.arguments.item_name (a_type.position))
					l_vtat1a.set_feature (a_feature)
					error_handler.insert_error (l_vtat1a)
				end
			else
				if not l_controler_state then
						-- Enable like controler only if not already enabled.
					like_control.turn_on
				end
				like_control.put_argument (a_type.position)
				l_anchor_type := a_feature.arguments.i_th (a_type.position)
				l_anchor_type.process (Current)
				if last_type /= Void then
					a_type.set_actual_type (last_type)
					last_type := a_type
				end
				if not l_controler_state then
						-- Disable like controler only if it was not enabled before
						-- entering current routine.
					like_control.turn_off
				end
			end
		end

	update_like_feature (a_feature: FEATURE_I; a_type: LIKE_FEATURE) is
			-- Given `a_feature' to which `a_type' anchors to, verify that
			-- `a_type' is valid, and update `a_type' accordingly.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		local
			l_anchor_type: TYPE_A
			l_rout_id: INTEGER
			l_depend_unit: DEPEND_UNIT
			l_vtat1: VTAT1
			l_controler_state: BOOLEAN
		do
				-- It is an anchored type on a feature: check if the
				-- anchor feature has not an anchored type itself.
			l_rout_id := a_feature.rout_id_set.first
			l_controler_state := like_control.is_on

			if l_controler_state and like_control.has_routine_id (l_rout_id) then
					-- Error because of cycle
				last_type := Void
				if has_error_reporting then
					create l_vtat1.make (a_type, a_type.feature_name)
					l_vtat1.set_class (current_class)
					l_vtat1.set_feature (current_feature)
					error_handler.insert_error (l_vtat1)
				end
			else
				if not l_controler_state then
						-- Enable like controler only if not already enabled.
					like_control.turn_on
				end
					-- Update anchored type controler
				like_control.put_routine_id (l_rout_id)

					-- Process type referenced by anchor.
				a_feature.type.process (Current)
				l_anchor_type := last_type

				if l_anchor_type = Void then
						-- Nothing to be done, error if any was already reported.
				elseif l_anchor_type.is_void then
					last_type := Void
					if has_error_reporting then
						fixme ("What is the error for an anchor to a procedure")
						create l_vtat1.make (a_type, a_type.feature_name)
						l_vtat1.set_class (current_class)
						l_vtat1.set_feature (current_feature)
						error_handler.insert_error (l_vtat1)
					end
				else
					fixme ("Use something else for `actual_type' which does the same thing with a different name.")
					a_type.set_actual_type (l_anchor_type.actual_type)
					last_type := a_type
					if suppliers /= Void then
							-- There is a dependance between `current_feature' and
							-- the `a_feature'.
							-- Record it for the propagation of the recompilations
						create l_depend_unit.make (current_class.class_id, a_feature)
						suppliers.extend (l_depend_unit)
					end
				end
				if not l_controler_state then
						-- Disable like controler only if it was not enabled before
						-- entering current routine.
					like_control.turn_off
				end
			end
		ensure
			last_type_set: last_type = Void or else last_type = a_type
		end

feature {NONE} -- Implementation

	record_exp_dependance (a_class: CLASS_C) is
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

end
