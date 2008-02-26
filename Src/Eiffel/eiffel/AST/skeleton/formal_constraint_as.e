indexing
	description: "Abstract description of a formal generic parameter. %
				%Instances produced by Yacc. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_CONSTRAINT_AS

inherit
	FORMAL_DEC_AS

	SHARED_SERVER
		export
			{NONE} all
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

create
	initialize

feature -- Status

	constraint_types (a_context_class: CLASS_C): TYPE_SET_A is
			-- Actual type of the constraint.
		require
			a_context_class_not_void: a_context_class /= Void
			-- Assumes that we are past degree 4, so that one can be sure that it works.
		local
			l_constraining_type: CONSTRAINING_TYPE_AS
			l_renamed_type: RENAMED_TYPE_A [TYPE_A]
			l_constraints: like constraints
			l_constraints_cursor: INTEGER
			l_constraint_position: INTEGER
			l_renaming_cache: ARRAY [RENAMING_A]
		do
			if not has_constraint then
					-- Default constraint to ANY
					-- Do a twin because it's an eiffel base list and this could lead to troubles.
				Result := Constraint_types_containing_any.twin
			else
				l_constraints := constraints
				create Result.make (l_constraints.count)
				from
					l_constraints_cursor := l_constraints.index
					l_constraint_position := 1
					l_renaming_cache := a_context_class.constraint_renaming (Current)
					l_constraints.start
				until
					l_constraints.after
				loop
					l_constraining_type := l_constraints.item
					create l_renamed_type.make (
						type_a_generator.evaluate_type_if_possible (l_constraining_type.type,
							a_context_class), l_renaming_cache.item (l_constraint_position))
					Result.extend (l_renamed_type)

					l_constraint_position := l_constraint_position + 1
					l_constraints.forth
				end
				l_constraints.go_i_th (l_constraints_cursor)
			end
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
			result_does_not_containt_void: Result.for_all (agent (a_any: RENAMED_TYPE_A [TYPE_A]): BOOLEAN do Result := (a_any /= Void) end)
		end

	constraint_types_if_possible (a_context_class: CLASS_C): TYPE_SET_A is
			-- Fault tolerant actual type of the constraint.
			--
			-- `a_context_class' is the context class.
			--| It will always return a non void list, but it can contain void values. Namely for all those
			--| Types for which we were unnable to retriefe a type are not added to the type set (!!)
		require
			a_context_class_not_void: a_context_class /= Void
		local
			l_constraining_type: CONSTRAINING_TYPE_AS
			l_type: TYPE_A
			l_renamed_type: RENAMED_TYPE_A [TYPE_A]
			l_constraints: like constraints
			l_constraints_cursor: INTEGER
			l_constraint_position: INTEGER
			l_renaming_cache: ARRAY [RENAMING_A]
		do
			if not has_constraint then
					-- Default constraint to ANY
					-- Do a twin because it's an eiffel base list and this could lead to troubles.
				Result := Constraint_types_containing_any.twin
			else
				l_constraints := constraints
				create Result.make (l_constraints.count)
				from
					l_constraints_cursor := l_constraints.index
					l_constraint_position := 1
					l_renaming_cache := a_context_class.constraint_renaming (Current)
					l_constraints.start
				until
					l_constraints.after
				loop
					l_constraining_type := l_constraints.item
					l_type := type_a_generator.evaluate_type_if_possible (l_constraining_type.type, a_context_class)
					if l_type /= Void then
						create l_renamed_type.make (l_type, l_renaming_cache.item (l_constraint_position))
						Result.extend (l_renamed_type)
					end
					l_constraint_position := l_constraint_position + 1
					l_constraints.forth
				end
				l_constraints.go_i_th (l_constraints_cursor)
			end
		ensure
			result_not_void: Result /= Void
		end

	constraint_type (a_context_class: CLASS_C): RENAMED_TYPE_A [TYPE_A] is
			-- Actual type of the constraint.
			--
			-- `a_context_class' is used to evaluate the type.
			--| A call to this function is only valid if a_context_class
		require
			a_context_class_not_void: a_context_class /= Void
			not_has_multi_constraints: not has_multi_constraints
			-- Assume that we are past degree 4, so that one can be sure that it works.
		local
			l_constraint: like constraint
			l_type: TYPE_A
		do
			l_constraint := constraint
			if l_constraint = Void then
					-- Default constraint to ANY
				Result := Any_constraint_type
			else
				l_type := type_a_generator.evaluate_type_if_possible (l_constraint.type, a_context_class)
				check l_type_not_void: l_type /= Void end
				create Result.make (l_type, a_context_class.constraint_renaming (Current).item (1))
				end

		ensure
			result_not_void: Result /= Void
		end

	constraint_type_if_possible (a_context_class: CLASS_C): RENAMED_TYPE_A [TYPE_A] is
			-- Actual type of the constraint.
		require
			a_context_class_not_void: a_context_class /= Void
			not_has_multi_constraints: not has_multi_constraints
		local
			l_constraint: like constraint
			l_type: TYPE_A
		do
			l_constraint := constraint
			if l_constraint = Void then
					-- Default constraint to ANY
				Result := Any_constraint_type
			else
					-- No need to check validity of `Result' after converting
					-- TYPE_AS into TYPE_A because at this stage it should be
					-- a valid class.				
				l_type := type_a_generator.evaluate_type_if_possible (l_constraint.type, a_context_class)
				if l_type /= Void then
					create Result.make (l_type, a_context_class.constraint_renaming (Current).item (1))
				end
			end
		end

	has_computed_feature_table (a_context_class: CLASS_C): BOOLEAN is
			-- Check that we can retrieve a FEATURE_TABLE from the class
			-- on which we want to check the validity rule about creation
			-- constraint.
			--| Basically, sometimes (degree 4) for example, we need to access
			--| the information on a class which has not been yet compiled, because
			--| of the order of the compilation which does not take into account
			--| the constraint part.
		require
			a_context_class_not_void: a_context_class /= Void
		local
			class_type: CL_TYPE_A
			l_constraint_types: LIST[RENAMED_TYPE_A [TYPE_A]]
		do
			l_constraint_types := constraint_types (a_context_class)
			Result := True
			if creation_feature_list /= Void then
				from
					l_constraint_types.start
				until
					l_constraint_types.after
				loop
					class_type ?= l_constraint_types.item

					if class_type /= Void then
						Result := Result and class_type.associated_class.has_feature_table
					end
					l_constraint_types.forth
				end
			end
		end

	constraint_creation_list (a_context_class: CLASS_C): LINKED_LIST [TUPLE [type_item: RENAMED_TYPE_A [TYPE_A]; feature_item: FEATURE_I]] is
			-- Actual creation routines from a constraint clause.
			--
			-- `a_context_class' is used to compute a flat version of the formal constraints.
			--| It goes through all constraints and gathers the proper features by applying
			--| the renaming first.
			--| This feature requires a sane creation list without ambiguities.
		require
			has_creation_constraint: has_creation_constraint
			a_context_class_not_void: a_context_class /= Void
			has_computed_feature_table: has_computed_feature_table (a_context_class)
		local
			l_constraint_types: TYPE_SET_A
			class_type: CL_TYPE_A
			feature_name: ID_AS
			feat_table: FEATURE_TABLE
			l_renaming: RENAMING_A
			l_constraint_types_item: RENAMED_TYPE_A [TYPE_A]
			l_has_more_than_one_version_default_create, l_is_version_of_default_create: BOOLEAN
		do
				-- Reset `has_default_create' as the algorithm depends on its initial state as False
			has_default_create := False

			l_constraint_types := constraint_types (a_context_class).constraining_types (a_context_class)
			from
				create Result.make
				l_constraint_types.start
			until
				l_constraint_types.after
			loop
				l_constraint_types_item := l_constraint_types.item
				class_type ?= l_constraint_types_item.type
				l_renaming := l_constraint_types_item.renaming

				if class_type /= Void then
					feat_table := class_type.associated_class.feature_table
					check
							-- A feature table associated to `class_type' should
							-- always be in the system
						feature_table_exists: feat_table /= Void
					end
					from
						creation_feature_list.start
					until
						creation_feature_list.after
					loop
						feature_name := creation_feature_list.item.internal_name
						if l_renaming /= Void then
							feat_table.search_id_under_renaming (feature_name.name_id, l_renaming)
						else
							feat_table.search_id (feature_name.name_id)
						end
						if feat_table.found_item /= Void then
							Result.extend ([l_constraint_types_item, feat_table.found_item])
								-- We will not set has_default_create in the multi constraint case if
							l_is_version_of_default_create := (feat_table.found_item.rout_id_set.first = System.default_create_rout_id)
							if
								l_is_version_of_default_create and then
								not l_has_more_than_one_version_default_create
							then
								 if not has_default_create then
								 		-- Simple case
								 	has_default_create := True
								 else
								 		-- This should only occur in the multi constraint case
								 	check has_multi_constraints: has_multi_constraints end
								 		-- As we do not know which version should be selected for an
								 		-- an abstract creation we prevent this from happening by setting `has_default_create' to False.
								 		--| Example which shows ambiguity:
								 		--| class MULTI [G -> {X rename default_create as x end, Y rename default_create as y} create x, y end]
								 		--| g: G; feature f do create g; end: We do not know which version of `default_create' we should take.
								 	l_has_more_than_one_version_default_create := True
								 	has_default_create := False
								 end
							end
						end
						creation_feature_list.forth
					end
				end
				l_constraint_types.forth
			end
		end

feature {NONE} -- Access

	Any_constraint_type: RENAMED_TYPE_A [CL_TYPE_A] is
			-- Default constraint actual type
		once
			create Result.make (create {CL_TYPE_A}.make(System.any_id),Void)
		end

	Constraint_types_containing_any: TYPE_SET_A is
			-- Default constraint actual type
		once
			create Result.make(1)
			Result.extend(create {RENAMED_TYPE_A [TYPE_A]}.make (create {CL_TYPE_A}.make (System.any_id), Void))
		end

feature -- Output

	append_signature (a_text_formatter: TEXT_FORMATTER; a_short: BOOLEAN; a_context_class: CLASS_C) is
			-- Append the signature of current class in `a_text_formatter'
			-- If `a_short', use "..." to replace constrained generic type, so
			-- class {HASH_TABLE [G, H -> HASHABLE]} becomes {HASH_TABLE [G, H -> ...]}.
			--| We do not produce the creation constraint clause since
			--| it is useless in this case.
		require
			non_void_st: a_text_formatter /= Void
			a_context_class_not_void: a_context_class /= Void
		local
			c_name: STRING
			eiffel_name: STRING
			l_type_set: TYPE_SET_A
			l_feature: E_FEATURE
		do
			if is_reference then
				a_text_formatter.process_keyword_text (ti_reference_keyword, Void)
				a_text_formatter.add_space
			elseif is_expanded then
				a_text_formatter.process_keyword_text (ti_expanded_keyword, Void)
				a_text_formatter.add_space
			end
			c_name := name.name.as_upper
			a_text_formatter.process_generic_text (c_name)
			if has_constraint then
				a_text_formatter.add_space
				a_text_formatter.process_symbol_text (ti_Constraint)
				a_text_formatter.add_space
				if a_short then
					a_text_formatter.add_string (once "...")
				else

					append_constraints (a_text_formatter, a_short, a_context_class)
					l_type_set := constraint_types_if_possible (a_context_class).constraining_types_if_possible (a_context_class)

					if has_creation_constraint then
						from
							creation_feature_list.start
							a_text_formatter.add_space
							a_text_formatter.process_keyword_text (ti_Create_keyword, Void)
						until
							creation_feature_list.after
						loop
							a_text_formatter.add_space
							eiffel_name := creation_feature_list.item.internal_name.name
							l_feature := l_type_set.e_feature_state (creation_feature_list.item.internal_name).feature_item
							if l_feature /= Void then
								a_text_formatter.process_feature_text (eiffel_name, l_feature, false)
							else
								a_text_formatter.add_feature_name (eiffel_name, a_context_class)
							end
							creation_feature_list.forth
							if not creation_feature_list.after then
								a_text_formatter.process_symbol_text (ti_Comma)
							end
						end
						a_text_formatter.add_space
						a_text_formatter.process_keyword_text (ti_End_keyword, Void)
					end
				end

			end
		end

feature -- Validity checking

	check_constraint_renaming (a_context_class: CLASS_C)
			-- Checks the rename clause:
			-- Does every feature exist?
			-- Is nothing renamed twice?
			-- Are no two or more feature renamed to the same new feature name?
			--
			-- `a_context_class' is used to do the feature lookups.
		require
			has_constraint: has_constraint
		local
			l_cluster: CONF_GROUP
			l_type: TYPE_AS
			l_named_tuple_type: NAMED_TUPLE_TYPE_AS
			l_class_type: CLASS_TYPE_AS
			l_rename_clause: RENAME_CLAUSE_AS
			l_constraints: like constraints
			l_constraint_position: INTEGER
			l_constraining_type: CONSTRAINING_TYPE_AS
			l_class_i: CLASS_I
			l_compiled_class: CLASS_C
			l_vtmc3: VTMC3
		do

		 	l_cluster := a_context_class.group

			l_constraints := constraints
			from
				l_constraints.start
				l_constraint_position := 1
			until
				l_constraints.after
			loop
					-- Check wether we have a class type.
				l_constraining_type := l_constraints.item
				l_type := l_constraining_type.type
				l_class_type ?= l_type

				if l_class_type = Void then
					l_named_tuple_type ?= l_type
					if l_named_tuple_type = Void then
						if l_constraining_type.renaming /= Void then
							create l_vtmc3
							l_vtmc3.set_class (a_context_class)
							l_vtmc3.set_type (l_type)
							l_vtmc3.set_message ("It is not allowed to apply a renaming to constraint which is a formal generic or NONE.")
							Error_handler.insert_error (l_vtmc3)
						end
					else
						l_class_i := universe.class_named ("TUPLE", l_cluster)
					end
				else
					l_class_i := universe.class_named (l_class_type.class_name.name, l_cluster)
				end
					-- We handle only the case where `class_i' is a valid reference
					-- because the case has been handled in `check_constraint_type'
					-- from CLASS_TYPE_AS which is called just before this feature.
				if l_class_i /= Void then
						-- Here we assume that the class is correct (call `check_constraint_type'
						-- from CLASS_TYPE_AS did not add any error items to `Error_handler'.)
					l_compiled_class := l_class_i.compiled_class
					a_context_class.constraint_classes (Current).put (l_compiled_class, l_constraint_position)

					l_rename_clause := l_constraints.item.renaming
					if l_rename_clause /= Void then
							-- After this call a RENAMING_A object will be stored into the cache
							-- if there were no errors.
						check_rename_clause (a_context_class, l_class_i.compiled_class, l_rename_clause,
							l_constraint_position)
					else
						-- no renaming to check
					end
				end
				l_constraints.forth
				l_constraint_position := l_constraint_position + 1
			end
		end

	check_constraint_creation (a_context_class: CLASS_C) is
			-- Check validity of the creation clause in the constraint.
			-- Also checks the constraint renaming (`check_constraint_renaming')
			--
			-- `a_context_class' is the class where the formals are defined.
		require
			has_creation_constraint: has_creation_constraint
			renaming_is_sane: (agent (a_context_class2: CLASS_C): BOOLEAN
									local
										l_error_level: NATURAL
									do
										l_error_level := error_handler.error_level
										check_constraint_renaming (a_context_class2)
											-- No erros should occur.
										Result := (l_error_level = error_handler.error_level)
									end).item ([a_context_class])
		local

			l_original_feature_name_id: INTEGER
			l_vtgc3: VTGC3
			l_constraints, l_flat_constraints: TYPE_SET_A
			l_result: TUPLE [feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
			l_error_info: MC_FEATURE_INFO
		do
				-- Here we will just check that the feature listed in the creation
				-- constraint part are effectively features of the constraint.
				-- We have to apply the renaming first, in order to find the right feature.
				-- Each creation constraint should yield in exactly one corresponding feature in one class.
				-- Otherwise we throw an error.
			l_constraints := constraint_types (a_context_class)
			l_flat_constraints := l_constraints.constraining_types (a_context_class)
			check l_flat_constraints_constains_no_formals: not l_flat_constraints.has_formal end

			from
				creation_feature_list.start
			until
				creation_feature_list.after
			loop
					l_original_feature_name_id := creation_feature_list.item.internal_name.name_id
					l_result := l_flat_constraints.feature_i_state_by_name_id (l_original_feature_name_id)
					if l_result.features_found_count = 1 then
						-- Ok, we found exactly one feature, this means our constraint is met and we're fine.
					else
							-- This is certainly an error: Let's spend some time finding out what exactly is wrong.
						l_error_info := l_constraints.info_about_feature_by_name_id (l_original_feature_name_id, position, a_context_class)

						create l_vtgc3
						l_vtgc3.set_constraints (l_constraints)
						l_vtgc3.set_class (a_context_class)
						l_vtgc3.set_error_info (l_error_info)
						l_vtgc3.set_feature_name ((create {ID_AS}.initialize_from_id (l_original_feature_name_id)).name)
						l_vtgc3.set_location (creation_feature_list.item.start_location)
						Error_handler.insert_error (l_vtgc3)
					end
					creation_feature_list.forth
			end

		end

	is_valid_creation_routine (f: FEATURE_I): BOOLEAN is
			-- Does `f' have all the needed requirement to be
			-- used a creation routine for the future creation
			-- of the generic parameter.
		require
			feature_exists: f /= Void
		local
			p: PROCEDURE_I
		do
			p ?= f
			Result := p /= Void
		end

feature {NONE} -- Implementation

	append_constraints (a_text_formatter: TEXT_FORMATTER; a_short: BOOLEAN; a_context_class: CLASS_C) is
			-- Append constraints to a text decorator.
			--
			-- Output is appended to a`a_text_formatter'
			-- `a_short' set to true will not print the renaming.
			-- `a_context_class' is used to evaluate the types and formal constraint chains.
		require
			a_text_formatter_attached: a_text_formatter /= Void
			a_context_class_attached: a_context_class /= Void
			has_constraint: has_constraint
		local
			l_constraining_type: CONSTRAINING_TYPE_AS
			l_constraints: like constraints
			l_constraints_cursor: INTEGER
			l_type: TYPE_A
			l_has_multi_constraints: BOOLEAN
			l_constraint_class: CLASS_C
		do
			l_has_multi_constraints := has_multi_constraints
			if l_has_multi_constraints then
				a_text_formatter.process_symbol_text ("{")
			end

			l_constraints := constraints
			from
				l_constraints_cursor := l_constraints.index
				l_constraints.start
			until
				l_constraints.after
			loop
				l_constraining_type := l_constraints.item
				l_type := type_a_generator.evaluate_type_if_possible (l_constraining_type.type, a_context_class)
				if l_type /= Void then
						-- Type was found: Process the type
					type_output_strategy.process (l_type, a_text_formatter, a_context_class, Void)
					if l_constraining_type.has_at_least_one_renaming then
						if l_type.has_associated_class then
							l_constraint_class := l_type.associated_class
						end
						a_text_formatter.add_space
						append_rename_clause (a_text_formatter, l_constraining_type.renaming , l_constraint_class, a_short)
					end
				else
						-- Type was not found: Simply dump it
					a_text_formatter.add (l_constraining_type.type.dump)
					if l_constraining_type.has_at_least_one_renaming then
						a_text_formatter.add_space
						append_rename_clause (a_text_formatter, l_constraining_type.renaming , Void, a_short)
					end
				end
				l_constraints.forth
				if l_has_multi_constraints and not l_constraints.after then
					a_text_formatter.add (", ")
				end
			end
			l_constraints.go_i_th (l_constraints_cursor)
			if l_has_multi_constraints then
				a_text_formatter.process_symbol_text ("}")
			end
		end


	append_rename_clause (a_text_formatter: TEXT_FORMATTER; a_rename_clause: RENAME_CLAUSE_AS; a_constraint_class: CLASS_C; a_short: BOOLEAN) is
			-- Prints renaming
			--
			-- `a_text_formatter': Used to append the renaming to.
			-- `a_rename_clause': Rename clause which is printed
			-- `a_constraint_class': Class to which the renaming is applied to. Used to link to features. Can be `Void'.
			-- `a_short': States whether we print a short version (rename ... end) or not.
		require
			a_text_formatter_attached: a_text_formatter /= Void
			a_rename_clause_attached: a_rename_clause /= Void
			a_rename_clause_has_content: a_rename_clause.content /= Void and then not a_rename_clause.content.is_empty
		local
			l_content: EIFFEL_LIST [RENAME_AS]
			l_old_name, l_new_name: ID_AS
			l_e_feature: E_FEATURE
			l_alias_name: STRING_AS
			l_as, l_quote: STRING
		do
			l_as := " as "
			l_quote := "%""
			a_text_formatter.process_keyword_text ("rename", Void)
			if a_short then
				a_text_formatter.add (" ... ")
			else
				a_text_formatter.add_space
				l_content := a_rename_clause.content
				from
					l_content.start
				until
					l_content.after
				loop
					l_old_name := l_content.item.old_name.internal_name
					l_new_name := l_content.item.new_name.internal_name
					l_alias_name := l_content.item.new_name.alias_name
					if a_constraint_class /= Void and then a_constraint_class.has_feature_table then
						l_e_feature := a_constraint_class.feature_with_id (l_old_name)
					end
					if l_e_feature /= Void then
						a_text_formatter.process_feature_text (l_old_name.name, l_e_feature, false)
					else
						a_text_formatter.add (l_old_name.name)
					end

					a_text_formatter.add (l_as)
					a_text_formatter.add (l_new_name.name)
					if l_alias_name /= Void then
						a_text_formatter.add_space
						a_text_formatter.process_keyword_text ("alias", Void)
						a_text_formatter.add_space
						a_text_formatter.process_symbol_text (l_quote)
						a_text_formatter.add (l_alias_name.value)
						a_text_formatter.process_symbol_text (l_quote)
					end

					l_content.forth
					if not l_content.after then
						a_text_formatter.add (once ", ")
					end
				end
			end
			a_Text_formatter.add_space
			a_text_formatter.process_keyword_text ("end", Void)
		end


	check_rename_clause (a_context_class, a_constraint: CLASS_C; a_rename_clause: RENAME_CLAUSE_AS; a_constraint_position: INTEGER)
			-- Checks a rename clause and inserts a `RENAMING_A' instance into the cache.
			-- If the check was already performed it won't be done again.
			--
			-- `a_constraint' is the class of the constraining type. For 'G -> STRING rename ... end' it is STRING.
			-- `a_rename_clause' is the renaming clause for one constraint
			-- `a_constraint_position' is the position of the actual constraint being checked.
		require
			a_context_class_not_void: a_context_class /= Void
			a_constraint_not_void: a_constraint /= Void
			a_constraint_has_feature_table: a_constraint.has_feature_table
			a_rename_clause_not_void: a_rename_clause /= Void
			a_constraint_position_in_range: a_constraint_position > 0 and then a_constraint_position <= constraints.count
		local
			l_renaming_cache: ARRAY [RENAMING_A]
			l_renaming: RENAMING_A
			l_vtgc2: VTGC2
		do
			l_renaming_cache := a_context_class.constraint_renaming (Current)
			l_renaming := l_renaming_cache.item (a_constraint_position)
			if l_renaming = Void then
				l_renaming := new_renaming_a (a_rename_clause)
				if l_renaming /= Void then
					l_renaming.check_against_feature_table (a_constraint.feature_table)
					if l_renaming.has_error_report then
						create l_vtgc2
						l_vtgc2.set_class (system.current_class)
						l_vtgc2.set_formal_constraint (Current)
						l_vtgc2.set_constraint (a_constraint, a_constraint_position)
						l_vtgc2.set_renaming (a_rename_clause)
						l_vtgc2.set_features_renamed_multiple_times (l_renaming.error_report.renamed_multiple_times)
						l_vtgc2.set_features_renamed_to_the_same_name (l_renaming.error_report.renamed_to_same_name)
						l_vtgc2.set_non_existent_features (l_renaming.error_report.non_existent)
						error_handler.insert_error (l_vtgc2)
					else
						l_renaming_cache.put (l_renaming, a_constraint_position)
					end
				end
			end
		end

	new_renaming_a (a_rename_clause: RENAME_CLAUSE_AS): RENAMING_A is
			-- Renaming lookup datastructure from `a_renaming_clause'.
			--
			-- `a_rename_clause': AST for which the RENAMING_A instance is built.
		local
			l_renaminings: EIFFEL_LIST [RENAME_AS]
			l_rename: RENAME_AS
			l_new_name: FEATURE_NAME
			l_old_name_id, l_alias_name_id: INTEGER
			l_feature_name_id: FEAT_NAME_ID_AS
		do
			if a_rename_clause /= Void then
				l_renaminings := a_rename_clause.content
				if l_renaminings /= Void then
					create Result.make (l_renaminings.count)
					from
						l_renaminings.start
					until
						l_renaminings.after
					loop
						l_rename := l_renaminings.item
						l_old_name_id := l_rename.old_name.internal_name.name_id
						l_new_name := l_rename.new_name
						l_feature_name_id ?= l_new_name
						if l_feature_name_id /= Void then
								-- We have a "normal" name (but in case of an object of type `FEATURE_NAME_ALIAS_AS' we can still have an alias.)
							Result.put (l_old_name_id,
										l_new_name.internal_name.name_id)
						end
							-- Now check in any case for an alias
							-- This includes the case where we have an object of type `INFIX_PREFIX_AS'
						l_alias_name_id := l_new_name.internal_alias_name_id
						if l_alias_name_id /= 0 then
							Result.put_delayed_alias (l_old_name_id, l_new_name)
						end
						l_renaminings.forth
					end
				end
			end
		ensure
			new_rename_a_not_void:
				(a_rename_clause /= Void and then a_rename_clause.content /= Void) implies Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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


