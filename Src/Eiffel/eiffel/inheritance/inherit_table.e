note
	description: "[
			Table of inherited features indexed by name ID.
			Feature `pass2' is second pass of compiler.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INHERIT_TABLE

inherit
	HASH_TABLE [INHERIT_FEAT, INTEGER]
		rename
			make as extend_tbl_make,
			merge as extend_table_merge
		end

	SHARED_SERVER
		export
			{ANY} all
		undefine
			copy, is_equal
		end

	SHARED_SELECTED
		undefine
			copy, is_equal
		end

	SHARED_ERROR_HANDLER
		export
			{ANY} error_handler
		undefine
			copy, is_equal
		end

	SHARED_INST_CONTEXT
		undefine
			copy, is_equal
		end

	SHARED_ORIGIN_TABLE
		undefine
			copy, is_equal
		end

	SHARED_ID_TABLES
		undefine
			copy, is_equal
		end

	SHARED_DEGREES
		undefine
			copy, is_equal
		end

	SHARED_RESCUE_STATUS
		undefine
			copy, is_equal
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_IL_CASING
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			copy, is_equal
		end

	SHARED_DEGREES
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_EXPORT_STATUS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

create {INHERIT_TABLE}
	extend_tbl_make

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Hash table creation
		do
			default_size := n
			extend_tbl_make (300)
			create inherited_features.make (n)
			create changed_features.make (250)
			create origins.make (250)
		end

feature

	default_size: INTEGER
			-- Default size for `inherited_features'.

	inherited_features: FEATURE_TABLE
			-- Table of inherited features.
			-- It is calculated by feature `analyse'.

	a_class: CLASS_C
			-- Current class to analyze

	feature_table: FEATURE_TABLE
			-- Previous feature table of the class `a_class': processed
			-- by feature `analyze_declarations'; if the class has never
			-- been compiled before, this attribute will be created
			-- and empty before the analysis of the local declarations

	previous_feature_table: FEATURE_TABLE
			-- Previous feature table processed during a second pass,
			-- and put in the temporary server only.
			--| Useful for the processing of feature ids

	class_info: CLASS_INFO
			-- Information about current class analyzed: it contains
			-- a compild form of parents, a reference on the feature
			-- list produced by the first pass and indexes left by
			-- the temporary AST server (`Tmp_ast_server') when the
			-- abstract syntax tree of the current analyzed class
			-- has been put in it.
			-- (actually we have here the offsets in the (future) file
			-- ".AST" of the abstract represention of the features).

	parents: PARENT_LIST
			-- Compiled form of the parents of the current analyzed class

	changed_features: ARRAYED_LIST [INTEGER]
			-- Changed features of `a_class'.

	invariant_changed: BOOLEAN
			-- Did the invariant clause changed ?

	invariant_removed: BOOLEAN
			-- Is the invariant clause removed ?

	origins: ARRAYED_LIST [INTEGER]
			-- Origin features name list for pattern processing

	supplier_status_modified: BOOLEAN
			-- The status (expanded, deferred) of a supplier has changed

	assert_prop_list: LINKED_LIST [INTEGER]
			-- List of routine ids for assertion modifications

	adaptations: LINKED_LIST [FEATURE_ADAPTATION]
			-- List of redefinitions and joins
		once
			create Result.make
		end

	pass2_control: PASS2_CONTROL
			-- Second pass controler, needs to be an attribute since
			-- used by `pass2' and `feature_i_from_feature_as'.

	pass2 (pass_c: CLASS_C; is_supplier_status_modified: BOOLEAN)
			-- Second pass of the compiler on class `cl'. The ultimate
			-- goal here is to calculate the feature table `inherited_features'.
		require
			pass_c_not_void: pass_c /= Void
			class_info_exists: Class_info_server.has (pass_c.class_id);
		local
			class_id: INTEGER
			resulting_table: like inherited_features
			pass3_control: PASS3_CONTROL
			depend_unit: DEPEND_UNIT
			old_creators, new_creators: like {CLASS_C}.creators
			old_convert_to, old_convert_from: HASH_TABLE [INTEGER, DEANCHORED_TYPE_A]
			creation_name: INTEGER
			l_error_level: NATURAL
			l_is_il_generation: BOOLEAN
		do
			l_error_level := error_handler.error_level

			a_class := pass_c
				-- Store previous data
			old_creators := a_class.creators
			old_convert_to := a_class.convert_to
			old_convert_from := a_class.convert_from

				-- A new pass2_control object has to be created each time
				-- as this routine can be called via indirect recursion
				-- if descendent classes need to be recompiled as a result
				-- of a change in an ancestor.
			create pass2_control.make

			l_is_il_generation := System.il_generation

			if l_is_il_generation then
				a_class.init_class_interface
			end

			supplier_status_modified := is_supplier_status_modified;

				-- Initialization of the context for evaluation of actual
				-- types
			Inst_context.set_group (a_class.group)

				-- Empty the selection control list
			Selected.wipe_out;
			class_id := a_class.class_id;

				-- Look for the interpreted class information left
				-- by the first pass if the class has syntactically changed.
			class_info := Class_info_server.item (class_id)

				-- Extract `computed_parents' from current class an reset
				-- it as it is not needed that we store this information
				-- since it is only used in `pass2'.
			parents := a_class.computed_parents

				-- Compute attribute `feature_table'.
			assign_feature_table

				-- Check generic parents of the class
			a_class.check_parents

				-- Merge parents table: the topological sort and the
				-- sort of list `changed_classes' of the system ensures
				-- that the second pass has been applied to the parents
				-- of class `cl' before.
				-- We also check if renamed features are available
			merge_parent_list_and_check_renamings (parents)

				-- Check adaptation clauses of parents
			parents.check_validity2

			if error_handler.error_level /= l_error_level then
				error_handler.raise_error
			end

				-- Process feature renaming.
			process_renaming

				-- Make sure unused feature id table is cleared.
			unused_feature_id_table.wipe_out

			analyze
				-- Check-sum error after analysis fo the inherited
				-- features
			if error_handler.error_level /= l_error_level then
				error_handler.raise_error
			end

				-- In the past we used to call `a_class.changed_features.clear_all'
				-- however this is not good for incrementality because if you change the body
				-- of a routine f from Body1 to Body2 but then get an error at degree 3 after
				-- the new bytecode for f has been generated. Then you fix the error and change
				-- f back to Body1, the compiler will not detect the change and will not recompute
				-- the bytecode which is necessary since we do not want Body2.
				-- This fixes eweasel test#incr228 and test#incr399.
				-- a_class.changed_features.clear_all;

				-- Analyze features written directly in `a_class'.
			if a_class.changed then
					-- Class `a_class' is syntactically changed
				analyze_declarations;
					-- No update of `Instantiator' if there is an error
				if error_handler.error_level /= l_error_level then
					error_handler.raise_error
				end
					-- Look for generic types in the inheritance clause
					-- of a syntactically changed class
				a_class.update_instantiator1
			else
					-- The class didn't syntactically changed but, one
					-- or more ancestor has a new feature table.
				recompute_declarations
			end;

				-- Check the redefine and select clause, and keep track
				-- of possible joins between deferred features
			check_validity2

				-- Wipeout unused feature table as it is no longer required.
			unused_feature_id_table.wipe_out

				-- Computes a good size for the feature table
			resulting_table := inherited_features

				-- Check redeclarations into an attribute
			process_redeclarations (resulting_table)

				-- Check sum
			if error_handler.error_level /= l_error_level then
				error_handler.raise_error
			end

				-- Compute selection table
				-- Origin table is only used to hold the original features for determining
				-- selection, it may be wiped out after here as it contains no
				-- persistent data.
			Origin_table.compute_feature_table (parents, feature_table, resulting_table);

				-- Check sum error: because of possible bad selections,
				-- anchored types on features could not be evaluated here.
			if error_handler.error_level /= l_error_level then
				error_handler.raise_error
			end

				-- Now that the table is completely build, we are building
				-- the quick lookup table.
			resulting_table.compute_lookup_tables

				-- Check types in the feature table
			origin_table.check_feature_types (resulting_table)
			if error_handler.error_level /= l_error_level then
				error_handler.raise_error
			end

				-- Update the assert_id_set of redefined features.
				-- This should be done before `check_validity3` that uses `{FEATURE_I}.assert_id_set`.
			update_inherited_assertions

				-- Check the adaptations
			check_validity3 (resulting_table)

				-- Check useless selections
			parents.check_validity4

				-- Creators processing
			a_class.set_creators (class_info.creation_table (resulting_table))
				-- No update of `Instantiator' if there is an error
			if error_handler.error_level /= l_error_level then
				error_handler.raise_error
			end

			if class_info.convertors /= Void then
					-- Convertibility processing
					-- Only check if there are convertors present
					-- Note: Manu 04/23/2003: Do we need to make a once of `CONVERTIBILITY_CHECKER'?
					-- At the moment no as it does not seem expensive to create it all the time.
				(create {CONVERTIBILITY_CHECKER}).init_and_check_convert_tables (
					a_class, resulting_table, class_info.convertors)
				if error_handler.error_level /= l_error_level then
					error_handler.raise_error
				end
			else
					-- If the class had a conversion clause, we need to remove it.
				a_class.set_convert_from (Void)
				a_class.set_convert_to (Void)
			end

				-- Track generic types in the result and arguments of
				-- features of a changed class
			if a_class.changed then
					-- Generic types tracking
					--resulting_table.update_instantiator2
				Origin_table.update_instantiator2 (resulting_table)

					-- Compute invariant clause
				compute_invariant;
			end;

				-- Check sum error
			if error_handler.error_level /= l_error_level then
				error_handler.raise_error
			end

				-- Pass2 controler evaluation
			feature_table.fill_pass2_control (pass2_control, resulting_table);
			if previous_feature_table /= Void then
					-- Add the modifications done since the last unsuccessful compilation
				previous_feature_table.fill_pass2_control (pass2_control, resulting_table);
			end;

				-- Process externals
			if a_class.changed then
				pass2_control.process_externals
			end;

				-- Insert the changed creators in the propagators list
			new_creators := a_class.creators
			if old_creators = Void then
				if
					attached new_creators or else
					(a_class.is_deferred and then pass_c.deferred_modified) or else
					pass_c.once_modified
				then
						-- the clients using !! without a creation routine
						-- must be recompiled
					if a_class.is_used_as_expanded then
						create depend_unit.make_expanded_unit (class_id);
						pass2_control.propagators.extend (depend_unit)
					end;
					create depend_unit.make_creation_unit (class_id);
					pass2_control.propagators.extend (depend_unit)
				end;
			else
				from
					old_creators.start
				until
					old_creators.after
				loop
					creation_name := old_creators.key_for_iteration
					if
						not attached new_creators or else
						not new_creators.has (creation_name) or else
							-- The new export status is more restrictive than the old one
						not old_creators.item_for_iteration.equiv (new_creators.item (creation_name))
					then
						resulting_table.search_id (creation_name)
						if resulting_table.found then
								-- The routine is not a creation routine any more
								-- or the export status has changed
							create depend_unit.make (class_id, resulting_table.found_item)
							pass2_control.propagators.extend (depend_unit)
						end
					end
					old_creators.forth
				end
				if a_class.is_used_as_expanded and then
					(new_creators = Void or else new_creators.count > 1)
				then
					create depend_unit.make_expanded_unit (class_id)
					pass2_control.propagators.extend (depend_unit)
				end
				old_creators := Void
			end

				-- Insert removed routines from convert clauses into propagators list.
			if old_convert_to /= Void then
				update_convert_clause (old_convert_to, a_class.convert_to, resulting_table)
			end
			if old_convert_from /= Void then
				update_convert_clause (old_convert_from, a_class.convert_from, resulting_table)
			end

				-- Remember the removed features written in `a_class'
			pass3_control := a_class.propagators
			pass3_control.set_removed_features (pass2_control.removed_features)
			pass3_control.set_invariant_changed (invariant_changed)
			pass3_control.set_invariant_removed (invariant_removed)

				-- Process patterns of origin features
			process_pattern (resulting_table)

				-- Propagation
			Degree_4.process_and_propagate
				(pass_c, resulting_table,
				resulting_table.equiv
					(if attached previous_feature_table then
							-- If there is a table in the tmp server,
							-- the propagation is done again only if the new
							-- table is different.
						previous_feature_table
					else
							-- There is no table in the tmp server, see if the
							-- new feature table is equivalent to the old one.
						feature_table
					end, pass2_control),
				pass2_control, assert_prop_list, changed_features)

				-- Reset `assert_prop_list' for next iteration.
			assert_prop_list := Void

			if l_is_il_generation then
				a_class.class_interface.process_features (resulting_table)
					-- Find main_parent of current class.
				compute_main_parent (resulting_table)
			end

				-- Put the resulting table in the temporary feature table
				-- server.
			a_class.set_current_feature_table (resulting_table)

				-- Ensure a wrapper is generated for attributes of a formal generic type.
			mark_generic_attribute_seeds (resulting_table)

				-- Flush all the routines we have created so far to the disk.
			resulting_table.flush
				-- Update table `changed_features' of `a_class'.
			update_changed_features;
			clear;
		rescue
			if Rescue_status.is_error_exception then
					-- Error happened during second pass: clear the
					-- structure
				clear
				if a_class.changed then
						-- Reset the old creation table
					a_class.set_creators (old_creators)
				end
			end
		end

	mark_generic_attribute_seeds (resulting_table: FEATURE_TABLE)
			-- Mark attributes that are seeds of generic types to generate
			-- wrappers for them.
		require
			resulting_table_attached: resulting_table /= Void
		local
			f: FEATURE_I
			l_attribute_count, l_attribute_counter: INTEGER
		do
			from
				l_attribute_count := resulting_table.attribute_count
				resulting_table.start
			until
				l_attribute_counter = l_attribute_count
			loop
				f := resulting_table.item_for_iteration
				if f.is_attribute then
						-- We have an attribute so increase the counter
					l_attribute_counter := l_attribute_counter + 1
					if f.is_origin and then f.rout_id_set.count = 1 then
						if attached {ATTRIBUTE_I} f as a then
							a.set_generate_in (f.written_in)
						else
							check f_is_attribute: False end
						end
					end
				end
				if l_attribute_counter < l_attribute_count then
					resulting_table.forth
				end
			end
			check
				attributes_iterated: l_attribute_count = l_attribute_counter
			end
		end

	assign_feature_table
			-- Assign attribute `feature_table'. Look for a previous
			-- feature table.
		require
			a_class /= Void
		local
			id: INTEGER;
		do
			id := a_class.class_id;
				-- Look for a previous feature table
			feature_table := a_class.previous_feature_table
			if feature_table = Void then
					-- No previous compilation.
				feature_table := Empty_table
			end
				-- Prepare `inherited_features'.
			inherited_features.set_feat_tbl_id (id);
				-- Compute `previous_feature_table'.
			previous_feature_table := a_class.current_feature_table
		end

	Empty_table: FEATURE_TABLE
			-- Empty feature table
		do
			create Result.make (1)
			Result.set_computed
		ensure
			empty_table_not_void: Result /= Void
		end

	merge_parent_list_and_check_renamings (a_parent_list: PARENT_LIST)
			-- Merge features of parents from `a_parent_list' into `Current'
			-- Renaming is checked during each merge.
		require
			a_parent_list_not_void: a_parent_list /= Void
		local
			i: INTEGER
			l_parent_count: INTEGER
		do
			from
				l_parent_count := a_parent_list.count
				inherit_feat_cache.reset_with_n_elements (0)
				inherit_info_cache.reset_with_n_elements (0)
				selection_list_cache.reset_with_n_elements (0)
					-- Non-conforming parents to the list at the end.
					-- This will leave any features from conforming
					-- branches as the first item in the list which is
					-- the version we wish to take should the features be the same.
					-- We can then check to see if the parent is non-conforming, this
					-- will mean that it needs to be replicated as a conforming version
					-- is not present (see {INHERIT_FEAT}.process_features)
				i := 1
			until
				i > l_parent_count
			loop
				merge_features_of_parent_c (a_parent_list [i])
				i := i + 1
			end
		end

	merge_features_of_parent_c (parent_c: PARENT_C)
			-- Merge feature table of parent `cl' into
			-- a data structure to analyse.
		local
			parent_table: SPECIAL [FEATURE_I]
				-- Feature table of the parent `parent_c'
			parent_type: LIKE_CURRENT
				-- "like Current" type of `parent_c'
			l_feature_name_id: INTEGER
			i, nb: INTEGER
			l_inherit_info_cache: like inherit_info_cache
			l_inherit_feat_cache: like inherit_feat_cache
		do
			from
				l_inherit_info_cache := inherit_info_cache
				l_inherit_feat_cache := inherit_feat_cache
				create parent_type.make (parent_c.parent_type)
					-- Look for the parent table on the disk
				parent_table := parent_c.parent.feature_table.features.area
				check
					parent_table_exists: parent_table /= Void
					-- Because of topological sort, the parents are
					-- necessary analyzed (if needed) before class
					-- `a_class'. Redefinition of feature `item' in
					-- class FEAT_TBL_SERVER will look for the table
					-- in the file `Tmp_feat_tbl_file' and then
					-- in the file `Feat_tbl_file'.
				end

					-- Iteration on the parent feature table
				i := 0
				nb := parent_table.count
			until
				i = nb
			loop
				l_feature_name_id := parent_table [i].feature_name_id

					-- Add inherited feature information to the concerned instance of INHERIT_FEAT
				search (l_feature_name_id)
					-- If an INHERIT_FEAT object corresponding to feature_name_id is not present then add one.
				if found_item = Void then
						-- Add new feature to the inheritance table.
					put (l_inherit_feat_cache.new_inherit_feat, l_feature_name_id)
				end
				found_item.insert (l_inherit_info_cache.new_inherited_info (parent_table [i], parent_c, parent_type))
				i := i + 1
			end

				-- Check renamings of `parent_c'
			parent_c.check_validity1
		end

	process_renaming
			-- Process all direct renamings.
		local
			l_parents: like parents
			l_old_feature_name_id: INTEGER
			i, l_count: INTEGER
			l_inherit_info: INHERIT_INFO
			l_from_features_list: BOOLEAN
			new_name_id: INTEGER
			new_alias_name_id: like {RENAMING}.alias_name_id
			names: like names_heap
		do
				-- Loop through the parent list
			names := names_heap
			l_parents := parents
			from
				l_parents.start
			until
				l_parents.after
			loop
				if l_parents.item.has_renaming then
					from
						l_parents.item.renaming.start
					until
						l_parents.item.renaming.after
					loop
						l_old_feature_name_id := l_parents.item.renaming.key_for_iteration
						search (l_old_feature_name_id)
						if found then
							l_inherit_info := Void
								-- We have retrieved the appropriate inherit feat object
								-- Now we retrieve the unprocessed inherit info for the parent_c corresponding to `l_old_feature_name_id'.
							from
								i := 1
								l_count := found_item.features.count
								l_from_features_list := False
							until
								i > l_count or else l_from_features_list
							loop
								if not found_item.features [i].renaming_processed and then found_item.features [i].parent = l_parents.item then
									l_from_features_list := True
									l_inherit_info := found_item.features [i]
								else
									i := i + 1
								end
							end

							if not l_from_features_list then
								from
									i := 1
									l_count := found_item.deferred_features.count
								until
									i > l_count or else l_inherit_info /= Void
								loop
									if not found_item.deferred_features [i].renaming_processed and then found_item.deferred_features [i].parent = l_parents.item then
										l_inherit_info := found_item.deferred_features [i]
									else
										i := i + 1
									end
								end
							end

							if not l_inherit_info.renaming_processed then
									-- We have found the inherit info object to be renamed

								new_name_id := l_parents.item.renaming.item_for_iteration.feature_name_id
								new_alias_name_id := l_parents.item.renaming.item_for_iteration.alias_name_id

									-- Instantiate then copy if aliased.
								if l_inherit_info.a_feature_needs_instantiation then
									l_inherit_info.delayed_instantiate_a_feature
								end
								l_inherit_info.copy_a_feature_for_feature_table

									-- Move the inherit feature information under
									-- 'new_name'.
								l_inherit_info.a_feature.set_renamed_name_id (new_name_id, new_alias_name_id)
								l_inherit_info.a_feature.set_has_convert_mark (l_parents.item.renaming.item_for_iteration.has_convert_mark)

									-- Update feature flags.
									-- Identifier feature.
								l_inherit_info.a_feature.set_is_infix (False)
								l_inherit_info.a_feature.set_is_prefix (False)
									-- Assume a feature name without aliases.
								l_inherit_info.a_feature.set_is_binary (False)
								l_inherit_info.a_feature.set_is_bracket (False)
								l_inherit_info.a_feature.set_is_parentheses (False)
								l_inherit_info.a_feature.set_is_unary (False)
								if attached new_alias_name_id then
										-- Update information for aliases.
									across
										new_alias_name_id as a
									loop
										if a.item = {PREDEFINED_NAMES}.bracket_symbol_id then
												-- Bracket alias.
											l_inherit_info.a_feature.set_is_bracket (True)
										elseif a.item = {PREDEFINED_NAMES}.parentheses_symbol_id then
												-- Parenthesis alias.
											l_inherit_info.a_feature.set_is_parentheses (True)
										elseif l_inherit_info.a_feature.argument_count = 0 then
												-- Unary operator.
											l_inherit_info.a_feature.set_is_unary (True)
										else
												-- Binary operator.
											l_inherit_info.a_feature.set_is_binary (True)
										end
									end
								end
									-- Remove the inherit info from its old location
								if l_from_features_list then
									found_item.features.remove_i_th (i)
								else
									found_item.deferred_features.remove_i_th (i)
								end
									-- If old feature has no remaining features then remove from `Current'.
								if found_item.is_empty then
									found_item.reset
									remove (l_old_feature_name_id)
								end

									-- Add renamed feature back to `Current' with new name.
								search (new_name_id)
								if not found then
									put (inherit_feat_cache.new_inherit_feat, new_name_id)
								end
								found_item.insert (l_inherit_info)

									-- Mark it as processed so that it doesn't get reiterated.
								l_inherit_info.set_renaming_processed
							end
						end
						l_parents.item.renaming.forth
					end
				end
				l_parents.forth
			end
		end

	uninitialized_features: ARRAYED_LIST [INHERIT_FEAT]
			-- Iteration position for features that have yet to have their feature ids initialized.
		once
			create Result.make (35)
		end

	used_feature_ids: SEARCH_TABLE [INTEGER]
			-- Search table for used feature id's
		once
			create Result.make (35)
		end

	add_to_inherit_table (a_inherit_info: INHERIT_INFO)
			-- Add renamed feature referenced in `a_inherit_info'.
		local
			f: FEATURE_I
		do
			f := a_inherit_info.a_feature
			inherited_features.put (f, f.feature_name_id, a_inherit_info.a_feature_aliased)
			if f.has_alias then
				check_alias_name_conflict (f)
			end
		end

	add_renamed_feature (info: INHERIT_INFO; feature_name_id: INTEGER)
			-- Adds a renamed inherited feature in the table.
		do
			search (feature_name_id)
			if not found then
				put (inherit_feat_cache.new_inherit_feat, feature_name_id)
			end
			found_item.insert (info)
		end

	analyze
			-- Analyze inherited features: the renamings must have
			-- been treated before
		require
			a_class /= Void;
			feature_table /= Void;
		local
			inherit_feat: INHERIT_FEAT;
			l_check_undefinition, l_check_redefinition: BOOLEAN
			l_adaptations: like adaptations
			l_origin_table: like origin_table
			l_compilation_straight: BOOLEAN
			l_uninitialized_features: like uninitialized_features
			l_used_feature_ids: like used_feature_ids
			l_feature_id, l_highest_feature_id: INTEGER
		do
			from
				l_compilation_straight := System.compilation_straight

					-- Wipe out previous meta information.
				l_used_feature_ids := used_feature_ids
				l_used_feature_ids.wipe_out
				l_uninitialized_features := uninitialized_features
				uninitialized_features.wipe_out

				l_adaptations := adaptations
				l_origin_table := origin_table

					-- Determining whether to check features for undefinition and redefinition
				l_check_undefinition := parents.are_features_undefined
				l_check_redefinition := parents.are_features_redefined
					-- Iteration on the structure.
				start
			until
				after
			loop
				inherit_feat := item_for_iteration

					-- Calculates attribute `inherited_feature' of
					-- instance `inherit_feat'.
				inherit_feat.process (a_class, key_for_iteration, l_check_undefinition, l_check_redefinition)
				if inherit_feat.inherited_info /= Void then
						-- Feature is coming from a single parent.
						-- Initialize (without feature id processing) then insert into origin table
						-- We add to `Current' later due to aliasing processing.
					init_inherited_feature (inherit_feat.inherited_info, inherit_feat, False)
					if
						not inherit_feat.inherited_info.internal_a_feature.is_deferred and then
						inherit_feat.deferred_features.count > 0
					then
							-- Case of an implementation of inherited deferred
							-- features by an inherited non-deferred feature.
							-- Reset assertions of `feature_i'
							-- Make sure that feature_i is not aliased.
						inherit_feat.inherited_info.copy_a_feature_for_feature_table
						l_adaptations.extend (create {DEFINITION}.make (inherit_feat, inherit_feat.inherited_info));
					else
						l_origin_table.insert (inherit_feat.inherited_info);
					end
						-- Attempt to reuse feature id for aliasing
					if l_compilation_straight and then inherit_feat.inherited_info.a_feature_aliased then
						l_feature_id := inherit_feat.inherited_info.a_feature.feature_id
						if not l_used_feature_ids.has (l_feature_id) then
								-- We can reuse the feature id for this aliased feature.
							add_to_inherit_table (inherit_feat.inherited_info)
							l_used_feature_ids.put (l_feature_id)
							l_highest_feature_id := l_highest_feature_id.max (l_feature_id)
						else
							l_uninitialized_features.extend (inherit_feat)
						end
					else
						l_uninitialized_features.extend (inherit_feat)
					end
				end
				forth
			end

				-- Add all unaliased features to `Current'.
			from
				l_uninitialized_features.start
					-- Set `l_feature_id' to zero so that it gets correctly set to 1 when it enters the loop
				l_feature_id := 0
			until
				l_uninitialized_features.after
			loop
				if l_compilation_straight then
						-- Retrieve next available feature id.
					from
							-- Use previous `l_feature_id' to prevent reiterating `l_used_feature_ids'
						l_feature_id := l_feature_id + 1
					until
						not l_used_feature_ids.has (l_feature_id)
					loop
						l_feature_id := l_feature_id + 1
					end
					l_highest_feature_id := l_highest_feature_id.max (l_feature_id)

						-- Add to used_feature_ids so that it cannot be reused.
					l_used_feature_ids.put (l_feature_id)

						-- Set feature id and add to `Current'.
					l_uninitialized_features.item.inherited_info.copy_a_feature_for_feature_table
					l_uninitialized_features.item.inherited_info.a_feature.set_feature_id (l_feature_id)
					add_to_inherit_table (l_uninitialized_features.item.inherited_info)
				else
					assign_feature_id_and_insert (l_uninitialized_features.item.inherited_info)
				end
				l_uninitialized_features.forth
			end

			if l_compilation_straight then
				a_class.feature_id_counter.set_value (l_highest_feature_id)
			end
		end

	analyze_declarations
			-- Analyze local declarations written in the class for a
			-- syntactically changed class.
		local
			feature_clause: FEATURE_CLAUSE_AS
			features: EIFFEL_LIST [FEATURE_AS]
				-- Reference on the feature list produced by the first pass
			single_feature: FEATURE_AS
				-- Single standard Eiffel feature
			name_list: EIFFEL_LIST [FEATURE_NAME]
				-- Attribute list names
			feature_i: FEATURE_I
			feat_name: FEATURE_NAME
			l_export_status: EXPORT_I
			property_name: STRING
			property_names: HASH_TABLE [FEATURE_I, STRING]
			unique_counter: COUNTER
			creation_index_name: FEATURE_NAME
			n: like class_info.creators.count
		do
			if attached class_info.features as clauses then
				if system.il_generation then
					create property_names.make (0)
				end
				if a_class.has_unique then
					create unique_counter
				end
				across
					clauses as c
				loop
					feature_clause := c.item
						-- Evaluation of the export status
					l_export_status := export_status_generator.
						feature_clause_export_status (system, a_class, feature_clause)
					from
							-- Iteration of the feature written in class
							-- `a_class'.
						features := feature_clause.features
						features.start
					until
						features.after
					loop
						single_feature := features.item
						from
							name_list := single_feature.feature_names
							name_list.start
						until
							name_list.after
						loop
							feat_name := name_list.item
								-- Computes an internal name for the feature
								-- taking care of prefix/infix notations
							feature_i := feature_i_from_feature_as (single_feature, feat_name, unique_counter)
								-- Attributes `body_index', `feature_name' and
								-- `written_in' are ok now. If it is an old
								-- instance of FEATURE_I from a previous
								-- compilation, we know if it was an origin.
							analyze_local_feature_declaration (feature_i, feature_i.feature_name_id, l_export_status)
							if
								attached property_names and then
									-- Check that there are no property name clashes
								feature_i.has_property
							then
								property_name := single_feature.property_name
								if property_name = Void or else property_name.is_empty then
										-- Use implicit property name.
									property_name := il_casing.pascal_casing
											(system.dotnet_naming_convention, feature_i.feature_name, {IL_CASING_CONVERSION}.lower_case)
								end
								if property_names.has (property_name) then
									error_handler.insert_error (create {VIPM}.make
											(a_class, feature_i, property_names.item (property_name), property_name))
								else
									property_names.put (feature_i, property_name)
								end
									-- Check that there are no property setters with
									-- several arguments as order of the arguments is
									-- different in Eiffel and IL.
								if feature_i.has_property_setter and then
									(feature_i.type.is_void and then feature_i.argument_count /= 1 or else
										not feature_i.type.is_void and then feature_i.argument_count > 0)
								then
									error_handler.insert_error (create {VIPS}.make (a_class, feature_i))
								end
							end
							name_list.forth
						end
						features.forth
					end
				end
			end
			if a_class.is_once then
					-- Add an attribute to keep an index of a creation procedure.
				n := class_info.creators.count
				create {FEATURE_NAME} creation_index_name.initialize (create {ID_AS}.initialize_from_id (names_heap.inspect_attribute_name_id))
				feature_i := feature_i_from_feature_as
						(create {FEATURE_AS}.initialize
							(create {EIFFEL_LIST [FEATURE_NAME]}.make_from_iterable (<<creation_index_name>>),
							create {BODY_AS}.initialize
								(Void,
								create {CLASS_TYPE_AS}.initialize (create {ID_AS}.initialize
											-- TODO: Replace manifest type names with computed names to take possible renaming into account.
										(if n <= 0xFF then
											"NATURAL_8"
										elseif n <= 0xFFFF then
											"NATURAL_16"
										elseif n <= 0xFFFF_FFFF then
											"NATURAL_32"
										else
											"NATURAL_64"
										end)),
								Void, Void, Void, Void, Void, Void),
							Void,
							0,
							a_class.ast.end_position),
						creation_index_name,
						Void)
				feature_i.set_is_hidden (True)
				analyze_local_feature_declaration (feature_i, feature_i.feature_name_id, export_none)
			end
		end

	recompute_declarations
			-- Recompute local declarations for a non-syntactically changed
			-- class.
		require
			good_class: a_class /= Void
			non_syntactically_changed: a_class.changed2
		local
			feature_i: FEATURE_I
			feature_name_id: INTEGER
			id: INTEGER
		do
			from
				id := a_class.class_id
				feature_table.start
			until
				feature_table.after
			loop
				feature_i := feature_table.item_for_iteration
				if feature_i.written_in = id then
					feature_name_id := feature_i.feature_name_id
						-- Recompute a former local declaration.
					analyze_local_feature_declaration (feature_i.duplicate, feature_name_id, feature_i.immediate_export_status)
				end
				feature_table.forth
			end
		end

	analyze_local_feature_declaration (feature_i: FEATURE_I; feature_name_id: INTEGER; immediate_export_status: EXPORT_I)
			-- Analyze local declaration of class `a_class' named
			-- `feat_name' which abstract representation is `yacc_feature'.
		require
			good_feature: feature_i /= Void;
			good_feature_name_id: feature_name_id > 0
		local
			inherit_feat: INHERIT_FEAT
				-- Possible inherited features
			old_feature: FEATURE_I
			new_rout_id: INTEGER
			new_rout_id_set: ROUT_ID_SET
			redef: REDEFINITION
			info, inherited_info: INHERIT_INFO
			vmfn: VMFN
			vmfn1: VMFN1
			compute_new_rout_id: BOOLEAN
			export_status: EXPORT_I
		do
			export_status := immediate_export_status
				-- Now, compute the routine id set of the feature.
			inherit_feat := item (feature_name_id)

				-- Find out if there previously was a feature with name
				-- `feature_name'
			old_feature := feature_table.item_id (feature_name_id)

			if inherit_feat = Void then
					-- No feature inherited under name `feature_name'. This
					-- deserves a brand new origin.
				if feature_i.is_origin then
						-- An old feature from a previous compilation was
						-- an origin. Keep the current routine id.
					new_rout_id_set := feature_i.rout_id_set
					check
						rout_id_set_exists: new_rout_id_set /= Void
						has_only_one: new_rout_id_set.count = 1
					end
					new_rout_id := new_rout_id_set.first
					compute_new_rout_id :=
						feature_i.is_attribute /= Routine_id_counter.is_attribute (new_rout_id)
				else
					if
						old_feature /= Void and then not old_feature.is_origin
					then
							-- We changed the origin of the feature, we need to
							-- mark the feature as changed since its assertions
							-- could have been changed even though its body did
							-- not changed
						changed_features.extend (feature_name_id)
					end
					feature_i.set_is_origin (True)
						-- There are no inherited assertions anymore (if there were any).
					feature_i.set_assert_id_set (Void)
					compute_new_rout_id := True
				end
				if compute_new_rout_id then
					create new_rout_id_set.make
					new_rout_id := feature_i.new_rout_id
					new_rout_id_set.put (new_rout_id)
					feature_i.set_rout_id_set (new_rout_id_set)
				end
					-- Insertion into the system routine info table.
				System.rout_info_table.put (new_rout_id, a_class)
				info := inherit_info_cache.new_inherited_info (feature_i, Void, Void)
			else
					-- This is either an explicit redefinition through
					-- the redefine clause or an implicit redefinition like
					-- an implementation of deferred features
				inherited_info := inherit_feat.inherited_info
				if inherited_info = Void then
						-- Implicit or explicit redefinition
					new_rout_id_set := inherit_feat.rout_id_set.twin
						-- This is not an origin.
					feature_i.set_is_origin (False)
					if
						old_feature /= Void and then old_feature.is_origin
					then
							-- We changed the origin of the feature, we need to
							-- mark the feature as changed since its assertions
							-- could have been changed even though its body did
							-- not change.
						changed_features.extend (feature_name_id)
					end
						-- Routine id set for the redefinition
					if
						attached feature_i.rout_id_set as l_id_set and then
						not l_id_set.same_as (new_rout_id_set)
					then
							-- The routine is not exactly the same even if it has kept
							-- its original implementation. Most likely new routines
							-- have been merged resulting in a different ROUT_ID_SET.
						changed_features.extend (feature_name_id)
					end
					feature_i.set_rout_id_set (new_rout_id_set);
						-- Mark the redefinition to be done.
						-- We pass `feature_i' as creation routine to
						-- satisfy INHERIT_INFO invariant, but this is
						-- not the correct value. The correct one will
						-- will be set later by one of the routine that
						-- calls `set_a_feature' from INHERIT_INFO.
					info := inherit_info_cache.new_inherited_info (feature_i, Void, Void)
					inherit_feat.set_inherited_info (info)
						-- Store the redefinition for later
					create redef.make (inherit_feat, info)
					adaptations.put_front (redef)
					export_status := export_status.concatenation (inherit_feat.exports (feature_name_id))
				elseif inherited_info.parent = Void then
						-- The feature has two implementations in the class
					create vmfn
					vmfn.set_class (a_class)
					vmfn.set_a_feature (feature_i)
					vmfn.set_inherited_feature (inherited_info.internal_a_feature)
					Error_handler.insert_error (vmfn)
				else
						-- Name clash: a non-deferred feature is inherited
					create vmfn1
					vmfn1.set_class (a_class)
					vmfn1.set_a_feature (feature_i)
					vmfn1.set_inherited_feature (inherited_info.internal_a_feature)
					vmfn1.set_parent (inherited_info.parent.parent)
					Error_handler.insert_error (vmfn1)
				end
			end
			if info /= Void then
				if old_feature = Void then
						-- Since the old feature table hasn't a feature named
						-- `feature_name', new feature id for the feature
					feature_i.set_feature_id (retrieve_feature_id (feature_i))
				else
						-- Take the previous feature id
					feature_i.set_feature_id (old_feature.feature_id)
					if
						old_feature.written_in = a_class.class_id and then
						((feature_i.is_attribute and not old_feature.is_attribute) or else
							(feature_i.is_deferred and then not old_feature.is_deferred) or else
							(feature_i.is_attribute and old_feature.is_attribute and feature_i.is_origin /= old_feature.is_origin))
					then
						System.execution_table.add_dead_function (old_feature.body_index)
					end
				end
					-- Put new feature in `inherited_features'.
				insert_feature (feature_i)
					-- Put the new feature written in the current class
					-- in the origin table
				if redef = Void then
					info.set_a_feature (feature_i)
					Origin_table.insert (info)
				end
			end

				-- Keep track of the origin features for pattern
				-- processing
			origins.extend (feature_i.feature_name_id)
				-- Update export status of the feature.
			feature_i.set_immediate_export_status (export_status, immediate_export_status)
		end

	feature_i_from_feature_as (yacc_feature: FEATURE_AS; feat: FEATURE_NAME; a_unique_counter: detachable COUNTER): FEATURE_I
			-- Feature correponding to declaration `yacc_feature'.
			-- If we found a feature named `feature_name' in a previous
			-- feature table, don't change of feature id. If this previous
			-- feature didn't change, keep the body id, otherwise compute
			-- a new body id.
		require
			syntactically_changed: a_class.changed;
		local
			old_feature_i: FEATURE_I
			unique_feature: UNIQUE_I
				-- Feature coming from a previous recompilation
			body_index: INTEGER
				-- Body index of a previous compiled feature
			old_description, old_tmp_description: FEATURE_AS
				-- Abstract representation of a previous compiled feature
			is_the_same: BOOLEAN
				-- Is the parsed feature the same than a previous
				-- compiled one ?
			feature_name_id: INTEGER
				-- Internal name of the feature
			alias_name_ids: like {FEATURE_I}.alias_name_ids
			integer_value: INTEGER_CONSTANT
			vffd4: VFFD4
		do
			feature_name_id := feat.feature_name.name_id
			debug ("ACTIVITY")
				io.error.put_string ("FEATURE_UNIT on ");
				io.error.put_string (feat.feature_name.name);
				io.error.put_new_line;
			end;

			Result := feature_i_generator.new_feature (yacc_feature, feature_name_id, a_class)
			if attached {FEATURE_NAME_ALIAS_AS} feat as l_alias_feat then
				create alias_name_ids.make_empty (l_alias_feat.aliases.count)
				across
					l_alias_feat.aliases as ic
				loop
					check is_alias_id (ic.item.id) end
					alias_name_ids.extend (ic.item.id)
				end
				Result.set_feature_name_id (feature_name_id, alias_name_ids)
				Result.set_has_convert_mark (l_alias_feat.has_convert_mark)
			else
				Result.set_feature_name_id (feature_name_id, Void)
			end
			Result.set_written_in (a_class.class_id)
			Result.set_is_frozen (feat.is_frozen)
			Result.set_is_infix (False) -- FIXME: remove? [2019-09-30]
			Result.set_is_prefix (False) -- FIXME: remove? [2019-09-30]
			Result.set_is_bracket (feat.has_bracket_alias)
			Result.set_is_parentheses (feat.has_parentheses_alias)
			Result.set_is_binary (feat.is_binary)
			Result.set_is_unary (feat.is_unary)

			if Result.is_unique and attached {UNIQUE_I} Result as l_unique_i then
				unique_feature := l_unique_i
					-- Unique value processing
				create integer_value.make_with_value (a_unique_counter.next)
				if integer_value.valid_type (unique_feature.type) then
					integer_value.set_real_type (unique_feature.type)
				else
						-- The value cannot be represented using specified integer type.
					error_handler.insert_error (create {VQUI2}.make (a_class, Result.feature_name, Result.type))
				end
				unique_feature.set_value (integer_value)
			elseif Result.is_c_external and attached {EXTERNAL_I} Result as external_i then
					-- Track new externals introduced in the class. Freeze is taken care by
					-- EXTERNALS.is_equivalent queried by SYSTEM_I.
				pass2_control.add_external (external_i)
			end

				-- Look for a previous definition of the feature
			old_feature_i := feature_table.item_id (feature_name_id);

			if old_feature_i /= Void then
				if old_feature_i.written_in = a_class.class_id then

					if old_feature_i.is_deferred /= Result.is_deferred then
							-- We have changed the deferred status of an origin so a new body index needs to be
							-- generated.
						body_index := Body_index_counter.next_id
					else
						body_index := old_feature_i.body_index

							-- Found a feature of same name and written in the
							-- same class.
						old_description := body_server.server_item (a_class.class_id, body_index)
						if old_description = Void then
								-- This should not happen, but if it does.
							is_the_same := False
						else
							if not tmp_ast_server.has (a_class.class_id) then
									-- We could get an old body from the previous compilation, but `a_class'
									-- was added back to degree 4 even though it was not re-parsed. This happens
									-- whenever there is a call to `{CLASS_I}.set_changed' and that the class
									-- is added back to degree 4.
									-- For example, when signature of a routine changes and that routine is
									-- used as part of a qualified anchored type (See eweasel test#incr353
									-- to reproduce the scenario).
									-- Or when a class has some replicated features.

									-- We force a load of the AST into the `Tmp_ast_server'
								Tmp_ast_server.load (a_class)
							end

							old_tmp_description := Tmp_ast_server.body_item (a_class.class_id, body_index)

								-- Incrementality of the workbench is here: we
								-- compare the content of a new feature and the
								-- one of an old feature.
							is_the_same := old_description.is_assertion_equiv (yacc_feature) and
								(old_tmp_description /= Void implies old_tmp_description.is_assertion_equiv (yacc_feature))
						end

						if not is_the_same then
								-- assertions have changed
							if assert_prop_list = Void then
									-- Create a new assertion list if first change.
								create assert_prop_list.make;
							end

							assert_prop_list.extend (old_feature_i.rout_id_set.first)

								-- FIXME: Manu 08/05/2004: It is a pain to have to freeze each
								-- time you change an assertion from an external routine, but
								-- this is required for the moment (as call to external routine
								-- is not done in generated byte code).
								-- The solution is to separate the Eiffel encapsulation from
								-- the external encapsulation and have the melted code call the
								-- tiny external encapsulation.
							if old_feature_i.is_external then
								System.request_freeze
							end
						else
							is_the_same := old_description.is_body_equiv (yacc_feature) and
								(old_tmp_description /= Void implies old_tmp_description.is_body_equiv (yacc_feature))
								-- Same interface does NOT work: the types must be resolved first
								-- The check is done later anyway

								--and then Result.same_interface (feature_i);
							if is_the_same and unique_feature /= Void then
								is_the_same := old_feature_i.is_unique and then
									unique_feature.same_value (old_feature_i)
							end;
								-- If they seems the same, let's have a look at the previous signature
								-- as maybe it is not valid anymore in which case it clearly is not the
								-- same routine. Or let's check they really have the same signature.
								-- This fixes eweasel test#incr347.
							if is_the_same and old_feature_i.is_valid then
								is_the_same := not Result.is_type_evaluation_delayed and then old_feature_i.same_signature (Result)
							end
						end;

							-- If old representation written in the class,
							-- keep the fact the old feature from a previous
							-- is an origin or not.
						Result.set_is_origin (old_feature_i.is_origin);
						Result.set_rout_id_set (old_feature_i.rout_id_set.twin)
					end
				else
						-- new feature => new body_index
					body_index := Body_index_counter.next_id
				end

				Result.set_body_index (body_index)
				if
					not is_the_same or else
					(supplier_status_modified and then
						not Degree_4.changed_status.disjoint (old_feature_i.suppliers))
					-- The status of one of the suppliers of the feature has changed
				then
					debug ("ACTIVITY")
						io.error.put_string ("Is the same ");
						io.error.put_boolean (is_the_same);
						io.error.put_string ("%Nsupplier_status_modified ");
						io.error.put_boolean (supplier_status_modified);
						io.error.put_string ("%Nchanged status ");
						io.error.put_boolean (not Degree_4.changed_status.disjoint (old_feature_i.suppliers));
						io.error.put_string ("%Nold_feature_in_class ");
						io.error.put_new_line;
					end;

						-- Update `read_info' in BODY_SERVER
					if body_index > 0 then
						Tmp_ast_server.body_force (a_class.class_id, yacc_feature, body_index)
					else
						check
							feature_is_il_external: old_feature_i.extension /= Void
								and then old_feature_i.extension.is_il
						end
						Tmp_ast_server.body_force (a_class.class_id, yacc_feature, external_body_index)
					end

						-- Insert the changed feature in the table of
						-- changed features of class `a_class'.
					changed_features.extend (feature_name_id);
				else
						-- Update `read_info' in BODY_SERVER
					Tmp_ast_server.body_force (a_class.class_id, yacc_feature, body_index)
				end;
			else
				Result.set_body_index (Body_index_counter.next_id)
				Tmp_ast_server.body_force (a_class.class_id, yacc_feature, Result.body_index)

					-- Insert the changed feature in the table of changed
					-- features of `a_class'.
				changed_features.extend (feature_name_id);
			end;

				-- Check incompatibily between `frozen' and `deferred'
			if Result.is_frozen and then Result.is_deferred then
					-- A deferred feature cannot be frozen
				create vffd4;
				vffd4.set_class (Result.written_class);
				vffd4.set_feature_name (Result.feature_name);
				Error_handler.insert_error (vffd4);
			end;
		end;

	clear
			-- Clear the second pass processor
		do
			previous_feature_table := Void;
			feature_table := Void;
			parents := Void;
			Origin_table.wipe_out;
			adaptations.wipe_out;
			changed_features.wipe_out;
			origins.wipe_out;
			invariant_changed := False;
			invariant_removed := False;
			assert_prop_list := Void;

			wipe_out
--			if capacity > 200 then
--				extend_tbl_make (default_size)
--			end
			create inherited_features.make (default_size)
		end;

	process_pattern (resulting_table: FEATURE_TABLE)
			-- Process pattern of features listed in `origins'.
			-- [We just have to compute pattern ids for origin features
			-- since for inherited features it is transmitted automatically
			-- by duplication of instances of FEATURE_I. For redeclarations,
			-- Through redeclarations, the pattern id cannot change: so
			-- the pattern id is updated in descendants of FEATURE_ADAPTATION]
		require
			good_argument: resulting_table /= Void;
		local
			l_origins: like origins
		do
			from
				l_origins := origins
				l_origins.start
			until
				l_origins.after
			loop
				resulting_table.item_id (l_origins.item).delayed_process_pattern
				l_origins.forth
			end;
		end;

	update_inherited_assertions
			-- Update assert_id_set for redefined or merged routines
			-- in adaptations.
		do
			; (create {REDEF_FEAT}).process (adaptations)
		end

	update_changed_features
			-- Update table `changed_features' of `a_class' after a
			-- successful second pass
		local
			i, l_count: INTEGER
		do
			from
				i := 1
				l_count := changed_features.count
			until
				i > l_count
			loop
				a_class.insert_changed_feature (changed_features [i]);
				i := i + 1
			end;
		end;

	update_convert_clause (
			a_old_convert, a_new_convert: HASH_TABLE [INTEGER, DEANCHORED_TYPE_A];
			a_resulting_table: FEATURE_TABLE)

			-- Take into account incremental changes in `convert' clauses.
		require
			a_class_not_void: a_class /= Void
			a_old_convert_not_void: a_old_convert /= Void
			a_resulting_table_not_void: a_resulting_table /= Void
		local
			l_feat_name_id: INTEGER
			l_depend_unit: DEPEND_UNIT
		do
			if a_new_convert = Void or else not a_old_convert.is_equal (a_new_convert) then
					-- Old convert clause is different from new one. For each routines previously
					-- specified in `a_old_convert' and not specified in `a_new_convert',
					-- we need to progagate to the classes that were using those routines
					-- so that the code is recompiled at degree 3 (for type checking purpose only).
				from
					a_old_convert.start
				until
					a_old_convert.after
				loop
					l_feat_name_id := a_old_convert.item_for_iteration
					a_resulting_table.search_id (l_feat_name_id)
					if
						a_resulting_table.found and
						(a_new_convert = Void or else not a_new_convert.has_item (l_feat_name_id))
					then
						create l_depend_unit.make (a_class.class_id, a_resulting_table.found_item)
						pass2_control.propagators.extend (l_depend_unit)
					end
					a_old_convert.forth
				end
			end
		end

	Routine_id_counter: ROUTINE_COUNTER
			-- Counter for routine ids
		once
			Result := System.routine_id_counter;
		end;

	Body_index_counter: BODY_INDEX_COUNTER
			-- Counter for bodies index
		once
			Result := System.body_index_counter;
		end;

	check_validity2
			-- Check if redefinitions are effectively done and joins deferred features if needed.
		require
			inherited_features /= Void;
		local
			deferred_info: INHERIT_INFO
			inherit_feat: INHERIT_FEAT
			p: PARENT_C
		do
			from
					-- We iterate 'count' times so as to only call 'forth' that number of times
					-- instead of 'count' + 1 which will iterate the entire 'content' structure.
				start
			until
				after
			loop
				inherit_feat := item_for_iteration
				if inherit_feat.inherited_info = Void then
					if inherit_feat.features.count > 0 then
							-- Cannot find a redefinition.
						Error_handler.insert_error (create {VDRS4_NO_REDECLARATION}.make (key_for_iteration, inherit_feat.features [1].parent, a_class))
					else
							-- Case of deferred features only
						check
							not inherit_feat.is_empty
						end
						deferred_info := inherit_feat.deferred_features.first
							-- New inherited feature

							-- Initialization of an inherited feature
						init_inherited_feature (deferred_info, inherit_feat, True)

						Origin_table.insert (deferred_info)
						if inherit_feat.deferred_features.count > 1 then
								-- Keep track of the feature adaptation.
								-- The deferred features must have the same
								-- signature
							adaptations.put_front (create {JOIN}.make (inherit_feat, deferred_info))
						end
					end
				else
						-- Inherited info has been set
					if inherit_feat.inherited_info.internal_a_feature.written_in = a_class.class_id then
							-- The feature is declared in the current class.
						if
							not inherit_feat.inherited_info.internal_a_feature.is_deferred and then
							inherit_feat.has_deferred
						then
								-- A redeclaration into an effective feature.
								-- It should not be a redefinition of a deferred feature.
							across
								inherit_feat.deferred_features as f
							loop
								p := f.item.parent
								if
									p.is_redefining (f.item.internal_a_feature.feature_name_id) and then
										-- Report the error only if all features inherited from this parent are deferred.
									∀ e: inherit_feat.features ¦ e.parent /= p
								then
									Error_handler.insert_error (create {VDRS4_EFFECTING}.make (f.item.internal_a_feature.feature_name_id, p, a_class))
								end
							end
						end
					else
						if inherit_feat.features.count > 1 then
								-- We have a repeatedly inherited feature that is not defined in current class.
								-- We need to check for any erroneous redefinitions, if so then raise VDRS-4 error.
							across
								inherit_feat.features as f
							loop
								p := f.item.parent
								if p.is_redefining (f.item.internal_a_feature.feature_name_id) then
										-- We have an erroneous redefinition.
									Error_handler.insert_error (create {VDRS4_NO_REDECLARATION}.make (f.item.internal_a_feature.feature_name_id, p, a_class))
								end
							end
						end
						if inherit_feat.has_deferred then
							across
								inherit_feat.deferred_features as f
							loop
								p := f.item.parent
								if p.is_redefining (f.item.internal_a_feature.feature_name_id) then
										-- We have an erroneous redefinition.
									Error_handler.insert_error (create {VDRS4_NO_REDECLARATION}.make (f.item.internal_a_feature.feature_name_id, p, a_class))
								end
							end
						end
					end
				end
				forth
			end
		end

	init_inherited_feature (inherit_info: INHERIT_INFO; inherit_feat: INHERIT_FEAT; a_add_to_table: BOOLEAN)
			-- Initialization of an inherited feature
		require
			a_feature_valid: inherit_info /= Void and then inherit_info.internal_a_feature /= Void
			inherit_feat_not_void: inherit_feat /= Void
		local

			l_export_status, l_old_export_status: EXPORT_I
		do
				-- Make sure that inherit info is instantiated if not already done so.
			if inherit_info.a_feature_needs_instantiation then
				inherit_info.delayed_instantiate_a_feature
			end

			if inherit_info.a_feature.is_origin then
					-- It is no more an origin
					--| FIXME IEK: This needs to be rewritten as a feature is still an origin if inherited.
					--| This also means that features directly inherited from ANY are not aliased.
				inherit_info.copy_a_feature_for_feature_table
				inherit_info.a_feature.set_is_origin (False)
			end

			if inherit_info.a_feature.is_replicated_directly then
					-- Reset direct replication flag as this cannot be aliased.
				inherit_info.copy_a_feature_for_feature_table
				inherit_info.a_feature.set_is_replicated_directly (False)
			end

			if inherit_info.a_feature.has_property then
					-- We need to aliasing if not already done
				inherit_info.copy_a_feature_for_feature_table
				inherit_info.a_feature.set_has_property (False)
				if
					a_class.is_single and then
						-- Feature getters and setters may have been generated so we reset.
					attached inherit_feat.inherited_info as i and then
					i.parent.parent.is_single
				then
					inherit_info.a_feature.set_has_property_getter (False)
					inherit_info.a_feature.set_has_property_setter (False)
				end
			end

				-- Copy over the rout_id_set if different from inherited routine.
			if not inherit_feat.rout_id_set.is_equal (inherit_info.a_feature.rout_id_set) then
				inherit_info.copy_a_feature_for_feature_table
				inherit_info.a_feature.set_rout_id_set (inherit_feat.rout_id_set.twin)
			end

				-- Concatenation of the export statuses of all the
				-- precursors of the inherited feature: take care of new
				-- adapted export status specified in inheritance clause
			l_old_export_status := inherit_info.a_feature.export_status
			l_export_status := inherit_feat.exports (inherit_info.a_feature.feature_name_id)
			if
				l_old_export_status /= l_export_status
				and then not (l_old_export_status.is_all and l_export_status.is_all)
				and then not (l_old_export_status.is_none and l_export_status.is_none)
			then
				inherit_info.copy_a_feature_for_feature_table
				inherit_info.a_feature.set_export_status (l_export_status)
			end

			if a_add_to_table then
				assign_feature_id_and_insert (inherit_info)
			end
		end

	assign_feature_id_and_insert (a_inherit_info: INHERIT_INFO)
		local
			old_feature: FEATURE_I
			l_new_feature_id, l_current_feature_id: INTEGER
			l_feature_is_aliased: BOOLEAN
			l_compilation_straight: BOOLEAN
		do
			l_feature_is_aliased := a_inherit_info.a_feature_aliased
				-- Process feature id
			l_compilation_straight := System.compilation_straight
			if not l_compilation_straight then
				old_feature := feature_table.item_id (a_inherit_info.a_feature.feature_name_id)
			end
			if old_feature = Void then
					-- New feature id since the old feature table
					-- doesn't have an entry `feature_name'
				l_new_feature_id := retrieve_feature_id (a_inherit_info.a_feature)
			else
					-- Take the old feature id
				l_new_feature_id := old_feature.feature_id
				if
					old_feature.can_be_encapsulated and then
					old_feature.to_generate_in (a_class)
				then
						-- If it is an attribute that was generated in `a_class',
						-- we have to redo mark it dead as an encapsulation. `is_valid'
						-- on its execution unit will tell us if we still need the
						-- encapsulation or not.
					system.execution_table.add_dead_function (old_feature.body_index)
				end
			end

			l_current_feature_id := a_inherit_info.a_feature.feature_id

				-- Set feature id if different than current
			if l_current_feature_id /= l_new_feature_id then
				a_inherit_info.copy_a_feature_for_feature_table
				a_inherit_info.a_feature.set_feature_id (l_new_feature_id)
			end

				-- Insert it in the table `inherited_features'.
			add_to_inherit_table (a_inherit_info)
		end

	unused_feature_id_table: SEARCH_TABLE [INTEGER]
			-- Table for storing unused feature ids of current class.
		once
			create Result.make (35)
		end

	retrieve_feature_id (f: FEATURE_I): INTEGER
			-- Retrieve a feature id for `f', generate a new one
			-- if `a_new', otherwise return 0.
		require
			good_argument: f /= Void;
			has_a_new_name: not feature_table.has_id (f.feature_name_id);
		local
			old_feature: FEATURE_I;
		do
			if previous_feature_table /= Void then
				old_feature := previous_feature_table.item_id (f.feature_name_id);
				if old_feature /= Void then
						-- Keep the feature id, because byte code for client
						-- features using this new feature name could have been
						-- already computed.
					Result := old_feature.feature_id
				else
					Result := a_class.feature_id_counter.next;
				end
			else
				Result := a_class.feature_id_counter.next;
			end;
		end

	check_validity3 (resulting_table: FEATURE_TABLE)
			-- Check the signature conformance of the redefinitions and
			-- validity of joins; check assigner command validity.
		do
			from
				adaptations.start
			until
				adaptations.after
			loop
				adaptations.item.check_adaptation (resulting_table)
				adaptations.forth
			end
			from
				resulting_table.start
			until
				resulting_table.after
			loop
				if resulting_table.item_for_iteration.assigner_name_id /= 0 then
					resulting_table.item_for_iteration.delayed_check_assigner (resulting_table)
				end
				resulting_table.forth
			end
		end

	process_redeclarations (resulting_table: FEATURE_TABLE)
			-- Check redeclarations into an attribute.
		do
			from
				adaptations.start
			until
				adaptations.after
			loop
				adaptations.item.check_redeclaration (resulting_table, feature_table, origins)
				adaptations.forth
			end;
		end;

	insert_feature (f: FEATURE_I)
			-- Insert `f' in `inherited_feature'
		require
			good_argument: f /= Void
		local
			feature_name_id: INTEGER
			vmfn: VMFN
		do
			feature_name_id := f.feature_name_id
			inherited_features.put (f, feature_name_id, False)
			if inherited_features.conflict then
				create vmfn
				vmfn.set_class (a_class)
				vmfn.set_a_feature (f)
				vmfn.set_inherited_feature (inherited_features.item_id (feature_name_id))
				Error_handler.insert_error (vmfn)
			elseif f.has_alias then
				check_alias_name_conflict (f)
			end
		end

	compute_invariant
			-- Compute invariant clause
		require
			good_context: not (a_class = Void or else class_info = Void)
			changed: a_class.changed
		local
			class_id: INTEGER
				-- information left by the temporary server `Tmp_ast_server'
				-- and stored in `class_info'
			old_invar_clause, invar_clause: INVARIANT_AS
		do
				-- First: check is the invariant clause of the current
				-- class has syntactically changed. If yes, flag
				-- `changed5' of `a_class' is set to True.
			class_id := a_class.class_id
				-- Look in the non-temporary invariant AST server for
				-- for an old invariant clause
			old_invar_clause := inv_ast_server.server_item (class_id)
			invar_clause := tmp_ast_server.invariant_item (class_id)
			if invar_clause /= Void then
					-- The changed class `a_class' has an invariant clause
				if old_invar_clause /= Void then
						-- Incrementality test on invariant clause
					invariant_changed := not invar_clause.is_equivalent (old_invar_clause)
				else
					invariant_changed := True
				end
			elseif old_invar_clause /= Void or a_class.has_invariant then
				invariant_removed := True
				tmp_ast_server.invariant_remove (class_id)
			end
		end

feature {NONE} -- Implementation

	compute_main_parent (a_feat_tbl: FEATURE_TABLE)
			-- Set `number_of_features' and `main_parent' of `a_class'
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			il_generation: System.il_generation
		local
			l_parent, l_main_parent: CLASS_C
			l_number_of_features, l_max: INTEGER
		do
			from
				parents.start
			until
				parents.after
			loop
				l_parent := parents.item.parent
				if l_parent.is_single or (l_parent.is_external and not l_parent.is_interface) then
						-- We cannot optimize here, we have to take it
						-- as main parent even if there is no feature in it.
					l_main_parent := l_parent
					parents.finish
				else
					l_number_of_features := l_parent.feature_table.count
					if l_number_of_features > l_max then
						l_main_parent := parents.item.parent
						l_max := l_number_of_features
					end
				end
				parents.forth
			end
			if l_main_parent = Void then
					-- No parents, means that we are handling ANY.
				l_main_parent := a_class
			end
			a_class.set_main_parent (l_main_parent)
			a_class.set_number_of_features (a_feat_tbl.count)
		ensure
			main_parent_set: a_class.main_parent /= Void
			nb_features_set: a_class.number_of_features = a_feat_tbl.count
		end

	check_alias_name_conflict (f: FEATURE_I)
			-- Check if feature after `f' has been added to `inherited_features'
			-- `inherited_features.is_alias_conflict' is set to `true'. Report error in this case.
		require
			f_attached: f /= Void
			f_has_alias_name: f.has_alias
		local
			vfav: VFAV
		do
			if inherited_features.is_alias_conflict then
				if f.is_bracket then
					create {VFAV2} vfav
				elseif f.is_parentheses then
					create {VFAV3} vfav
				else
					create {VFAV1} vfav
				end
				vfav.set_class (a_class)
				vfav.set_a_feature (f)
				vfav.set_inherited_feature (inherited_features.item_alias_id (inherited_features.conflicting_alias))
				Error_handler.insert_error (vfav)
			end
		end

feature {NONE} -- Temporary body index

	external_body_index: INTEGER
			-- Dummy body index to be used when someone redefine an external feature
			-- with no body (i.e. an IL external).
		once
			Result := Body_index_counter.next_id
		ensure
			external_body_index_positive: Result > 0
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
