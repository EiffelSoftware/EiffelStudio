-- Internal representation of a DLE dynamic system.

class DLE_SYSTEM_I 

inherit

	SYSTEM_I
		redefine
			sorter, dle_max_dr_type_id, is_dynamic, make_update,
			init_recompilation, do_recompilation, process_skeleton,
			make_option_table, freeze_system, process_dynamic_types,
			generate_empty_update_file, generate_skeletons,
			generate_conformance_table, generate_dispatch_table,
			generate_main_eiffel_files, generate_init_file, 
			generate_rout_info_table, generate_option_file,
			generate_cecil, generate_exec_table, shake,
			finalized_generation, melt, generate_reference_table,
			generate_size_table, clear_dle_finalization_data,
			dle_type_set, generate_plug, remove_dead_code,
			dle_finalized_nobid_table, generate_routine_table,
			generate_table, remove_useless_classes, remove_class,
			check_dle_finalize, dle_system_name, dle_max_topo_id,
			dynamic_class_ids
		end

feature -- Initialization

	extending (static: SYSTEM_I) is
			-- Create a dynamic system as an extension of the
			-- static system `static'.
		require
			static_exists: static /= Void;
			extendible: static.extendible
		do
				-- Copy the static system's data structures.
				-- This is a raw copy of all the attributes of `static'.
				-- We could be smarter by copying only what's relevant.

				-- Attributes from `BASIC_SYSTEM_I'.
			any_class := static.any_class;
			array_class := static.array_class;
			bit_class := static.bit_class;
			boolean_class := static.boolean_class;
			boolean_ref_class := static.boolean_ref_class;
			character_class := static.character_class;
			character_ref_class := static.character_ref_class;
			double_class := static.double_class;
			double_ref_class := static.double_ref_class;
			general_class := static.general_class;
			integer_class := static.integer_class;
			integer_ref_class := static.integer_ref_class;
			plug_file := static.plug_file;
			pointer_class := static.pointer_class;
			pointer_ref_class := static.pointer_ref_class;
			real_class := static.real_class;
			real_ref_class := static.real_ref_class;
			special_class := static.special_class;
			string_class := static.string_class;
			to_special_class := static.to_special_class;
			dynamic_class := static.dynamic_class;

				-- Attributes from `SYSTEM_I'.
			rout_info_table := static.rout_info_table;
			class_counter := static.class_counter;
			body_id_counter := static.body_id_counter;
			body_index_counter := static.body_index_counter;
			type_id_counter := static.type_id_counter;
			static_type_id_counter := static.static_type_id_counter;
			feature_counter := static.feature_counter;
			feat_tbl_server := static.feat_tbl_server;
			body_server := static.body_server;
			ast_server := static.ast_server;
			byte_server := static.byte_server;
			rep_server := static.rep_server;
			rep_feat_server := static.rep_feat_server;
			class_info_server := static.class_info_server;
			inv_ast_server := static.inv_ast_server;
			inv_byte_server := static.inv_byte_server;
			depend_server := static.depend_server;
			rep_depend_server := static.rep_depend_server;
			m_feat_tbl_server := static.m_feat_tbl_server;
			m_feature_server := static.m_feature_server;
			m_rout_id_server := static.m_rout_id_server;
			m_desc_server := static.m_desc_server;
			class_comments_server := static.class_comments_server;
			classes := static.classes;
			class_types := static.class_types;
			type_set := static.type_set;
			pattern_table := static.pattern_table;
			successfull := static.successfull;
			private_freeze := static.private_freeze;
			freezing_occurred := static.freezing_occurred;
			history_control := static.history_control;
			instantiator := static.instantiator;
			externals := static.externals;
			system_name := static.system_name;
			root_cluster := static.root_cluster;
			root_class_name := static.root_class_name;
			creation_name := static.creation_name;
			c_file_names := static.c_file_names;
			object_file_names := static.object_file_names;
			makefile_names := static.makefile_names;
			executable_directory := static.executable_directory;
			c_directory := static.c_directory;
			object_directory := static.object_directory;
			first_compilation := static.first_compilation;
			poofter_finalization := static.poofter_finalization;
			new_class := static.new_class;
			new_classes := static.new_classes;
			moved := static.moved;
			update_sort := static.update_sort;
			max_class_id := static.max_class_id;
			freeze_set1 := static.freeze_set1;
			freeze_set2 := static.freeze_set2;
			is_conformance_table_melted := static.is_conformance_table_melted;
			melted_conformance_table := static.melted_conformance_table;
			melted_set := static.melted_set;
			frozen_level := static.frozen_level;
			body_index_table := static.body_index_table;
			original_body_index_table := static.original_body_index_table;
			onbidt := static.onbidt;
			dispatch_table := static.dispatch_table;
			execution_table := static.execution_table;
			server_controler := static.server_controler;
			remover := static.remover;
			remover_off := static.remover_off;
			code_replication_off := static.code_replication_off;
			exception_stack_managed := static.exception_stack_managed;
			has_expanded := static.has_expanded;
			current_pass := static.current_pass;
			current_class := static.current_class;
			makefile_generator := static.makefile_generator;
			cecil_file := static.cecil_file;
			skeleton_file := static.skeleton_file;
			conformance_file := static.conformance_file;
			make_file := static.make_file;
			array_make_name := static.array_make_name;
			optimization_tables := static.optimization_tables;
			array_optimization_on := static.array_optimization_on;
			inlining_on := static.inlining_on;
			inlining_size := static.inlining_size;
			keep_assertions := static.keep_assertions;
			do_not_check_vape := static.do_not_check_vape;
			removed_log_file := static.removed_log_file;
			used_features_log_file := static.used_features_log_file;
			dle_poly_server := static.dle_poly_server;
			dle_eiffel_table := static.dle_eiffel_table;
			dle_remover := static.dle_remover;
			dle_frozen_nobid_table := static.dle_frozen_nobid_table;
			dle_static_calls := static.dle_static_calls;
			dle_system_name := static.system_name;
			address_table := static.address_table;
			routine_id_counter := static.routine_id_counter;

			!! sorter.make;
			!! dynamic_class_ids.make (50);

				-- Save information concerning the static base system.
			dle_array_optimization_on :=
					array_optimization_on and not remover_off;
			!! dle_finalized_nobid_table.make (50);
			dle_finalized_nobid_table.set_threshold (body_id_counter.value);
			dle_type_set := clone (type_set);
			dle_max_dr_type_id := type_id_counter.value;
			dle_max_topo_id := max_class_id;
				-- Keep track of the melted descriptors of 
				-- the static system.
			m_static_desc_server := m_desc_server;

				-- Get rid of the melted data structures of
				-- the base static system.
			freeze_set1.wipe_out;
			freeze_set2.wipe_out;
			melted_set.wipe_out;
			m_feat_tbl_server.clear;
			m_feature_server.clear;
			m_rout_id_server.clear;
			!! m_desc_server.make;
			execution_table.init_dle;
			dispatch_table.init_dle;
			pattern_table.init_dle
		end;

feature -- Access

	sorter: DLE_CLASS_SORTER;
			-- Topological sorter on classes

	dynamic_class_ids: SEARCH_TABLE [CLASS_ID]
			-- Set of ids of dynamic classes

	dle_max_topo_id: INTEGER;
			-- Greatest topological class id of the static system

	dle_max_dr_type_id: INTEGER;
			-- Greatest class_type type_id of the static system

	m_static_desc_server: M_DESC_SERVER;
			-- Server for melted class type descriptors of the static
			-- system

	dle_type_set: ROUT_ID_SET;
			-- Set of the routine ids for which a type table should
			-- have been generated in the extendible system

	dle_finalized_nobid_table: NEW_OLD_TABLE;
			-- Finalized New/Old body id table; Keep track of body_id
			-- modifications between finalization of the static system
			-- and finalization of the dynamic system

	dle_array_optimization_on: BOOLEAN;
			-- Was the array optimization on in the static system?

	dle_make_min_used: INTEGER;
			-- Minimum used type id in the `dle_make' routine table
			-- (Table of the `make' creation routines of the
			-- descendands of DYNAMIC in the DC-set)

	dle_system_name: STRING;
			-- Name of the static system

feature -- Status report

	is_dynamic: BOOLEAN is true;
			-- Is the current system a Dynamic Class Set?

	has_been_frozen: BOOLEAN;
			-- Has the Dynamic Class Set already been frozen?

feature -- Recompilation 

	init_recompilation is
			-- Initialization before the compilation of a dynamic class set.
			-- All the classes in the DC-set should be compiled.
		do
				-- Need to compile all the new dynamic classes.
			Workbench.change_all_new_dynamic_classes

				-- If status of compilation is successfull, copy
				-- a duplication of the body index table in
				-- `origin_body_index_table' and re-initialize the
				-- melted set of feature tables.
			if successfull then
					-- !!!!!!!!!!!!!!
					-- Important Note
					-- !!!!!!!!!!!!!!
					-- There are other references in the system to "THE" 
					-- Original Body Index table (Namely through onces)
					-- We CANNOT do a simple assignment of twin. We need 
					-- to ensure that the object remains the same troughout 
					-- a session. If you want to change it, think thoroughly
					-- before! (Dino, that's an allusion to you, -- FRED)
				original_body_index_table.copy (clone (body_index_table));
				melted_set.wipe_out
			end
		end;

	do_recompilation is
			-- Incremetal recompilation of the system.
		local
			root_class_c: CLASS_C
		do
				-- Recompilation initialization
			init_recompilation

				-- Set the generation mode in workbench mode
			byte_context.set_workbench_mode;

				-- The time checker just checks if there is a possible
				-- conflict for the suppliers of a class, i.e. a new class
				-- has been introduced and can create a conflict
			Time_checker.check_suppliers_of_unchanged_classes;

				-- The `new_classes' list is not used after the time
				-- check. If it was successful, the list can be wiped out.
			new_classes.wipe_out;

				-- If the finalization is still believed to
				-- be straight at this point we need to pervert it
				-- into being a poofter once and for all if if is not
				-- the first compilation and if there are actual classes
				-- to be parsed.
			if not poofter_finalization then
				poofter_finalization := not (first_compilation or else
					pass1_controler.changed_classes.empty);
			end;

				-- Syntax analysis: This maybe add new classes to
				-- the system
			process_pass (pass1_controler);
			
				-- Check generic validity on old classes
				-- generic parameters cannot be new classes
debug ("ACTIVITY")
	io.error.putstring ("%Tnew_class = ");
	io.error.putbool (new_class);
	io.error.new_line;
end;
			if not first_compilation and then new_class then
				check_generics;
					-- The association name <==> supplier has been done in pass1
					-- so even if the compilation fails after this point, the
					-- check must not be done again if no classes are introduced
					-- before the recompilation
			end;
			new_class := False;

			if not Lace.compile_all_classes then
					-- Remove useless classes i.e classes without
					-- syntactical clients. Do not remove descendants
					-- of DYNAMIC in the DC-set.
				remove_useless_classes
			end;

				-- Topological sort and building of the conformance
				-- table (if new classes have been added by first pass)
debug ("ACTIVITY")
	io.error.putstring ("%Tmoved = ");
	io.error.putbool (moved);
	io.error.putstring ("%N%Tupdate_sort = ");
	io.error.putbool (update_sort);
	io.error.new_line;
end;
			update_sort := update_sort or else moved;
			if update_sort then
					-- Sort
				sorter.sort;
					-- Check sum error
				Error_handler.checksum;
					-- Re-sort the list `changed_classes' of `pass2',
					-- because the topological sort modified the class ids,
					-- and the second pass needs it and rebuild the
					-- conformance tables
				pass2_controler.sort;
				pass3_controler.sort;
				pass4_controler.sort;
				build_conformance_table;

					-- Clear the topo sorter
				sorter.clear;

				reset_melted_conformance_table
			end;

				-- Inheritance analysis: list `changed_classes' is
				-- sorted by class ids so the parent come first the
				-- heirs after
			process_pass (pass2_controler);

				-- Check each descendant of DYNAMIC in the DC-set is not
				-- generic and include a `make' procedure with one argument
				-- of type ANY in its creation clause.
			Universe.check_descendants_of_dynamic

				-- Byte code production and type checking
			process_pass (pass3_controler);

			if not Lace.compile_all_classes then
					-- Externals incrementality
				private_freeze := private_freeze or else not externals.equiv
			end;

				-- Process the type system
			process_type_system;

				-- Process the skeleton of classes
			process_skeleton;

				-- Melt the changed features
			melt;

				-- Finalize a successfull compilation
			finalize;

				-- Produce the update file
			if freeze then
					-- Verbose
				io.error.putstring ("Freezing system%N");

				c_comp_actions_freeze_system;
				private_freeze := False;

			else
					-- Verbose
				io.error.putstring ("Melting changes%N");

				execution_table.set_levels;
				dispatch_table.set_levels;
				make_update
debug ("VERBOSE")
	io.error.putstring ("Saving melted.eif%N");
end;
			end;
			first_compilation := False
		end;

feature -- Processing

	process_skeleton is
			-- Type skeleton processing: for a class marked `changed2', the
			-- feature table has changed so the skeleton of its class
			-- types must be re-processed and markged `is_changed' if different.
			-- For a class marked `changed4', inspection of the types (instance
			-- of CLASS_TYPE) looking for a new one (marked `is_changed also).
		local
			a_class: CLASS_C;
			skeleton: SKELETON
		do
debug ("ACTIVITY", "SKELETON")
io.error.putstring ("Process_skeleton%N");
end;
			from
				pass4_controler.changed_classes.start
			until
				pass4_controler.changed_classes.after
			loop
				a_class := pass4_controler.changed_classes.item.associated_class;
debug ("ACTIVITY", "SKELETON")
io.error.putstring ("%T");
io.error.putstring (a_class.class_name);
io.error.putstring ("%N");
end;
					-- Process skeleton(s) for `a_class'.
				if a_class.has_types then
					a_class.process_skeleton;

					check
						has_class_type: not a_class.types.empty
					end;
						-- Check valididty of special classes ARRAY, STRING,
						-- TO_SPECIAL, SPECIAL
					a_class.check_validity;
				end;

				pass4_controler.changed_classes.forth
			end;

				-- Check expanded client relation
			check_expanded;

				-- Check sum error
			Error_handler.checksum
		end;

	process_dynamic_types is
			-- Processing of the dynamic types
		local
			class_list: ARRAY [CLASS_C];
			a_class: CLASS_C;
			types: TYPE_LIST;
			class_type: CLASS_TYPE;
			new_type_id, i, nb: INTEGER
		do

				-- First re-process all the type id of instances of
				-- CLASS_TYPE available in attribute list `types' of
				-- instances of CLASS_C

debug ("ACTIVITY")
	io.error.putstring ("Process dynamic types%N");
end;
				-- Sort the class_list by type id in `class_list'.
			from
				classes.start;
				nb := max_class_id;
				!!class_list.make (1, nb)
			until
				classes.after
			loop
				a_class := classes.item_for_iteration;
				class_list.put (a_class, a_class.topological_id);
				classes.forth
			end;

				-- Iteration on `class_list' in order to compute new type id's.
				-- Recompute only the types of the DLE system, keeping the
				-- static system type ids unchanged.
			from
					-- Reset the type id counter to the maximum `type_id'
					-- of the static system.
				type_id_counter.set_value (dle_max_dr_type_id);
				i := 1
			until
				i > nb
			loop
					-- Types of the class
				types := class_list.item (i).types;
				from
					types.start
				until
					types.after
				loop
					class_type := types.item;
					if class_type.is_dynamic then
						new_type_id := type_id_counter.next;
						class_type.set_type_id (new_type_id);
debug ("ACTIVITY")
	io.error.putint (new_type_id);
	io.error.putstring (": ");
	class_type.type.trace;
	io.error.putstring (" [");
	io.error.putint (class_type.id.id);
	io.error.putstring ("]%N");
end;
							-- Update `class_types'
						insert_class_type (class_type)
					end;
					types.forth
				end;
				i := i + 1
			end
		end;

	remove_useless_classes is
			-- Remove useless classes.
		local
			class_id: CLASS_ID;
			a_class: CLASS_C;
			root_class_c: CLASS_C;
			marked_classes: SEARCH_TABLE [CLASS_ID];
			vd31: VD31
		do

				-- First mark all the classes that can be
				-- reached from the root class
			!! marked_classes.make (System_chunk);

			root_class_c := root_class.compiled_class;
			root_class_c.mark_class (marked_classes);
			general_class.compiled_class.mark_class (marked_classes);
			any_class.compiled_class.mark_class (marked_classes);
			double_class.compiled_class.mark_class (marked_classes);
			real_class.compiled_class.mark_class (marked_classes);
			integer_class.compiled_class.mark_class (marked_classes);
			boolean_class.compiled_class.mark_class (marked_classes);
			character_class.compiled_class.mark_class (marked_classes);
			array_class.compiled_class.mark_class (marked_classes);
			bit_class.compiled_class.mark_class (marked_classes);
			pointer_class.compiled_class.mark_class (marked_classes);

				-- Mark the descendants of DYNAMIC in the DC-set.
			from
				dynamic_class_ids.start
			until
				dynamic_class_ids.after
			loop
				class_id := dynamic_class_ids.item_for_iteration;
				a_class := class_of_id (class_id);
				if a_class /= Void then
					if a_class.syntactical_inherits_from_dynamic then
						a_class.mark_class (marked_classes)
					end
				end;
				dynamic_class_ids.forth
			end;

				-- Remove all the classes that cannot be reached if they are
				-- not protected
			from
				classes.start
			until
				classes.after
			loop
				a_class := classes.item_for_iteration;
				if not marked_classes.has (a_class.id) then
					if a_class.has_visible then
						!!vd31;
						vd31.set_class_name (a_class.class_name);
						vd31.set_cluster (a_class.cluster);
						Error_handler.insert_error (vd31)
					else
debug ("REMOVE_CLASS")
	io.error.putstring ("Remove useless classes: ");
	io.error.putstring (a_class.class_name);
	io.error.new_line
end;
						remove_class (a_class)
					end
				end;
				classes.forth
			end;
			Error_handler.checksum
		end;

	remove_class (a_class: CLASS_C) is
			-- Remove class `a_class' from the system even if
			-- it has syntactical_clients.
		local
			parents: ARRAYED_LIST [CL_TYPE_A];
			compiled_root_class: CLASS_C;
			descendants, suppliers, clients: LINKED_LIST [CLASS_C];
			supplier: CLASS_C;
			supplier_clients: LINKED_LIST [CLASS_C];
			id: CLASS_ID;
			types: TYPE_LIST;
			ftable: FEATURE_TABLE;
			f: FEATURE_I;
			ext: EXTERNAL_I
		do
			if a_class.is_dynamic then
				id := a_class.id;

debug ("ACTIVITY", "REMOVE_CLASS");
	io.error.putstring ("%TRemoving class ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end;
					-- Update control flags of the topological sort
				moved := True;

					-- Remove type check relations
				if a_class.parents /= Void then
					a_class.remove_relations
				end;

					-- Remove one occurrence for each external written
					-- in the class
				if Feat_tbl_server.has (id.id) then
					ftable := Feat_tbl_server.item (id.id);
					from ftable.start until ftable.after loop
						f := ftable.item_for_iteration;
						if f.is_external and then equal (f.written_in, id) then
							ext ?= f;
								-- If the external is encapsulated then it was
								-- not added to the list of new externals in
								-- inherit_table. Same thing if it has to be
								-- removed if not ext.encapsulated then
							if not ext.encapsulated then
								Externals.remove_occurence (ext.external_name)
							end
						end;
						ftable.forth
					end
				end;

					-- Remove class `a_class' from the lists of changed classes
				pass1_controler.remove_class (a_class);
				pass2_controler.remove_class (a_class);
				pass3_controler.remove_class (a_class);
				pass4_controler.remove_class (a_class);

					-- Mark the class to remove uncompiled
				a_class.lace_class.reset_compiled_class

					-- Remove its types
				from
					types := a_class.types;
					types.start
				until
					types.after
				loop
					class_types.put (Void, types.item.type_id);
					types.forth
				end;

					-- Remove if from the servers
debug ("ACTIVITY");
	io.error.putstring ("%TRemoving id from servers: ");
	io.error.putint (id.id);
	io.error.new_line;
end;
				Inv_byte_server.remove (id.id);
				Ast_server.remove (id.id);
				Feat_tbl_server.remove (id.id);
				Class_info_server.remove (id.id);
				Inv_ast_server.remove (id.id);
				Depend_server.remove (id.id);
				Rep_depend_server.remove (id.id);
				M_rout_id_server.remove (id.id);
				M_desc_server.remove (id.id);

				Tmp_inv_byte_server.remove (id.id);
				Tmp_ast_server.remove (id.id);
				Tmp_feat_tbl_server.remove (id.id);
				Tmp_class_info_server.remove (id.id);
				Tmp_rep_info_server.remove (id.id);
				Tmp_inv_ast_server.remove (id.id);
				Tmp_depend_server.remove (id.id);
				Tmp_rep_depend_server.remove (id.id);
				Tmp_m_rout_id_server.remove (id.id);
				Tmp_m_desc_server.remove (id.id);

				freeze_set1.prune (id);
				freeze_set2.prune (id);
				melted_set.prune (id);
				dynamic_class_ids.remove (id);
				classes.remove (id);

					-- Remove client/supplier syntactical relations
					-- and remove classes recursively
				from
					a_class.syntactical_suppliers.start
					if root_class /= Void then
						compiled_root_class := root_class.compiled_class
					end
				until
					a_class.syntactical_suppliers.off
				loop
					supplier := a_class.syntactical_suppliers.item.supplier;
					supplier_clients := supplier.syntactical_clients;
					supplier_clients.start;
					supplier_clients.compare_references;
					supplier_clients.search (a_class);
					check
						not_after: not supplier_clients.after
					end;
					supplier_clients.remove;
					if
						supplier_clients.empty and then
							-- The root class is not removed
							-- true only if the root class has changed and
							-- was a client for a removed class
						supplier /= compiled_root_class and then
							-- Cannot propagate for a protected class
						not supplier.id.protected and then
							-- Do not remove descendants of DYNAMIC in
							-- the DC-set.
						(supplier.is_static or else
						not supplier.syntactical_inherits_from_dynamic) and then
							-- A recursion may occur when removing a cluster
						classes.has (supplier.id)
					then
						remove_class (supplier)
					end;
					a_class.syntactical_suppliers.forth
				end
			end
		end;

feature -- Melting

	melt is
			-- Melt the changed features and feature and
			-- descriptor tables in the system.
		local
			a_class: CLASS_C;
			id_list: LINKED_LIST [CLASS_ID];
			i: INTEGER;
			temp: STRING
		do
				-- Melt features
				-- Open the file for writing on disk feature byte code
			process_pass (pass4_controler);
			current_pass := Void;

				-- The dispatch and execution tables are now updated.

			if not freeze then
debug ("COUNT")
	i := melted_set.count;
end;
					-- Melt the feature tables
					-- Open first the file for writing on disk melted feature
					-- tables
				from
					id_list := melted_set;
					id_list.start
				until
					id_list.off
				loop
					a_class := class_of_id (id_list.item);
						-- Verbose
debug ("COUNT")
	io.error.putstring ("[");
	io.error.putint (i);
	io.error.putstring ("] ");
	i := i - 1;
end;
					io.error.putstring ("Degree 1: class ");
						temp := clone (a_class.class_name);
						temp.to_upper;
					io.error.putstring (temp);
					io.error.new_line;
					a_class.melt_dle_feature_table;
					a_class.melt_dle_descriptor_tables;
					id_list.forth
				end;
				melted_set.wipe_out
			end
		end;

	make_update is
			-- Produce the file containing melted information of the
			-- Dynamic Class Set.
		local
			id_list: LINKED_LIST [CLASS_ID];
			a_class: CLASS_C;
			types: TYPE_LIST;
			feat_tbl: MELTED_FEATURE_TABLE;
			class_id: CLASS_ID;
			file_pointer: POINTER;
			cl_type: CLASS_TYPE;
			temp: STRING;
			nb_tables: INTEGER;
			server_id: INTEGER
		do
debug ("DLE ACTIVITY")
	io.error.putstring ("Creating melted.dle%N");
end;
			Melted_dle_file.open_write;
			file_pointer := Melted_dle_file.file_pointer;

			if has_been_frozen then
					-- The system has been frozen.
				Melted_dle_file.putchar ('%/001/')
			else
				Melted_dle_file.putchar ('%U')
			end;
				-- The DC-set is melted.
			Melted_dle_file.putchar ('%/001/');

				-- Write first the number of class types now available
			write_int (file_pointer, type_id_counter.value);
				-- Write the number of classes now available
			write_int (file_pointer, class_counter.total_count);
				-- Write DYNAMIC dtype
			write_int (file_pointer, dynamic_dtype - 1);
				-- Write first the new size of the dispatch table
			dispatch_table.write_dispatch_count (Melted_dle_file);


debug ("DLE ACTIVITY")
	io.error.putstring ("%Tfeature tables%N");
end;
				-- Count of feature tables to update.
			from
				id_list := freeze_set2;
				id_list.start
			until
				id_list.after
			loop
				a_class := class_of_id (id_list.item);
				nb_tables := nb_tables + 
					(a_class.types.count - a_class.nb_static_class_types);
				id_list.forth
			end;
				-- Write the number of feature tables to update
			write_int (file_pointer, nb_tables);

debug ("DLE ACTIVITY")
	io.error.putstring ("%Tbyte code%N");
end;
				-- Write then the byte code for feature tables to update.
				-- First, open the reading file associated to the melted
				-- feature table server.
			from
				id_list.start
			until
				id_list.after
			loop
				a_class := class_of_id (id_list.item);
	
debug ("DLE ACTIVITY")
	io.error.putstring ("%T%T");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end;
				from
					types := a_class.types;
					types.start
				until
					types.after
				loop
					if not types.item.is_static then
						feat_tbl := m_feat_tbl_server.item (types.item.type_id);
debug ("DLE ACTIVITY")
	io.error.putstring ("melting class desc of ");
	types.first.type.trace;
	io.error.new_line;
end;
						feat_tbl.store (Melted_dle_file)
					end;
					types.forth
				end;
				id_list.forth
			end;

debug ("DLE ACTIVITY")
	io.error.putstring ("%TMelted routine id array%N");
end;
				-- Melted routine id array
			from
				m_rout_id_server.start
			until
				m_rout_id_server.after
			loop
				server_id := m_rout_id_server.key_for_iteration;
				class_id := m_rout_id_server.disk_item (server_id).class_id;
				a_class := class_of_id (class_id);
debug ("DLE ACTIVITY")
io.error.putstring ("melting routine id array of ");
io.error.putstring (a_class.class_name);
io.error.putstring (" (class_id #");
io.error.putint (class_id.id);
io.error.putstring (")");
io.error.new_line;
end;
				write_int (file_pointer, class_id.id);
				m_rout_id_server.item (class_id.id).store (Melted_dle_file);
				from
					types := a_class.types;
					types.start
				until
					types.after
				loop
					cl_type := types.item;
						-- Write dynamic type
					write_int (file_pointer, cl_type.type_id - 1);
						-- Write original dynamic type (first freezing)
					write_int (file_pointer, cl_type.id.id - 1);
					types.forth
				end;
				write_int (file_pointer, -1);
				m_rout_id_server.forth
			end;
			write_int (file_pointer, -1);

				-- Update the dispatch table
			Dispatch_table.make_update (Melted_dle_file);

				-- Open the file for reading byte code for melted features
				-- Update the execution table
			execution_table.make_melted_dle (Melted_dle_file);

			make_conformance_table_byte_code (Melted_dle_file);

			make_option_table (Melted_dle_file);

			make_rout_info_table (Melted_dle_file);

				-- Melted descriptors
			from
				M_desc_server.start
			until
				M_desc_server.after
			loop
				server_id := M_desc_server.key_for_iteration;
				M_desc_server.item (server_id).store (Melted_dle_file);
				M_desc_server.forth
			end;
			from
				M_static_desc_server.start
			until
				M_static_desc_server.after
			loop
				server_id := M_static_desc_server.key_for_iteration;
				M_static_desc_server.item (server_id).store (Melted_dle_file);
				M_static_desc_server.forth
			end;
				-- End mark
			write_int (file_pointer, -1);

			Melted_dle_file.close;
		end;

	make_option_table (file: RAW_FILE) is
			-- Generate byte code for the option table.
		local
			i, nb: INTEGER;
			cl_type: CLASS_TYPE;
			a_class: CLASS_C
		do
debug ("OPTIONS")
	io.error.putstring ("Making option table%N");
end;
			Byte_array.clear;
			from
					-- Start the iteration from the maximum `type_id' 
					-- value of the static system.
				i := dle_max_dr_type_id + 1;
				nb := Type_id_counter.value
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				if cl_type /= Void then
						-- Classes could be removed
					Byte_array.append_short_integer (cl_type.type_id - 1);
					a_class := cl_type.associated_class;
debug ("OPTIONS")
	io.error.putstring ("%TClass ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end;
					a_class.assertion_level.make_byte_code (Byte_array);
					a_class.debug_level.make_byte_code (Byte_array);
					a_class.trace_level.make_byte_code (Byte_array);
					a_class.profile_level.make_byte_code (Byte_array)
				end;
				i := i + 1
			end;
				-- End mark
			Byte_array.append_short_integer (-1);

				-- Put the byte code description of the option table
				-- in update file
			Byte_array.character_array.store (file)
		end;

feature -- Freeezing

	freeze_system is
			-- Workbench C code generation.
		local
			a_class: CLASS_C;
			id_list: LINKED_LIST [CLASS_ID];
			descriptors: ARRAY [INTEGER];
			i, nb: INTEGER;
			temp: STRING;
			server_id: INTEGER
		do
			freezing_occurred := True;
			!WBENCH_DLE_MAKER!makefile_generator.make;

				-- Re-process dynamic types
			--process_dynamic_types;

				-- Process the C pattern table
debug ("ACTIVITY")
	io.error.putstring ("pattern_table.process%N");
end;
			pattern_table.process;

debug ("ACTIVITY")
	io.error.putstring ("Clear the melted code servers%N");
end;
				-- Clear the melted byte code servers
			m_feat_tbl_server.clear;
			m_feature_server.clear;
			m_rout_id_server.clear;

debug ("ACTIVITY")
	io.error.putstring ("Shake%N");
end;
				-- Rebuild the dispatch table and the execution tables
			shake;

				-- Generation of the descriptor tables
			if First_compilation then
				from
					id_list := freeze_set2;
debug ("COUNT")
	i := id_list.count;
end;
					id_list.start
				until
					id_list.off
				loop
					a_class := class_of_id (id_list.item);
debug ("COUNT")
	io.error.putstring ("[");
	io.error.putint (i);
	io.error.putstring ("] ");
	i := i - 1;
end;
						-- Verbose
					io.error.putstring ("Degree -1: class ");
						temp := clone (a_class.class_name);
						temp.to_upper;
					io.error.putstring (temp);
					io.error.new_line;

					a_class.generate_descriptor_tables;

					id_list.forth
				end;
			else
				from
					descriptors := m_desc_server.current_keys;
					i := 1;
					nb := descriptors.count;
				until
					i > nb
				loop
					server_id := descriptors.item (i);
					a_class := class_of_id (m_desc_server.disk_item (server_id).class_id);
					if a_class /= Void then
						melted_set.put (a_class.id)
					end;
					i := i + 1
				end;
				from
					id_list := melted_set;
					id_list.start
debug ("COUNT")
	i := melted_set.count;
end;
				until
					id_list.off
				loop
					a_class := class_of_id (id_list.item);
debug ("COUNT")
	io.error.putstring ("[");
	io.error.putint (i);
	io.error.putstring ("] ");
	i := i - 1;
end;
					if a_class /= Void then
							-- Verbose
						io.error.putstring ("Degree -1: class ");
							temp := clone (a_class.class_name);
							temp.to_upper;
						io.error.putstring (temp);
						io.error.new_line;

						a_class.generate_dle_descriptor_tables
					end;
					id_list.forth
				end;
			end;

			m_desc_server.clear;
			melted_set.wipe_out;

			from
				id_list := freeze_set1;
debug ("COUNT")
	i := id_list.count;
end;
				id_list.start
				open_log_files
			until
				id_list.off
			loop
				a_class := class_of_id (id_list.item);
debug ("COUNT")
	io.error.putstring ("[");
	io.error.putint (i);
	io.error.putstring ("] ");
	i := i - 1;
end;
					-- Verbose
				io.error.putstring ("Degree -2: class ");
					temp := clone (a_class.class_name);
					temp.to_upper;
				io.error.putstring (temp);
				io.error.new_line;

				a_class.dle_generate_wkbench_code;

				id_list.forth
			end;
			close_log_files;

			from
				id_list := freeze_set2;
debug ("COUNT")
	i := id_list.count;
end;
				id_list.start
			until
				id_list.off
			loop
				a_class := class_of_id (id_list.item);
debug ("COUNT")
	io.error.putstring ("[");
	io.error.putint (i);
	io.error.putstring ("] ");
	i := i - 1;
end;
				if a_class.is_dynamic then
						-- Verbose
					io.error.putstring ("Degree -3: class ");
						temp := clone (a_class.class_name);
						temp.to_upper;
					io.error.putstring (temp);
					io.error.new_line;

					a_class.generate_feature_table;
				end;

				id_list.forth
			end;

debug ("ACTIVITY")
io.error.putstring ("Generating tables...%N");
end;

			freeze_set1.wipe_out;
			freeze_set2.wipe_out;
			generate_main_eiffel_files
		end;

	shake is
			-- Real shake compresses the dispatch and execution tables
			-- Not called because the descriptors must be reprocessed
			-- if a dispatch unit is moved (real_body_index changes)
		local
			exec_unit: EXECUTION_UNIT;
			external_unit: EXT_EXECUTION_UNIT;
			info: EXTERNAL_INFO
        do
 
			update_valid_body_ids;
 
			execution_table.shake_dle;
			dispatch_table.shake_dle;
 
			from
				execution_table.start
			until
				execution_table.after
			loop
				exec_unit := execution_table.item_for_iteration;
				if exec_unit.is_external and then exec_unit.is_valid then
					external_unit ?= exec_unit;
					check
						externals.has (external_unit.external_name);
					end;
					info := externals.item (external_unit.external_name);
					info.set_execution_unit (external_unit);
				end;
				execution_table.forth
			end;

				-- Reset the frozen level since the execution table
				-- is re-built now.
			frozen_level := execution_table.frozen_level;
			execution_table.set_levels;
			dispatch_table.set_levels;

				-- Freeze the external table: reset the real body ids,
				-- remove all unused externals and make the duplication
			externals.freeze
		end;

feature -- Final mode 

	finalized_generation (keep_assert: BOOLEAN) is
			-- Finalized generation.
		local
			class_id: CLASS_ID;
			a_class: CLASS_C;
			temp: STRING;
			old_remover_off: BOOLEAN;
			old_exception_stack_managed: BOOLEAN;
			old_inlining_on, old_array_optimization_on: BOOLEAN
		do
			keep_assertions := keep_assert and then Lace.has_assertions;

				-- Save the value of `remover_off'
				-- and `exception_stack_managed'
			old_remover_off := remover_off;
			old_exception_stack_managed := exception_stack_managed;
			old_inlining_on := inlining_on;
			old_array_optimization_on := array_optimization_on;

				-- Should dead code be removed?
			if not remover_off then
				remover_off := keep_assertions
			end;
			if not exception_stack_managed then
				exception_stack_managed := keep_assertions
			end;

			inlining_on := inlining_on and not remover_off;
			array_optimization_on := array_optimization_on and not remover_off;

				-- Set the generation mode in final mode
			byte_context.set_final_mode;

				-- Retrieve data stored during the last finalization
				-- of the dynamically extendible system.
			tmp_poly_server.copy (dle_poly_server);
			Eiffel_table.init_dle (Old_eiffel_table);

			from
				dynamic_class_ids.start
			until
				dynamic_class_ids.after
			loop
				class_id := dynamic_class_ids.item_for_iteration;
				a_class := class_of_id (class_id);
debug ("COUNT");
	io.error.putstring ("[");
--	io.error.putint (nb-i+1);
	io.error.putstring ("] ");
end;
				if a_class /= Void then
						-- Verbose
					io.error.putstring ("Degree -4: class ");
						temp := clone (a_class.class_name)
						temp.to_upper;
					io.error.putstring (temp);
					io.error.new_line;

					a_class.process_polymorphism;
					History_control.check_overload
				end;

				dynamic_class_ids.forth
			end;
			History_control.transfer;
			tmp_poly_server.flush;

				-- Dead code removal
			if not remover_off then
					-- Verbose
				io.error.putstring ("Removing dead code%N");
				remove_dead_code
			end;
			tmp_opt_byte_server.flush;

				-- Check whether some feature calls have been statically bound
				-- in the extendible system, but need to be dynamically bound
				-- because of the DC-set.
			check_static_calls;

			!FINAL_DLE_MAKER! makefile_generator.make;

			--process_dynamic_types;

				-- Generation of C files associated to the classes of
				-- the system.
			from
				classes.start;
				open_log_files
			until
				classes.after
			loop
				a_class := classes.item_for_iteration;
						-- Verbose
debug ("COUNT")
	io.error.putstring ("[");
--	io.error.putint (nb-i+1);
	io.error.putstring ("] ");
end;
				current_class := a_class;
				if a_class.dle_generate_final_code then
					io.error.putstring ("Degree -5: class ");
						temp := clone (a_class.class_name)
						temp.to_upper;
					io.error.putstring (temp);
					io.error.new_line
				end

				classes.forth
			end;
			close_log_files;

			generate_table;

				-- Generate makefile
			generate_make_file;

				-- Address table
			address_table.generate (True)

				-- Generate DLE file
			generate_dle_file;

				-- Clean Eiffel table
			Eiffel_table.wipe_out;
			Old_eiffel_table.wipe_out;
			Tmp_poly_server.clear;
			Tmp_opt_byte_server.clear;

			remover := Void;
			remover_off := old_remover_off;
			exception_stack_managed := old_exception_stack_managed;
			inlining_on := old_inlining_on;
			array_optimization_on := old_array_optimization_on
		rescue
				-- Clean the servers if the finalization is aborted
			Tmp_poly_server.flush;
			Tmp_poly_server.clear;
			Tmp_opt_byte_server.flush;
			Tmp_opt_byte_server.clear
		end;

	check_dle_finalize is
			-- If the user asked for a finalization then check whether
			-- the static system has been finalized as well.
		local
			v9fm: V9FM
		do
			if Compilation_modes.is_finalizing then
				if dle_poly_server = Void then
						-- The static system has not been finalized.
					!! v9fm;
					Error_handler.insert_error (v9fm);
					Error_handler.checksum
				end
			end
		end;

	check_static_calls is
			-- Check whether the statically bound calls in the static system
			-- need not to be dynamically bound now.
		local
			table: POLY_TABLE [ENTRY];
			type_id: INTEGER;
			rout_id: ROUTINE_ID;
			rout_ids: DLE_STATIC_CALLS;
			feature_table: FEATURE_TABLE;
			class_c: CLASS_C;
			feat: FEATURE_I;
			v9sc: V9SC
		do
			from
				dle_static_calls.start
			until
				dle_static_calls.after
			loop
				type_id := dle_static_calls.key_for_iteration;
				rout_ids := dle_static_calls.item (type_id);
				from
					rout_ids.start
				until
					rout_ids.after
				loop
					class_c := class_types.item (type_id).associated_class;
					feature_table := class_c.feature_table;
					rout_id := rout_ids.item;
					table := Eiffel_table.poly_table (rout_id);
					if table.is_polymorphic (type_id) then
							-- The call is not statically bound anymore.
						feat := feature_table.feature_of_rout_id (rout_id);
						if feat /= Void then
							!! v9sc;
							v9sc.set_class (class_c);
							v9sc.set_feature (feat);
							Error_handler.insert_error (v9sc)
						end
					end;
					rout_ids.forth
				end;
				dle_static_calls.forth
			end;
			Error_handler.checksum
		end;

	clear_dle_finalization_data is
			-- Get rid of the data stored during the last
			-- final mode compilation normally used when finalizing
			-- the Dynamic Class Set.
		do
			-- Do nothing here since we do want to keep these data
			-- for the finalization of the dynamic system.
		end;

feature -- Generation

	generate_main_eiffel_files is
			-- Generate the "e*.c" files of the DC-set.
		do
			generate_skeletons;
			generate_cecil;
			generate_conformance_table;
			is_conformance_table_melted := False;
			melted_conformance_table := Void;
			generate_plug;
			generate_init_file;
			generate_option_file;
			address_table.generate (False);
			generate_rout_info_table;
			pattern_table.generate_dle;
			generate_make_file;
			generate_dispatch_table;
			generate_exec_table;
			generate_dle_file;
			generate_empty_update_file
		end;

	generate_empty_update_file is
			-- Produce the file containing melted information of the
			-- static system when freezing the Dynamic Class Set.
		local
			file_pointer: POINTER;
			class_id: CLASS_ID;
			server_id: INTEGER
		do
debug ("DLE ACTIVITY")
	io.error.putstring ("Creating melted.dle%N");
end;
			Melted_dle_file.open_write;
			file_pointer := Melted_dle_file.file_pointer;

				-- The system has been frozen.
			has_been_frozen := true;
			Melted_dle_file.putchar ('%/001/');
				-- The DC-set is not melted.
			Melted_dle_file.putchar ('%U');
				-- Write first the number of class types now available
			write_int (file_pointer, type_id_counter.value);
				-- Write the number of classes now available
			write_int (file_pointer, class_counter.total_count);
				-- Write DYNAMIC dtype
			write_int (file_pointer, dynamic_dtype - 1);
				-- Write first the new size of the dispatch table
			Dispatch_table.write_dispatch_count (Melted_dle_file);

				-- Melted descriptors
			from
				M_static_desc_server.start
			until
				M_static_desc_server.after
			loop
				server_id := M_static_desc_server.key_for_iteration;
				M_static_desc_server.item (server_id).store (Melted_dle_file);
				M_static_desc_server.forth
			end;
				-- End mark
			write_int (file_pointer, -1);

			Melted_dle_file.close
		end;

	generate_skeletons is
			-- Generate skeletons of class types of the DC-set.
		local
			i, nb, nb_class: INTEGER;
			cl_type: CLASS_TYPE;
			a_class: CLASS_C;
			has_attribute, final_mode: BOOLEAN;
			types: TYPE_LIST
		do
			nb := Type_id_counter.value;
			final_mode := in_final_mode;

				-- Open skeleton file
			Skeleton_file := Skeleton_f (final_mode);
			Skeleton_file.open_write;

			Skeleton_file.putstring ("#include %"struct.h%"%N");
			Skeleton_file.putstring ("#include %"macros.h%"%N");
			if final_mode then
				Skeleton_file.putstring ("#include %"");
				Skeleton_file.putstring (Eskelet);
				Skeleton_file.putstring (Dot_h);
				Skeleton_file.putstring ("%"%N%N");
				from
						-- Start the iteration from the maximum `type_id' 
						-- value of the static system.
					i := dle_max_dr_type_id + 1
				until
					i > nb
				loop
					cl_type := class_types.item (i);
					if cl_type /= Void then
						cl_type.skeleton.make_extern_declarations
					end;
					i := i + 1
				end;
				Extern_declarations.generate (final_file_name (Eskelet, Dot_h));
				Extern_declarations.wipe_out
			else
				Skeleton_file.new_line;
				from
					classes.start
				until
					classes.after
				loop
					a_class := classes.item_for_iteration;
					i := a_class.id.id;
					if a_class.has_dynamic then
						if not a_class.is_precompiled then
							Skeleton_file.putstring ("extern int32 ra");
							Skeleton_file.putint (i);
							Skeleton_file.putstring ("[];%N");
						end;
						if a_class.has_visible then
							Skeleton_file.putstring ("extern char *cl");
							Skeleton_file.putint (i);
							Skeleton_file.putstring ("[];%N");
							Skeleton_file.putstring ("extern uint32 cr");
							Skeleton_file.putint (i);
							Skeleton_file.putstring ("[];%N");
						end;
						if not a_class.skeleton.empty then
							from
								types := a_class.types;
								types.start
							until
								types.after
							loop
								if types.item.is_dynamic then
									Skeleton_file.putstring 
											("extern uint32 types");
									Skeleton_file.putint (types.item.type_id);
									Skeleton_file.putstring ("[];%N")
								end;
								types.forth
							end
						end
					end;

					classes.forth
				end;
				Skeleton_file.new_line
			end;

			from 
					-- Start the iteration from the maximum `type_id' 
					-- value of the static system.
				i := dle_max_dr_type_id + 1
			until
				i > nb
			loop
				cl_type := class_types.item (i);
					-- Classes could be removed
				if cl_type /= Void then
					cl_type.generate_skeleton1
				end;
				i := i + 1
			end;

			Skeleton_file.putstring ("void dle_eskelet()");
			Skeleton_file.new_line;
			Skeleton_file.putchar ('{');
			Skeleton_file.new_line;
			Skeleton_file.indent;
			Skeleton_file.putstring ("struct cnode *node;");
			Skeleton_file.new_line;
			if final_mode then
				Skeleton_file.new_line;
				Skeleton_file.putstring ("esystem = (struct cnode *)cmalloc(");
				Skeleton_file.putint (Type_id_counter.value);
				Skeleton_file.putstring (" * sizeof(struct cnode));");
				Skeleton_file.new_line;
				Skeleton_file.putstring ("if (esystem == (struct cnode *) 0)");
				Skeleton_file.new_line;
				Skeleton_file.indent;
				Skeleton_file.putstring ("enomem();");
				Skeleton_file.new_line;
				Skeleton_file.exdent;
				Skeleton_file.putstring ("bcopy(fsystem, esystem, ");
				Skeleton_file.putint (dle_max_dr_type_id);
				Skeleton_file.putstring (" * sizeof(struct cnode));");
				Skeleton_file.new_line
			else
				Skeleton_file.putstring ("struct ctable *cecil_tab;");
				Skeleton_file.new_line
			end;
			from
					-- Start the iteration from the maximum `type_id' 
					-- value of the static system.
				i := dle_max_dr_type_id + 1
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				if cl_type /= Void and then cl_type.is_dynamic then
					Skeleton_file.new_line;
					cl_type.generate_dle_skeleton
				end;
				i := i + 1
			end;

			if not final_mode then
					-- Generate the array of routine id arrays
				Skeleton_file.new_line;
				from
						-- Start the iteration from the maximum `type_id' 
						-- value of the static system.
					i := dle_max_dr_type_id + 1
				until
					i > nb
				loop
					cl_type := class_types.item (i);
					Skeleton_file.putstring ("Routids(");
					Skeleton_file.putint (cl_type.id.id - 1);
					Skeleton_file.putstring (") = ");
					if
						cl_type /= Void and then
						not cl_type.associated_class.is_precompiled
					then
						Skeleton_file.putstring ("ra");
						Skeleton_file.putint (cl_type.associated_class.id.id);
					else
						Skeleton_file.putstring ("(int32 *) 0")
					end;
					Skeleton_file.putchar (';');
					Skeleton_file.new_line
					i := i + 1
				end
			else
				Skeleton_file.exdent;
				Skeleton_file.putchar ('}');
				Skeleton_file.new_line;
				Skeleton_file.new_line;
				Skeleton_file.putstring ("void free_eskelet()");
				Skeleton_file.new_line;
				Skeleton_file.putchar ('{');
				Skeleton_file.new_line;
				Skeleton_file.indent;
				Skeleton_file.putstring ("xfree(esystem);");
				Skeleton_file.new_line;
				Skeleton_file.putstring ("esystem = fsystem;");
				Skeleton_file.new_line
			end;
			Skeleton_file.exdent;
			Skeleton_file.putchar ('}');
			Skeleton_file.new_line;
			Skeleton_file.new_line

				-- Close skeleton file
			Skeleton_file.close;
			Skeleton_file := Void
		end;

	generate_cecil is
			-- Generate Cecil structures.
		local
			i, nb, generic, no_generic: INTEGER;
			cl_type: CLASS_TYPE;
			a_class: CLASS_C;
			final_mode: BOOLEAN;
			temp: STRING;
			subdir: DIRECTORY;
			f_name: FILE_NAME;
			dir_name: DIRECTORY_NAME
		do
			final_mode := byte_context.final_mode;
			Cecil_file := cecil_f (final_mode);
			Cecil_file.open_write;
			Cecil_file.putstring ("#include %"cecil.h%"%N");
			if final_mode then
				Cecil_file.putstring ("#include %"ececil.h%"%N")
			end;
			Cecil_file.putstring ("#include %"struct.h%"%N%N");
			Cecil_file.putstring ("extern struct ctable ce_type;%N");
			Cecil_file.putstring ("extern struct ctable ce_gtype;%N%N");
			from
				classes.start
			until
				classes.after
			loop
				a_class := classes.item_for_iteration;
				if a_class.has_visible then
					a_class.dle_generate_cecil
				end;
				classes.forth
			end;
			make_cecil_tables;
			Cecil2.generate;
			Cecil3.generate;
			Cecil_file.putstring ("void dle_evisib()");
			Cecil_file.new_line;
			Cecil_file.putchar ('{');
			Cecil_file.new_line;
			Cecil_file.indent;
			if final_mode then
					-- Extern declarations for previous file
				temp := clone (System_object_prefix);
				temp.append_integer (1);
				!!dir_name.make_from_string (Final_generation_path);
				dir_name.extend (temp);
				!! subdir.make (dir_name);
				if not subdir.exists then
					subdir.create
				end;
				!!f_name.make_from_string (dir_name);
				f_name.set_file_name ("ececil.h");
				Extern_declarations.generate (f_name);
				Extern_declarations.wipe_out;
				Cecil_file.putstring ("struct ctable *cecil_tab;");
				Cecil_file.new_line;
				Cecil_file.new_line;
				Cecil_file.putstring ("ce_rname = (struct ctable *)cmalloc(");
				Cecil_file.putint (Type_id_counter.value);
				Cecil_file.putstring (" * sizeof(struct ctable));");
				Cecil_file.new_line;
				Cecil_file.putstring ("if (ce_rname == (struct ctable *) 0)");
				Cecil_file.new_line;
				Cecil_file.indent;
				Cecil_file.putstring ("enomem();");
				Cecil_file.new_line;
				Cecil_file.exdent;
				Cecil_file.putstring ("bcopy(fce_rname, ce_rname, ");
				Cecil_file.putint (dle_max_dr_type_id);
				Cecil_file.putstring (" * sizeof(struct ctable));");
				Cecil_file.new_line;
				Cecil_file.new_line;
				from
						-- Start the iteration from the maximum `type_id' 
						-- value of the static system.
					i := dle_max_dr_type_id + 1;
					nb := Type_id_counter.value
				until
					i > nb
				loop
if class_types.item (i) /= Void then
					Cecil_file.putstring ("cecil_tab = &Cecil(");
					Cecil_file.putint (i - 1);
					Cecil_file.putstring (");");
					Cecil_file.new_line;
					class_types.item (i).dle_generate_cecil (Cecil_file);
					Cecil_file.new_line;
end;
					i := i + 1
				end
			end;
			Cecil_file.putstring ("ce_type = Dce_type;");
			Cecil_file.new_line;
			Cecil_file.putstring ("ce_gtype = Dce_gtype;");
			Cecil_file.new_line;
			if final_mode then
				Cecil_file.exdent;
				Cecil_file.putstring ("}%N%N");
				Cecil_file.putstring ("void free_evisib()");
				Cecil_file.new_line;
				Cecil_file.putchar ('{');
				Cecil_file.new_line;
				Cecil_file.indent;
				Cecil_file.putstring ("xfree(ce_rname);");
				Cecil_file.new_line;
				Cecil_file.putstring ("ce_rname = fce_rname;");
				Cecil_file.new_line
			end;
			Cecil_file.exdent;
			Cecil_file.putstring ("}%N");

			Cecil_file.close;
			Cecil_file := Void
		end;

	generate_conformance_table is
			-- Generates conformance tables.
		local
			i, nb: INTEGER;
			cl_type: CLASS_TYPE
		do
			Conformance_file := conformance_f (byte_context.final_mode);
			Conformance_file.open_write;

			Conformance_file.putstring ("#include %"struct.h%"%N%N");

			from
				i := 1;
				nb := Type_id_counter.value
			until
				i > nb
			loop
				cl_type := class_types.item (i);
if cl_type /= Void then
		-- FIXME
				cl_type.generate_conformance_table;
end;
				i := i + 1
			end;

			Conformance_file.putstring
					("static struct conform *Dco_table[] = {%N");
			from
				i := 1
			until
				i > nb
			loop
				cl_type := class_types.item (i);
if cl_type /= Void then
				Conformance_file.putstring ("&conf");
				Conformance_file.putint (cl_type.type_id);
else
		-- FIXME
	Conformance_file.putstring ("(struct conform *)0");
end;
				Conformance_file.putstring (",%N");
				i := i + 1
			end;

			Conformance_file.putstring ("};%N");

			Conformance_file.new_line;
			Conformance_file.putstring ("void dle_econform()");
			Conformance_file.new_line;
			Conformance_file.putchar ('{');
			Conformance_file.new_line;
			Conformance_file.indent;
			Conformance_file.putstring ("co_table = Dco_table;");
			Conformance_file.new_line;
			Conformance_file.exdent;
			Conformance_file.putchar ('}');
			Conformance_file.new_line;
			if in_final_mode then
				Conformance_file.new_line;
				Conformance_file.putstring ("void free_econform()");
				Conformance_file.new_line;
				Conformance_file.putchar ('{');
				Conformance_file.new_line;
				Conformance_file.indent;
				Conformance_file.putstring ("co_table = fco_table;");
				Conformance_file.new_line;
				Conformance_file.exdent;
				Conformance_file.putchar ('}');
				Conformance_file.new_line
			end;

			Conformance_file.close;
			Conformance_file := Void
		end;

	generate_dispatch_table is
			-- Generate `dispatch_table'.
		do
			Dispatch_file.open_write;
			dispatch_table.generate_dle (Dispatch_file);
			dispatch_table.freeze;
			Dispatch_file.close;
				-- The melted list of the dispatch table
				-- is now empty
		end;

	generate_exec_table is
			-- Generate `execution_table'.
		do
			Frozen_file.open_write;
			execution_table.generate_dle (Frozen_file);
			execution_table.freeze;
			Frozen_file.close;
				-- The melted list of the execution table
				-- is now empty
		end;

	generate_init_file is
			-- Generation of the init file of the DC-set.
		local
			Initialization_file: INDENT_FILE;
			i, nb: INTEGER;
			cl_type: CLASS_TYPE
		do
			Initialization_file := Init_f (false);
			Initialization_file.open_write;
			Initialization_file.putstring ("void dle_einit()");
			Initialization_file.new_line;
			Initialization_file.putchar ('{');
			Initialization_file.new_line;
			Initialization_file.indent;
			from
					-- Start the iteration from the maximum `type_id' 
					-- value of the static system.
				i := dle_max_dr_type_id + 1;
				nb := type_id_counter.value
			until
				i > nb
			loop
				cl_type := class_types.item (i);

-- FIXME ???
-- cl_type cannot be Void if process_dynamic_types has been done in
-- freeze_system.
				if cl_type /= Void then
					Initialization_file.putstring ("Init");
					Initialization_file.putint (cl_type.id.id);
					Initialization_file.putstring ("();");
					Initialization_file.new_line
				end;
				i := i + 1
			end;
			Initialization_file.exdent;
			Initialization_file.putstring ("}");
			Initialization_file.new_line;
			Initialization_file.close
		end;

	generate_rout_info_table is
		local
			f: INDENT_FILE
		do
			if not byte_context.final_mode then
				f := Rout_info_file;
				f.open_write;
				f.putstring (Rout_info_table.dle_C_string);
				f.close
			end
		end;

	generate_option_file is
			-- Generate compilation option file.
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
			partial_debug: DEBUG_TAG_I;
			class_type: CLASS_TYPE
		do
			Option_file.open_write;

			Option_file.putstring ("#include %"struct.h%"%N%N");

				-- First debug keys
			from
				classes.start
			until
				classes.after
			loop
				a_class := classes.item_for_iteration;
				if a_class.has_dynamic then
					partial_debug ?= a_class.debug_level;
					if partial_debug /= Void then
						partial_debug.generate_keys (Option_file, a_class.id)
					end
				end;
				classes.forth
			end;

			Option_file.putstring ("void dle_eoption()");
			Option_file.new_line;
			Option_file.putchar ('{');
			Option_file.new_line;
			Option_file.indent;
			Option_file.putstring ("struct eif_opt *dle_opt;");
			Option_file.new_line;
			Option_file.putstring ("struct dbg_opt *dle_dbg;");
			Option_file.new_line;
			from
					-- Start the iteration from the maximum `type_id' 
					-- value of the static system.
				i := dle_max_dr_type_id + 1;
				nb := Type_id_counter.value
			until
				i > nb
			loop
				Option_file.new_line;

				Option_file.putstring("dle_opt = &eoption[");
				Option_file.putint(i - 1);
				Option_file.putstring("];");
				Option_file.new_line;

				class_type := class_types.item (i);
				if class_type /= Void then
						-- Classes could be removed

					a_class := class_type.associated_class;
					Option_file.putstring("dle_opt->assert_level = ");
					a_class.assertion_level.generate (Option_file);
					Option_file.putchar (';');
					Option_file.new_line;

					Option_file.putstring("dle_opt->profile_level = ");
					a_class.profile_level.generate (Option_file);
					Option_file.putchar (';');
					Option_file.new_line;

					Option_file.putstring("dle_opt->trace_level = ");
					a_class.trace_level.generate (Option_file);
					Option_file.putchar (';');
					Option_file.new_line;

					Option_file.putstring("dle_dbg = &dle_opt->debug_level;");
					Option_file.new_line;
					a_class.debug_level.generate_dle (Option_file, a_class.id)
				else
					Option_file.putstring("dle_opt->assert_level = (int16) 0;");
					Option_file.new_line;
					Option_file.putstring("dle_opt->trace_level = (int16) 0;");
					Option_file.new_line;
					Option_file.putstring("dle_opt->profile_level = (int16) 0;");
					Option_file.new_line;
					Option_file.putstring("dle_dbg = &dle_opt->debug_level;");
					Option_file.new_line;
					Option_file.putstring("dle_dbg->debug_level = (int16) 0;");
					Option_file.new_line;
					Option_file.putstring("dle_dbg->nb_keys = (int16) 0;");
					Option_file.new_line;
					Option_file.putstring("dle_dbg->keys = (char **) 0);");
					Option_file.new_line
				end;
				i := i + 1
			end;
	
			Option_file.exdent;
			Option_file.putchar ('}');
			Option_file.new_line;

			Option_file.close
		end;

	generate_table is
			-- Generation of all the tables needed by the finalized
			-- Eiffel executable.
		do
				-- Generation of type size table
			generate_size_table;
				-- Generation of the reference number table
			generate_reference_table;
				-- Generation of the skeletons
			generate_skeletons;
				-- Cecil structures generation
			generate_cecil;
				-- Generation of the conformance table
			generate_conformance_table;
				-- Routine/Attribute table generation
			generate_routine_table;
				-- Generate plug with run-time.
				-- The plug file has to be generated after the routine
				-- table for `dle_max_min_used' to be initialized.
			generate_plug
		end;

	generate_size_table is
			-- Generate the size table.
		local
			i, nb: INTEGER;
			class_type: CLASS_TYPE;
			file: INDENT_FILE
		do
			file := Size_file (true);
			from
				i := dle_max_dr_type_id + 1;
				nb := type_id_counter.value;
				file.open_write;
				file.putstring ("#include %"macros.h%"");
				file.new_line;
				file.new_line;
				file.putstring ("void dle_esize()");
				file.new_line;
				file.putchar ('{');
				file.new_line;
				file.indent;
				file.putstring ("esize = (long *)cmalloc(");
				file.putint (Type_id_counter.value);
				file.putstring (" * sizeof(long));");
				file.new_line;
				file.putstring ("if (esize == (long *) 0)");
				file.new_line;
				file.indent;
				file.putstring ("enomem();");
				file.new_line;
				file.exdent;
				file.putstring ("bcopy(fsize, esize, ");
				file.putint (dle_max_dr_type_id);
				file.putstring (" * sizeof(long));");
				file.new_line;
				file.new_line
			until
				i > nb
			loop
				class_type := class_types.item (i);
if class_type /= Void then
				file.putstring ("esize[");
				file.putint (i - 1);
				file.putstring ("] = ");
				class_type.skeleton.generate_size (file);
				file.putchar (';');
				file.new_line;
end;
				i := i + 1
			end;
			file.exdent;
			file.putchar ('}');
			file.new_line;
			file.new_line;

			file.putstring ("void free_esize()");
			file.new_line;
			file.putchar ('{');
			file.new_line;
			file.indent;
			file.putstring ("xfree(esize);");
			file.new_line;
			file.putstring ("esize = fsize;");
			file.new_line;
			file.exdent;
			file.putchar ('}');
			file.new_line;

			file.close
		end;

	generate_reference_table is
			-- Generate the table of reference numer per type.
		local
			i, nb, nb_ref, nb_exp: INTEGER;
			class_type: CLASS_TYPE;
			skeleton: SKELETON
		do
			from
				i := dle_max_dr_type_id + 1;
				nb := type_id_counter.value;
				Reference_file.open_write;
				Reference_file.putstring ("#include %"plug.h%"");
				Reference_file.new_line;
				Reference_file.new_line;
				Reference_file.putstring ("void dle_eref()");
				Reference_file.new_line;
				Reference_file.putchar ('{');
				Reference_file.new_line;
				Reference_file.indent;
				Reference_file.putstring ("nbref = (long *)cmalloc(");
				Reference_file.putint (Type_id_counter.value);
				Reference_file.putstring (" * sizeof(long));");
				Reference_file.new_line;
				Reference_file.putstring ("if (nbref == (long *) 0)");
				Reference_file.new_line;
				Reference_file.indent;
				Reference_file.putstring ("enomem();");
				Reference_file.new_line;
				Reference_file.exdent;
				Reference_file.putstring ("bcopy(fnbref, nbref, ");
				Reference_file.putint (dle_max_dr_type_id);
				Reference_file.putstring (" * sizeof(long));");
				Reference_file.new_line;
				Reference_file.new_line
			until
				i > nb
			loop
				class_type := class_types.item (i);
if class_type /= Void then
				Reference_file.putstring ("nbref[");
				Reference_file.putint (i - 1);
				Reference_file.putstring ("] = ");
				skeleton := class_type.skeleton;
				nb_ref := skeleton.nb_reference;
				nb_exp := skeleton.nb_expanded;
				Reference_file.putint (nb_ref + nb_exp);
				Reference_file.putchar (';');
				Reference_file.new_line
end;
				i := i + 1
			end;
			Reference_file.exdent;
			Reference_file.putchar ('}');
			Reference_file.new_line;
			Reference_file.new_line;

			Reference_file.putstring ("void free_eref()");
			Reference_file.new_line;
			Reference_file.putchar ('{');
			Reference_file.new_line;
			Reference_file.indent;
			Reference_file.putstring ("xfree(nbref);");
			Reference_file.new_line;
			Reference_file.putstring ("nbref = fnbref;");
			Reference_file.new_line;
			Reference_file.exdent;
			Reference_file.putchar ('}');
			Reference_file.new_line;

			Reference_file.close
		end;

	generate_plug is
			-- Generate plug with run-time.
		local
			final_mode: BOOLEAN;
			init_name, dispose_name: STRING;
			dle_make_name: STRING
		do
			final_mode := in_final_mode;
			Plug_file := plug_f (final_mode);
			Plug_file.open_write;
			Plug_file.putstring ("#include %"plug.h%"%N");
			Plug_file.putstring ("#include %"struct.h%"%N%N");
			if final_mode then
					-- Extern declarations
				init_name := Initialization_rout_id.table_name;
				dispose_name := Dispose_rout_id.table_name;
				dle_make_name := Dle_make_rout_id.table_name;
				Plug_file.putstring ("extern char *(**");
				Plug_file.putstring (init_name);
				Plug_file.putstring (")();%N");
				Plug_file.putstring ("extern char *(**");
				Plug_file.putstring (dispose_name);
				Plug_file.putstring (")();%N");
				Plug_file.putstring ("extern char *(**");
				Plug_file.putstring (dle_make_name);
				Plug_file.putstring (")();%N");
				if array_optimization_on or dle_array_optimization_on then
					remover.array_optimizer.generate_dle_plug_extern (Plug_file)
				end;
				Plug_file.new_line;
				Plug_file.putstring ("void dle_eplug()");
				Plug_file.new_line;
				Plug_file.putchar ('{');
				Plug_file.new_line;
				Plug_file.indent;
					-- Initialization routines
				Plug_file.putstring ("ecreate = ");
				Plug_file.putstring (init_name);
				Plug_file.putchar (';');
				Plug_file.new_line;
					-- Dispose routines
				Plug_file.putstring ("edispose = (void (**)()) ");
				Plug_file.putstring (dispose_name);
				Plug_file.putchar (';');
				Plug_file.new_line;
					-- `make' creation procedures of descendands
					-- of DYNAMIC in the DC-set.
				Plug_file.putstring ("dle_make = ");
				Plug_file.putstring (dle_make_name);
				Plug_file.putstring (" - ");
				Plug_file.putint (dle_make_min_used - 1);
				Plug_file.putchar (';');
				Plug_file.new_line;
				if array_optimization_on or dle_array_optimization_on then
					remover.array_optimizer.generate_dle_plug (Plug_file)
				end;
					-- New scount
				Plug_file.putstring ("scount = ");
				Plug_file.putint (Type_id_counter.value);
				Plug_file.putchar (';');
				Plug_file.new_line;
					-- DYNAMIC dtype
				Plug_file.putstring ("dynamic_dtype = ");
				Plug_file.putint (dynamic_dtype - 1);
				Plug_file.putchar (';');
			else
				Plug_file.putstring ("extern fnptr **eif_address_table;%N%N");
				Plug_file.putstring ("extern fnptr *Deif_address_table[];%N%N");
				Plug_file.putstring ("void dle_eplug()");
				Plug_file.new_line;
				Plug_file.putchar ('{');
				Plug_file.new_line;
				Plug_file.indent;
				Plug_file.putstring ("eif_address_table = Deif_address_table;");
			end;
			Plug_file.new_line;
			Plug_file.exdent;
			Plug_file.putchar ('}');
			Plug_file.new_line;

			Plug_file.close
		end;

	generate_routine_table is
			-- Generate routine and attribute table.
		local
			server_id: INTEGER;
			rout_id: ROUTINE_ID;
			table: POLY_TABLE [ENTRY]
		do
			Attr_generator.init;
			Rout_generator.init;
			from
				Tmp_poly_server.start
			until
				Tmp_poly_server.after
			loop
				server_id := Tmp_poly_server.key_for_iteration;
				table := Tmp_poly_server.item (server_id).poly_table;
				rout_id := table.rout_id;
				if Eiffel_table.is_used (rout_id) then
					table.write
				end;
				Tmp_poly_server.forth
			end;
			generate_initialization_table;
			generate_dispose_table;
			generate_dle_make_table;
			Attr_generator.finish;
			Rout_generator.finish
		end;

	generate_dle_file is
			-- Generate DLE related data to be loaded at run-time.
		local
			DLE_file: INDENT_FILE;
			DLE_file_h: INDENT_FILE;
			i, nb: INTEGER
		do
				-- Open DLE file
			DLE_file := DLE_f (in_final_mode);
			DLE_file.open_write;

			if not in_final_mode then
				DLE_file.putstring ("extern void dle_eskelet();");
				DLE_file.new_line;
				DLE_file.putstring ("extern void dle_efrozen();");
				DLE_file.new_line;
				DLE_file.putstring ("extern void dle_disptch();");
				DLE_file.new_line;
				DLE_file.putstring ("extern void dle_econform();");
				DLE_file.new_line;
				DLE_file.putstring ("extern void dle_ecall();");
				DLE_file.new_line;
				DLE_file.putstring ("extern void dle_eoption();");
				DLE_file.new_line;
				DLE_file.putstring ("extern void dle_epattern();");
				DLE_file.new_line;
				DLE_file.putstring ("extern void free_epattern();");
				DLE_file.new_line;
				DLE_file.putstring ("extern void dle_einit();");
				DLE_file.new_line;
				DLE_file.putstring ("extern void dle_evisib();");
				DLE_file.new_line;
				DLE_file.putstring ("extern void dle_eplug();");
				DLE_file.new_line;
				DLE_file.new_line;
				DLE_file.putstring ("void dle_load()");
				DLE_file.new_line;
				DLE_file.putchar ('{');
				DLE_file.new_line;
				DLE_file.indent;
				DLE_file.putstring ("dle_eskelet();");
				DLE_file.new_line;
				DLE_file.putstring ("dle_efrozen();");
				DLE_file.new_line;
				DLE_file.putstring ("dle_edisptch();");
				DLE_file.new_line;
				DLE_file.putstring ("dle_econform();");
				DLE_file.new_line;
				DLE_file.putstring ("dle_ecall();");
				DLE_file.new_line;
				DLE_file.putstring ("dle_eoption();");
				DLE_file.new_line;
				DLE_file.putstring ("dle_epattern();");
				DLE_file.new_line;
				DLE_file.putstring ("dle_einit();");
				DLE_file.new_line;
				DLE_file.putstring ("dle_evisib();");
				DLE_file.new_line;
				DLE_file.putstring ("dle_eplug();");
				DLE_file.new_line;
				DLE_file.exdent;
				DLE_file.putchar ('}');
				DLE_file.new_line;
				DLE_file.new_line;

				DLE_file.putstring ("void dle_free()");
				DLE_file.new_line;
				DLE_file.putchar ('{');
				DLE_file.new_line;
				DLE_file.indent;
				DLE_file.putstring ("free_epattern();");
				DLE_file.new_line;
				DLE_file.exdent;
				DLE_file.putchar ('}');
				DLE_file.new_line
			else
				!! DLE_file_h.make (final_file_name (Edle, Dot_h));
				DLE_file_h.open_write;
				DLE_file.putstring ("#include %"");
				DLE_file.putstring (Edle);
				DLE_file.putstring (Dot_h);
				DLE_file.putchar ('"');
				DLE_file.new_line;
				DLE_file.new_line;
				DLE_file.putstring ("void dle_load()");
				DLE_file.new_line;
				DLE_file.putchar ('{');
				DLE_file.new_line;
				DLE_file.indent;

				DLE_file_h.putstring ("extern void dle_econform();");
				DLE_file_h.new_line;
				DLE_file.putstring ("dle_econform();");
				DLE_file.new_line;

				DLE_file_h.putstring ("extern void dle_eref();");
				DLE_file_h.new_line;
				DLE_file.putstring ("dle_eref();");
				DLE_file.new_line;

				DLE_file_h.putstring ("extern void dle_esize();");
				DLE_file_h.new_line;
				DLE_file.putstring ("dle_esize();");
				DLE_file.new_line;

				DLE_file_h.putstring ("extern void dle_eskelet();");
				DLE_file_h.new_line;
				DLE_file.putstring ("dle_eskelet();");
				DLE_file.new_line;

				DLE_file_h.putstring ("extern void dle_evisib();");
				DLE_file_h.new_line;
				DLE_file.putstring ("dle_evisib();");
				DLE_file.new_line;

				from
					i := 1;
					nb := Rout_generator.file_counter
				until
					i > nb
				loop
					DLE_file_h.putstring ("extern void dle_erout");
					DLE_file_h.putint (i);
					DLE_file_h.putstring ("();");
					DLE_file_h.new_line;

					DLE_file.putstring ("dle_erout");
					DLE_file.putint (i);
					DLE_file.putstring ("();");
					DLE_file.new_line;
					i := i + 1
				end;
				from
					i := 1;
					nb := Attr_generator.file_counter
				until
					i > nb
				loop
					DLE_file_h.putstring ("extern void dle_eattr");
					DLE_file_h.putint (i);
					DLE_file_h.putstring ("();");
					DLE_file_h.new_line;

					DLE_file.putstring ("dle_eattr");
					DLE_file.putint (i);
					DLE_file.putstring ("();");
					DLE_file.new_line;
					i := i + 1
				end;

					-- The code in `plug' has to be called after the routine
					-- and attribute tables have been initialized.
				DLE_file_h.putstring ("extern void dle_eplug();");
				DLE_file_h.new_line;
				DLE_file.putstring ("dle_eplug();");
				DLE_file.new_line;

				DLE_file.exdent;
				DLE_file.putchar ('}');
				DLE_file.new_line;
				DLE_file.new_line;

				DLE_file.putstring ("void dle_free()");
				DLE_file.new_line;
				DLE_file.putchar ('{');
				DLE_file.new_line;
				DLE_file.indent;

				DLE_file_h.putstring ("extern void free_econform();");
				DLE_file_h.new_line;
				DLE_file.putstring ("free_econform();");
				DLE_file.new_line;

				DLE_file_h.putstring ("extern void free_eref();");
				DLE_file_h.new_line;
				DLE_file.putstring ("free_eref();");
				DLE_file.new_line;

				DLE_file_h.putstring ("extern void free_esize();");
				DLE_file_h.new_line;
				DLE_file.putstring ("free_esize();");
				DLE_file.new_line;

				DLE_file_h.putstring ("extern void free_eskelet();");
				DLE_file_h.new_line;
				DLE_file.putstring ("free_eskelet();");
				DLE_file.new_line;

				DLE_file_h.putstring ("extern void free_evisib();");
				DLE_file_h.new_line;
				DLE_file.putstring ("free_evisib();");
				DLE_file.new_line;

				DLE_file.exdent;
				DLE_file.putchar ('}');
				DLE_file.new_line;

				DLE_file_h.close
			end;

				-- Close DLE file
			DLE_file.close
		end;

	generate_dle_make_table is
			-- Generate the table of `make' creation procedures of
			-- the descendants of DYNAMIC in the DC-set.
		local
			rout_table: DYN_ROUT_TABLE;
			rout_entry: ROUT_ENTRY;
			class_c: CLASS_C;
			feat: FEATURE_I;
			cl_type: CLASS_TYPE;
			void_type: VOID_I
		do
			from
				!! void_type;
				!! rout_table.make;
				rout_table.set_rout_id (Dle_make_rout_id)
				dynamic_class_ids.start
			until
				dynamic_class_ids.after
			loop
				class_c := class_of_id (dynamic_class_ids.item_for_iteration);
				if
					class_c /= Void and then
					class_c.inherits_from_dynamic
				then
					!! rout_entry;
						-- Classes of the DC-set inheriting from DYNAMIC
						-- are not generic nor deferred. They hence have
						-- only one type.
					cl_type := class_c.types.first;
					feat := class_c.creation_feature;
					rout_entry.set_type_id (cl_type.type_id);
					rout_entry.set_written_type_id
					 	(feat.written_type_id (cl_type.type));
					rout_entry.set_body_index (feat.body_index);
					rout_entry.set_type (void_type);
					rout_table.extend (rout_entry)
				end;
				dynamic_class_ids.forth
			end;
			rout_table.write;
			dle_make_min_used := rout_table.min_used
		end;

feature -- Dead code removal

	remove_dead_code is
			-- Dead code removal.
		local
			a_class: CLASS_C;
			root_feat: FEATURE_I;
			i, nb: INTEGER;
			ct: CLASS_TYPE
		do
			!!remover.make;

				-- Record the descendants of ARRAY
			if array_optimization_on then
				remover.record_array_descendants
			end;

				-- First, inspection of the Eiffel code
			if creation_name /= Void then
				a_class := root_class.compiled_class;
				root_feat := a_class.feature_table.item (creation_name);
				remover.record (root_feat, a_class)
			end;

			from
				classes.start
			until
				classes.after
			loop
				a_class := classes.item_for_iteration;
				a_class.mark_dispose (remover);
				if a_class.visible_level.has_visible then
					a_class.mark_visible (remover)
				end;
				if
					a_class.is_dynamic and then
					a_class.inherits_from_dynamic
				then
						-- Protection of features of descendants
						-- of DYNAMIC in the DC-set.
					a_class.mark_all_used (remover);
					a_class.dle_mark_make (remover)
				end;
				classes.forth
			end;

			if has_expanded then
				from
					i := 1;
					nb := Type_id_counter.value
				until
					i > nb
				loop
					ct := class_types.item (i);
					if ct /= Void then
						ct.mark_creation_routine (remover)
					end;
					i := i + 1
				end
			end;

				-- Protection of the attribute `area' in class TO_SPECIAL
			to_special_class.compiled_class.mark_all_used (remover);

				-- Protection of `make' from ARRAY
			array_class.compiled_class.mark_all_used (remover);

				-- Protection of features written in basic reference classes
			character_ref_class.compiled_class.mark_all_used (remover);
			boolean_ref_class.compiled_class.mark_all_used (remover);
			integer_ref_class.compiled_class.mark_all_used (remover);
			real_ref_class.compiled_class.mark_all_used (remover);
			double_ref_class.compiled_class.mark_all_used (remover);
			pointer_ref_class.compiled_class.mark_all_used (remover);

				-- Protection of feature `make' of class STRING
			string_class.compiled_class.mark_all_used (remover);

				-- New line at the end of the last line of dots
			io.error.new_line
		end;

invariant

	extending: is_dynamic;
	not_extendible: not extendible;
	not_precompiling: not Compilation_modes.is_precompiling

end -- class DLE_SYSTEM_I
