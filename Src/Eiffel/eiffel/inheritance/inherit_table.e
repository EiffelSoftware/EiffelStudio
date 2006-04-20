indexing
	description: "[
		Table of inherited features indexed by name ID: feature `pass2' is
		second pass of compiler.
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

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Hash table creation
		do
			default_size := n
			extend_tbl_make (n)
			create inherited_features.make (n)
			create changed_features.make (100)
			create origins.make (100)
		end

feature

	default_size: INTEGER
			-- Default size for `inherited_features'.

	inherited_features: FEATURE_TABLE;
			-- Table of inherited features.
			-- It is calculated by feature `analyse'.

	a_class: CLASS_C;
			-- Current class to analyze

	feature_table: FEATURE_TABLE;
			-- Previous feature table of the class `a_class': processed
			-- by feature `analyze_declarations'; if the class has never
			-- been compiled before, this attribute will be created
			-- and empty before the analysis of the local declarations

	previous_feature_table: FEATURE_TABLE;
			-- Previous feature table processed during a second pass,
			-- and put in the temporary server only.
			--| Useful for the processing of feature ids

	class_info: CLASS_INFO;
			-- Information about current class analyzed: it contains
			-- a compild form of parents, a reference on the feature
			-- list produced by the first pass and indexes left by
			-- the temporary AST server (`Tmp_ast_server') when the
			-- abstract syntax tree of the current analyzed class
			-- has been put in it.
			-- (actually we have here the offsets in the (future) file
			-- ".AST" of the abstract represention of the features).

	parents: PARENT_LIST;
			-- Compiled form of the parents of the current analyzed class

	changed_features: ARRAYED_LIST [INTEGER];
			-- Changed features of `a_class'.

	invariant_changed: BOOLEAN;
			-- Did the invariant clause changed ?

	invariant_removed: BOOLEAN;
			-- Is the invariant clause removed ?

	origins: ARRAYED_LIST [INTEGER];
			-- Origin features name list for pattern processing

	supplier_status_modified: BOOLEAN;
			-- The status (expanded, deferred) of a supplier has changed

	assert_prop_list: LINKED_LIST [INTEGER];
			-- List of routine ids for assertion modifications

	adaptations: LINKED_LIST [FEATURE_ADAPTATION] is
			-- List of redefinitions and joins
		once
			create Result.make
		end;

	pass2_control: PASS2_CONTROL
			-- Second pass controler, needs to be an attribute since
			-- used by `pass2' and `feature_unit'.

	pass2 (pass_c: CLASS_C; is_supplier_status_modified: BOOLEAN) is
			-- Second pass of the compiler on class `cl'. The ultimate
			-- goal here is to calculate the feature table `inherited_features'.
		require
			pass_c_not_void: pass_c /= Void
			class_info_exists: Class_info_server.has (pass_c.class_id);
		local
			class_id: INTEGER;
			resulting_table: like inherited_features;
			pass3_control: PASS3_CONTROL;
			depend_unit: DEPEND_UNIT;
			old_creators, new_creators: HASH_TABLE [EXPORT_I, STRING];
			old_convert_to, old_convert_from: DS_HASH_TABLE [INTEGER, NAMED_TYPE_A]
			creation_name: STRING;
			equiv_tables: BOOLEAN;
		do
			a_class := pass_c
				-- Store previous data
			old_creators := a_class.creators
			old_convert_to := a_class.convert_to
			old_convert_from := a_class.convert_from

			create pass2_control.make

			if System.il_generation then
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
			compute_feature_table;

				-- Check generic parents of the class
			a_class.check_parents

				-- Merge parents table: the topological sort and the
				-- sort of list `changed_classes' of the system ensures
				-- that the second pass has been applied to the parents
				-- of class `cl' before.
				-- We also check if renamed features are available
			parents.merge_and_check_renamings (Current)

			Error_handler.checksum;
				-- Treat the renamings
				--| Needs to be done twice
				--| a is processed
				--| if `rename b as a' is done afterwards, we need to
				--| reprocess the inherit_feat for a again.
			check_renamings;
			check_renamings;
				-- Analyze features inherited under the same final name
			analyze;
				-- Check adaptation clauses of parents
			parents.check_validity2;
				-- Check-sum error after analysis fo the inherited
				-- features
			Error_handler.checksum;

				-- Analyze local features
			if a_class.changed then
					-- Remove all changed features if any
				a_class.changed_features.clear_all;
					-- Class `a_class' is syntactically changed
				analyze_declarations;
					-- No update of `Instantiator' if there is an error
				Error_handler.checksum;
					-- Look for generic types in the inheritance clause
					-- of a syntactically changed class
				a_class.update_instantiator1;
			else
					-- The class didn't syntactically changed but, one
					-- or more ancestor has a new feature table.
				recompute_declarations;
			end;

				-- Check the redefine and select clause, and kepp track
				-- of possible joins between deferred features
			check_validity2;

				-- Computes a good size for the feature table
			resulting_table := inherited_features.twin

				-- Check redeclarations into an attribute
			check_redeclarations (resulting_table);

				-- Check sum
			Error_handler.checksum;

				-- Compute selection table
			Origin_table.compute_feature_table (parents, feature_table, resulting_table);
			resulting_table.set_origin_table (Origin_table.computed);
				-- Check sum error: because of possible bad selections,
				-- anchored types on features could not be evaluated here.
			Error_handler.checksum;

				-- Check types in the feature table
			resulting_table.check_table;
				-- Check the adaptations
			check_validity3 (resulting_table);
				-- Check useless selections
			parents.check_validity4;

				-- Creators processing
		   	a_class.set_creators (class_info.creation_table (resulting_table));
				-- No update of `Instantiator' if there is an error
			Error_handler.checksum;

				-- Convertibility processing
				-- Note: Manu 04/23/2003: Do we need to make a once of `CONVERTIBILITY_CHECKER'?
				-- At the moment no as it does not seem expensive to create it all the time.
			(create {CONVERTIBILITY_CHECKER}).init_and_check_convert_tables (
				a_class, resulting_table, class_info.convertors)
			Error_handler.checksum

				-- Track generic types in the result and arguments of
				-- features of a changed class
			if a_class.changed then
					-- Generic types tracking
				resulting_table.update_instantiator2;
					-- Compute invariant clause
				compute_invariant;
			end;

				-- Check sum error
			Error_handler.checksum;
			check
				No_error: not Error_handler.has_error;
			end;

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
			new_creators := a_class.creators;
			if old_creators = Void then
				if
					new_creators /= Void
					or else (a_class.is_deferred and then pass_c.deferred_modified)
				then
						-- the clients using !! without a creation routine
						-- must be recompiled
debug ("ACTIVITY")
	io.error.put_string ("Insert -1 in the propagators%N");
	if new_creators /= Void then
		io.error.put_string ("Creators have been added");
	else
		io.error.put_string ("The class is now deferred%N");
	end;
end;
					if a_class.is_used_as_expanded then
						create depend_unit.make_expanded_unit (a_class.class_id);
						pass2_control.propagators.extend (depend_unit)
					end;
					create depend_unit.make_creation_unit (a_class.class_id);
					pass2_control.propagators.extend (depend_unit)
				end;
			else
				from
					old_creators.start
				until
					old_creators.after
				loop
					creation_name := old_creators.key_for_iteration;
					if
						new_creators = Void
					or else
						not new_creators.has (creation_name)
					or else
							-- The new export status is more restrictive than the old one
						not old_creators.item_for_iteration.equiv (new_creators.item (creation_name))
					then
						if resulting_table.has (creation_name) then
								-- The routine is not a creation routine any more
								-- or the export status has changed
debug ("ACTIVITY")
	io.error.put_string ("Creators: ");
	io.error.put_string (creation_name);
	io.error.put_string (" inserted in pass2_control.propagators%N");
end;
							create depend_unit.make (a_class.class_id, resulting_table.found_item);
							pass2_control.propagators.extend (depend_unit);
						end;
					end;
					old_creators.forth
				end;
				if a_class.is_used_as_expanded and then
					(new_creators  = Void or else new_creators.count > 1)
				then
					create depend_unit.make_expanded_unit (a_class.class_id);
					pass2_control.propagators.extend (depend_unit)
				end;
				old_creators := Void
			end;

				-- Insert removed routines from convert clauses into propagators list.
			if old_convert_to /= Void then
				update_convert_clause (old_convert_to, a_class.convert_to, resulting_table)
			end
			if old_convert_from /= Void then
				update_convert_clause (old_convert_from, a_class.convert_from, resulting_table)
			end

				-- Remember the removed features written in `a_class'
			pass3_control := a_class.propagators;
			pass3_control.set_removed_features (pass2_control.removed_features);
			pass3_control.set_invariant_changed (invariant_changed);
			pass3_control.set_invariant_removed (invariant_removed);

				-- Update the assert_id_set of redefined features.
			update_inherited_assertions;

			if previous_feature_table /= Void then
					-- If there is a table in the tmp server,
					-- the propagation is done again only if the new
					-- table is different.
				equiv_tables := resulting_table.equiv (previous_feature_table, pass2_control)
			else
					-- There is no table in the tmp server, see if the
					-- new feature table is equivalent to the old one
				equiv_tables := resulting_table.equiv (feature_table, pass2_control);
			end;

				-- Propagation
			Degree_4.propagate (pass_c, resulting_table, equiv_tables,
								pass2_control, assert_prop_list);
			assert_prop_list := Void;

				-- Process paterns of origin features
			process_pattern (resulting_table);

-- Line removed by Frederic Deramat 15/04/92.
--
--    *** resulting_table.process_polymorphism (feature_table); ***
--
-- The "polymorphical tables" are not generated in workbench mode
-- anymore (replaced by "offset descriptors"). Nevertheless, the
-- facility is still used to produce finalized code, but
-- "polymorphical tables" are in no case stored to disk (only
-- generated temporarily in final mode in order to generate the
-- static C routine tables.

			if System.il_generation then -- and then not a_class.is_external then
				a_class.class_interface.process_features (resulting_table)
			end

				-- Instantiate generic parameter in context of current
				-- class.
			a_class.update_generic_features

				-- Find main_parent of current class.
			if System.il_generation then
				compute_main_parent (resulting_table)
			end

				-- Put the resulting table in the temporary feature table
				-- server.
			Tmp_feat_tbl_server.put (resulting_table);
debug ("HAS_CALLS", "TRACE_TABLE")
			resulting_table.trace_replications;
			resulting_table.trace;
end;
				-- Update table `changed_features' of `a_class'.
			update_changed_features;
			clear;
		ensure
			No_error: not Error_handler.has_error;
		rescue
			if Rescue_status.is_error_exception then
					-- Error happened during second pass: clear the
					-- structure
				clear;
				if a_class.changed then
						-- Reset the old creation table
					a_class.set_creators (old_creators);
				end;
			end;
		end;

	compute_feature_table is
			-- Compute attribute `feature_table'. Look for a previous
			-- feature table.
		require
			a_class /= Void
		local
			id: INTEGER;
		do
			id := a_class.class_id;
				-- Look for a previous feature table in server `Feat_tbl_server'
				-- nb: we don't have to look for it in the temporary server
				-- for feature table here, that's why we are using feature
				-- `server_item' of class FEAT_TBL_SERVER.
			if Feat_tbl_server.server_has (id) then
					-- We have a previous compiled class
				feature_table := Feat_tbl_server.server_item (id);
				feature_table.update_table;
			else
					-- No previous compilation
				feature_table := Empty_table;
			end;
				-- Prepare `inherited_features'.
			inherited_features.set_feat_tbl_id (id);
				-- Compute `previous_feature_table'.
			if Tmp_feat_tbl_server.has (id) then
					-- There was an error and a feature table has been already
					-- computed for this class.
				previous_feature_table := Tmp_feat_tbl_server.item (id);
				previous_feature_table.update_table;
			end;
		end;

	Empty_table: FEATURE_TABLE is
			-- Empty feature table
		local
			select_table: SELECT_TABLE;
		once
			create select_table.make (1);
			create Result.make (1);
			Result.set_origin_table (select_table);
		end;

	merge (parent_c: PARENT_C) is
			-- Merge feature table of parent `cl' into
			-- a data structure to analyse.
		local
			parent: CLASS_C
				-- Parent class
			parent_table: FEATURE_TABLE;
				-- Feature table of the parent `parent_c'
			info: INHERIT_INFO
				-- Information on one inherited feature
			feature_i: FEATURE_I
				-- Inherited feature
			parent_type: LIKE_CURRENT
				-- "like Current" type of `parent_c'
		do
			from
				parent := parent_c.parent
				create parent_type
				parent_type.set_actual_type (parent_c.parent_type)
					-- Look for the parent table on the disk
				parent_table := Feat_tbl_server.item (parent.class_id)
				check
					parent_table_exists: parent_table /= Void;
						-- Because of topological sort, the parents are
						-- necessary analyzed (if needed) before class
						-- `a_class'. Redefinition of feature `item' in
						-- class FEAT_TBL_SERVER will look for the table
						-- in the file `Tmp_feat_tbl_file' and then
						-- in the file `Feat_tbl_file'.
				end;

					-- Iteration on the parent feature table
				parent_table.start;
			until
				parent_table.after
			loop
					-- Take one feature
				feature_i := parent_table.item_for_iteration.duplicate

					-- Instantiation of the feature in its parent
				feature_i.instantiate (parent_type)

					-- Creation of an inherited feature information unit	
				create info.make (feature_i)
				info.set_parent (parent_c)

					-- Add the information to the concerned instance of
					-- INHERIT_FEAT
				add_inherited_feature (info, feature_i.feature_name_id)
				parent_table.forth
			end
		end

	add_inherited_feature (info: INHERIT_INFO; feature_name_id: INTEGER) is
				-- Add an inherited feature in the table.
		local
			l: INHERIT_FEAT
		do
			l := item (feature_name_id)
			if l = Void then
					-- Take a new object from the free list
				create l.make
				put (l, feature_name_id)
			end
				-- Add the information to the concerned instance of
				-- INHERIT_FEAT
			l.insert (info)
		end

	check_renamings is
			-- Check all the renamings made in the table of
			-- inherited features
		local
			inh_feat: INHERIT_FEAT
		do
			from
				start;
			until
				after
			loop
				inh_feat := item_for_iteration
					-- Check the renamings on one name
				inh_feat.check_renamings;
				forth
			end;
		end;

	analyze is
			-- Analyze inherited features: the renamings must have
			-- been treated before
		require
			a_class /= Void;
			feature_table /= Void;
		local
			feature_name_id: INTEGER;
			inherit_feat: INHERIT_FEAT;
			inherited_info: INHERIT_INFO;
			feature_i: FEATURE_I;
			def: DEFINITION;
		do
			from
					-- Iteration on the structure
				start
			until
				after
			loop
					-- Calculates an inherited feature: instance of
					-- FEATURE_I
				inherit_feat := item_for_iteration;
				feature_name_id := key_for_iteration;

					-- Calculates attribute `inherited_feature' of
					-- instance `inherit_feat'.
				inherit_feat.process (a_class, feature_name_id)
				inherited_info := inherit_feat.inherited_info;
				if inherited_info /= Void then
						-- Class inherit from a feature coming from one
						-- parent.
					feature_i := inherited_info.a_feature;
						-- Feature name
					feature_i.set_feature_name_id (feature_name_id, feature_i.alias_name_id)
						-- initialization of an inherited feature
					init_inherited_feature (feature_i, inherit_feat);
						-- Insertion in the origin table
					inherited_info.set_a_feature (feature_i);
					if 	not feature_i.is_deferred
						and then
						inherit_feat.nb_deferred > 0
					then
							-- Case of an implementation of inherited deferred
							-- features by an inherited non-deferred feature
						create def.make (inherit_feat, feature_i);
							-- Reset assertions of `feature_i'
						adaptations.put_front (def);
					else
						 Origin_table.insert (inherited_info);
					end;
				end;
				forth
			end;
		end;

	analyze_declarations is
			-- Analyze local declarations written in the class for a
			-- syntactically changed class.
		local
			feature_clause: FEATURE_CLAUSE_AS;
			features: EIFFEL_LIST [FEATURE_AS];
				-- Reference on the feature list produced by the first pass
			single_feature: FEATURE_AS;
				-- Single standard Eiffel feature
			name_list: EIFFEL_LIST [FEATURE_NAME];
				-- Attribute list names
			feature_i: FEATURE_I;
			feat_name: FEATURE_NAME;
			clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			l_export_status: EXPORT_I;
		do
			clauses := class_info.features;
			if clauses /= Void then
				from
					clauses.start
				until
					clauses.after
				loop
					feature_clause := clauses.item;
						-- Evaluation of the export status
					l_export_status := export_status_generator.
						feature_clause_export_status (a_class, feature_clause)
					from
							-- Iteration of the feature written in class
							-- `a_class'.
						features := feature_clause.features;
						features.start;
					until
						features.after
					loop
						single_feature := features.item;
						from
							name_list := single_feature.feature_names;
							name_list.start;
						until
							name_list.after
						loop
							feat_name := name_list.item;
								-- Computes an internal name for the feature
								-- taking care of prefix/infix notations
							feature_i := feature_unit (single_feature, feat_name);
								-- Attributes `body_index', `feature_name' and
								-- `written_in' are ok now. If it is an old
								-- instance of FEATURE_I from a previous
								-- compilation, we know if it was an origin.
							analyze_local (feature_i, feature_i.feature_name_id)
								-- Set the export status
							feature_i.set_export_status (l_export_status);
							name_list.forth;
						end;

						features.forth;
					end;
					clauses.forth;
				end;
			end;
		end;

	recompute_declarations is
			-- Recompute local declarations for a non-syntactically changed
			-- class.
		require
			good_class: a_class /= Void;
			non_syntactically_changed: a_class.changed2;
		local
			feature_i: FEATURE_I;
			feature_name_id: INTEGER;
			id: INTEGER;
		do
			from
				id := a_class.class_id;
				feature_table.start;
			until
				feature_table.after
			loop
				feature_i := feature_table.item_for_iteration;
				if feature_i.written_in = id then
					feature_name_id := feature_table.key_for_iteration;
						-- recompute a former local declaration
					analyze_local (feature_i.duplicate, feature_name_id);
				end;
				feature_table.forth;
			end;
		end;

	analyze_local (feature_i: FEATURE_I; feature_name_id: INTEGER) is
			-- Analyze local declaration of class `a_class' named
			-- `feat_name' which abstract representation is `yacc_feature'.
		require
			good_feature: feature_i /= Void;
			good_feature_name_id: feature_name_id > 0
		local
			inherit_feat: INHERIT_FEAT;
				-- Possible inherited features
			old_feature: FEATURE_I;
			new_rout_id: INTEGER;
			new_rout_id_set: ROUT_ID_SET;
			redef: REDEFINITION;
			info, inherited_info: INHERIT_INFO;
			vmfn: VMFN;
			vmfn1: VMFN1;
			compute_new_rout_id: BOOLEAN;
		do
				-- Now, compute the routine id set of the feature.	
			inherit_feat := item (feature_name_id);

				-- Find out if there previously was a feature with name
				-- `feature_name'
			old_feature := feature_table.item_id (feature_name_id);

			if inherit_feat = Void then
					-- No feature inherited under name `feature_name'. This
					-- deserves a brand new origin.
				if feature_i.is_origin then
						-- An old feature from a previous compilation was
						-- an origin. Keep the current routine id.
						-- Make sure an attribute has a negative routine id
						-- otherwise a positive one
					new_rout_id_set := feature_i.rout_id_set;
					check
						rout_id_set_exists: new_rout_id_set /= Void;
						has_only_one: new_rout_id_set.count = 1;
					end;
					new_rout_id := new_rout_id_set.first;
					if feature_i.is_attribute then
						compute_new_rout_id := not Routine_id_counter.is_attribute (new_rout_id)
					else
						compute_new_rout_id := Routine_id_counter.is_attribute (new_rout_id)
					end;
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
					feature_i.set_is_origin (True);
					compute_new_rout_id := True;
				end;
				if compute_new_rout_id then
					create new_rout_id_set.make
					new_rout_id := feature_i.new_rout_id;
					new_rout_id_set.put (new_rout_id);
					feature_i.set_rout_id_set (new_rout_id_set);
				end;
					-- Insertion into the system routine info table.
				System.rout_info_table.put (new_rout_id, a_class);
				create info.make (feature_i)
			else
					-- This is either an explicit redefinition through
					-- the redefine clause or an implicit redefinition like
					-- an implementation of deferred features
				inherited_info := inherit_feat.inherited_info;
				if inherited_info = Void then
						-- Implicit or explicit redefinition
					new_rout_id_set := inherit_feat.rout_id_set.twin
						-- This is not an origin.
					feature_i.set_is_origin (False);
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
					feature_i.set_rout_id_set (new_rout_id_set);
						-- Mark the redefinition to be done.
						-- We pass `feature_i' as creation routine to
						-- satisfy INHERIT_INFO invariant, but this is
						-- not the correct value. The correct one will
						-- will be set later by one of the routine that
						-- calls `set_a_feature' from INHERIT_INFO.
					create info.make (feature_i)
					inherit_feat.set_inherited_info (info);
						-- Store the redefintion for later
					create redef.make (inherit_feat, feature_i);
					adaptations.put_front (redef);
				elseif inherited_info.parent = Void then
						-- The feature has two implementations in the class
					create vmfn;
					vmfn.set_class (a_class);
					vmfn.set_a_feature (feature_i);
					vmfn.set_inherited_feature (inherited_features.item_id (feature_name_id));
					Error_handler.insert_error (vmfn);
				else
						-- Name clash: a non-deferred feature is inherited
					create vmfn1;
					vmfn1.set_class (a_class);
					vmfn1.set_a_feature (feature_i);
					vmfn1.set_inherited_feature (inherited_info.a_feature);
					vmfn1.set_parent (inherited_info.parent.parent);
					Error_handler.insert_error (vmfn1);
				end;
			end;
			if info /= Void then
				if old_feature = Void then
						-- Since the old feature table hasn't a feature named
						-- `feature_name', new feature id for the feature
					give_new_feature_id (feature_i);
				else
						-- Take the previous feature id
					feature_i.set_feature_id (old_feature.feature_id);
					if old_feature.written_in = a_class.class_id then
						if
							(feature_i.is_attribute and not old_feature.is_attribute) or else
							(feature_i.is_deferred and then not old_feature.is_deferred) or else
							(feature_i.is_attribute and old_feature.is_attribute and
								feature_i.is_origin /= old_feature.is_origin)
						then
							System.execution_table.add_dead_function (old_feature.body_index)
						end
					end;
				end;
					-- Put new feature in `inherited_features'.
				insert_feature (feature_i);
					-- Put the new feature written in the current class
					-- in the origin table
				if redef = Void then
					info.set_a_feature (feature_i);
					Origin_table.insert (info);
				end;
			end;
				-- Keep track of the origin features for pattern
				-- processing
			origins.extend (feature_i.feature_name_id);
		end;

	feature_unit (yacc_feature: FEATURE_AS; feat: FEATURE_NAME): FEATURE_I is
			-- Feature correponding to declaration `yacc_feature'.
			-- If we found a feature named `feature_name' in a previous
			-- feature table, don't change of feature id. If this previous
			-- feature didn't change, keep the body id, otherwise compute
			-- a new body id.
		require
			syntactically_changed: a_class.changed;
		local
			feature_i: FEATURE_I;
			unique_feature: UNIQUE_I;
				-- Feature coming from a previous recompilation
			body_index: INTEGER;
				-- Body index of a previous compiled feature
			old_description, old_tmp_description: FEATURE_AS;
				-- Abstract representation of a previous compiled feature
			is_the_same: BOOLEAN;
				-- Is the parsed feature the same than a previous
				-- compiled one ?
			feature_name_id: INTEGER;
			integer_value: INTEGER_CONSTANT;
				-- Internal name of the feature
			vffd4: VFFD4;
			external_i: EXTERNAL_I;
		do
			feature_name_id := feat.internal_name_id;
debug ("ACTIVITY")
	io.error.put_string ("FEATURE_UNIT on ");
	io.error.put_string (feat.internal_name);
	io.error.put_new_line;
end;

			Result := feature_i_generator.new_feature (yacc_feature, a_class)
			Result.set_feature_name_id (feature_name_id, feat.internal_alias_name_id)
			Result.set_written_in (a_class.class_id)
			Result.set_is_frozen (feat.is_frozen)
			Result.set_is_infix (feat.is_infix)
			Result.set_is_prefix (feat.is_prefix)
			Result.set_is_bracket (feat.is_bracket)
			Result.set_is_binary (feat.is_binary)
			Result.set_is_unary (feat.is_unary)
			Result.set_has_convert_mark (feat.has_convert_mark)

			if Result.is_unique then
					-- Unique value processing
				unique_feature ?= Result;
				create integer_value.make_with_value (
					Tmp_ast_server.unique_values_item (a_class.class_id).item (Result.feature_name))
				unique_feature.set_value (integer_value);
			elseif Result.is_c_external then
					-- Track new externals introduced in the class. Freeze is taken care by
					-- EXTERNALS.is_equivalent queried by SYSTEM_I.
				external_i ?= Result
				pass2_control.add_external (external_i)
			end

				-- Look for a previous definition of the feature
			feature_i := feature_table.item_id (feature_name_id);

			if feature_i /= Void then
				if feature_i.written_in = a_class.class_id then
						-- same feature, reuse body_index
					body_index := feature_i.body_index

						-- Found a feature of same name and written in the
						-- same class.
					old_description := Body_server.server_item (body_index)
					if Tmp_ast_server.body_has (body_index) then
						old_tmp_description := Tmp_ast_server.body_item (body_index)
					end

						-- Incrementality of the workbench is here: we
						-- compare the content of a new feature and the
						-- one of an old feature.
					is_the_same := old_description.is_assertion_equiv (yacc_feature) and
						(old_tmp_description /= Void implies old_tmp_description.is_assertion_equiv (yacc_feature))

					if not is_the_same then
							-- assertions have changed
						create assert_prop_list.make;
						assert_prop_list.compare_objects;
						assert_prop_list.extend (feature_i.rout_id_set.first)

							-- FIXME: Manu 08/05/2004: It is a pain to have to freeze each
							-- time you change an assertion from an external routine, but
							-- this is required for the moment (as call to external routine
							-- is not done in generated byte code).
							-- The solution is to separate the Eiffel encapsulation from
							-- the external encapsulation and have the melted code call the
							-- tiny external encapsulation.
						if feature_i.is_external then
							System.set_freeze
						end
					else
						is_the_same := old_description.is_body_equiv (yacc_feature) and
							(old_tmp_description /= Void implies old_tmp_description.is_body_equiv (yacc_feature))
							-- Same interface does NOT work: the types must be resolved first
							-- The check is done later anyway

							--and then Result.same_interface (feature_i);
						if is_the_same and unique_feature /= Void then
							is_the_same := feature_i.is_unique and then
								unique_feature.same_value (feature_i)
						end;
					end;

						-- If old representation written in the class,
						-- keep the fact the old feature from a previous
						-- is an origin or not.
					Result.set_is_origin (feature_i.is_origin);
					Result.set_rout_id_set (feature_i.rout_id_set.twin)
					Result.set_is_selected (feature_i.is_selected);
				else
						-- new feature => new body_index
					body_index := Body_index_counter.next_id
				end

				Result.set_body_index (body_index)
				if
					not is_the_same or else
					(supplier_status_modified and then
					not Degree_4.changed_status.disjoint (feature_i.suppliers))
							-- The status of one of the suppliers of the feature has changed
				then
debug ("ACTIVITY")
	io.error.put_string ("Is the same ");
	io.error.put_boolean (is_the_same);
	io.error.put_string ("%Nsupplier_status_modified ");
	io.error.put_boolean (supplier_status_modified);
	io.error.put_string ("%Nchanged status ");
	io.error.put_boolean (not Degree_4.changed_status.disjoint (feature_i.suppliers));
	io.error.put_string ("%Nold_feature_in_class ");
	io.error.put_new_line;
end;

						-- Update `read_info' in BODY_SERVER
					if body_index > 0 then
						Tmp_ast_server.body_force (yacc_feature, body_index)
						Tmp_ast_server.reactivate (body_index)
					else
						check
							feature_is_il_external: feature_i.extension /= Void
								and then feature_i.extension.is_il
						end
						Tmp_ast_server.body_force (yacc_feature, external_body_index)
					end

						-- Insert the changed feature in the table of
						-- changed features of class `a_class'.
					changed_features.extend (feature_name_id);
				else
						-- Update `read_info' in BODY_SERVER
					Tmp_ast_server.body_force (yacc_feature, body_index)
					Tmp_ast_server.reactivate (body_index)
				end;
			else
				Result.set_body_index (Body_index_counter.next_id)
				Tmp_ast_server.body_force (yacc_feature, Result.body_index)

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

	clear is
			-- Clear the second pass processor
		do
			previous_feature_table := Void;
			feature_table := Void;
			parents := Void;
			Origin_table.clear_all;
			adaptations.wipe_out;
			changed_features.wipe_out;
			origins.wipe_out;
			invariant_changed := False;
			invariant_removed := False;
			assert_prop_list := Void;

			clear_all
			extend_tbl_make (default_size)
			create inherited_features.make (default_size)
		end;

	process_pattern (resulting_table: FEATURE_TABLE) is
			-- Process pattern of features listed in `origins'.
			-- [We just have to compute pattern ids for origin features
			-- since for inherited features it is transmitted automatically
			-- by duplication of instances of FEATURE_I. For redeclarations,
			-- Through redeclarations, the pattern id cannot change: so
			-- the pattern id is updated in descendants of FEATURE_ADAPTATION]
		require
			good_argument: resulting_table /= Void;
		local
			a_feature: FEATURE_I;
			sys: SYSTEM_I
			l_origins: like origins
		do
			from
				sys := System
				l_origins := origins
				l_origins.start
			until
				l_origins.after
			loop
				a_feature := resulting_table.item_id (l_origins.item);
				a_feature.process_pattern;
				l_origins.forth;
			end;
		end;

	update_inherited_assertions is
			-- Update assert_id_set for redefined or merged routines
			-- in adaptations.
		local
			redefined_features: REDEF_FEAT;
		do
			create redefined_features;
			redefined_features.process (adaptations);
		end;

	update_changed_features is
			-- Update table `changed_features' of `a_class' after a
			-- successful second pass
		require
			no_error: not Error_handler.has_error;
		local
			feature_name_id: INTEGER
			class_id: INTEGER
		do
			from
				class_id := a_class.class_id
				changed_features.start
			until
				changed_features.after
			loop
				feature_name_id := changed_features.item;
				a_class.insert_changed_feature (feature_name_id);
				changed_features.forth;
			end;
		end;

	update_convert_clause (
			a_old_convert, a_new_convert: DS_HASH_TABLE [INTEGER, NAMED_TYPE_A];
			a_resulting_table: FEATURE_TABLE)
		is
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

	Routine_id_counter: ROUTINE_COUNTER is
			-- Counter for routine ids
		once
			Result := System.routine_id_counter;
		end;

	Body_index_counter: BODY_INDEX_COUNTER is
			-- Counter for bodies index
		once
			Result := System.body_index_counter;
		end;

	check_validity2 is
			-- Check if redefinitions are effectively done and does
			-- joins an deferred features if needed
		require
			inherited_features /= Void;
		local
			inherited_feature: FEATURE_I;
			deferred_info, inherited_info: INHERIT_INFO;
			inherit_feat: INHERIT_FEAT;
			feature_name_id: INTEGER;
			join: JOIN;
			vdrs4: VDRS4;
		do
			from
				start
			until
				after
			loop
				inherit_feat := item_for_iteration;
				inherited_info := inherit_feat.inherited_info;
				if inherited_info = Void then
					if inherit_feat.nb_features > 0 then
							-- Cannot find a redefinition
						create vdrs4;
						vdrs4.set_class (a_class);
						vdrs4.set_feature_name (Names_heap.item (key_for_iteration))
						Error_handler.insert_error (vdrs4);
					else
							-- Case of deferred features only
						check
							not inherit_feat.is_empty;
						end;
						feature_name_id := key_for_iteration;
						deferred_info := inherit_feat.deferred_features.first;
							-- New inherited feature
						inherited_feature := deferred_info.a_feature
						inherited_feature.set_feature_name_id (feature_name_id, inherited_feature.alias_name_id)
							-- Initialization of an inherited feature
						init_inherited_feature (inherited_feature, inherit_feat);
							-- Insertion in the origin table
						inherited_info := deferred_info.twin
						inherited_info.set_a_feature (inherited_feature);
						Origin_table.insert (inherited_info);
						if inherit_feat.nb_deferred > 1 then
								-- Keep track of the feature adaptation.
								-- The deferred features must have the same
								-- signature
							create join.make (inherit_feat, inherited_feature);
							adaptations.put_front (join);
debug ("ACTIVITY")
	io.put_string ("joining feature: ");
	io.put_string (inherited_feature.feature_name);
	io.put_string ("%N%Tfrom class: ");
	io.put_string (inherited_feature.written_class.name);
	io.put_new_line;
end;
						end;
					end;
				end;
				forth;
			end;
		end;

	init_inherited_feature (f: FEATURE_I; inherit_feat: INHERIT_FEAT) is
			-- Initialization of an inherited feature
		require
			f_not_void: f /= Void
			inherit_feat_not_void: inherit_feat /= Void
		local
			rout_ids: ROUT_ID_SET
			old_feature: FEATURE_I
			feature_name_id: INTEGER
		do
				-- It is no more an origin
			f.set_is_origin (False)

				--  Check the routine table ids
			rout_ids := inherit_feat.rout_id_set
			f.set_rout_id_set (rout_ids.twin)
				-- Process feature id
			feature_name_id := f.feature_name_id
			old_feature := feature_table.item_id (feature_name_id)
			if old_feature = Void then
					-- New feature id since the old feature table
					-- doesn't have an entry `feature_name'
				give_new_feature_id (f)

					-- We reactivate `body_index' in case `old_feature' is Void because
					-- it was removed in `compute_feature_table' as it was not valid
					-- anymore (Most likely because its signature had some classes
					-- which have been moved to a different location and those
					-- classes have now a different `class_id' which makes it not a
					-- valid feature anymore).
					--| The only issue when performing this call is that in a compilation
					--| from scratch it is useless, but we do not have much choice in
					--| case of incremental compilation.
				Tmp_ast_server.reactivate (f.body_index)
			else
					-- Take the old feature id
				f.set_feature_id (old_feature.feature_id)
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
				-- Concatenation of the export statuses of all the
				-- precursors of the inherited feature: take care of new
				-- adapted export status specified in inheritance clause
			f.set_export_status (inherit_feat.exports (feature_name_id))
				-- Insert it in the table `inherited_features'.
			inherited_features.put (f, feature_name_id)
			check_alias_name_conflict (f)
		end

	give_new_feature_id (f: FEATURE_I) is
			-- Give a new feature id to `f'.
		require
			good_argument: f /= Void;
			has_a_new_name: not feature_table.has_id (f.feature_name_id);
		local
			new_feature_id: INTEGER;
			old_feature: FEATURE_I;
		do
			if previous_feature_table /= Void then
				old_feature := previous_feature_table.item_id (f.feature_name_id);
				if old_feature /= Void then
						-- Keep the feature id, because byte code for client
						-- features using this new feature name could have been	
						-- already computed.
					new_feature_id := old_feature.feature_id
				else
					new_feature_id := a_class.feature_id_counter.next;
				end
			else
				new_feature_id := a_class.feature_id_counter.next;
			end;
			f.set_feature_id (new_feature_id);
		end;

	check_validity3 (resulting_table: FEATURE_TABLE) is
			-- Check the signature conformance of the redefinitions and
			-- validity of joins; check assigner command validity.
		local
			f: FEATURE_I
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
				f := resulting_table.item_for_iteration
				if f.assigner_name_id /= 0 then
					f.check_assigner (resulting_table)
				end
				resulting_table.forth
			end
		end

	check_redeclarations (resulting_table: FEATURE_TABLE) is
			-- Check redeclarations into an attribute.
		do
			from
				adaptations.start;
			until
				adaptations.after
			loop
				adaptations.item.check_redeclaration
					(resulting_table, feature_table, origins, Origin_table);
				adaptations.forth;
			end;
		end;

	insert_feature (f: FEATURE_I) is
			-- Insert `f' in `inherited_feature'
		require
			good_argument: f /= Void
		local
			feature_name_id: INTEGER
			vmfn: VMFN
		do
			feature_name_id := f.feature_name_id
			inherited_features.put (f, feature_name_id)
			if inherited_features.conflict then
				create vmfn
				vmfn.set_class (a_class)
				vmfn.set_a_feature (f)
				vmfn.set_inherited_feature (inherited_features.item_id (feature_name_id))
				Error_handler.insert_error (vmfn)
			else
				check_alias_name_conflict (f)
			end
		end

	compute_invariant is
			-- Compute invariant clause
		require
			good_context: not (a_class = Void or else class_info = Void);
			changed: a_class.changed;
		local
			class_id: INTEGER;
				-- information left by the temporary server `Tmp_ast_server'
				-- and stored in `class_info'
			old_invar_clause, invar_clause: INVARIANT_AS;
			old_clause_exists, clause_exists: BOOLEAN;
		do
				-- First: check is the invariant clause of the current
				-- class has syntactically changed. If yes, flag
				-- `changed5' of `a_class' is set to True.
			class_id := a_class.class_id;
				-- Look in the non-temporary invariant AST server for
				-- for an old invariant clause
			old_clause_exists := Inv_ast_server.server_has (class_id);
			clause_exists := Tmp_ast_server.invariant_has (class_id)
			if clause_exists then
					-- The changed class `a_class' has an invariant clause
				if old_clause_exists then
						-- Evaluation of an old invariant clause in order
						-- to see if it has changed
					old_invar_clause := Inv_ast_server.server_item (class_id);
					invar_clause := Tmp_ast_server.invariant_item (class_id);


						-- Incrementality test on invariant clause
					if invar_clause = Void then
						invariant_changed := old_invar_clause /= Void
					else
						invariant_changed := not (
							old_invar_clause /= Void and then
							invar_clause.is_equivalent (old_invar_clause))
					end
				else
					invariant_changed := True;
				end;
			elseif old_clause_exists or a_class.has_invariant then
				invariant_removed := True;
				tmp_ast_server.invariant_remove (class_id)
			end;
		end;

feature {NONE} -- Implementation

	compute_main_parent (a_feat_tbl: FEATURE_TABLE) is
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

	check_alias_name_conflict (f: FEATURE_I) is
			-- Check if feature `f' has an alias name and that after adding it to `inherited_features'
			-- `inherited_features.is_alias_conflict' is set to `true'. Report error in this case.
		local
			alias_name_id: INTEGER
			vfav: VFAV
		do
			alias_name_id := f.alias_name_id
			if alias_name_id > 0 and then inherited_features.is_alias_conflict then
				if f.is_bracket then
					create {VFAV2} vfav
				else
					create {VFAV1} vfav
				end
				vfav.set_class (a_class)
				vfav.set_a_feature (f)
				vfav.set_inherited_feature (inherited_features.item_alias_id (alias_name_id))
				Error_handler.insert_error (vfav)
			end
		end

feature {NONE} -- Temporary body index

	external_body_index: INTEGER is
			-- Dummy body index to be used when someone redefine an external feature
			-- with no body (i.e. an IL external).
		once
			Result := Body_index_counter.next_id
		ensure
			external_body_index_positive: Result > 0
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

