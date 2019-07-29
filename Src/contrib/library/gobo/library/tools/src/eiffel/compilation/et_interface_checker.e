note

	description:

		"Eiffel class interface checkers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2003-2019, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_INTERFACE_CHECKER

inherit

	ET_CLASS_PROCESSOR
		redefine
			make
		end

	ET_AST_NULL_PROCESSOR
		rename
			make as make_ast_processor
		redefine
			process_class
		end

	ET_SHARED_CALL_NAME_TESTER
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_system_processor: like system_processor)
			-- Create a new interface checker for given classes.
		do
			precursor (a_system_processor)
			create classes_to_be_processed.make (10)
			create qualified_anchored_type_checker.make (a_system_processor)
			qualified_anchored_type_checker.set_classes_to_be_processed (classes_to_be_processed)
			create unfolded_tuple_actual_parameters_resolver.make (a_system_processor)
			create old_name_rename_table.make_map (20)
			old_name_rename_table.set_key_equality_tester (call_name_tester)
			create new_name_rename_table.make_map (40)
			new_name_rename_table.set_key_equality_tester (call_name_tester)
		end

feature -- Processing

	process_class (a_class: ET_CLASS)
			-- Flatten features of `a_class' if not already done.
			-- Then check validity of qualified anchored types appearing
			-- in signatures, and check signature conformance in case of
			-- redeclaration if this could not be done already.
			-- Then check validity of the constraint creations of
			-- formal parameters of `a_class' and of the actual
			-- paramaters of its parents after having done
			-- so for its parent classes recursively.
		local
			a_processor: like Current
			l_other_class: ET_CLASS
		do
			if a_class.is_none then
				a_class.set_interface_checked
			elseif not current_class.is_unknown then
					-- Internal error (recursive call)
					-- This internal error is not fatal.
				error_handler.report_giaaa_error
				create a_processor.make (system_processor)
				a_processor.process_class (a_class)
			elseif a_class.is_unknown then
				if not a_class.interface_checked or else not a_class.has_interface_error then
					set_fatal_error (a_class)
					error_handler.report_giaaa_error
				end
			elseif not a_class.is_preparsed then
				set_fatal_error (a_class)
			else
				internal_process_class (a_class)
				from
				until
					classes_to_be_processed.is_empty
				loop
					l_other_class := classes_to_be_processed.last
					classes_to_be_processed.remove (l_other_class)
					process_class (l_other_class)
				end
			end
		ensure then
			interface_checked: a_class.interface_checked
		end

feature -- Error handling

	set_fatal_error (a_class: ET_CLASS)
			-- Report a fatal error to `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			a_class.set_interface_error
		ensure
			interface_checked: a_class.interface_checked
			has_interface_error: a_class.has_interface_error
		end

feature {NONE} -- Processing

	internal_process_class (a_class: ET_CLASS)
			-- Flatten features of `a_class' if not already done.
			-- Then check validity of qualified anchored types appearing
			-- in signatures, and check signature conformance in case of
			-- redeclaration if this could not be done already.
			-- Then check validity of the constraint creations of
			-- formal parameters of `a_class' and of the actual
			-- paramaters of its parents after having done
			-- so for its parent classes recursively.
		require
			a_class_not_void: a_class /= Void
			a_class_preparsed: a_class.is_preparsed
		local
			old_class: ET_CLASS
			a_parent_class: ET_CLASS
			i, nb: INTEGER
			j, nb2: INTEGER
			l_parent_clause: ET_PARENT_LIST
		do
			old_class := current_class
			current_class := a_class
			if not current_class.interface_checked then
					-- Flatten features of `current_class' if not already done.
				current_class.process (system_processor.feature_flattener)
				if current_class.features_flattened and then not current_class.has_flattening_error then
					current_class.set_interface_checked
						-- Process parents first.
					nb := current_class.parents_count
					from i := 1 until i > nb loop
						l_parent_clause := current_class.parents (i)
						nb2 := l_parent_clause.count
						from j := 1 until j > nb2 loop
							a_parent_class := l_parent_clause.parent (j).type.base_class
							if not a_parent_class.is_preparsed then
									-- Internal error: the VTCT error should have already been
									-- reported in ET_ANCESTOR_BUILDER.
								set_fatal_error (current_class)
								error_handler.report_giaaa_error
							else
									-- This is a controlled recursive call to `internal_process_class'.
								internal_process_class (a_parent_class)
								if a_parent_class.has_interface_error then
									set_fatal_error (current_class)
								end
							end
							j := j + 1
						end
						i := i + 1
					end
					if not current_class.has_interface_error then
						error_handler.report_compilation_status (Current, current_class, system_processor)
						check_qualified_anchored_signatures_validity
						resolve_signatures_unfolded_tuple_actual_parameters
						if not current_class.is_dotnet then
								-- No need to check validity of .NET classes.
							check_constraint_renamings_validity
							check_constraint_creations_validity
						end
					end
				else
					set_fatal_error (current_class)
				end
			end
			current_class := old_class
		ensure
			interface_checked: a_class.interface_checked
		end

feature {NONE} -- Signature resolving

	resolve_signatures_unfolded_tuple_actual_parameters
			-- Resolve Tuple-type-unfolding types in signature of features declared
			-- in `current_class'.
		local
			l_queries: ET_QUERY_LIST
			l_procedures: ET_PROCEDURE_LIST
			i, nb: INTEGER
		do
			l_queries := current_class.queries
			nb := l_queries.declared_count
			from i := 1 until i > nb loop
				resolve_signature_unfolded_tuple_actual_parameters (l_queries.item (i))
				i := i + 1
			end
			l_procedures := current_class.procedures
			nb := l_procedures.declared_count
			from i := 1 until i > nb loop
				resolve_signature_unfolded_tuple_actual_parameters (l_procedures.item (i))
				i := i + 1
			end
		end

	resolve_signature_unfolded_tuple_actual_parameters (a_feature: ET_FEATURE)
			-- Resolve Tuple-type-unfolding types in signature of `a_feature'
			-- in `current_class'.
		require
			a_feature_not_void: a_feature /= Void
		local
			a_type, previous_type: detachable ET_TYPE
			an_arg: ET_FORMAL_ARGUMENT
			i, nb: INTEGER
		do
			a_type := a_feature.type
			if a_type /= Void then
				unfolded_tuple_actual_parameters_resolver.resolve_type (a_type, current_class)
			end
			if attached a_feature.arguments as args then
				nb := args.count
				from i := 1 until i > nb loop
					an_arg := args.formal_argument (i)
					a_type := an_arg.type
					if a_type /= previous_type then
							-- Not resolved yet.
						unfolded_tuple_actual_parameters_resolver.resolve_type (a_type, current_class)
						previous_type := a_type
					end
					i := i + 1
				end
			end
		end

	unfolded_tuple_actual_parameters_resolver: ET_UNFOLDED_TUPLE_ACTUAL_PARAMETERS_RESOLVER2
			-- Tuple-type-unfolding type resolver

feature {NONE} -- Signature validity

	check_qualified_anchored_signatures_validity
			-- Check validity of qualified anchored types involved in
			-- the types of all signatures of `current_class'.
			-- Resolve identifiers in qualified anchored types (such as in
			-- 'like a.identifier' and 'like {A}.identifier') if not already done.
			-- Set `has_fatal_error' if a fatal error occurred.
		do
			qualified_anchored_type_checker.check_signatures_validity (current_class)
			if qualified_anchored_type_checker.has_fatal_error then
				set_fatal_error (current_class)
			end
		end

	qualified_anchored_type_checker: ET_QUALIFIED_ANCHORED_TYPE_CHECKER
			-- Qualified anchored type checker

feature {NONE} -- Constraint renaming validity

	check_constraint_renamings_validity
			-- Check validity of the constraint rename clauses
			-- of `current_class' if any.
		local
			i, l_formal_count: INTEGER
			l_formal: ET_FORMAL_PARAMETER
			j, l_constraint_count: INTEGER
		do
			if attached current_class.formal_parameters as a_formals then
				l_formal_count := a_formals.count
				from i := 1 until i > l_formal_count loop
					l_formal := a_formals.formal_parameter (i)
					if attached l_formal.constraint as l_constraint then
						l_constraint_count := l_constraint.count
						from j := 1 until j > l_constraint_count loop
							check_constraint_renaming_validity (l_constraint.type_constraint (j), l_formal)
							j := j + 1
						end
					end
					i := i + 1
				end
			end
		end

	check_constraint_renaming_validity (a_constraint: ET_TYPE_CONSTRAINT; a_formal: ET_FORMAL_PARAMETER)
			-- Check validity of the rename clause of the constraint
			-- `a_constraint' of `a_formal' if any.
		require
			a_constraint_not_void: a_constraint /= Void
			a_formal_not_void: a_formal /= Void
		local
			l_base_class: ET_CLASS
		do
			if attached a_constraint.renames as l_renames then
				if not attached {ET_BASE_TYPE} a_constraint.type as l_base_type then
					if attached {ET_FORMAL_PARAMETER_TYPE} a_constraint.type as l_formal_type then
							-- Limitation of ISE 18.11: we cannot have a rename clause
							-- on a constraint type which is a formal type.
						set_fatal_error (current_class)
						error_handler.report_vggc2b_error (current_class, l_formal_type, l_renames, a_formal)
					else
							-- Internal error: at this stage we know that the constraint
							-- type is either a formal type or a class type or a tuple type.
						set_fatal_error (current_class)
						error_handler.report_giaaa_error
					end
				elseif l_base_type.base_class.is_none then
						-- Error: We cannot have a rename clause
						-- on a constraint type which is "NONE".
					set_fatal_error (current_class)
					error_handler.report_vggc2c_error (current_class, l_base_type, l_renames, a_formal)
				else
					l_base_class := l_base_type.base_class
					check_constraint_renamed_names_validity (l_renames, l_base_type, a_formal)
					check_constraint_not_renamed_names_validity (l_base_class.queries, l_base_type, a_formal)
					check_constraint_not_renamed_names_validity (l_base_class.procedures, l_base_type, a_formal)
					old_name_rename_table.wipe_out
					new_name_rename_table.wipe_out
				end
			end
		end

	check_constraint_renamed_names_validity (a_renames: ET_CONSTRAINT_RENAME_LIST; a_constraint: ET_BASE_TYPE; a_formal: ET_FORMAL_PARAMETER)
			-- Check the validity of names appearing in the rename clause `a_renames'
			-- of the constraint `a_constraint' of `a_formal'.
			-- Fill `old_name_rename_table' and `new_name_update_table'.
			-- Do not take into account features from `a_constraint' which have not been
			-- renamed (this is done in `check_constraint_not_renamed_names_validity')
		require
			a_renames_not_void: a_renames /= Void
			a_constraint_not_void: a_constraint /= Void
			a_formal_not_void: a_formal /= Void
		local
			i, nb: INTEGER
			l_base_class: ET_CLASS
			l_rename_pair: ET_RENAME
			l_other_rename_pair: ET_RENAME
			l_old_name: ET_FEATURE_NAME
			l_new_extended_name: ET_EXTENDED_FEATURE_NAME
			l_new_name: ET_FEATURE_NAME
			l_alias_name: detachable ET_ALIAS_NAME
			l_old_duplicated: BOOLEAN
			l_has_new_name_error: BOOLEAN
			l_has_new_alias_error: BOOLEAN
			l_feature: detachable ET_FEATURE
		do
			old_name_rename_table.wipe_out
			nb := a_renames.count
			if old_name_rename_table.capacity < nb then
				old_name_rename_table.resize (nb)
			end
			new_name_rename_table.wipe_out
			if new_name_rename_table.capacity < 2 * nb then
				new_name_rename_table.resize (2 * nb)
			end
			l_base_class := a_constraint.base_class
			from i := 1 until i > nb loop
				l_rename_pair := a_renames.rename_pair (i)
				l_old_name := l_rename_pair.old_name
				l_new_extended_name := l_rename_pair.new_name
				l_new_name := l_new_extended_name.feature_name
				l_alias_name := l_new_extended_name.alias_name
				l_old_duplicated := False
				l_has_new_name_error := False
				l_has_new_alias_error := False
				l_feature := Void
				old_name_rename_table.search (l_old_name)
				if not old_name_rename_table.found then
					old_name_rename_table.put_new (l_rename_pair, l_old_name)
				else
						-- Feature name `l_old_name' appears twice on the
						-- left-hand-side of a Rename_pair in the Rename
						-- clause.
					l_old_duplicated := True
					set_fatal_error (current_class)
					error_handler.report_vggc2d_error (current_class, a_constraint, old_name_rename_table.found_item, l_rename_pair, a_formal)
				end
				if attached l_base_class.named_feature (l_old_name) as l_named_feature then
					l_feature := l_named_feature
					l_old_name.set_seed (l_feature.first_seed)
					l_new_name.set_seed (l_feature.first_seed)
				end
				if l_feature = Void then
						-- Error: There is no feature named `l_old_name' in the
						-- base class of the constraint type.
					if not l_old_duplicated then
							-- No need to report the same error again.
						set_fatal_error (current_class)
						error_handler.report_vggc2a_error (current_class, a_constraint, l_rename_pair, a_formal)
					end
				elseif l_new_name.is_infix then
					if not l_feature.is_infixable then
						l_has_new_name_error := True
						set_fatal_error (current_class)
						error_handler.report_vfav1o_error (current_class, a_constraint, l_rename_pair, l_feature)
					end
				elseif l_new_name.is_prefix then
					if not l_feature.is_prefixable then
						l_has_new_name_error := True
						set_fatal_error (current_class)
						error_handler.report_vfav1l_error (current_class, a_constraint, l_rename_pair, l_feature)
					end
				elseif l_alias_name = Void then
					-- OK
				elseif l_alias_name.is_bracket then
					if not l_feature.is_bracketable then
							-- A feature with a Bracket alias should be
							-- a function with one or more arguments.
						l_has_new_alias_error := True
						set_fatal_error (current_class)
						error_handler.report_vfav2e_error (current_class, a_constraint, l_rename_pair, l_feature)
					end
				elseif l_alias_name.is_parenthesis then
					if not l_feature.is_parenthesisable then
							-- A feature with a Parenthesis alias should be
							-- a function with one or more arguments.
						l_has_new_alias_error := True
						set_fatal_error (current_class)
						error_handler.report_vfav3e_error (current_class, a_constraint, l_rename_pair, l_feature)
					end
				elseif l_feature.is_prefixable then
					if l_alias_name.is_prefixable then
						l_alias_name.set_prefix
					else
							-- A feature with a binary Operator alias should be
							-- a function with exactly one argument.
						l_has_new_alias_error := True
						set_fatal_error (current_class)
						error_handler.report_vfav1m_error (current_class, a_constraint, l_rename_pair, l_feature)
					end
				elseif l_feature.is_infixable then
					if l_alias_name.is_infixable then
						l_alias_name.set_infix
					else
							-- A feature with a unary Operator alias should be
							-- a query with no argument.
						l_has_new_alias_error := True
						set_fatal_error (current_class)
						error_handler.report_vfav1n_error (current_class, a_constraint, l_rename_pair, l_feature)
					end
				elseif l_alias_name.is_infixable and l_alias_name.is_prefixable then
						-- This can be an alias for either a binary Operator (the feature
						-- should be a function with exactly one argument) or for a
						-- unary Operator (the feature should be a query with no argument).
						-- Examples of such aliases are 'alias "+"' and 'alias "-"'.
					l_has_new_alias_error := True
					set_fatal_error (current_class)
					error_handler.report_vfav1p_error (current_class, a_constraint, l_rename_pair, l_feature)
				elseif l_alias_name.is_infix then
						-- A feature with a binary Operator alias should be
						-- a function with exactly one argument.
					l_has_new_alias_error := True
					set_fatal_error (current_class)
					error_handler.report_vfav1m_error (current_class, a_constraint, l_rename_pair, l_feature)
				elseif l_alias_name.is_prefix then
						-- A feature with a unary Operator alias should be
						-- a query with no argument.
					l_has_new_alias_error := True
					set_fatal_error (current_class)
					error_handler.report_vfav1n_error (current_class, a_constraint, l_rename_pair, l_feature)
				else
						-- Internal error: no other kind of alias name.
					l_has_new_alias_error := True
					set_fatal_error (current_class)
					error_handler.report_giaaa_error
				end
				if l_alias_name /= Void and then l_alias_name.convert_keyword /= Void and then not l_alias_name.is_infix then
						-- When the 'convert' mark is specified, the alias
						-- should be a binary operator alias.
					set_fatal_error (current_class)
					error_handler.report_vfav4a_error (current_class, l_alias_name)
				end
				if not l_has_new_name_error then
					new_name_rename_table.search (l_new_name)
					if not new_name_rename_table.found then
						new_name_rename_table.put_new (l_rename_pair, l_new_name)
					elseif attached {ET_ALIAS_NAME} l_new_name as l_infix_or_prefix_name then
							-- Alias name `l_infix_or_prefix_name' appears twice on the
							-- right-hand-side of a Rename_pair in the Rename clause.
						l_other_rename_pair := new_name_rename_table.found_item
						set_fatal_error (current_class)
						if l_infix_or_prefix_name.is_prefix then
							error_handler.report_vfav1q_error (current_class, a_constraint, l_other_rename_pair, l_rename_pair, l_infix_or_prefix_name, a_formal)
						elseif l_infix_or_prefix_name.is_infix then
							error_handler.report_vfav1r_error (current_class, a_constraint, l_other_rename_pair, l_rename_pair, l_infix_or_prefix_name, a_formal)
						else
								-- Internal error: it has to be 'infix "..."' or 'prefix "..."'.
							error_handler.report_giaaa_error
						end
					else
							-- Feature name `l_new_name' appears twice on the
							-- right-hand-side of a Rename_pair in the Rename
							-- clause.
						set_fatal_error (current_class)
						error_handler.report_vggc2e_error (current_class, a_constraint, new_name_rename_table.found_item, l_rename_pair, a_formal)
					end
				end
				if l_alias_name /= Void and not {KL_ANY_ROUTINES}.same_objects (l_alias_name, l_new_name) and then not l_has_new_alias_error then
					new_name_rename_table.search (l_alias_name)
					if not new_name_rename_table.found then
						new_name_rename_table.put_new (l_rename_pair, l_alias_name)
					else
							-- Alias name `l_alias_name' appears twice on the
							-- right-hand-side of a Rename_pair in the Rename
							-- clause.
						l_other_rename_pair := new_name_rename_table.found_item
						set_fatal_error (current_class)
						if l_alias_name.is_bracket then
							error_handler.report_vfav2f_error (current_class, a_constraint, l_other_rename_pair, l_rename_pair, l_alias_name, a_formal)
						elseif l_alias_name.is_parenthesis then
							error_handler.report_vfav3f_error (current_class, a_constraint, l_other_rename_pair, l_rename_pair, l_alias_name, a_formal)
						elseif l_alias_name.is_prefix then
							error_handler.report_vfav1q_error (current_class, a_constraint, l_other_rename_pair, l_rename_pair, l_alias_name, a_formal)
						elseif l_alias_name.is_infix then
							error_handler.report_vfav1r_error (current_class, a_constraint, l_other_rename_pair, l_rename_pair, l_alias_name, a_formal)
						else
								-- Internal error: no other kind of alias name.
							error_handler.report_giaaa_error
						end
					end
				end
				i := i + 1
			end
		end

	check_constraint_not_renamed_names_validity (a_features: ET_FEATURE_LIST; a_constraint: ET_BASE_TYPE; a_formal: ET_FORMAL_PARAMETER)
			-- Check that the features `a_features' of the constraint `a_constraint'
			-- of `a_formal' which have not been renamed have a name and alias which
			-- do not conflict with the new names.
			-- Use `old_name_rename_table' and `new_name_update_table'.
		require
			a_features_not_void: a_features /= Void
			a_constraint_not_void: a_constraint /= Void
			a_formal_not_void: a_formal /= Void
		local
			i, nb: INTEGER
			l_feature: ET_FEATURE
			l_name: ET_FEATURE_NAME
			l_new_alias_name: ET_CALL_NAME
			l_rename_pair: ET_RENAME
		do
			nb := a_features.count
			from i := 1 until i > nb loop
				l_feature := a_features.item (i)
				l_name := l_feature.name
				if not old_name_rename_table.has (l_name) and (attached l_feature.alias_name as l_alias_name implies not old_name_rename_table.has (l_alias_name)) then
					new_name_rename_table.search (l_name)
					if new_name_rename_table.found then
						if attached {ET_ALIAS_NAME} l_name as l_infix_or_prefix_name then
								-- Alias name `l_infix_or_prefix_name' appearing on the right-hand-side
								-- of a Rename_pair in the Rename clause is already the alias
								-- name of a feature in `a_constraint'.
							l_rename_pair := new_name_rename_table.found_item
							l_new_alias_name := new_name_rename_table.found_key
							set_fatal_error (current_class)
							if l_infix_or_prefix_name.is_prefix then
								error_handler.report_vfav1s_error (current_class, a_constraint, l_rename_pair, l_new_alias_name, l_feature, a_formal)
							elseif l_infix_or_prefix_name.is_infix then
								error_handler.report_vfav1t_error (current_class, a_constraint, l_rename_pair, l_new_alias_name, l_feature, a_formal)
							else
									-- Internal error: it has to be 'infix "..."' or 'prefix "..."'.
								error_handler.report_giaaa_error
							end
						else
								-- Feature name `l_name' appearing on the right-hand-side
								-- of a Rename_pair in the Rename clause is already the name
								-- of a feature in `a_constraint'.
							set_fatal_error (current_class)
							error_handler.report_vggc2f_error (current_class, a_constraint, new_name_rename_table.found_item, a_formal)
						end
					end
					if attached l_feature.alias_name as l_alias_name and then not {KL_ANY_ROUTINES}.same_objects (l_alias_name, l_name) then
						new_name_rename_table.search (l_alias_name)
						if new_name_rename_table.found then
								-- Alias name `l_alias_name' appearing on the right-hand-side
								-- of a Rename_pair in the Rename clause is already the alias
								-- name of a feature in `a_constraint'.
							l_rename_pair := new_name_rename_table.found_item
							l_new_alias_name := new_name_rename_table.found_key
							set_fatal_error (current_class)
							if l_new_alias_name.is_bracket then
								error_handler.report_vfav2g_error (current_class, a_constraint, l_rename_pair, l_new_alias_name, l_feature, a_formal)
							elseif l_new_alias_name.is_parenthesis then
								error_handler.report_vfav3g_error (current_class, a_constraint, l_rename_pair, l_new_alias_name, l_feature, a_formal)
							elseif l_new_alias_name.is_prefix then
								error_handler.report_vfav1s_error (current_class, a_constraint, l_rename_pair, l_new_alias_name, l_feature, a_formal)
							elseif l_new_alias_name.is_infix then
								error_handler.report_vfav1t_error (current_class, a_constraint, l_rename_pair, l_new_alias_name, l_feature, a_formal)
							else
									-- Internal error: no other kind of alias name.
								error_handler.report_giaaa_error
							end
						end
					end
				end
				i := i + 1
			end
		end

	old_name_rename_table: DS_HASH_TABLE [ET_RENAME, ET_CALL_NAME]
			-- Rename pairs indexed by old names
			--
			-- Note: use ET_CALL_NAME instead of ET_FEATURE_NAME in order
			-- to make it work when in 'alias_transition_mode'. But all
			-- objects are feature names anyway.

	new_name_rename_table: DS_HASH_TABLE [ET_RENAME, ET_CALL_NAME]
			-- Rename pairs indexed by new names and aliases

feature {NONE} -- Constraint creation validity

	check_constraint_creations_validity
			-- Check validity of the constraint creations
			-- of `current_class' if any.
		local
			i, nb: INTEGER
		do
			if attached current_class.formal_parameters as a_formals then
				nb := a_formals.count
				from i := 1 until i > nb loop
					check_constraint_creation_validity (a_formals.formal_parameter (i))
					i := i + 1
				end
			end
		end

	check_constraint_creation_validity (a_formal: ET_FORMAL_PARAMETER)
			-- Check validity of the constraint creation
			-- of `a_formal' if any.
		require
			a_formal_not_void: a_formal /= Void
		local
			l_constraint_base_types: ET_CONSTRAINT_BASE_TYPES
			a_name, other_name: ET_FEATURE_NAME
			a_class: ET_CLASS
			i, j: INTEGER
			nb_constaints: INTEGER
			nb_creators: INTEGER
			l_has_flattening_error: BOOLEAN
			l_constraint: ET_BASE_TYPE_CONSTRAINT
			l_found_constraint: detachable ET_BASE_TYPE_CONSTRAINT
			l_found_feature: detachable ET_FEATURE
		do
			if attached a_formal.creation_procedures as a_creator then
				l_constraint_base_types := a_formal.constraint_base_types
					-- Build the feature tables.
				nb_constaints := l_constraint_base_types.count
				from i := 1 until i > nb_constaints loop
					a_class := l_constraint_base_types.type_constraint (i).base_class
					a_class.process (system_processor.feature_flattener)
					if not a_class.features_flattened_successfully then
						set_fatal_error (current_class)
						l_has_flattening_error := True
					end
					i := i + 1
				end
				nb_creators := a_creator.count
				from i := 1 until i > nb_creators loop
					a_name := a_creator.feature_name (i)
					from j := 1 until j >= i loop
						other_name := a_creator.feature_name (j)
						if other_name.same_feature_name (a_name) then
								-- Feature name appears twice in Creation clause.
								-- This is not considered as a fatal error.
							error_handler.report_vgcp3c_error (current_class, other_name, a_name)
						end
						j := j + 1
					end
					if l_has_flattening_error then
						-- We cannot go further.
					else
						l_found_constraint := Void
						l_found_feature := Void
						from j := 1 until j > nb_constaints loop
							l_constraint := l_constraint_base_types.type_constraint (j)
							if attached l_constraint.named_feature (a_name) as l_feature then
								if l_found_constraint /= Void and l_found_feature /= Void then
									if l_found_feature /= l_feature or not l_found_constraint.type.same_named_type (l_constraint.type, current_class, current_class) then
											-- This is not considered as an error if this is the same feature and
											-- the constraint types are the same (with the same type marks).
										set_fatal_error (current_class)
										error_handler.report_vggc3d_error (current_class, a_name, l_found_feature, l_found_constraint, l_feature, l_constraint)
									end
								else
									l_found_constraint := l_constraint
									l_found_feature := l_feature
									if l_feature.is_procedure then
											-- We found a creation procedure.
										a_name.set_seed (l_feature.first_seed)
									else
											-- This feature is not a procedure.
										set_fatal_error (current_class)
										error_handler.report_vggc3c_error (current_class, a_name, l_feature, l_found_constraint.base_class)
									end
								end
							end
							j := j + 1
						end
						if l_found_constraint = Void then
								-- This name is not the final name of a feature in any of the constraints.
							set_fatal_error (current_class)
							if nb_constaints = 1 then
								error_handler.report_vggc3a_error (current_class, a_name, l_constraint_base_types.type_constraint (1).base_class)
							else
								error_handler.report_vggc3b_error (current_class, a_name, l_constraint_base_types)
							end
						end
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Access

	classes_to_be_processed: DS_HASH_SET [ET_CLASS]
			-- Classes that need to be processed as a result of processing `current_class';
			-- Typically, we already discovered that `current_class' was not valid because
			-- these classes that it depends on were not valid themselves. But we need to
			-- force the processing of these classes in order for the corresponding validity
			-- errors to be properly reported.

invariant

	qualified_anchored_type_checker_not_void: qualified_anchored_type_checker /= Void
	unfolded_tuple_actual_parameters_resolver_not_void: unfolded_tuple_actual_parameters_resolver /= Void
	old_name_rename_table_not_void: old_name_rename_table /= Void
	no_void_old_rename_name: not old_name_rename_table.has_void
	no_void_old_rename: not old_name_rename_table.has_void_item
	new_name_rename_table_not_void: new_name_rename_table /= Void
	no_void_new_rename_name: not new_name_rename_table.has_void
	no_void_new_rename: not new_name_rename_table.has_void_item
	classes_to_be_processed_not_void: classes_to_be_processed /= Void
	no_void_class_to_be_processed: not classes_to_be_processed.has_void

end
