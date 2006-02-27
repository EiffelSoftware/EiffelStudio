indexing
	description: "Perform resolution of TYPE_AS into TYPE_A as well as checking validity of TYPE_A."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_TYPE_CHECKER

inherit
	AST_NULL_VISITOR
		redefine
			process_like_id_as, process_like_cur_as,
			process_formal_as, process_class_type_as, process_none_type_as,
			process_bits_as, process_bits_symbol_as, process_type_a,
			process_named_tuple_type_as, process_type_dec_as
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
		export
			{NONE} all
		end

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_LIKE_CONTROLER
		export
			{NONE} all
		end

	SHARED_RESCUE_STATUS
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

feature -- Status report

	solved_type (a_type: TYPE_AS): TYPE_A is
			-- Solved type of `a_type' in current context.
		require
			a_type_not_void: a_type /= Void
		do
			like_control.turn_off
			Result := internal_solved_type (a_type)
			error_handler.checksum
		end

	nested_solved_type (a_type: TYPE_AS): TYPE_A is
			-- 	Solved type of `a_type' in current context, called from within a call to `solved_type'
			-- from Current or TYPE_AS. Thus does not reset state of `like_control'.
		require
			a_type_not_void: a_type /= Void
		do
			Result := internal_solved_type (a_type)
			error_handler.checksum
		end

feature {NONE} -- Status report

	internal_solved_type (a_type: TYPE_AS): TYPE_A is
			-- Solved type of `a_type' in current context which is used by `solved_type'
			-- as an exception might be raised by the anchor controler.
		require
			a_type_not_void: a_type /= Void
		local
			l_vtat1: VTAT1
		do
			parent_type := a_type
			a_type.process (Current)
			Result := last_type
			last_type := Void
			parent_type := Void
		rescue
			if Rescue_status.is_like_exception then
					-- Cycle in anchored type or unvalid anchor: the
					-- exception is raised in routine `solved_type' of
					-- classes LIKE_FEATURE and LIKE_ARGUMENT
					-- which we unfortunately still supports.
				Rescue_status.set_is_like_exception (False)
				create l_vtat1
				l_vtat1.set_type (a_type)
				l_vtat1.set_class (current_class)
				l_vtat1.set_feature (current_feature)
				Error_handler.insert_error (l_vtat1)
					-- Exception propagation now: cannot go on...
				Rescue_status.set_is_error_exception (True)
			end
		end

feature -- Settings

	init (a_feature: FEATURE_I; a_class: CLASS_C) is
			-- Initialize Current with `a_feature' and `a_class'
		require
			a_feature_not_void: a_feature /= Void
			a_class_not_void: a_class /= Void
		do
			current_feature := a_feature
			current_class := a_class
			current_feature_table := a_class.feature_table
		ensure
			current_feature_set: current_feature = a_feature
			current_class_set: current_class = a_class
			current_feature_table_set: current_feature_table = current_class.feature_table
		end

	init_with_feature_table (a_feature: FEATURE_I; a_feat_tbl: FEATURE_TABLE) is
			-- Initialize Current with `a_feature' and `a_feat_tbl'
		require
			a_feature_not_void: a_feature /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
		do
			current_feature := a_feature
			current_class := a_feat_tbl.associated_class
			current_feature_table := a_feat_tbl
		ensure
			current_feature_set: current_feature = a_feature
			current_class_set: current_class = a_feat_tbl.associated_class
			current_feature_table_set: current_feature_table = a_feat_tbl
		end

feature {NONE} -- Implementation: Access

	last_type: TYPE_A
			-- Last resolved type of checker

	parent_type: TYPE_AS
			-- Top type being checked by Current

	current_feature_table: FEATURE_TABLE
			-- Feature table where current type is resolved

	current_feature: FEATURE_I
			-- Feature where current type is resolved

	current_class: CLASS_C
			-- Current class where current type is resolved

feature -- Special checking

	check_type_validity (a_type: TYPE_A; a_type_node: TYPE_AS) is
			-- Check validity of `a_type' linked to `a_type_node'.
		require
			a_type_node_not_void: a_type_node /= Void
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
				context.init_error (l_vgcc3)
				l_vgcc3.set_is_symbol
				l_vgcc3.set_symbol_name (a_type_node.dump)
				l_vgcc3.set_location (a_type_node.start_location)
				Error_handler.insert_error (l_vgcc3)
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
						context.init_error (l_vtec)
						l_vtec.set_location (a_type_node.start_location)
						Error_handler.insert_error (l_vtec)
						l_has_error := True
					end
				end
				if not l_has_error then
					if not a_type.good_generics then
						l_vtug := a_type.error_generics
						l_vtug.set_class (current_class)
						l_vtug.set_feature (current_feature)
						l_vtug.set_location (a_type_node.start_location)
						Error_handler.insert_error (l_vtug)
					else
						a_type.reset_constraint_error_list
						a_type.check_constraints (current_class)
						if not a_type.constraint_error_list.is_empty then
							create l_vtcg3
							l_vtcg3.set_class (current_class)
							l_vtcg3.set_feature (current_feature)
							l_vtcg3.set_error_list (a_type.constraint_error_list)
							l_vtcg3.set_location (a_type_node.start_location)
							Error_handler.insert_error (l_vtcg3)
						else
							a_type.check_labels (current_class, a_type_node)
						end
					end
				end
			end
			error_handler.checksum
		end

	check_constraint_type (a_class: CLASS_C; a_type: TYPE_AS) is
			-- Is `a_type' a valid constraint for `a_class'?
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
			l_pos: INTEGER
			l_is_tuple_type : BOOLEAN
			l_gen_type: GEN_TYPE_A
		do
			l_class_type ?= a_type
			if a_type.has_like then
				create l_vcfg3
				l_vcfg3.set_class (a_class)
				l_vcfg3.set_formal_name ("Constraint genericity")
				l_vcfg3.set_location (a_type.start_location)
				Error_handler.insert_error (l_vcfg3)
			elseif l_class_type /= Void then
				l_cluster := a_class.cluster
				l_class_i := Universe.class_named (l_class_type.class_name, l_cluster)
				if l_class_i = Void then
					create l_vtct
					l_vtct.set_class (a_class)
					l_vtct.set_class_name (l_class_type.class_name)
					l_vtct.set_location (l_class_type.start_location)
					Error_handler.insert_error (l_vtct)
					error_handler.raise_error
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
						l_vtug.set_class (a_class)
						l_vtug.set_type (l_class_type.actual_type)
						l_vtug.set_base_class (l_associated_class)
						l_vtug.set_location (l_class_type.class_name)
						Error_handler.insert_error (l_vtug)
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
								l_gen_type ?= l_class_type.actual_type
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
								l_nb_errors := Error_handler.nb_errors
								l_t1 := l_class_type.generics.item
								check_constraint_type (a_class, l_t1)
								l_has_error := Error_handler.nb_errors /= l_nb_errors
								if not l_has_error then
									l_t2 := l_cl_generics.item.constraint
									if l_t2 /= Void then
										l_t1.actual_type.check_const_gen_conformance
											(l_gen_type, l_t2.actual_type, a_class, l_pos)
										l_has_error := Error_handler.new_error
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
								l_nb_errors := Error_handler.nb_errors
								l_t1 := l_class_type.generics.item
								check_constraint_type (a_class, l_t1)
								l_has_error := Error_handler.nb_errors /= l_nb_errors
								l_class_type.generics.forth
							end
						end
					end
				end
			end
		end

feature {NONE} -- Visitor implementation

	process_like_id_as (l_as: LIKE_ID_AS) is
		local
			l_anchor_feature: FEATURE_I
			l_anchor_type: TYPE_AS
			l_argument_position: INTEGER
			l_rout_id: INTEGER
			l_like_argument: LIKE_ARGUMENT
			l_like_feature: LIKE_FEATURE
			l_depend_unit: DEPEND_UNIT
			l_veen: VEEN
			l_vtat1: VTAT1
			l_controler_state: BOOLEAN
		do
			l_anchor_feature := current_feature_table.item (l_as.anchor)
			if l_anchor_feature /= Void then
					-- It is an anchored type on a feature: check if the
					-- anchor feature has not an anchored type itself.
				l_anchor_type := l_anchor_feature.type
				l_rout_id := l_anchor_feature.rout_id_set.first

				l_controler_state := like_control.is_on
					-- Check if there is a cycle
				if
					l_anchor_type.is_void or
					(l_controler_state and like_control.has_routine_id (l_rout_id))
				then
						-- Error because of cycle
					create l_vtat1.make (parent_type, l_as)
					l_vtat1.set_class (current_class)
					l_vtat1.set_feature (current_feature)
					Error_handler.insert_error (l_vtat1)
				else
					if not l_controler_state then
							-- Enable like controler only if not already enabled.
						like_control.turn_on
					end
						-- Update anchored type controler
					like_control.put_routine_id (l_rout_id)
						-- Create instance of LIKE_FEATURE
					create l_like_feature.make (l_anchor_feature)
					l_like_feature.set_actual_type (
						l_anchor_type.solved_type (current_feature_table,
							l_anchor_feature).actual_type)
					last_type := l_like_feature
					if System.in_pass3 then
							-- There is a dependance between `current_feature' and
							-- the `l_anchor_feature'.
							-- Record it for the propagation of the recompilations
						create l_depend_unit.make (current_class.class_id, l_anchor_feature)
						context.supplier_ids.extend (l_depend_unit)
					end
					if not l_controler_state then
							-- Disable like controler only if it was not enabled before
							-- entering current routine.
						like_control.turn_off
					end
				end
			else
				l_argument_position := current_feature.argument_position (l_as.anchor)
				if l_argument_position /= 0 then
						-- Found argument
					l_controler_state := like_control.is_on
					if l_controler_state and like_control.has_argument (l_argument_position) then
							-- Cycle involving anchors on arguments
						like_control.raise_error
					else
						if not l_controler_state then
								-- Enable like controler only if not already enabled.
							like_control.turn_on
						end
						like_control.put_argument (l_argument_position)
						l_anchor_type := current_feature.arguments.i_th (l_argument_position)
						create l_like_argument
						l_like_argument.set_position (l_argument_position)
						l_like_argument.set_actual_type
							(l_anchor_type.solved_type (current_feature_table,
								current_feature).actual_type)
						last_type := l_like_argument
						if not l_controler_state then
								-- Disable like controler only if it was not enabled before
								-- entering current routine.
							like_control.turn_off
						end
					end
				else
					create l_veen
					l_veen.set_class (System.current_class)
					l_veen.set_feature (current_feature)
					l_veen.set_identifier (l_as.anchor)
					l_veen.set_location (l_as.anchor)
					Error_handler.insert_error (l_veen)
					Error_handler.raise_error
				end
			end
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		local
			l_cur: LIKE_CURRENT
		do
			create l_cur
			l_cur.set_actual_type (current_class.actual_type)
			last_type := l_cur
		end

	process_formal_as (l_as: FORMAL_AS) is
		do
			create {FORMAL_A} last_type.make (l_as.is_reference, l_as.is_expanded, l_as.position)
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		local
			l_class: CLASS_C
			l_actual_generic: ARRAY [TYPE_A]
			i, count: INTEGER
			l_type: TYPE_A
		do
				-- Lookup class in universe, it should be present.
			check
				class_found: Universe.class_named (l_as.class_name, Inst_context.cluster) /= Void
			end
			l_class := Universe.class_named (l_as.class_name, Inst_context.cluster).compiled_class
			check
				class_found_is_compiled: l_class /= Void
			end

			if l_as.generics /= Void then
				from
					i := 1
					count := l_as.generics.count
					create l_actual_generic.make (1, count)
					l_type := l_class.partial_actual_type (l_actual_generic, l_as.is_expanded,
						l_as.is_separate)
				until
					i > count
				loop
					l_as.generics.i_th (i).process (Current)
					l_actual_generic.put (last_type, i)
					i := i + 1
				end
			else
				l_type := l_class.partial_actual_type (Void, l_as.is_expanded, l_as.is_separate)
			end
			if l_type.is_expanded and not l_type.is_basic then
					-- Only record when necessary.
				record_exp_dependance (l_class)
			end
			last_type := l_type
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS) is
		local
			l_class: CLASS_C
			l_actual_generic: ARRAY [TYPE_A]
			i, count: INTEGER
			l_type: NAMED_TUPLE_TYPE_A
			l_generics: EIFFEL_LIST [TYPE_DEC_AS]
			l_names: SPECIAL [INTEGER]
			l_id_list: CONSTRUCT_LIST [INTEGER]
		do
				-- Lookup class in universe, it should be present.
			l_class := System.tuple_class.compiled_class
			check
				class_found_is_compiled: l_class /= Void
			end
			l_generics := l_as.generics
			from
				i := 1
				count := l_as.generic_count
				create l_actual_generic.make (1, count)
				create l_names.make (count)
				create l_type.make (l_class.class_id, l_actual_generic, l_names)
			until
				i > count
			loop
				l_generics.i_th (i).process (Current)
				l_id_list := l_generics.i_th (i).id_list
				from
					l_id_list.start
				until
					l_id_list.after
				loop
					l_actual_generic.put (last_type, i)
					l_names.put (l_id_list.item, i - 1)
					i := i + 1
					l_id_list.forth
				end
			end
			last_type := l_type
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
		do
			l_as.type.process (Current)
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
			last_type := none_type
		end

	process_bits_as (l_as: BITS_AS) is
		local
			l_vtbt: VTBT
			l_value: INTEGER
		do
			l_value := l_as.bits_value.integer_32_value
			if
				l_value <= 0 or else
				l_value > {EIFFEL_SCANNER_SKELETON}.Maximum_bit_constant
			then
				create l_vtbt
				l_vtbt.set_class (current_class)
				l_vtbt.set_feature (current_feature)
				l_vtbt.set_value (l_value)
				l_vtbt.set_location (l_as.bits_value.start_location)
				Error_handler.insert_error (l_vtbt)
					-- Cannot go on here
				Error_handler.raise_error
			end
			create {BITS_A} last_type.make (l_value)
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		local
			l_vtbt: VTBT
			l_veen: VEEN
			l_constant: CONSTANT_I
			l_value: INTEGER
			l_has_error: BOOLEAN
			l_int_value: INTEGER_CONSTANT
			l_depend_unit: DEPEND_UNIT
		do
			if not current_feature_table.has (l_as.bits_symbol) then
				create l_veen
				l_veen.set_class (current_class)
				l_veen.set_feature (current_feature)
				l_veen.set_identifier (l_as.bits_symbol)
				l_veen.set_location (l_as.bits_symbol)
				Error_handler.insert_error (l_veen)
				Error_handler.raise_error
			end
			l_constant ?= current_feature_table.item (l_as.bits_symbol)
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
				create l_vtbt
				l_vtbt.set_class (current_class)
				l_vtbt.set_feature (current_feature)
				l_vtbt.set_value (l_value)
				l_vtbt.set_location (l_as.bits_symbol)
				Error_handler.insert_error (l_vtbt)
					-- Cannot go on here
				Error_handler.raise_error
			end
			check
				positive_bits_value: l_value > 0
			end
			create {BITS_SYMBOL_A} last_type.make (l_constant, l_value)
			if System.in_pass3 then
				create l_depend_unit.make (current_class.class_id, l_constant)
				context.supplier_ids.extend (l_depend_unit)
			end
		end

	process_type_a (a_type: TYPE_A) is
		do
			last_type := a_type.solved_type (current_feature_table, current_feature)
		end

feature {NONE} -- Implementation

	record_exp_dependance (a_class: CLASS_C) is
		require
			a_class_not_void: a_class /= Void
		local
			d: DEPEND_UNIT
			f: FEATURE_I
			c_class: CLASS_C
		do
			c_class := System.current_class
			if c_class /= Void then
-- *** FIXME ****
-- This was done since actual_type is called on the generic
-- parameters when the signature of the class is requested.
-- This approach seems ok but the FIXME is to make YOU
-- aware that there could be potential problems.
				-- Only mark the class if it is used during a
				-- compilation not when querying the actual
				-- type
				c_class.set_has_expanded
				a_class.set_is_used_as_expanded
				if System.in_pass3 then
					create d.make_expanded_unit (a_class.class_id)
					context.supplier_ids.extend (d)
					f := a_class.creation_feature
					if f /= Void then
						create d.make (a_class.class_id, f)
						context.supplier_ids.extend (d)
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
