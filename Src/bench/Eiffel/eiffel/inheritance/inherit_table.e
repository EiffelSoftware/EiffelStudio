-- Table of inherited features sorted by name: feature `pass2' is the
-- second pass of the compiler.

class INHERIT_TABLE 

inherit

	EXTEND_TABLE [INHERIT_FEAT, STRING]
		rename
			make as extend_tbl_make,
			merge as extend_table_merge
		end;
	SHARED_SERVER
		export
			{ANY} all
		undefine
			copy, is_equal
		end;
	SHARED_SELECTED
		undefine
			copy, is_equal
		end;
	SHARED_ERROR_HANDLER
		export
			{ANY} error_handler
		undefine
			copy, is_equal
		end;
	SHARED_INST_CONTEXT
		undefine
			copy, is_equal
		end;
	SHARED_ORIGIN_TABLE
		undefine
			copy, is_equal
		end;
	SHARED_ID_TABLES
		undefine
			copy, is_equal
		end;
	SHARED_PASS
		undefine
			copy, is_equal
		end;
	SHARED_RESCUE_STATUS
		undefine
			copy, is_equal
		end;
	COMPILER_EXPORTER
        undefine
            copy, is_equal
        end;

creation

	make

	
feature

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

	body_table: EXTEND_TABLE [READ_INFO, INTEGER];
			-- Body table information for `Tmp_body_server'.

	changed_features: LINKED_LIST [STRING];
			-- Changed features of `a_class'.

	invariant_changed: BOOLEAN;
			-- Did the invariant clause changed ?

	invariant_removed: BOOLEAN;
			-- Is the invariant clause removed ?

	origins: LINKED_LIST [STRING];
			-- Origin features name list for pattern processing

	new_body_id: INTEGER;
			-- Last new computed body id

	supplier_status_modified: BOOLEAN;
			-- The status (expanded, deferred) of a supplier has changed

	assert_prop_list: LINKED_LIST [ROUTINE_ID];
			-- List of routine ids for assertion modifications

	adaptations: LINKED_LIST [FEATURE_ADAPTATION] is
			-- List of redefinitions and joins
		once
			!!Result.make
		end;

    rep_parent_list: LINKED_LIST [REP_NAME_LIST] is
            -- List of replicated names for each parent clause 
        once
            !!Result.make
        end;

	new_externals: LINKED_LIST [STRING];
			-- New externals introduced into the class

	make (n: INTEGER) is
			-- Hash table creation
		do
			extend_tbl_make (n);
			!!inherited_features.make (n);
			!!body_table.make (50);
			!!changed_features.make;	
			!!origins.make;
			!!new_externals.make;
		end;

	pass2 (pass_c: PASS2_C; is_supplier_status_modified: BOOLEAN) is
			-- Second pass of the compiler on class `cl'. The ultimate
			-- goal here is to calculate the feature table `inherited_features'.
		require
			argument_not_void: pass_c /= Void;
			class_not_void: pass_c.associated_class /= Void;
			class_info_exists: Class_info_server.has (pass_c.associated_class.id);
		local
			class_id, i, nb: INTEGER;
			resulting_table: like inherited_features;
			a_cluster: CLUSTER_I;
			pass2_control: PASS2_CONTROL;
			pass3_control: PASS3_CONTROL;
			depend_unit: DEPEND_UNIT;
			old_creators, new_creators: EXTEND_TABLE [EXPORT_I, STRING];
			creation_name: STRING;
			equiv_tables: BOOLEAN;
		do
			new_body_id := 0;

			a_class := pass_c.associated_class;
			supplier_status_modified := is_supplier_status_modified;

			a_cluster := a_class.cluster;
				-- Initialization of the context for evaluation of actual
				-- types
			Inst_context.set_cluster (a_cluster);

				-- Empty the selection control list
			Selected.wipe_out;
			class_id := a_class.id;

				-- Look for the interpreted class information left
				-- by the first pass if the class has syntactically changed.
			class_info := Class_info_server.item (class_id);
			parents := class_info.parents;

				-- Compute attribute `feature_table'.
			compute_feature_table;

				-- Merge parents table: the topological sort and the
				-- sort of list `changed_classes' of the system ensures
				-- that the second pass has been applied to the parents
				-- of class `cl' before.
			from
					-- Iteration on the parents of class `cl'.
				nb := parents.count;
				i := 1
			until
				i > nb
			loop
					-- Insert features inherited from a parent in the
					-- inheritance table `Inherit_table'.
				merge (parents.i_th (i));
				i := i + 1;
			end;
				-- Check if the feature renamed are available
			check_validity1;

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
			resulting_table := clone (inherited_features);
				-- Check redeclarations into an attribute
			check_redeclarations (resulting_table);
				-- Check sum
			Error_handler.checksum;
				-- Compute selection table
			Origin_table.compute_feature_table
					(parents, feature_table, resulting_table);
			resulting_table.set_origin_table (Origin_table.computed);
				-- Check sum error: because of possible bad selections,
				-- anchored types on features could not be evaluated here.
			Error_handler.checksum;
				-- Check types in the feature table
			resulting_table.check_table;
				-- Check the adaptations
			check_validity3 (resulting_table);
				-- Check useless selections
			check_validity4;
				-- Track generic types in the result and arguments of
				-- features of a changed class
			if a_class.changed then
					-- Creators processing
				old_creators := a_class.creators;
			   	a_class.set_creators
							(class_info.creation_table (resulting_table));
					-- No update of `Instantiator' if there is an error
				Error_handler.checksum;
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
			if not System.code_replication_off then
				if rep_parent_list.count > 0 then
					process_replicated_features (resulting_table);
				else
					if Rep_server.has (a_class.id) then
							--! Remove it from the server if it
							--! previously existed
						Rep_server.remove (a_class.id)
					end;
					if Tmp_rep_info_server.has (a_class.id) then
						--| An error may have occured during Degree 3
						--| and there may have been replicated info
						--| originally and when recompiled 
						--| these may have been removed.
						Tmp_rep_info_server.remove (a_class.id)
					end;
				end;
			end;

				-- Pass2 controler evaluation
			pass2_control := feature_table.pass2_control (resulting_table);
			if previous_feature_table /= Void then
					-- Add the modifications done since the last unsuccessful compilation
				previous_feature_table.fill_pass2_control (pass2_control, resulting_table);
			end;

				-- Process externals
			if a_class.changed then
				pass2_control.set_new_externals (new_externals);
				pass2_control.process_externals;
			end;

				-- Insert the changed creators in the propagators list
			new_creators := a_class.creators;
			if old_creators = Void then
				if
					new_creators /= Void
				or else
					(a_class.is_deferred and then pass_c.deferred_modified)
				then
						-- the clients using !! without a creation routine
						-- must be recompiled
debug ("ACTIVITY")
	io.error.putstring ("Insert -1 in the propagators%N");
	if new_creators /= Void then
		io.error.putstring ("Creators have been added");
	else
		io.error.putstring ("The class is now deferred%N");
	end;
end;
					if a_class.is_used_as_expanded then
						!!depend_unit.make (a_class.id, -2);
						pass2_control.propagators.extend (depend_unit)
					end;
					!!depend_unit.make (a_class.id, -1);
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
	io.error.putstring ("Creators: ");
	io.error.putstring (creation_name);
	io.error.putstring (" inserted in pass2_control.propagators%N");
end;
							!!depend_unit.make (a_class.id, resulting_table.item (creation_name).feature_id);
							pass2_control.propagators.extend (depend_unit);
						end;
					end;
					old_creators.forth
				end;
				if a_class.is_used_as_expanded and then
					(new_creators  = Void or else new_creators.count > 1)
				then
					!!depend_unit.make (a_class.id, -2);
					pass2_control.propagators.extend (depend_unit)
				end;
				old_creators := Void
			end;

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

--			equiv_tables := resulting_table.equiv (feature_table);
--			if equiv_tables and then previous_feature_table /= Void then
--				equiv_tables := resulting_table.equiv (previous_feature_table)
--			end;

				-- Propagation
			pass_c.propagate (resulting_table, equiv_tables,
								pass2_control, assert_prop_list);
			assert_prop_list := Void;

				-- Process creation feature of `a_class'.
			a_class.process_creation_feature (resulting_table);
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

				-- Put the resulting table in the temporary feature table
				-- server.
			Tmp_feat_tbl_server.put (resulting_table);
debug ("HAS_CALLS", "TRACE_TABLE")
			resulting_table.trace_replications;
			resulting_table.trace;
end;
				-- Update `Tmp_body_server'.
			update_body_server;
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
			id := a_class.id;
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
			inherited_features.set_feat_tbl_id (a_class.id);
				-- Compute `previous_feature_table'.
			if Tmp_feat_tbl_server.has (id) then
					-- There eas an error and a feature table has been already
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
			!!select_table.make (1);
			!!Result.make (1);
			Result.set_origin_table (select_table);
		end;

	merge (parent_c: PARENT_C) is
			-- Merge feature table of parent `cl' into
			-- a data structure to analyse.
		local
			parent: CLASS_C;
				-- Parent class
			parent_table: FEATURE_TABLE;
				-- Feature table of the parent `parent_c'
			info: INHERIT_INFO;
				-- Information on one inherited feature
			feature_i: FEATURE_I;
				-- Inherited feature
		do
				-- Check generic parents of the class
			a_class.check_parents;

			from
				parent := parent_c.parent;
					-- Look for the parent table on the disk
				parent_table := Feat_tbl_server.item (parent.id);
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
				feature_i := parent_table.item_for_iteration.duplicate;
					-- Instantiation of the feature in its parent
				feature_i.instantiate (parent_c.parent_type);
		
					-- Creation of an inherited feature information unit	
				!!info;
				info.set_a_feature (feature_i);
				info.set_parent (parent_c);
					-- Add the information to the concerned instance of
					-- INHERIT_FEAT
				add_inherited_feature (info, feature_i.feature_name);
				parent_table.forth
			end;
		end;

	add_inherited_feature (info: INHERIT_INFO; feature_name: STRING) is
				-- Add an inherited feature in the table.
		local
			l: INHERIT_FEAT;
		do
			l := item (feature_name);
			if l = Void then
					-- Take a new object from the free list
				!!l.make;
				put (l, feature_name);
			end;
				-- Add the information to the concerned instance of
				-- INHERIT_FEAT
			l.insert (info);
		end;

	check_renamings is
			-- Check all the renamings made in the table of
			-- inherited features
		local
			c_keys: ARRAY [STRING];
			i, nb: INTEGER;
			inh_feat: INHERIT_FEAT
		do
			from
				c_keys := current_keys;
				i := 1;
				nb := c_keys.count
			until
				i > nb
			loop
				inh_feat := item (c_keys.item (i));
				if inh_feat /= Void then
						-- Check the renamings on one name
					inh_feat.check_renamings;
				end;
				i := i + 1;
			end;
		end;

	analyze is
			-- Analyze inherited features: the renamings must have
			-- been treated before
		require
			a_class /= Void;
			feature_table /= Void;
		local
			feature_name: STRING;
			inherit_feat: INHERIT_FEAT;
			inherited_info: INHERIT_INFO;
			feature_i: FEATURE_I;
			attribute: ATTRIBUTE_I;
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
				feature_name := key_for_iteration;

					-- Calculates attribute `inherited_feature' of
					-- instance `inherit_feat'.		
				inherit_feat.process (a_class, feature_name);
				inherited_info := inherit_feat.inherited_info;
				if inherited_info /= Void then
						-- Class inherit from a feature coming from one
						-- parent.
					feature_i := inherited_info.a_feature;
						-- Feature name
					feature_i.set_feature_name (feature_name);
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
						!!def.make (inherit_feat, feature_i);
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
			feature_clause: FEATURE_CLAUSE_AS_B;
			features: EIFFEL_LIST_B [FEATURE_AS_B];
				-- Reference on the feature list produced by the first pass
			single_feature: FEATURE_AS_B;
				-- Single standard Eiffel feature
			name_list: EIFFEL_LIST_B [FEATURE_NAME_B];
				-- Attribute list names
			feature_i: FEATURE_I;
			feat_name: FEATURE_NAME_B;
			clauses: EIFFEL_LIST_B [FEATURE_CLAUSE_AS_B];
			export_status: EXPORT_I;
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
					export_status := feature_clause.export_status;
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
							feature_i := feature_unit
												(single_feature, feat_name);
								-- Attributes `body_id', `feature_name' and
								-- `written_in' are ok now. If it is an old
								-- instance of FEATURE_I from a previous
								-- compilation, we know if it was an origin.
							analyze_local (feature_i, feat_name.internal_name);
								-- Set the export status
							feature_i.set_export_status (export_status);
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
			feature_name: STRING;
				-- Feature name
			id: INTEGER;
				-- Current class id
		do
			from
				id := a_class.id;
				feature_table.start;
			until
				feature_table.after
			loop
				feature_i := feature_table.item_for_iteration;
				if feature_i.written_in = id then
					feature_name := feature_table.key_for_iteration;
						-- recompute a former local declaration
					analyze_local (feature_i.duplicate, feature_name);
				end;
				feature_table.forth;
			end;
		end;
				
	analyze_local (feature_i: FEATURE_I; feature_name: STRING) is
			-- Analyze local declaration of class `a_class' named
			-- `feat_name' which abstract representation is `yacc_feature'.
		require
			good_feature: feature_i /= Void;
			good_feature_name: feature_name /= Void;
		local
			inherit_feat: INHERIT_FEAT;
				-- Possible inherited features
			inherited_feature, old_feature: FEATURE_I;
			new_rout_id: ROUTINE_ID;
			rout_id_set, new_rout_id_set: ROUT_ID_SET;
			redef: REDEFINITION;
			info, inherited_info: INHERIT_INFO;
			vmfn: VMFN;
			vmfn1: VMFN1;
			compute_new_rout_id: BOOLEAN;
		do
				-- Now, compute the routine id set of the feature.	
			inherit_feat := item (feature_name);

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
						compute_new_rout_id := not new_rout_id.is_attribute;
					else
						compute_new_rout_id := new_rout_id.is_attribute
					end;
				else
					feature_i.set_is_origin (True);
					compute_new_rout_id := True;
				end;
				if compute_new_rout_id then
					!!new_rout_id_set.make (1);
					new_rout_id := feature_i.new_rout_id;
					new_rout_id_set.put (new_rout_id);
					feature_i.set_rout_id_set (new_rout_id_set);
				end;
					-- Insertion into the system routine info table.
				System.rout_info_table.put (new_rout_id, a_class);
					--
				!!info;
				info.set_a_feature (feature_i);
			else
					-- This is either an explicit redefinition through
					-- the redefine clause or an implicit redefinition like
					-- an implementation of deferred features
				inherited_info := inherit_feat.inherited_info;
				if inherited_info = Void then
						-- Implicit or explicit redefinition
					new_rout_id_set := clone (inherit_feat.rout_id_set);
						-- This is not an origin
					feature_i.set_is_origin (False);
						-- Routine id set for the redefinition
					feature_i.set_rout_id_set (new_rout_id_set);
						-- Mark the redefinition to be done.
					!!info;
					inherit_feat.set_inherited_info (info);
						-- Store the redefintion for later
					!!redef.make (inherit_feat, feature_i);
					adaptations.put_front (redef);
				elseif inherited_info.parent = Void then
						-- The feature has two implementations in the class
					!!vmfn;
					vmfn.set_class (a_class);
					vmfn.set_a_feature (feature_i);
					vmfn.set_other_feature (inherited_features.item (feature_name));
					Error_handler.insert_error (vmfn);
				elseif not feature_i.is_code_replicated then
						-- Name clash: a non-deferred feature is inherited
					!!vmfn1;
					vmfn1.set_class (a_class);
					vmfn1.set_a_feature (feature_i);
					vmfn1.set_inherited_feature (inherited_info.a_feature);
					vmfn1.set_parent (inherited_info.parent.parent);
					Error_handler.insert_error (vmfn1);
				end;
			end;
			if info /= Void then
					-- Compute feature id and body index when no clash name
				old_feature := feature_table.item (feature_name);
				if old_feature = Void then
						-- Since the old feature table hasn't a feature named
						-- `feature_name', new feature id for the feature
					give_new_feature_id (feature_i);
						-- Compute a body index information
					feature_i.set_body_index (Body_index_counter.next);
				else
						-- Take the previous feature id
					feature_i.set_feature_id (old_feature.feature_id);
					if old_feature.written_in /= a_class.id then
						feature_i.set_body_index (Body_index_counter.next);
					else
						feature_i.set_body_index (old_feature.body_index);
					end;
				end;
					-- Update body index/body id correpondances
				if new_body_id > 0 then
						-- A new body id has been computed for `feature_i'.
					Body_index_table.force
									(new_body_id, feature_i.body_index);
debug ("ACTIVITY")
	io.error.putstring ("Insert new body id: ");
	io.error.putint (new_body_id);
	io.error.putstring ("%NBody index: ");
	io.error.putint (feature_i.body_index);
	io.error.new_line;
end
					new_body_id := 0;
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
			origins.put_front (feature_i.feature_name);
		end;

	feature_unit (yacc_feature: FEATURE_AS_B; feat: FEATURE_NAME_B): FEATURE_I is
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
			old_body_id, feature_body_id: INTEGER;
				-- Body id of a previous compiled feature
			old_description: FEATURE_AS_B;
				-- Abstract representation of a previous compiled feature
			is_the_same, old_feature_in_class: BOOLEAN;
				-- Is the parsed feature the saem than a previous
				-- compiled one ?
			read_info: READ_INFO;
			feature_name: STRING;
			integer_value: INT_VALUE_I;
				-- Internal name of the feature
			vffd4: VFFD4;
			external_i: EXTERNAL_I;
		do
			feature_name := feat.internal_name;
debug ("ACTIVITY")
	io.error.putstring ("FEATURE_UNIT on ");
	io.error.putstring (feature_name);
	io.error.new_line;
end;

			Result := yacc_feature.new_feature;
			Result.set_feature_name (feature_name);
			Result.set_written_in (a_class.id);
			Result.set_is_frozen (feat.is_frozen);
			Result.set_is_infix (feat.is_infix);
			Result.set_is_prefix (feat.is_prefix);
			if Result.is_unique then
					-- Unique value processing
				unique_feature ?= Result;
				!!integer_value;
				integer_value.set_int_val
					(class_info.unique_values.item (feature_name));
				unique_feature.set_value (integer_value);
debug ("ACTIVITY")
	io.error.putstring ("Value: ");
	io.error.putint (integer_value.int_val);
	io.error.new_line;
end;
			elseif Result.is_external then
					-- Track new externals introduced in the class
				external_i ?= Result;
				if not external_i.encapsulated then
					new_externals.put_front (external_i.external_name);
				end;
			end;

			read_info := class_info.index.item (yacc_feature.id);

				-- Look for a previous definition of the feature
			feature_i := feature_table.item (feature_name);

			if feature_i /= Void then
				old_feature_in_class := feature_i.written_in = a_class.id;
				old_body_id := feature_i.original_body_id;
				if 	
					old_feature_in_class and then 
					not feature_i.is_code_replicated 
				then
						-- Found a feature of same name and written in the
						-- same class.
debug ("ACTIVITY")
	io.error.putstring ("Getting old_body ");
	io.error.putint (old_body_id);
	io.error.new_line;
end;
					old_description := Body_server.server_item (old_body_id);
						-- Incrementality of the workbench is here: we
						-- compare the content of a new feature and the
						-- one of an old feature.
					is_the_same := old_description.is_assertion_equiv (yacc_feature);
debug ("ACTIVITY")
	if not is_the_same then
		io.error.putstring ("%Tassertions has syntactically changed%N");
	end;
end;
					if not is_the_same then
							-- assertions have changed
						!!assert_prop_list.make;
						assert_prop_list.extend (feature_i.rout_id_set.first)
					else
						is_the_same := old_description.is_body_equiv (yacc_feature)
							-- Same interface does NOT work: the types must be resolved first
							-- The check is done later anyway

							--and then Result.same_interface (feature_i);
						if is_the_same and unique_feature /= Void then
							is_the_same := feature_i.is_unique and then unique_feature.same_value (feature_i)
						end;
debug ("ACTIVITY")
	if not is_the_same then
		if not old_description.is_body_equiv (yacc_feature) then
			io.error.putstring ("%Tbody is not equiv%N");
		end;
--		if not Result.same_interface (feature_i) then
--			io.error.putstring ("%TInterface has changed%N");
--		end;
	end;
end;
					end;

						-- If old representation written in the class,
						-- keep the fact the old feature from a previous
						-- is an origin or not.
					Result.set_is_origin (feature_i.is_origin);
					Result.set_rout_id_set (clone (feature_i.rout_id_set));
					Result.set_is_selected (feature_i.is_selected);
				end;
				if not is_the_same or else
					(supplier_status_modified and then
					not pass2_controler.changed_status.disjoint (feature_i.suppliers))
							-- The status of one of the suppliers of the feature has changed
				then
debug ("ACTIVITY")
	io.error.putstring ("Is the same ");
	io.error.putbool (is_the_same);
	io.error.putstring ("%Nsupplier_status_modified ");
	io.error.putbool (supplier_status_modified);
	io.error.putstring ("%Nchanged status ");
	io.error.putbool (not pass2_controler.changed_status.disjoint (feature_i.suppliers));
	io.error.putstring ("%Nold_feature_in_class ");
	io.error.putbool (old_feature_in_class);
	io.error.new_line;
end;

					-- Feature has changed of body between two 
					-- recompilations; attribute `body_id' must be renew and the
					-- old body id should be remove from the body
					-- server after compilation if successfull.
					if old_feature_in_class then
						if not feature_i.is_code_replicated then
							Tmp_body_server.desactive (old_body_id);
						else
							Tmp_rep_feat_server.desactive (old_body_id);
						end;
					end;
						-- Computes a new body id for the changed
						-- feature.
					new_body_id := Body_id_counter.next;
						-- Take reading information left by the server
						-- `Tmp_ast_server' during first pass and put
						-- it in the server `Tmp_body_server'.
					body_table.put (read_info, new_body_id);	
						-- Insert the changed feature in the table of
						-- changed features of class `a_class'.
debug ("ACTIVITY")
	io.error.putstring (feature_name);
	io.error.putstring (" inserted in changed_features%N%
			%New body id: ");
	io.error.putint (new_body_id);
	io.error.new_line;
end;
					changed_features.put_front (feature_name);
				else
						-- Keep the type
					Result.set_type (feature_i.type);
						-- Relative offset of the unchanged feature
						-- description could change.
					body_table.put (read_info, old_body_id);
						-- Restore good body id in `Body_index_table'.
					if feature_i.body_id /= old_body_id then
							-- An error happended and modification was undone
						new_body_id := old_body_id;
					end;
					if not feature_i.is_code_replicated then
						Tmp_body_server.reactivate (old_body_id);
					else
						Tmp_rep_feat_server.reactivate (old_body_id);
					end;
				end;
			else
					-- New body id
				new_body_id := Body_id_counter.next;
					-- Take reading information for the body server left
					-- by `Tmp_ast_server' during first pass and put it
					-- the temporary body server.
				body_table.put (read_info, new_body_id);
					-- Insert the changed feature in the table of changed
					-- features of `a_class'.
debug ("ACTIVITY")
	io.error.putstring (feature_name);
	io.error.putstring (" inserted in changed_features (new body id)%N");
end;
				changed_features.put_front (feature_name);
			end;
				-- Check incompatibily between `frozen' and `deferred'
			if Result.is_frozen and then Result.is_deferred then
					-- A deferred feature cannot be frozen
				!!vffd4;
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
			body_table.clear_all;
			inherited_features.clear_all;
			Origin_table.clear_all;
			adaptations.wipe_out;
			changed_features.wipe_out;
			origins.wipe_out;
			new_externals.wipe_out;
			rep_parent_list.wipe_out;
			invariant_changed := False;
			invariant_removed := False;
			assert_prop_list := Void; 
			clear_all;
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
		do
			from
				origins.start
			until
				origins.after
			loop
				a_feature := resulting_table.item (origins.item);
				a_feature.process_pattern;
				origins.forth;
			end;
		end;

	update_inherited_assertions is
			-- Update assert_id_set for redefined or merged routines
			-- in adaptations.
		local
			redefined_features: REDEF_FEAT;
		do
			!!redefined_features;
			redefined_features.process (adaptations);
		end;

	update_body_server is
			-- Update `Tmp_body_server' after a successfull second
			-- pass
		require
			no_error: not Error_handler.has_error;
		do
			Tmp_body_server.merge (body_table);
		end;

	update_changed_features is
			-- Update table `changed_features' of `a_class' after a
			-- successfull second pass
		require
			no_error: not Error_handler.has_error;
		local
			rep_dep: REP_CLASS_DEPEND;
			feat_rep_dep: REP_FEATURE_DEPEND;
			feature_name: STRING
		do
			from
				if Rep_depend_server.has (a_class.id) then
					rep_dep := Rep_depend_server.item (a_class.id);
				end;
				changed_features.start
			until
				changed_features.after
			loop
				feature_name := changed_features.item;
				a_class.insert_changed_feature (feature_name);
				if rep_dep /= Void then
					feat_rep_dep := rep_dep.item (feature_name);
					if feat_rep_dep /= Void then
						a_class.propagate_replication (feat_rep_dep)
					end;
				end;
				changed_features.forth;
			end;
			if rep_dep /= Void and then feat_rep_dep /= Void then 
				if feat_rep_dep.count > 0 then
					Tmp_rep_depend_server.put (rep_dep)
				else
					Tmp_rep_depend_server.remove (a_class.id)
				end;
			end;
		end;

	Body_id_counter: COUNTER is
			-- Counter for body ids
		once
			Result := System.body_id_counter;
		end;

	Routine_id_counter: ROUTINE_COUNTER is
			-- Counter for routine ids
		once
			Result := System.routine_id_counter;
		end;

	Body_index_counter: COUNTER is
			-- Counter for bodies index
		once
			Result := System.body_index_counter;
		end;

	check_validity1 is
			-- Check renamings valididty
		do
			parents.check_validity1;
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
			feature_name: STRING;
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
				if	inherited_info = Void then
					if inherit_feat.nb_features > 0 then
							-- Cannot find a redefinition
						!!vdrs4;
						vdrs4.set_class (a_class);
						vdrs4.set_feature_name (key_for_iteration);
						Error_handler.insert_error (vdrs4);
					else
							-- Case of deferred features only
						check
							not inherit_feat.empty;
						end;
						feature_name := key_for_iteration;
						deferred_info := inherit_feat.deferred_features.first;
							-- New inherited feature
						inherited_feature := deferred_info.a_feature;
						inherited_feature.set_feature_name (feature_name);
							-- Initialization of an inherited feature
						init_inherited_feature (inherited_feature,inherit_feat);
							-- Insertion in the origin table
						inherited_info := clone (deferred_info);
						inherited_info.set_a_feature (inherited_feature);
						Origin_table.insert (inherited_info);
						if inherit_feat.nb_deferred > 1 then
								-- Keep track of the feature adaptation.
								-- The deferred features must have the same
								-- signature
							!!join.make (inherit_feat, inherited_feature);
							adaptations.put_front (join);
debug ("ACTIVITY")
	io.putstring ("joining feature: ");
	io.putstring (inherited_feature.feature_name);
	io.putstring ("%N%Tfrom class: ");
	io.putstring (inherited_feature.written_class.class_name);
	io.new_line;
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
			good_argument1: f /= Void;
			good_argument2: inherit_feat /= Void;
		local
			rout_ids: ROUT_ID_SET;
			old_feature: FEATURE_I;
			feature_name: STRING;
		do
				-- It is no more an origin
			f.set_is_origin (False);
				--  Check the routine table ids
			rout_ids := inherit_feat.rout_id_set;
			f.set_rout_id_set (clone (rout_ids));
				-- Process feature id
			feature_name := f.feature_name;
			old_feature := feature_table.item (feature_name);
			if old_feature = Void then
					-- New feature id since the old feature table
					-- doesn't have an entry `feature_name'
				give_new_feature_id (f);
			else
					-- Take the old feature id
				f.set_feature_id (old_feature.feature_id);
			end;
				-- Concatenation of the export statuses of all the
				-- precursors of the inherited feature: take care of new
				-- adapted export status specified in inheritance clause
			f.set_export_status (inherit_feat.exports (feature_name));
				-- Insert it in the table `inherited_features'.
			inherited_features.put (f, feature_name);
		end;

	give_new_feature_id (f: FEATURE_I) is
			-- Give a new feature id to `f'.
		require
			good_argument: f /= Void;
			has_a_new_name: not feature_table.has (f.feature_name);
		local
			new_feature_id: INTEGER;
			old_feature: FEATURE_I;
		do
			if previous_feature_table /= Void then
				old_feature := previous_feature_table.item (f.feature_name);
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
			-- validity of joins
		do
			from
				adaptations.start;
			until
				adaptations.after
			loop
				adaptations.item.check_adaptation (resulting_table);
				adaptations.forth;
			end;
		end;

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

	check_validity4 is
			-- Check if there is no useless selections
		do
			parents.check_validity4;
		end;

	insert_feature (f: FEATURE_I) is
			-- Insert `f' in `inherited_feature'
		require
			good_argument: f /= Void;
		local
			feature_name: STRING;
			vmfn: VMFN;
		do
			feature_name := f.feature_name;
			inherited_features.put (f, feature_name);
			if inherited_features.conflict then
				!!vmfn;
				vmfn.set_class (a_class);
				vmfn.set_a_feature (inherited_features.item (feature_name));
				vmfn.set_other_feature (f);
				Error_handler.insert_error (vmfn);
			end;
		end;

	compute_invariant is
			-- Compute invariant clause
		require
			good_context: not (a_class = Void or else class_info = Void);
			changed: a_class.changed;
		local
			class_id: INTEGER;
			invariant_info: READ_INFO;
				-- information left by the temporary server `Tmp_ast_server'
				-- and stored in `class_info'
			old_invar_clause, invar_clause: INVARIANT_AS_B;
			old_clause_exists: BOOLEAN;
		do
				-- First: check is the invariant clause of the current
				-- class has syntactically changed. If yes, flag 
				-- `changed5' of `a_class' is set to True.
			class_id := a_class.id;
			invariant_info := class_info.invariant_info;
				-- Look in the non-temporary invariant AST server for
				-- for an old invariant clause
			old_clause_exists := Inv_ast_server.server_has (class_id);
			if invariant_info /= Void then
					-- The changed class `a_class' has an invariant clause
				if old_clause_exists then
						-- Evaluation of an old invariant clause in order
						-- to see if it has changed
					old_invar_clause := Inv_ast_server.server_item (class_id);
					invar_clause := Tmp_inv_ast_server.item (class_id);
				
						-- Incrementality test on invariant clause
					invariant_changed := not deep_equal
											(invar_clause, old_invar_clause);
				else
					invariant_changed := True;
				end;
			elseif old_clause_exists then
				invariant_removed := True;
					-- Remove invariant description from server
				Tmp_inv_ast_server.remove_id (class_id);
			elseif Tmp_inv_ast_server.has (class_id) then
					-- There was an invariant in the previous
					-- unsuccessful compilation: remove
					-- it from the server and reset `invariant_feature'
					-- in CLASS_C
				a_class.set_invariant_feature (Void);
				Tmp_inv_ast_server.remove_id (class_id);
			end;
		end;

feature -- Replications
 
	process_replicated_features (f_table: FEATURE_TABLE) is
				-- Process replicated features detected in `treat_renamings'.
				-- Check to see if code replication is necessary, and if so,
				-- update the replicated feature accordingly.
		require
			valid_rep_count: rep_parent_list.count > 0
		local
			feature_as: FEATURE_AS_B;
			new_feat, rep_feat, old_feat: FEATURE_I;
			f_name: STRING;
			rep_name_list: REP_NAME_LIST;
			rep_name: REP_NAME;
			calls_list: CALLS_LIST;
			s_rep_name_list: S_REP_NAME_LIST;
			rep_class_info: REP_CLASS_INFO;
			tmp_rep_class_info: EXTEND_TABLE [S_REP_NAME_LIST, INTEGER];
			stop, needs_replication: BOOLEAN;
			written_in_cont, body_id: INTEGER;
			same_features: BOOLEAN;
			cur: CURSOR;
			s_rep_name: S_REP_NAME;
		do
			from
				rep_parent_list.start;
				!!calls_list.make;
				!!rep_class_info.make (a_class.id);
				!!tmp_rep_class_info.make (a_class.id);
			until
				rep_parent_list.after
			loop
debug ("REPLICATION")
				io.error.putstring ("Parent clause: ");
				io.error.putstring (rep_parent_list.item.parent_clause.class_name);
				io.error.new_line;
end;
				rep_name_list := rep_parent_list.item;
				needs_replication := False;
				from
					-- Need to update because f_table contains unselected.
					written_in_cont := 0;
					rep_name_list.start
				until
					rep_name_list.after 
				loop
					rep_name := rep_name_list.item;
					rep_feat :=	rep_name.rep_feature;  
					if not rep_feat.is_deferred and then
						(rep_feat.written_in /= a_class.id) 
					then
						if written_in_cont /= rep_feat.written_in then
							written_in_cont := rep_feat.written_in;
							rep_name_list.update_old_features (f_table,
													written_in_cont);
						end;
						if tmp_rep_class_info.has (written_in_cont) then
							s_rep_name_list := tmp_rep_class_info.item (written_in_cont);
						else
							!!s_rep_name_list.make (
								rep_name_list.parent_clause.parent_id);
							tmp_rep_class_info.put (s_rep_name_list,
													written_in_cont);
							rep_name_list.update_new_features (f_table,
													written_in_cont);
						end;
						f_name := rep_feat.feature_name;
debug ("REPLICATION")
		io.error.putstring ("%Tchecking feature: ");
		io.error.putstring (rep_feat.feature_name);
		io.error.putstring (" ");
		io.error.putstring (rep_feat.generator);
		io.error.new_line;
end;
						old_feat :=	rep_name.old_feature;  
						if	
							old_feat /= Void
						then
							body_id := old_feat.body_id;
							if Rep_feat_server.has (body_id) then
								feature_as := Rep_feat_server.item (body_id)
							else
								feature_as := Body_server.item (body_id)
							end;
							calls_list.wipe_out;
							feature_as.fill_calls_list (calls_list);
							if rep_name_list.has_calls (calls_list) then
debug ("ACTUAL_REPLICATION")
		io.error.putstring ("%Tfeature going to be rep: ");
		io.error.putstring (rep_name.new_feature.feature_name);
		io.error.putstring (" ");
		io.error.putstring (rep_name.new_feature.generator);
		io.error.new_line;
end;
debug ("REPLICATION")
		--calls_list.trace;
		io.error.putstring ("%Tfeature going to be rep: ");
		io.error.putstring (rep_name.new_feature.feature_name);
		io.error.putstring (" ");
		io.error.putstring (rep_name.new_feature.generator);
		io.error.new_line;
end;
								new_feat := rep_name.new_feature;
								replicate_feature (new_feat);
								analyze_replicated_local (new_feat);
								needs_replication := True;
							end;
						end;
					end;
					if needs_replication then
						if not rep_class_info.has_list (s_rep_name_list) then
							s_rep_name_list.update (rep_name_list);
							rep_class_info.put_front (s_rep_name_list);
						end;
						!!s_rep_name;
						s_rep_name.set_old_feature (rep_name.old_feature);
						s_rep_name.set_new_feature (rep_name.new_feature);
						s_rep_name_list.add_replicated_feature (s_rep_name);
						needs_replication := False;
					end;
					rep_name_list.forth;
				end;
				tmp_rep_class_info.clear_all;
				rep_parent_list.forth;
			end;
			if rep_class_info.count > 0 then
				Tmp_rep_info_server.put (rep_class_info);
			elseif Tmp_rep_info_server.has (a_class.id) then
debug ("REPLICATION")
	io.error.putstring ("removing class ");
	io.error.putstring (a_class.class_name);
	io.error.putstring (" from tmp_rep_info server%N");
end;
				Tmp_rep_info_server.remove (a_class.id);
			end
		end;

	analyze_replicated_local (feature_i: FEATURE_I) is
			-- Calculate body_id and feature_id for replicated
			-- feature `feature_i'.
		local
			old_feature: FEATURE_I;
			new_rout_id_set: ROUT_ID_SET;
			info: INHERIT_INFO
		do
			--! The routine id set of feature_i was already done
			--! in unselected in selection list.
			--! Insertion into the origin table was also done
			old_feature := feature_table.item (feature_i.feature_name);
				-- Compute feature id and body index when no clash name
			if old_feature = Void then
					-- Since the old feature table hasn't a feature named
					-- `feature_name', new feature id for the feature
				give_new_feature_id (feature_i);
					-- Compute a body index information
				feature_i.set_body_index (Body_index_counter.next);
			else
					-- Take the previous feature id
				feature_i.set_feature_id (old_feature.feature_id);
				if old_feature.written_in /= a_class.id then
					feature_i.set_body_index (Body_index_counter.next);
				else
					feature_i.set_body_index (old_feature.body_index);
				end;
			end;
				-- A new body id has been computed for `feature_i'.
			Body_index_table.force (new_body_id, feature_i.body_index);
			new_body_id := 0;
			Origins.put_front (feature_i.feature_name);
		end;

	replicate_feature (feat: FEATURE_I) is
			-- If we found a feature named `feature_name' in a previous
			-- feature table, don't change feature id. If this previous
			-- feature didn't change, keep the body id, otherwise compute
			-- a new body id.
		local
			feature_i: FEATURE_I;
			unique_feature: UNIQUE_I;
				-- Feature coming from a previous recompilation
			old_body_id, feature_body_id: INTEGER;
				-- Body id of a previous compiled feature
			old_description: FEATURE_AS_B;
				-- Abstract representation of a previous compiled feature
			is_the_same, old_feature_in_class: BOOLEAN;
				-- Is the parsed feature the saem than a previous
				-- compiled one ?
			feature_name: STRING;
			unique_counter: COUNTER;
			integer_value: INT_VALUE_I;
				-- Internal name of the feature
			external_i: EXTERNAL_I;
		do
			feature_name := feat.feature_name;
debug ("REPLICATION")
	io.error.putstring ("REPLICATE FEATURE_UNIT on ");
	io.error.putstring (feature_name);
	io.error.putstring ("%N");
end;
			feat.set_written_in (a_class.id);
			feat.set_is_code_replicated;


-- FIXME: ask Bertrand
-- The unique keeps the same value if it is replicated

--			if feat.is_unique then
--					-- Unique value processing
--				unique_feature ?= feat;
--				unique_counter := a_class.unique_counter;
--				!!integer_value;
--				integer_value.set_int_val (unique_counter.next);
--				unique_feature.set_value (integer_value);
			if feat.is_external then
					-- Track new externals introduced in the class
				external_i ?= feat;
				if not external_i.encapsulated then
					new_externals.put_front (external_i.external_name);
				end;
			end;
 
				-- Look for a previous definition of the feature
			feature_i := feature_table.item (feature_name);
			if feature_i /= Void then
				old_feature_in_class := feature_i.written_in = a_class.id;
				if old_feature_in_class then
						-- Found a feature of same name and written in the
						-- same class.
						-- For now, give the current feature a 0 body_id.
						-- During process_replication (in CLASS_C) we use
						-- this value for incrementality (it indicates that
						-- this feature already existed from the previous
						-- value, hence we can compare AST).
						--| A special note: we perform actual replication
						--| at the end of the whole pass2 phase so that the
						--| feature_tables of all classes are available 
						--| when replicating `feature_i'.
					old_body_id := 0;
				else
						-- New body id
					new_body_id := Body_id_counter.next;
debug ("REPLICATION")
	io.error.putstring (feature_name);
	io.error.putstring (" inserted in changed_features%N");
end;
					changed_features.put_front (feature_name);
				end
			else
					-- New body id
				new_body_id := Body_id_counter.next;
debug ("REPLICATION")
	io.error.putstring (feature_name);
	io.error.putstring (" inserted in changed_features%N");
end;
				changed_features.put_front (feature_name);
			end;
		end;

end

