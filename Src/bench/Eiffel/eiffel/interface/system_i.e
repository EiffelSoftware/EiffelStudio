

-- Internal representation of a system.

class SYSTEM_I 

inherit

	BASIC_SYSTEM_I;
	SHARED_WORKBENCH;
	SHARED_TMP_SERVER;
	SHARED_EXPANDED_CHECKER;
	SHARED_TYPEID_TABLE;
	SHARED_TABLE;
	SHARED_FILES;
	SHARED_CODE_FILES;
	SHARED_GENERATOR;
	SHARED_ERROR_HANDLER
		export
			{ANY} Error_handler
		end;
	SHARED_TIME;
	SHARED_CECIL;
	SHARED_BODY_ID;
	SHARED_ENCODER;
	SHARED_USED_TABLE;
	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		export
			{ANY} byte_context
		end;
	SHARED_ARRAY_BYTE;
	SHARED_DECLARATIONS;
	SHARED_PASS;
	SHARED_RESCUE_STATUS

feature 

	changed_body_ids: EXTEND_TABLE [CHANGED_BODY_ID_INFO, INTEGER] is
		once
			!!Result.make (2)
		end;

	rout_info_table: ROUT_INFO_TABLE;
			-- Global routine info table
			-- rout_id --> (origin/offset)

	sorter: CLASS_SORTER;
			-- Topological sorter on classes

	class_counter: COUNTER;
			-- Counter of classes

	body_id_counter: BODY_ID_COUNTER;
			-- Counter for body ids

	body_index_counter: COUNTER;
			-- Body index counter

	routine_id_counter: ROUT_ID_COUNTER;
			-- Counter for routine ids

	type_id_counter: COUNTER;
			-- Counter of valid instances of CLASS_TYPE

	static_type_id_counter: COUNTER;
			-- Counter of instances of CLASS_TYPE

	feature_counter: COUNTER;
			-- Counter of instances of FEATURE_AS

	feat_tbl_server: FEAT_TBL_SERVER;
			-- Server for feature tables

	body_server: BODY_SERVER;
			-- Server for instances of EIFFEL_FEAT

	ast_server: AST_SERVER;
			-- Server for abstract syntax trees

	byte_server: BYTE_SERVER;
			-- Server for byte code trees

	rep_server: REP_SERVER;
			-- Server for class that has replicated features 

	rep_feat_server: REP_FEAT_SERVER;
			-- Server for replicated features 

	class_info_server: CLASS_INFO_SERVER;
			-- Server for class information produced bu first pass

	inv_ast_server: INV_AST_SERVER;
			-- Server for abstract syntax description of invariant clause

	inv_byte_server: INV_BYTE_SERVER;
			-- Server for invariant byte code

	depend_server: DEPEND_SERVER;
			-- Server for dependances for incremental type check

	rep_depend_server: REP_DEPEND_SERVER;
			-- Server for dependances for replicated features 

	m_feat_tbl_server: M_FEAT_TBL_SERVER;
			-- Server of byte code description of melted feature tables

	m_feature_server: M_FEATURE_SERVER;
			-- Server of melted feature byte code

	m_rout_tbl_server: M_ROUT_TBL_SERVER;
			-- Server for melted routine tables

	m_rout_id_server: M_ROUT_ID_SERVER;
			-- Server for routine id array byte code

	m_desc_server: M_DESC_SERVER;
			-- Server for class type descriptors

	id_array: ARRAY [CLASS_C];
			-- Array of classes indexed by their class `id's

	class_types: ARRAY [CLASS_TYPE];
			-- Array of class types indexed by their `type_id'

	type_set: ROUT_ID_SET;
			-- Set of the routine ids for which a type table should
			-- be generated

	pattern_table: PATTERN_TABLE;
			-- Pattern table

	successfull: BOOLEAN;
			-- Was the last recompilation successfull ?

	freeze: BOOLEAN;
			-- Has the system to be frozen again ?

	freezing_occurred: BOOLEAN;
			-- Did a freezing of the system occur ?

	history_control: HISTORY_CONTROL;
			-- Routine table controler
			-- Only used for final mode code generation.

	instantiator: INSTANTIATOR;
			-- Tool to process the generic derivations

	externals: EXTERNALS;
			-- Table of external names currently used by the system

	system_name: STRING;
			-- System name

	root_cluster: CLUSTER_I;
			-- Root class of the system

	root_class_name: STRING;
			-- Root class name

	creation_name: STRING;
			-- Creation procedure name

	c_file_names: FIXED_LIST [STRING];
			-- C file names to include

	object_file_names: FIXED_LIST [STRING];
			-- Object file names to link with the application

	makefile_names: FIXED_LIST [STRING];
			-- Makefile names to execute before the linking

	executable_directory: STRING;
			-- Directory for the executable file

	c_directory: STRING;
			-- Directory for the generated c files

	object_directory: STRING;
			-- Directory for the object files

	first_compilation: BOOLEAN;
			-- Is it the first compilation of the system
			-- Used by the time check

	poofter_finalization: BOOLEAN;
			-- Will the next finalization be a poofter finalization?
			-- i.e. not straight.
			-- If it is not a poofter finalization we know how to 
			-- generate the routine tables much quicker (see classes
			-- ATTR_TABLE and ROUT_TABLE)

	new_class: BOOLEAN;
			-- Has a new class been inserted in the universe ?
			-- It is different from moved because new_class is set
			-- even if the class is not used

	new_classes: LINKED_LIST [CLASS_I];
			-- New classes in the system
			-- Used during the time check

	moved: BOOLEAN;
			-- Has the system potentially moved in terms of classes ?
			-- [Each time a new class is inserted/removed in/from the system
			-- a topological sort has to be done.]

	update_sort: BOOLEAN;
			-- Has the conformance table to be updated ?
			-- [A class id has changed beetween two recompilation.]

	max_class_id: INTEGER;
			-- Greater class id: computed by class CLASS_SORTER

	max_precompiled_id: INTEGER;
			-- Greatest precompiled class id

	max_precompiled_type_id: INTEGER;
			-- Greatest precompiled class type id

	freeze_set1: LINKED_SET [INTEGER];
			-- List of class ids for which a source C compilation is
			-- needed when freezing.

	freeze_set2: LINKED_SET [INTEGER];
			-- List of class ids for which a hash table recompilation
			-- is needed when freezing

	is_conformance_table_melted: BOOLEAN;
			-- Is the conformance table melted ?

	melted_conformance_table: CHARACTER_ARRAY;
			-- Byte array representation of the melted conformance
			-- table.
			--| Once melted, it is kept in memory so it won't be re-processed
			--| each time

	melted_set: LINKED_SET [INTEGER];
			-- Set of class ids for which feature table needs to be updated
			-- when melting

	frozen_level: INTEGER;
			-- Frozen level

	body_index_table: BODY_INDEX_TABLE;
			-- Body index table
			--| Correspondance of generic body index and generic body
			--| id.

	original_body_index_table: BODY_INDEX_TABLE;
			-- Original body index table.
			-- | Since during second pass, correpondaces between body indexes
			-- | and body ids are changing, the second class must use a
			-- | duplicated one in order to compair versions of a same
			-- | feature.

	onbidt: O_N_TABLE;
			-- Correspondance table between old body ids
			-- (changed trough `vhange_body_id' of FEATURE_I)
			-- and new body id.

	dispatch_table: DISPATCH_TABLE;
			-- Dispatch table

	execution_table: EXECUTION_TABLE;
			-- Execution table

	server_controler: SERVER_CONTROL;
			-- Controler of servers

	remover: REMOVER;
			-- Dead code removal control

	remover_off: BOOLEAN;
			-- Is the remover off (by specifying the Ace option)

	code_replication_off: BOOLEAN;
			-- Is code replication off (by specifying the Ace option)

	exception_stack_managed: BOOLEAN;
			-- Is the exception stack managed in final mode

	has_expanded: BOOLEAN;
			-- Is there an expanded declaration in the system,
			-- i.e. some extra check must be done after pass2 ?

	current_pass: PASS;
			-- Current compiler pass
			-- Useful for `current_class'

	current_class: CLASS_C;
			-- Current processed class

	precompilation: BOOLEAN;
			-- Are we currently doing a precompilation?

	makefile_generator: MAKEFILE_GENERATOR;
			-- Makefile generator.

	cecil_file: INDENT_FILE;

	skeleton_file: INDENT_FILE;

	conformance_file: INDENT_FILE;

	make_file: INDENT_FILE;

	array_make_name: STRING;
			-- Name of the C routine corresponding to the
			-- make routine of ARRAY[ANY]. Needed for the
			-- "strip" functionality.
			-- Having an attribute is a temporary solution.
			-- There is a problem when ARRAY[ANY] is precompiled
			-- and a new generic derivation is introduced later on
			-- (the name will change, and not be compatible with the
			-- contenrt of the precompiled object file). The patch 
			-- consists of saving the name the very first time it
			-- is computed.

	optimization_tables: OPTIMIZATION_TABLES;
			-- Tables keeping track of flags for optimization
			-- Based on the body_index of a feature

	make is
			-- Create the system.
		do
			!!server_controler;
			server_controler.make;
				-- Creation of the system hash table
			!!id_array.make (1, System_chunk);
			!!class_types.make (1, System_chunk);
			!!new_classes.make;
				-- Creation of a topological sorter
			!!sorter.make;
				-- Creation of servers
			!!feat_tbl_server.make;
			!!body_server.make;
			!!byte_server.make;
			!!ast_server.make;
			!!rep_server.make;
			!!rep_feat_server.make;
			!!class_info_server.make;
			!!inv_ast_server.make;
			!!inv_byte_server.make;
			!!depend_server.make;
			!!rep_depend_server.make;
			!!m_feat_tbl_server.make;
			!!m_feature_server.make;
			!!m_rout_id_server.make;
			!!m_desc_server.make;
				-- Counter creation
			!!class_counter;
			!!body_id_counter.make;
			!!routine_id_counter.make;
			!!type_id_counter;
			!!static_type_id_counter;
			!!body_index_counter;
			!!feature_counter;
				-- Routine table controler creation
			!!history_control.make;
			!!instantiator.make;
			instantiator.compare_objects;
				-- Type set creation
			!!type_set.make (100);
				-- External table creation
			!!externals.make;
				-- Pattern table creation
			!!pattern_table.make;
				-- Freeze control sets creation
			!!freeze_set1.make;
			!!freeze_set2.make;
				-- Body index table creation
			!!body_index_table.make (System_chunk);
			!!original_body_index_table.make (1);
				-- Run-time table creation
			!!dispatch_table.init;
			!!execution_table.init;
			!!melted_set.make;
			!!rout_info_table.make;
			!!onbidt.make (50);
			!!optimization_tables.make
		end;

	init is
			-- System initialization
		require
			general_class: general_class /= Void;
		local
			local_workbench: WORKBENCH_I;
			local_universe: UNIVERSE_I;
			local_root_cluster: CLUSTER_I;
		do
			first_compilation := True;

			local_workbench := Workbench;
			local_universe := Universe;
			local_root_cluster := root_cluster;

				-- At the very beginning of a session, even class ANY is
				-- not compiled. So we must say to the workbench to compile
				-- classes ANY, DOUBLE... ARRAY
				-- It is very important that the number of calls below
				-- is equal to the value of `protected_classes'
			local_workbench.change_class (general_class);
			local_workbench.change_class (any_class);
			local_workbench.change_class (double_class);
			local_workbench.change_class (real_class);
			local_workbench.change_class (integer_class);
			local_workbench.change_class (boolean_class);
			local_workbench.change_class (character_class);
			local_workbench.change_class (array_class);
			local_workbench.change_class (bit_class);
			local_workbench.change_class (pointer_class);
			local_workbench.change_class (string_class);
				-- The root class is not protected 
				-- Godammit.
			local_workbench.change_class (root_class)
		end;

	protected_classes: INTEGER is 11;
		-- Usefull for remove_useless_classes
		-- The 11 first classes are protected (see `init')

	insert_new_class (c: CLASS_C) is
			-- Add new class `c' to the system.
		require
			good_argument: c /= Void;
		local
			new_id, id_array_count: INTEGER;
		do
			new_id := class_counter.next;
				-- Give a compiled class a frozen id
			c.set_id (new_id);
debug ("ACTIVITY")
io.error.putstring ("%TInserting class ");
io.error.putstring (c.class_name);
io.error.putint (new_id);
io.error.new_line;
end;

				-- Give a class id to class `c' which maybe changed 
				-- during the topological sort of a recompilation.
			c.set_topological_id (new_id);
				-- Insert the class
			id_array_count := id_array.count;
			if new_id > id_array_count then
				id_array.resize (1, System_chunk + id_array_count);
			end;
			id_array.put (c, new_id);

				-- Update control flags of the topological sort
			moved := True;

				-- Update the freeze control list: the class can have no
				-- features written in it (like ANY) and then not be
				-- included in `freeze_set1' after the second pass and so
				-- not been generated. (we need a source file even if the
				-- class is empty in terms of features written in it.).
			freeze_set1.put (new_id);
			freeze_set2.put (new_id);

			melted_set.put (new_id);

		ensure
			c.id > 0;
		end;

	record_new_class_i (a_class: CLASS_I) is
			-- Record a new CLASS_I
			-- Used during the time check and the genericity check after pass1
		do
			new_class := True;
			new_classes.put_front (a_class);
		end;

	remove_class (a_class: CLASS_C) is
			-- Remove class `a_class' from the system even if
			-- it has syntactical_clients
		require
			 good_argument: a_class /= Void;
		local
			parents: ARRAYED_LIST [CL_TYPE_A];
			compiled_root_class: CLASS_C;
			descendants, suppliers, clients: LINKED_LIST [CLASS_C];
			supplier: CLASS_C;
			supplier_clients: LINKED_LIST [CLASS_C];
			id: INTEGER;
			types: TYPE_LIST;
			ftable: FEATURE_TABLE;
			f: FEATURE_I;
			ext: EXTERNAL_I
		do
			id := a_class.id;

			if (id > max_precompiled_id) then
debug ("ACTIVITY", "REMOVE_CLASS");
	io.error.putstring ("%TRemoving class ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end;
					-- Update control flags of the topological sort
				moved := True;

					-- Remove type check relations
				if a_class.parents /= Void then
					a_class.remove_relations;
				end;

					-- Remove one occurrence for each external written
					-- in the class
				if Feat_tbl_server.has (id) then
					ftable := Feat_tbl_server.item (id)
					from
						ftable.start
					until
						ftable.after
					loop
						f := ftable.item_for_iteration;
						if
							f.is_external and then
							f.written_in = id
						then
							ext ?= f;
								-- If the external is encapsulated then it was not added to
								-- the list of new externals in inherit_table. Same thing
								-- if it has to be removed
							if not ext.encapsulated then
								Externals.remove_occurence (ext.external_name);
							end;
						end;
						ftable.forth
					end;
				end;

					-- Remove class `a_class' from the lists of changed classes
				pass1_controler.remove_class (a_class);
				pass2_controler.remove_class (a_class);
				pass3_controler.remove_class (a_class);
				pass4_controler.remove_class (a_class);

					-- Mark the class to remove uncompiled
				a_class.lace_class.set_compiled_class (Void);

					-- Remove its types
				from
					types := a_class.types;
					types.start
				until
					types.after
				loop
					class_types.put (Void, types.item.type_id);
					types.forth;
				end;

					-- Remove if from the servers
debug ("ACTIVITY");
	io.error.putstring ("%TRemoving id from servers: ");
	io.error.putint (id);
	io.error.new_line;
end;
				Inv_byte_server.remove (id);
				Ast_server.remove (id);
				Feat_tbl_server.remove (id);
				Class_info_server.remove (id);
				Inv_ast_server.remove (id);
				Depend_server.remove (id);
				Rep_depend_server.remove (id);
				M_rout_id_server.remove (id);
				M_desc_server.remove (id);

				Tmp_inv_byte_server.remove (id);
				Tmp_ast_server.remove (id);
				Tmp_feat_tbl_server.remove (id);
				Tmp_class_info_server.remove (id);
				Tmp_rep_info_server.remove (id);
				Tmp_inv_ast_server.remove (id);
				Tmp_depend_server.remove (id);
				Tmp_rep_depend_server.remove (id);
				Tmp_m_rout_id_server.remove (id);
				Tmp_m_desc_server.remove (id);

				freeze_set1.prune (id);
				freeze_set2.prune (id);
				melted_set.prune (id);
				id_array.put (Void, id);

					-- Remove client/supplier syntactical relations
					-- and remove classes recursively
				from
					a_class.syntactical_suppliers.start
					if root_class /= Void then
						compiled_root_class := root_class.compiled_class
					end;
				until
					a_class.syntactical_suppliers.off
				loop
					supplier := a_class.syntactical_suppliers.item.supplier;
					supplier_clients := supplier.syntactical_clients;
					supplier_clients.start;
					supplier_clients.compare_references
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
						supplier.id > protected_classes and then
							-- A recursion may occur when removing a cluster
						id_array.item (supplier.id) /= Void
					then
						remove_class (supplier);
					end;
					a_class.syntactical_suppliers.forth
				end;
			end;
		end;

	class_of_id (id: INTEGER): CLASS_C is
			-- Class of id `id'.
		require
			index_small_enough: id <= id_array.count;
		do
			Result := id_array.item (id);
debug ("CLASS_OF_ID")
io.error.putstring ("Class of id ");
io.error.putint (id);
io.error.putstring (": ");
io.error.putstring (Result.class_name);
io.error.new_line;
end;
		end;

	class_type_of_id (type_id: INTEGER): CLASS_TYPE is
			-- Class type of type id `type_id'.
		require
			index_small_enough: type_id <= class_types.count;
				-- Removed: if the index is bigger than type_id_counter.value
				-- then the corresponding entry is Void
			--valid_index: type_id <= type_id_counter.value;
		do
			Result := class_types.item (type_id);
		end;

	insert_class_type (class_type: CLASS_TYPE) is
			-- Insert `class_type' in `class_types'.
		require
			good_argument: class_type /= Void;
			index_big_enough: class_type.type_id > 0;
		local
			type_id: INTEGER;
		do
			type_id := class_type.type_id;
			if type_id > class_types.count then
				class_types.resize (1, type_id + System_chunk);
			end;
			class_types.put (class_type, type_id);
		end;

	init_recompilation is
			-- Initialization before a recompilation.
		do
				-- If first initialization, special initialization
			if not general_class.compiled then
				init;
			elseif root_class.compiled_class = Void then
				-- If root_class is not compiled (i.e. root class has changed since
				-- last compilaton), insert it in the changed_classes
				Workbench.change_class (root_class)
			end;

				-- `None' is specified as the root class
			if Lace.compile_all_classes then
				Workbench.change_all_new_classes
			end;

			freeze := freeze or else frozen_level = 0;

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
				melted_set.wipe_out;
			end;
		end;

feature -- Recompilation 

	recompile is
			-- Incremetal recompilation of the system.
		require
			no_error: not Error_handler.has_error;
		do
			freezing_occurred := False;
			do_recompilation;
			successfull := True;
		rescue
			if Rescue_status.is_error_exception then
				successfull := False;
			end;
		end;

	do_recompilation is
			-- Incremetal recompilation of the system.
		local
			root_class_c: CLASS_C;
		do
				-- Recompilation initialization
			if precompilation then
				init_precompilation
			else
				init_recompilation;
			end;

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

				-- Initialize the routine info table
			Rout_info_table.init;

				-- Check generic validity on old classes
				-- generic parameters cannot be new classes
debug ("ACTIVITY")
	io.error.putstring ("%Tnew_class = ");
	io.error.putbool (new_class);
	io.error.new_line;
end;
			if not first_compilation and then new_class then
				check_generics;
					-- The association name <==> supplier has been done in pass1 so
					-- even if the compilation fails after this point, the
					-- check must not be done again if no classes are introduced
					-- before the recompilation
			end;
			new_class := False;

			if not (precompilation or else Lace.compile_all_classes) then
					-- The root class is not generic
				root_class_c := root_class.compiled_class;
				current_class := root_class_c;
				root_class_c.check_non_genericity_of_root_class;
				current_class := Void;
			end;

			if not (precompilation or else Lace.compile_all_classes) then
					-- Remove useless classes i.e classes without syntactical clients
				remove_useless_classes;
			end;

				-- Topological sort and building of the conformance
				-- table (if new classes have been added by first pass
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
					-- because the topological sort modified the class ids, and the
					-- second pass needs it and rebuild the conformance tables
				pass2_controler.sort;
				pass3_controler.sort;
				pass4_controler.sort;
				build_conformance_table;

					-- Clear the topo sorter
				sorter.clear;

				reset_melted_conformance_table;
			end;
				-- Inheritance analysis: list `changed_classes' is
				-- sorted by class ids so the parent come first the
				-- heirs after
			process_pass (pass2_controler);

			if not (precompilation or else Lace.compile_all_classes) then
				root_class_c.check_root_class_creators;
			end;

				-- Byte code production and type checking
			process_pass (pass3_controler);

			if not (precompilation or else Lace.compile_all_classes) then
					-- Externals incrementality
				freeze := freeze or else not externals.equiv;
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

				freeze_system;
				freeze := False;

			else
					-- Verbose
				io.error.putstring ("Melting changes%N");

				make_update;
debug ("VERBOSE")
	io.error.putstring ("Saving .workbench%N");
end;
			end;
			first_compilation := False;
		end;

	check_generics is
			-- Check generic validity on old classes
			-- generic parameters cannot be new classes
		local
			i, nb: INTEGER;
			a_class: CLASS_C
		do
debug ("ACTIVITY")
	io.error.putstring ("Check generics%N");
end;
			from
				i := 1;
				nb := id_array.count
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if
					a_class /= Void
				and then
					a_class.generics /= Void
				and then
						-- If the class is changed then `pass1' has been
						-- done successfully on the class
					not a_class.changed
				then
					a_class.check_generic_parameters
				end;
				i := i + 1
			end;
			Error_handler.checksum
		end;

	remove_useless_classes is
			-- Remove useless classes
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
			root_class_c: CLASS_C;
			marked_classes: ARRAY [BOOLEAN];
			vd31: VD31;
		do

				-- First mark all the classes that can be reached from the root class
			nb := id_array.count;
			!!marked_classes.make (1, nb);

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

				-- Remove all the classes that cannot be reached if they are
				-- not protected
			from
					-- Class of id less than protected_classes is protected
					-- See feature `init'
				i := protected_classes+1;
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if	a_class /= Void -- Classes could be removed
					and then
					marked_classes.item (i) = False
				then
					if a_class.has_visible then
						!!vd31;
						vd31.set_class_name (a_class.class_name);
						vd31.set_cluster (a_class.cluster);
						Error_handler.insert_error (vd31);
					else
debug ("REMOVE_CLASS")
	io.error.putstring ("Remove useless classes: ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end;
						remove_class (a_class)
					end;
				end;
				i := i + 1
			end;
			Error_handler.checksum
		end;

	build_conformance_table is
			-- Build the conformance table
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
		do
			from
					-- Iteration on the class of the system
				i := 1;
				nb := id_array.count;
			until
				i > nb
			loop
				a_class := id_array.item (i);
					-- Since classes can be removed from the system,
					-- there can be "holes' in `id_array'.
				if a_class /= Void then
					a_class.fill_conformance_table;
				end;

				i := i + 1;
			end;
		end;

	process_type_system is
			-- Compute the type system
		local
			a_class: CLASS_C;
			old_value: INTEGER;
		do
			old_value := type_id_counter.value;
			from
				pass4_controler.changed_classes.start
			until
				pass4_controler.changed_classes.after
			loop
				a_class := pass4_controler.changed_classes.item.associated_class;
				if a_class.changed and then a_class.generics = Void then
					if a_class.types.empty then
							-- For non generic classes, standard initialization
							-- of their attribute `types'.
						a_class.init_types;
					end;
				end;
				pass4_controler.changed_classes.forth
			end;
				-- For generic classes, compute the types
			Instantiator.process;

				-- If first compilation, re-order dynamic types
			if old_value = 0 then
				process_dynamic_types;
			end;
		end;

	process_skeleton is
			-- Type skeleton processing: for a class marked `changed2', the
			-- feature table has changed so the skeleton of its class
			-- types must be re-processed and markged `is_changed' if different.
			-- For a class marked `changed4', inspection of the types (instance
			-- of CLASS_TYPE) looking for a new one (marked `is_changed also).
		local
			a_class: CLASS_C;
			skeleton: SKELETON;
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
				if
					(not (precompilation or else Lace.compile_all_classes)) or else
					a_class.has_types
				then
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
			Error_handler.checksum;
		end;

	check_vtec is
		local
			i, nb: INTEGER;
			a_class: CLASS_C
		do
			from
				i := 1;
				nb := id_array.count;
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if
					a_class /= Void
				and then
					(	a_class.has_expanded or else
						a_class.is_used_as_expanded)
				then
					set_current_class (a_class);
					a_class.check_expanded
				end;
				i := i + 1;
			end;
		end;

	check_expanded is
			-- Check expanded client relation
		local
			class_type: CLASS_TYPE;
			types: TYPE_LIST;
			a_class: CLASS_C;
			check_exp: BOOLEAN;
		do
			check_exp := has_expanded;
			from
				pass4_controler.changed_classes.start
			until
				pass4_controler.changed_classes.after
			loop
				a_class := pass4_controler.changed_classes.item.associated_class;
debug ("CHECK_EXPANDED")
	io.error.putstring ("Check expanded on ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end;
				from
					types := a_class.types;
					types.start
				until
					types.after
				loop
					class_type := types.item;
					if class_type.is_changed then
debug ("CHECK_EXPANDED")
	io.error.putstring ("Check expanded on type of ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end;
						if check_exp then
							Expanded_checker.set_current_type (class_type);
							Expanded_checker.check_expanded;
						end;
						class_type.set_is_changed (False);
					end;

					types.forth
				end;
				pass4_controler.changed_classes.forth
			end;
		end;

	melt is
			-- Melt the changed features and feature and
			-- descriptor tables in the system.
		require
			no_error: not Error_handler.has_error
		local
			a_class: CLASS_C;
			id_list: LINKED_LIST [INTEGER];
			i: INTEGER;
			temp: STRING
		do
				-- Melt features
				-- Open the file for writing on disk feature byte code
			process_pass (pass4_controler);
			current_pass := Void;

				-- The dispatch and execution tables are know updated.

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
					a_class.melt_feature_table;
					a_class.melt_descriptor_tables;
					id_list.forth
				end;
				melted_set.wipe_out;
			end;
		end;

	make_update is
			-- Produce the update file resulting of the consecutive
			-- melting process after the system has been frozen.
		local
			id_list: LINKED_LIST [INTEGER];
			a_class: CLASS_C;
			types: TYPE_LIST;
			feat_tbl: MELTED_FEATURE_TABLE;
			class_id, nb_tables: INTEGER;
			file_pointer: POINTER;
			cl_type: CLASS_TYPE;

			root_feat: FEATURE_I;
			static_type: INTEGER;
			dtype: INTEGER;
			feature_id: INTEGER;
			has_argument: INTEGER;
		do
debug ("ACTIVITY")
	io.error.putstring ("Updating .UPDT%N");
end;
			Update_file.open_write;
			file_pointer := Update_file.file_pointer;

				-- There is something to update
			Update_file.putchar ('%/001/');

				-- Update the root class info
			a_class := root_class.compiled_class;
			dtype := a_class.types.first.type_id - 1;
			static_type := a_class.types.first.id - 1;
			if creation_name /= Void then
				root_feat := a_class.feature_table.item (creation_name);
				feature_id := root_feat.feature_id;
				if root_feat.has_arguments then
					has_argument := 1;
				end;
			end;
			write_int (file_pointer, static_type);
			write_int (file_pointer, dtype);
			write_int (file_pointer, feature_id);
			write_int (file_pointer, has_argument);

				-- Write first the number of class types now available
			write_int (file_pointer, type_id_counter.value);
				-- Write the number of classes now available
			write_int (file_pointer, class_counter.value);

debug ("ACTIVITY")
	io.error.putstring ("%Tfeature tables%N");
end;
				-- Count of feature tables to update
			from
				id_list := freeze_set2;
				id_list.start
			until
				id_list.after
			loop
				a_class := class_of_id (id_list.item);
debug ("ACTIVITY")
	io.error.putstring ("%T%T");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end;
				nb_tables := nb_tables + 
					(a_class.types.count - a_class.nb_precompiled_class_types);
				id_list.forth
			end;
				-- Write the number of feature tables to update
			write_int (file_pointer, nb_tables);
debug ("ACTIVITY")
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
debug ("ACTIVITY")
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
					if not types.item.is_precompiled then
						feat_tbl := m_feat_tbl_server.item
												(types.item.type_id);
debug ("ACTIVITY")
	io.error.putstring ("melting class desc of ");
	types.item.type.trace;
	io.error.new_line;
end;
						feat_tbl.store (Update_file);
					end;
					types.forth
				end;
				id_list.forth
			end;

debug ("ACTIVITY")
	io.error.putstring ("%TMelted routine id array%N");
end;
				-- Melted routine id array
			from
				m_rout_id_server.start
			until
				m_rout_id_server.after
			loop
				class_id := m_rout_id_server.key_for_iteration;
				a_class := class_of_id (class_id);
debug ("ACTIVITY")
io.error.putstring ("melting routine id array of ");
io.error.putint (class_id);
io.error.putstring (a_class.class_name);
io.error.new_line;
end;
				write_int (file_pointer, class_id);
				m_rout_id_server.item (class_id).store (Update_file);
				from
					types := a_class.types;
					types.start
				until
					types.after
				loop
					cl_type := types.item;
						-- Write dynamic type
					write_int (file_pointer, cl_type.type_id - 1);
						-- Write original dynamic type (forst freezing)
					write_int (file_pointer, cl_type.id - 1);
					types.forth
				end;
				write_int (Update_file.file_pointer, -1);
				m_rout_id_server.forth;
			end;
			write_int (file_pointer, -1);

				-- Update the dispatch table
			dispatch_table.make_update (Update_file);

				-- Open the file for reading byte code for melted features
				-- Update the execution table
			execution_table.make_update (Update_file);

			make_conformance_table_byte_code;

			make_option_table;

			make_rout_info_table;

				-- Melted descriptors
			from
				M_desc_server.start
			until
				M_desc_server.after
			loop
				class_id := M_desc_server.key_for_iteration;
				M_desc_server.item (class_id).store (Update_file);
				M_desc_server.forth
			end;
				-- End mark
			write_int (file_pointer, -1);

			Update_file.close;
		end;

	reset_melted_conformance_table is
			-- Forget the `melted_conformance_table', i.e. a new
			-- class or class type has been added to the system.
		do
				-- Mark the conformance table melted
			is_conformance_table_melted := True;
				-- Trigger the recompuation of the conformance table
				-- byte code
			melted_conformance_table := Void;
		end;

	make_conformance_table_byte_code is
			-- Generates conformance tables byte code.
		local
			i, nb: INTEGER;
			cl_type: CLASS_TYPE;
			to_append: CHARACTER_ARRAY;
		do
			Byte_array.clear;

			if is_conformance_table_melted then
				if melted_conformance_table = Void then
						-- Compute `melted_conformance_table'.
debug ("ACTIVITY")
	io.error.putstring ("Generating conformance table%N");
end;
					Byte_array.append ('%/001/');
					from
						i := 1;
						nb := Type_id_counter.value;
					until
						i > nb
					loop
						cl_type := class_types.item (i);
						if cl_type /= Void then
								-- Classes could be removed
							cl_type.make_conformance_table_byte_code
																(Byte_array);
						end;
						i := i + 1;
					end;

						-- End mark
					Byte_array.append_short_integer (-1);

						-- Cecil structure
					make_cecil_tables;
					Cecil2.make_byte_code (Byte_array);
					Cecil3.make_byte_code (Byte_array);

					melted_conformance_table := Byte_array.character_array;
				end;
				to_append := melted_conformance_table;
			else
debug ("ACTIVITY")
	io.error.putstring ("No changes in conformance table%N");
end;
				Byte_array.append ('%U');
				to_append := Byte_array.character_array
			end;

				-- Put the condormance table in `Update_file'.
			to_append.store (Update_file);

		end;

	make_option_table is
			-- Generate byte code for the option table.
		local
			i, nb: INTEGER;
			cl_type: CLASS_TYPE;
			a_class: CLASS_C;
		do
debug ("OPTIONS")
	io.error.putstring ("Making option table%N");
end;
			Byte_array.clear;
			from
				i := 1;
				nb := Type_id_counter.value;
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
				end;
				i := i + 1;
			end;
				-- End mark
			Byte_array.append_short_integer (-1);

				-- Put the byte code description of the option table
				-- in update file
			Byte_array.character_array.store (Update_file);
		end;

	make_rout_info_table is
			-- Generate byte code for the routine info table
			-- and store it to disk.
		do
			Rout_info_table.melted.store (Update_file)
		end;

	finalize is
			-- Finalize a successfull recompilation and update the
			-- compilation files.
		local
			a_class: CLASS_C;
			i, nb: INTEGER;
		do
				-- Reinitialization of control flags of the topological
				-- sort.
			update_sort := False;
			moved := False;

				-- Reset the classes as unchanged
			from
				i := 1;
				nb := id_array.count
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if a_class /= Void then
					a_class.set_changed (False);
					a_class.set_changed2 (False);
					-- FIXME: changed4, changed5, changed6
					a_class.changed_features.clear_all;
					a_class.propagators.wipe_out;
				end;
				i := i + 1
			end;

				-- Update servers
			Feat_tbl_server.take_control (Tmp_feat_tbl_server);
			Tmp_body_server.finalize;
			Tmp_inv_ast_server.finalize;
			Tmp_rep_feat_server.finalize;
			Ast_server.take_control (Tmp_ast_server);
			Class_info_server.take_control (Tmp_class_info_server);
			Byte_server.take_control (Tmp_byte_server);
			Inv_byte_server.take_control (Tmp_inv_byte_server);
			Depend_server.take_control (Tmp_depend_server);
			Rep_depend_server.take_control (Tmp_rep_depend_server);
			M_feat_tbl_server.take_control (Tmp_m_feat_tbl_server);
			M_feature_server.take_control (Tmp_m_feature_server);
			M_rout_id_server.take_control (Tmp_m_rout_id_server);
			M_desc_server.take_control (Tmp_m_desc_server);
			Rep_server.take_control (Tmp_rep_server);
				-- Just clear the rep info server
			Tmp_rep_info_server.clear;

			-- NO !!!!!!! See comment in `init_recompilation'
			--original_body_index_table := Void
		end;

feature -- Freeezing

	freeze_system is
			-- Worrkbench C code generation
		require
			root_class.compiled;
		local
			a_class: CLASS_C;
			id_list: LINKED_LIST [INTEGER];
			descriptors: ARRAY [INTEGER];
			i, nb: INTEGER;
			temp: STRING
		do
			freezing_occurred := True;
			if precompilation then
				!PRECOMP_MAKER!makefile_generator.make
			else
				!WBENCH_MAKER!makefile_generator.make
			end;
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
					a_class := id_array.item (id_list.item);
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
					a_class := id_array.item (descriptors.item (i));
					if a_class /= Void then
						melted_set.put (a_class.id);
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

						a_class.generate_descriptor_tables;
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
				a_class := id_array.item (id_list.item);
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

				a_class.pass4;

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
				a_class := id_array.item (id_list.item);
debug ("COUNT")
	io.error.putstring ("[");
	io.error.putint (i);
	io.error.putstring ("] ");
	i := i - 1;
end;
				if not a_class.is_precompiled then
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
			generate_main_eiffel_files;
		end;

	generate_main_eiffel_files is
			-- Generate the "E*.c" files.
		do
			generate_skeletons;

			generate_cecil;

			generate_conformance_table;
			is_conformance_table_melted := False;
			melted_conformance_table := Void;

			generate_plug;

			generate_init_file;

			generate_main_file;

			generate_option_file;

			generate_rout_info_table;

			pattern_table.generate;

			generate_make_file;

			generate_exec_tables;

				-- Empty update file
			generate_empty_update_file;
		end;

	generate_empty_update_file is
		do
			Update_file.open_write;
				-- Nothing to update
			Update_file.putchar ('%U');
			Update_file.close;
		end;

	update_valid_body_ids is
		local
			id_list: LINKED_LIST [INTEGER];
			a_class: CLASS_C;
		do
			from
				id_list := freeze_set1;
				id_list.start
			until
				id_list.after
			loop
				a_class := id_array.item (id_list.item);
				a_class.update_valid_body_ids;
				id_list.forth
			end;
		end;

	shake is
		local
			exec_unit: EXECUTION_UNIT;
			external_unit: EXT_EXECUTION_UNIT;
			info: EXTERNAL_INFO;
		do
				-- Real shake compresses the dispatch and execution tables
				-- Not called because the descriptors must be reprocessed
				-- if a dispatch unit is moved (real_body_index changes)

			update_valid_body_ids;

			execution_table.shake;
			dispatch_table.shake;

			if precompilation then
				execution_table.set_precomp_level;
				dispatch_table.set_precomp_level
			end;

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

				-- Freeze the external table: reset the real body ids,
				-- remove all unused externals and make the duplication
			externals.freeze;

		end;

feature -- Final mode generation

	in_final_mode: BOOLEAN is
			-- Generation of Final code ?
		do
			Result := byte_context.final_mode
		end;

	finalized_generation (keep_assert: BOOLEAN) is
			-- Finalizer generation
		require
			root_class.compiled;
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
			temp: STRING;
			old_remover_off: BOOLEAN;
			old_exception_stack_managed: BOOLEAN;
		do

				-- Save the value of `remover_off'
				-- and `exception_stack_managed'
			old_remover_off := remover_off;
			old_exception_stack_managed := exception_stack_managed

				-- Should dead code be removed?
			if not remover_off then
				remover_off := 
					keep_assert and then Lace.has_assertions;
			end;
			if not exception_stack_managed then
				exception_stack_managed := 
					keep_assert and then Lace.has_assertions;
			end;

				-- Set the generation mode in final mode
			byte_context.set_final_mode;

			Eiffel_table.init;

			from
				i := 1;
				nb := class_counter.value;
			until
				i > nb
			loop
				a_class := id_array.item (i);
					-- Since a clas can be removed, test if `a_class' is
					-- not Void.
				if a_class /= Void then
debug ("COUNT");
	io.error.putstring ("[");
	io.error.putint (nb-i+1);
	io.error.putstring ("] ");
end;
						-- Verbose
					io.error.putstring ("Degree -4: class ");
						temp := clone (a_class.class_name)
						temp.to_upper;
					io.error.putstring (temp);
					io.error.new_line;

					a_class.process_polymorphism;
					History_control.check_overload;
				end;

				i := i + 1;
			end;
			History_control.transfer;
			tmp_poly_server.flush;

				-- Dead code removal
			if not remover_off then
				-- Verbose
				io.error.putstring ("Removing dead code%N");
				remove_dead_code;
			end;
			tmp_opt_byte_server.flush;

			!FINAL_MAKER!makefile_generator.make;

			--process_dynamic_types;

				-- Generation of C files associated to the classes of
				-- the system.
			from
				i := 1;
				nb := class_counter.value;
				open_log_files
			until
				i > nb
			loop
				a_class := id_array.item (i);
					-- Since a clas can be removed, test if `a_class' is
					-- not Void.
				if a_class /= Void then
						-- Verbose
debug ("COUNT")
	io.error.putstring ("[");
	io.error.putint (nb-i+1);
	io.error.putstring ("] ");
end;
					io.error.putstring ("Degree -5: class ");
						temp := clone (a_class.class_name)
						temp.to_upper;
					io.error.putstring (temp);
					io.error.new_line;

					current_class := a_class;

					a_class.pass4;
				end;

				i := i + 1;
			end;
			close_log_files;

			generate_table;

				-- Generate makefile
			generate_make_file;

				-- Generate main file
			generate_main_file;
			generate_init_file;

				-- Clean Eiffel table
			Eiffel_table.wipe_out;
			Tmp_poly_server.clear;
			Tmp_opt_byte_server.clear;

			remover := Void;
			remover_off := old_remover_off;
			exception_stack_managed := old_exception_stack_managed
		rescue
				-- Clean the servers if the finalization is aborted
			Tmp_poly_server.flush;
			Tmp_poly_server.clear;
			Tmp_opt_byte_server.flush;
			Tmp_opt_byte_server.clear;
		end;

feature -- Dead code removal

	set_remover_off (b: BOOLEAN) is
			-- Assign `b' to `remover_off'
		do
			remover_off := b;
		end;

	remove_dead_code is
			-- Dead code removal
		local
			a_class: CLASS_C;
			root_feat: FEATURE_I;
			i, nb: INTEGER;
			ct: CLASS_TYPE;
		do
			!!remover.make;

				-- record the descendants of ARRAY;
			if array_optimization_on then
				remover.record_array_descendants
			end;

				-- First, inspection of the Eiffel code
			if creation_name /= Void then
				a_class := root_class.compiled_class;
				root_feat := a_class.feature_table.item (creation_name);
				remover.record (root_feat, a_class);
			end;

			from
				i := 1;
				nb := id_array.count;
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if a_class /= Void then
						-- Classes could be removed	then
					a_class.mark_dispose (remover);
					if a_class.visible_level.has_visible then
						a_class.mark_visible (remover)
					end;
				end;
				i := i + 1
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
						ct.mark_creation_routine (remover);
					end;
					i := i + 1;
				end;
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
			io.error.new_line;
		end;

	is_used (f: FEATURE_I): BOOLEAN is
			-- Is feature `f' used in the system ?
		require
			good_argument: f /= Void;
		do
			Result := remover_off or else remover.is_alive (f)
		end;

feature -- In-lining optimization

	array_optimization_on: BOOLEAN;
			-- Is array optimization on?

	set_array_optimization_on (b: BOOLEAN) is
		do
			array_optimization_on := b;
		end;

	inlining_on: BOOLEAN;
			-- Is inlining on ?

	set_inlining_on (b: BOOLEAN) is
		do
			inlining_on := b
		end;

	inlining_size: INTEGER

	set_inlining_size (i: INTEGER) is
		do
debug ("INLINING")
	io.error.putstring ("Inlining size: ");
	io.error.putint (i)
	io.error.new_line
end
			inlining_size := i
		end;

feature

	do_not_check_vape: BOOLEAN;

	set_do_not_check_vape (b: BOOLEAN) is
		do
			do_not_check_vape := b;
		end;

feature -- Generation

	generate_table is
			-- Generation of all the tables needed by the finalized
			-- Eiffel executable
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

				-- Generate plug with run-time
			generate_plug;

				-- Routine table generation
			generate_routine_table;
		end;

	process_dynamic_types is
			-- Processing of the dynamic types
		local
			class_list: ARRAY [CLASS_C];
			a_class: CLASS_C;
			types: TYPE_LIST;
			class_type: CLASS_TYPE;
			new_type_id, i, nb: INTEGER;
		do
				-- First re-process all the type id of instances of
				-- CLASS_TYPE available in attribute list `types' of
				-- instances of CLASS_C

debug ("ACTIVITY")
	io.error.putstring ("Process dynamic types%N");
end;
				-- Sort the class_list by type id in `class_list'.
			from
				i := 1;
				nb := id_array.count;
				!!class_list.make (1, max_class_id);
			until
				i > nb
			loop
				a_class := id_array.item (i);
					-- Since classes can be removed from the system, test if
					-- `a_class' is not Void
				if a_class /= Void then
					class_list.put (a_class, a_class.topological_id);
				end;
				i := i + 1;
			end;
			nb := max_class_id;

				-- Iteration on `class_list' in order to compute new type
				-- id's
			from
					-- Reset the type id counter
				type_id_counter.reset;
				i := 1;
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
					new_type_id := type_id_counter.next;
					class_type.set_type_id (new_type_id);
debug ("ACTIVITY")
	io.error.putint (new_type_id);
	io.error.putstring (": ");
	class_type.type.trace;
	io.error.putstring (" [");
	io.error.putint (class_type.id);
	io.error.putstring ("]%N");
end;
						-- Update `class_types'
					insert_class_type (class_type);
					types.forth
				end;
				i := i + 1
			end;

		end;

	generate_routine_table is
			-- Generate routine tables
		require
			in_final_mode: byte_context.final_mode
		local
			rout_id: INTEGER;
			table: POLY_TABLE [ENTRY];
		do
			Attr_generator.init;
			Rout_generator.init;

			from
				Tmp_poly_server.start
			until
				Tmp_poly_server.after
			loop
				rout_id := Tmp_poly_server.key_for_iteration;

				if Eiffel_table.is_used (rout_id) then
					table := Tmp_poly_server.item (rout_id).poly_table;
					table.write;
				end;
				Tmp_poly_server.forth;
			end;
			generate_initialization_table;
			generate_dispose_table;

			Attr_generator.finish;
			Rout_generator.finish;
		end;

	generate_size_table is
			-- Generate the size table.
		local
			i, nb: INTEGER;
			class_type: CLASS_TYPE;
			file: INDENT_FILE
		do
			file := Size_file (byte_context.final_mode);
			from
				i := 1;
				nb := type_id_counter.value;
				file.open_write;
				file.putstring ("#include %"macros.h%"%N%N");
				file.putstring ("long esize[] = {%N");
			until
				i > nb
			loop
				class_type := class_types.item (i);
if class_type /= Void then
				class_type.skeleton.generate_size (file);
else
	-- FIXME
	-- Process_dynamic_types has been TEMPORARILY removed
				file.putstring ("0");
end;
				file.putstring (",");
				file.new_line;
				i := i + 1;
			end;
			file.putstring ("};%N");
			file.close;
		end;

	generate_reference_table is
			-- Generate the table of reference numer per type.
		local
			i, nb, nb_ref, nb_exp: INTEGER;
			class_type: CLASS_TYPE;
			skeleton: SKELETON;
		do
			from
				i := 1;
				nb := type_id_counter.value;
				Reference_file.open_write;
				Reference_file.putstring ("long nbref[] = {%N");
			until
				i > nb
			loop
				class_type := class_types.item (i);
if class_type /= Void then
				skeleton := class_type.skeleton;
				nb_ref := skeleton.nb_reference;
				nb_exp := skeleton.nb_expanded;
				Reference_file.putint (nb_ref + nb_exp);
else
		-- FIXME process_dynamic_types TEMPORARILY removed
	Reference_file.putint (0);
end;
				Reference_file.putchar (',');
				Reference_file.new_line;
				i := i + 1;
			end;
			Reference_file.putstring ("};%N");
			Reference_file.close;
		end;

	generate_skeletons is
			-- Generate skeletons of class types
		local
			i, nb, nb_class: INTEGER;
			cl_type: CLASS_TYPE;
			a_class: CLASS_C;
			has_attribute, final_mode: BOOLEAN;
			types: TYPE_LIST;
			type_cursor: LINKABLE [CLASS_TYPE];
			f_name: STRING;
				-- cltype_array is indexed by `id' not by `type_id'
				-- as `class_types'
			cltype_array: ARRAY [CLASS_TYPE];
			subdir: DIRECTORY
		do
			nb := Type_id_counter.value;
			final_mode := byte_context.final_mode;

				-- Open skeleton file
			Skeleton_file := Skeleton_f (final_mode);
			Skeleton_file.open_write;

			Skeleton_file.putstring ("#include %"struct.h%"%N");
			if final_mode then
				Skeleton_file.putstring ("#include %"");
				Skeleton_file.putstring (Eskelet);
				Skeleton_file.putstring (Dot_h);
				Skeleton_file.putstring ("%"%N%N");
				from
					i := 1
				until
					i > nb
				loop
if class_types.item (i) /= Void then
	-- FIXME
					class_types.item (i).skeleton.make_extern_declarations;
end;
					i := i + 1;
				end;
				f_name := clone (System_object_prefix);
				f_name.append_integer (1);
				f_name := build_path (Final_generation_path, f_name);
				!! subdir.make (f_name);
				if not subdir.exists then
					subdir.create
				end;
				f_name := build_path (f_name, Eskelet);
				f_name.append (Dot_h);
				Extern_declarations.generate (f_name);
				Extern_declarations.wipe_out;
			else
					-- Hash table extern declaration in workbench mode
				Skeleton_file.putstring ("#include %"macros.h%"%N");
				Skeleton_file.new_line;
				from
					i := 1;
					nb_class := id_array.count;
				until
					i > nb_class
				loop
					a_class := class_of_id (i);
					if a_class /= Void then
							-- Classes could be removed
						Skeleton_file.putstring ("%
							%extern int32 ra");
						Skeleton_file.putint (i);
						Skeleton_file.putstring ("[];%N");
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
						--		type_cursor := types.first_element;
								types.start
							until
						--		type_cursor = Void
								types.off
							loop
								Skeleton_file.putstring ("extern uint32 types");
								Skeleton_file.putint (types.item.type_id);
								Skeleton_file.putstring ("[];%N");
						--		type_cursor := type_cursor.right;
								types.forth
							end;
						end;
					end;

					i := i + 1;
				end;
				Skeleton_file.new_line;

				!!cltype_array.make (1, static_type_id_counter.value);
			end;

			from
				i := 1;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
					-- Classes could be removed
if cl_type /= Void then
				cl_type.generate_skeleton1;
				if not final_mode then
					cltype_array.put (cl_type, cl_type.id);
				end;
else
		-- FIXME
end;
				i := i + 1;
			end;

			if final_mode then
				Skeleton_file.putstring ("struct cnode esystem[] = {");
			else
				Skeleton_file.putstring ("struct cnode fsystem[] = {");
			end;
			Skeleton_file.new_line;
			from
				i := 1;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
if cl_type /= Void then
				cl_type.generate_skeleton2;
else
		-- FIXME
	if final_mode then
		Skeleton_file.putstring ("{ 0, %"INVALID_TYPE%", (char**)0, 0,0,0,0}");
	else
		Skeleton_file.putstring ("{ 0, %"INVALID_TYPE%", (char**)0, 0,0,0,0,0,%N");
		Skeleton_file.putstring ("'\0', '\0', 0, 0 , '\0', 0 , {0,0,0,0}}");
	end;
end;
				Skeleton_file.putstring (",%N");
				i := i + 1;
			end;
			Skeleton_file.putstring ("};%N%N");

			if not final_mode then
					-- Generate the array of routine id arrays
				Skeleton_file.putstring ("int32 *fcall[] = {%N");
				from
					i := 1
				until
					i > nb
				loop
					cl_type := cltype_array.item (i);
					if cl_type /= Void then
						Skeleton_file.putstring ("ra");
						Skeleton_file.putint (cl_type.associated_class.id);
					else
						Skeleton_file.putstring ("(int32 *) 0");
					end;
					Skeleton_file.putchar (',');
					Skeleton_file.new_line;
					i := i + 1
				end;
				Skeleton_file.putstring ("};%N%N");
					-- Generate the correspondances stable between original
					-- dynamic types and new dynamic types
				Skeleton_file.putstring ("int16 fdtypes[] = {%N");
				from
					i := 1
				until
					i > nb
				loop
					cl_type := cltype_array.item (i);
					Skeleton_file.putstring ("(int16) ");
					if cl_type /= Void then
						Skeleton_file.putint (cl_type.type_id - 1);
					else
						Skeleton_file.putint (0);
					end;
					Skeleton_file.putchar (',');
					Skeleton_file.new_line;
					i := i + 1
				end;
				Skeleton_file.putstring ("};%N");
			end;
				-- Close skeleton file
			Skeleton_file.close;
			Skeleton_file := Void;
		end;

	generate_cecil is
			-- Generate Cecil structures
		local
			i, nb, generic, no_generic: INTEGER;
			cl_type: CLASS_TYPE;
			a_class: CLASS_C;
			final_mode: BOOLEAN;
			f_name: STRING;
			subdir: DIRECTORY
		do
			final_mode := byte_context.final_mode;

			Cecil_file := cecil_f (final_mode);
			Cecil_file.open_write;
			Cecil_file.putstring ("#include %"cecil.h%"%N");
			if final_mode then
				Cecil_file.putstring ("#include %"ececil.h%"%N");
			end;
			Cecil_file.putstring ("#include %"struct.h%"%N%N");

			from
				i := 1;
				nb := class_counter.value;
			until
				i > nb
			loop
				a_class := class_of_id (i);
				if a_class /= Void and then a_class.has_visible then
					a_class.generate_cecil;
				end;
				i := i + 1;
			end;

			if final_mode then
					-- Extern declarations for previous file
				f_name := clone (System_object_prefix);
				f_name.append_integer (1);
				f_name := build_path (Final_generation_path, f_name);
				!! subdir.make (f_name);
				if not subdir.exists then
					subdir.create
				end;
				f_name := build_path (f_name, "ececil.h");
				Extern_declarations.generate (f_name);
				Extern_declarations.wipe_out;
				Cecil_file.putstring ("%Nstruct ctable ce_rname[] = {%N");
				from
					i := 1;
					nb := Type_id_counter.value;
				until
					i > nb
				loop
if class_types.item (i) /= Void then
					class_types.item (i).generate_cecil (Cecil_file);
else
		-- FIXME
		Cecil_file.putstring ("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
end;
					Cecil_file.putstring (",%N");
					i := i + 1;
				end;
				Cecil_file.putstring ("};%N%N");
			end;

			make_cecil_tables;
			Cecil2.generate;
			Cecil3.generate;

			Cecil_file.close;
			Cecil_file := Void;
		end;

	make_cecil_tables is
			-- Prepare cecil tables
		local
			i, nb, generic, no_generic: INTEGER;
			a_class: CLASS_C;
			upper_class_name: STRING;
		do
			from
				i := 1;
				nb := id_array.count;
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if a_class /= Void then
					if a_class.generics = Void then
						no_generic := no_generic + 1;
					else
						generic := generic + 1;
					end;
				end;
				i := i + 1;
			end;
			from
				i := 1;
				Cecil2.init (no_generic);
				Cecil3.init (generic);
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if a_class /= Void then
					upper_class_name := clone (a_class.external_name);
					upper_class_name.to_upper;
					if a_class.generics = Void then
						Cecil2.put (a_class, upper_class_name);
					else
						Cecil3.put (a_class, upper_class_name);
					end;
				end;
				i := i + 1;
			end;
		end;

	generate_conformance_table is
			-- Generates conformance tables.
		local
			i, nb: INTEGER;
			cl_type: CLASS_TYPE;
		do
			Conformance_file := conformance_f (byte_context.final_mode);
			Conformance_file.open_write;

			Conformance_file.putstring ("#include %"struct.h%"%N%N");

			from
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
if cl_type /= Void then
		-- FIXME
				cl_type.generate_conformance_table;
end;
				i := i + 1;
			end;

			if byte_context.final_mode then
				Conformance_file.putstring
								("struct conform *co_table[] = {%N");
			else
				Conformance_file.putstring
								("struct conform *fco_table[] = {%N");
			end;
			from
				i := 1;
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
				i := i + 1;
			end;
			Conformance_file.putstring ("};%N");
			Conformance_file.close;
			Conformance_file := Void;
		end;

	generate_initialization_table is
			-- Generate table of initialization routines
		local
			rout_table: SPECIAL_TABLE;
			rout_entry: SPECIAL_ENTRY;
			i, nb: INTEGER;
			class_type: CLASS_TYPE;
		do
			from
				!!rout_table.make;
				rout_table.set_rout_id (Initialization_id);
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				class_type := class_types.item (i);
if class_type /= Void then
-- FIXME
				if class_type.has_creation_routine then
					!!rout_entry;
					rout_entry.set_type_id (i);
					rout_entry.set_written_type_id (i);
					rout_entry.set_kind (Initialization_id);
					rout_table.extend (rout_entry);
				end;
end;
				i := i + 1;
			end;
			rout_table.write;
		end;

feature -- Dispose routine

	memory_dispose_id: INTEGER is
			-- Memory dispose routine id from class MEMORY. 
			-- Return 0 if the MEMORY class has not been compiled.
			--! (Assumed memory must have a dispose routine
			--! called "dispose" - DINOV).
		require
			checked_desc: memory_descendants /= Void
		local
			feature_i: FEATURE_I;
		once
			if memory_class /= Void then
				feature_i :=
				memory_class.feature_table.item ("dispose");
				if feature_i /= Void then
					Result := feature_i.rout_id_set.first;
				end;
			end
		end;

	memory_class: CLASS_C is
			-- MEMORY class of system. Void if it has
			-- not been compiled.
		local
			nbr, i: INTEGER;
			class_c: CLASS_C
		once
			from
				nbr := id_array.count;
				i := 1
			until
				i > nbr or else (Result /= Void)
			loop
				class_c := id_array.item (i);
				if
					(class_c /= Void)
				and then
					class_c.class_name.is_equal ("memory")
				then
					Result := class_c
				else
					i := i + 1;
				end;
			end;
		end;

	memory_descendants: LINKED_LIST [CLASS_C] is
			-- Memory descendants.
		once
			!!Result.make;
			if memory_class /= Void then
				formulate_mem_descendants (memory_class, Result);
			end;
		end;
 
	formulate_mem_descendants (c: CLASS_C; desc: LINKED_LIST [CLASS_C]) is
			-- Formulate descendants of class MEMORY. 
		local
			descendants: LINKED_LIST [CLASS_C];
			d: CLASS_C
		do
			from
				descendants := c.descendants;
				descendants.start
			until
				descendants.after
			loop
				d := descendants.item;
				desc.extend (d);
				formulate_mem_descendants (d, desc);
				descendants.forth;
			end;
		end;
 
	generate_dispose_table is
			-- Generate dispose table
		local
			rout_table: SPECIAL_TABLE;
			rout_entry: SPECIAL_ENTRY;
			i, nb: INTEGER;
			class_type: CLASS_TYPE;
			feature_i: FEATURE_I;
			written_type: CL_TYPE_I;
			written_class: CLASS_C
		do
			from
				!!rout_table.make;
				rout_table.set_rout_id (Dispose_id);
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb 
			loop
				class_type := class_types.item (i);
if class_type /= Void then
	-- FIXME
				feature_i := class_type.dispose_feature;
				if feature_i /= Void then
					!!rout_entry;
					rout_entry.set_type_id (i);
					written_class := class_of_id (feature_i.written_in);
					written_type := written_class.meta_type (class_type.type);
					rout_entry.set_written_type_id (written_type.type_id);
					rout_entry.set_kind (feature_i.body_id);
					rout_table.extend (rout_entry);
				end;
end;
				i := i + 1;
			end;
			rout_table.write;
		end;

feature -- Plug and Makefile file

	generate_plug is
			-- Generate plug with run-time
		local
			string_cl, bit_cl, array_cl: CLASS_C;
			arr_type_id, str_type_id, type_id, id: INTEGER;
			set_count_feat, creation_feature: FEATURE_I;
			creators: EXTEND_TABLE [EXPORT_I, STRING];
			dispose_name, str_make_name, init_name, set_count_name: STRING;
			arr_make_name: STRING;
			special_cl: SPECIAL_B;
			cl_type: CLASS_TYPE;
			final_mode: BOOLEAN;
		do
			final_mode := byte_context.final_mode;

			Plug_file := plug_f (final_mode);
			Plug_file.open_write;

			Plug_file.putstring ("#include %"portable.h%"%N%N");

				-- Extern declarations
			string_cl := class_of_id (string_id);
			cl_type := string_cl.types.first;
			id := cl_type.id;
			str_type_id := cl_type.type_id;
			creators := string_cl.creators;
			creators.start;
			--! make string declaration
			creation_feature := string_cl.feature_table.item
											(creators.key_for_iteration);
			set_count_feat := string_cl.feature_table.item ("set_count");
			str_make_name := clone (Encoder.feature_name
							(id, creation_feature.body_id))
			set_count_name := clone (Encoder.feature_name
							(id, set_count_feat.body_id))
			Plug_file.putstring ("extern void ");
			Plug_file.putstring (str_make_name);
			Plug_file.putstring ("();%N");
			Plug_file.putstring ("extern void ");
			Plug_file.putstring (set_count_name);
			Plug_file.putstring ("();%N");

			--| make array declaration
			--| Temporary solution. When a system uses precompiled information,
			--| the C code for ARRAY[ANY] is never re-generated, but the computed
			--| name of the make routine will (unfortunately) change. Therefore, the
			--| name in the plug file might not match the name in the precompiled
			--| C file... Heavy!
			if
				(array_make_name = Void) or not uses_precompiled or final_mode
			then
				array_cl := class_of_id (array_id);
					--! Array ref type (i.e. ARRAY[ANY])
				cl_type := Instantiator.Array_type.associated_class_type; 
				id := cl_type.id;
				arr_type_id := cl_type.type_id;
				creators := array_cl.creators;
				creators.start;
				creation_feature := array_cl.feature_table.item
											(creators.key_for_iteration);
				arr_make_name := clone (Encoder.feature_name
								(id, creation_feature.body_id))
				array_make_name := clone (arr_make_name)
			else
				cl_type := Instantiator.Array_type.associated_class_type; 
				arr_type_id := cl_type.type_id;
				arr_make_name := array_make_name
			end;
			Plug_file.putstring ("extern void ");
			Plug_file.putstring (arr_make_name);
			Plug_file.putstring ("();%N");

			if final_mode then
				init_name :=
						clone (Encoder.table_name (Initialization_id))
				dispose_name := 
						clone (Encoder.table_name (Dispose_id))

				Plug_file.putstring ("extern char *(*");
				Plug_file.putstring (init_name);
				Plug_file.putstring ("[])();%N");
				Plug_file.putstring ("extern char *(*");
				Plug_file.putstring (dispose_name);
				Plug_file.putstring ("[])();%N%N");
			end;

			if final_mode and then array_optimization_on then
				remover.array_optimizer.generate_plug_declarations (Plug_file)
			else
				Plug_file.putstring ("long *eif_area_table = (long *)0;%N%
										%long *eif_lower_table = (long *)0;%N");
			end;

				-- Pointer on creation feature of class STRING
			Plug_file.putstring ("void (*eif_strmake)() = ");
			Plug_file.putstring (str_make_name);
			Plug_file.putstring (";%N");
				-- Pointer on creation feature of class ARRAY[ANY]
			Plug_file.putstring ("void (*eif_arrmake)() = ");
			Plug_file.putstring (arr_make_name);
			Plug_file.putstring (";%N");

				--Pointer on `set_count' of class STRING
			Plug_file.putstring ("void (*eif_strset)() = ");
			Plug_file.putstring (set_count_name);
			Plug_file.putstring (";%N");

				-- Dynamic type of class STRING
			Plug_file.putstring ("int str_dtype = ");
			Plug_file.putint (str_type_id - 1);
			Plug_file.putstring (";%N");

				-- Dynamic type of class ARRAY[ANY]
			Plug_file.putstring ("int arr_dtype = ");
			Plug_file.putint (arr_type_id - 1);
			Plug_file.putstring (";%N");

				-- Dispose routine id from class MEMORY (if compiled) 
			Plug_file.putstring ("int32 disp_rout_id = ");
			if memory_class /= Void then
				Plug_file.putint (memory_dispose_id);
			else
				Plug_file.putstring ("-1");
			end;
			Plug_file.putstring (";%N");

				-- Dynamic type of class BIT_REF
			bit_cl := class_of_id (bit_id);
			type_id := bit_cl.types.first.type_id;
			Plug_file.putstring ("int bit_dtype = ");
			Plug_file.putint (type_id - 1);
			Plug_file.putstring (";%N");

			if final_mode then
					-- Initialization routines
				Plug_file.putstring ("char *(**ecreate)() = ");
				Plug_file.putstring (init_name);
				Plug_file.putstring (";%N");

					-- Dispose routines
				Plug_file.putstring ("void (**edispose)() = ");
				Plug_file.putstring ("(void (**)()) ");
				Plug_file.putstring (dispose_name);
				Plug_file.putstring (";%N");

			end;

			special_cl ?= special_class.compiled_class;
			special_cl.generate_dynamic_types;
			generate_dynamic_ref_type;
			Plug_file.close;
			Plug_file := Void;
		end;

	generate_make_file is
			-- Generate make file
		do
			makefile_generator.generate;
			makefile_generator.clear;
			makefile_generator := Void
		end;

feature -- Dispatch and execution tables generation

	generate_exec_tables is
			-- Generate `dispatch_table' and `execution_table'.
		do
			Dispatch_file.open_write;
			dispatch_table.generate (Dispatch_file);
			dispatch_table.freeze;
			Dispatch_file.close;

			Frozen_file.open_write;
			execution_table.generate (Frozen_file);
			execution_table.freeze;
			Frozen_file.close;

				-- The melted list of the dispatch and execution tables
				-- are now empty
		end

feature -- Main file generation

	generate_main_file is
		local
			Main_file: INDENT_FILE;
		do
			Main_file := Main_f (byte_context.final_mode);
			Main_file.open_write;

			Main_file.putstring ("%N%
				%#include %"except.h%"%N%
				%extern void emain();%N%
				%extern void reclaim();%N%
				%extern void failure();%N%
				%extern void eif_rtinit();%N%N");

			Main_file.putstring ("void main(argc, argv, envp)%N%
				%int argc;%N%
				%char **argv;%N%
				%char **envp;%N%
				%{%N%
				%%Tstruct ex_vect *exvect;%N%
				%%Tjmp_buf exenv;%N%N%
				%%Tinitsig();%N%
				%%Tinitstk();%N%
				%%Texvect = exset((char *) 0, 0, (char *) 0);%N%
				%%Texvect->ex_jbuf = (char *) exenv;%N%
				%%Tif (echval = setjmp(exenv))%N%
				%%T%Tfailure();%N%N%
				%%Teif_rtinit(argc, argv, envp);%N%
				%%Temain(argc, argv);%N%
				%%Treclaim();%N%
				%%Texit(0);%N%
				%}%N");

			Main_file.close;
		end;

	generate_init_file is
			-- Generation of the main file
		local
			root_cl: CLASS_C;
			root_feat: FEATURE_I;
			ext_feat: EXTERNAL_I;
			c_name: STRING;
			dtype: INTEGER;
			final_mode: BOOLEAN;
			cl_type: CLASS_TYPE;

			static_type: INTEGER;
			feature_id: INTEGER;
			has_argument: BOOLEAN;
			i, nb: INTEGER;
			Initialization_file: INDENT_FILE

			rout_id: INTEGER;
			rout_table: ROUT_TABLE
		do

			final_mode := byte_context.final_mode;
			Initialization_file := Init_f (final_mode);

			root_cl := root_class.compiled_class;
			cl_type := root_cl.types.first;
			dtype := cl_type.type_id - 1;

			static_type := cl_type.id - 1;
			if creation_name /= Void then
				root_feat := root_cl.feature_table.item (creation_name);
				feature_id := root_feat.feature_id;
				if root_feat.has_arguments then
					has_argument := True;
				end;
			end;

			Initialization_file.open_write;

			Initialization_file.putstring ("%
				%#include %"macros.h%"%N%
				%#include %"struct.h%"%N%N");

			if not final_mode then
				Initialization_file.putstring ("int rcst = ");
				Initialization_file.putint (static_type);
				Initialization_file.putstring (";%Nint rcdt = ");
				Initialization_file.putint (dtype);
				Initialization_file.putstring (";%Nint32 rcfid = ");
				Initialization_file.putint (feature_id);
				Initialization_file.putstring (";%Nint rcarg = ");
				if has_argument then
					Initialization_file.putstring ("1");
				else
					Initialization_file.putstring ("0");
				end;
				Initialization_file.putstring (";%N%N");
			end;

			Initialization_file.putstring ("%
				%void emain(argc, argv)%N%
				%int argc;%N%
				%char **argv;%N%
				%{%N%
				%%Textern char *root_obj;%N");

			if 	creation_name /= Void then
				if final_mode then
					rout_id := root_feat.rout_id_set.first;
					rout_table ?= Eiffel_table.item_id (rout_id);
					c_name := rout_table.feature_name (cl_type.id);
					Initialization_file.putstring ("%Textern void ");
					Initialization_file.putstring (c_name);
					Initialization_file.putstring (" ();%N%N");
				end;
			end;

			-- Set C variable `scount'.
			if final_mode then
				Initialization_file.putstring ("%Tscount = ");
				Initialization_file.putint (type_id_counter.value);
				Initialization_file.putstring (";%N");
			end;

			Initialization_file.putstring ("%Troot_obj = RTLN(");
			if final_mode then
				Initialization_file.putint (dtype);
			else
				Initialization_file.putstring ("rcdt");
			end;
			Initialization_file.putstring (");%N");

			if final_mode then
				if creation_name /= Void then
					Initialization_file.putchar ('%T');
					Initialization_file.putstring (c_name);
					Initialization_file.putstring ("(root_obj");
					if root_feat.has_arguments then
						Initialization_file.putstring (", argarr(argc, argv)");
					end;
					Initialization_file.putstring (");%N");
				end;
			else
				Initialization_file.putstring ("%Tif (rcfid)%N%
					%%T%Tif (rcarg)%N%
					%%T%T%T((void (*)()) RTWF(rcst, rcfid, rcdt))(root_obj, argarr(argc, argv));%N%
					%%T%Telse%N%
					%%T%T%T((void (*)()) RTWF(rcst, rcfid, rcdt))(root_obj);%N");
			end;

			Initialization_file.putstring ("}%N");

			-- Generation of einit() and tabinit(). Only for workbench
			-- mode.

			if not final_mode then

				Initialization_file.putstring ("%Nvoid tabinit()%N{%N");
				from
					i := 1;
					nb := type_id_counter.value
				until
					i > nb
				loop
					cl_type := class_types.item (i);

-- FIXME ???
-- cl_type cannot be Void if process_dynamic_types has been done in
-- freeze_system.
					if cl_type /= Void then
						Initialization_file.putstring ("%TInit");
						Initialization_file.putint (cl_type.id);
						Initialization_file.putstring ("();%N")
					end;
					i := i + 1
				end;
				Initialization_file.putstring ("}%N");

				Initialization_file.putstring ("%Nvoid einit()%N{%N");

					-- Set C variable `scount'.
				Initialization_file.putstring ("%Tscount = ");
				Initialization_file.putint (type_id_counter.value);
					-- Set C variable `ccount'.
				Initialization_file.putstring (";%N%Tccount = ");
				Initialization_file.putint (class_counter.value);
					-- Set C variable `dcount'.
				Initialization_file.putstring (";%N%Tdcount = ");
				Initialization_file.putint (dispatch_table.counter);
					-- Set the frozen level
				Initialization_file.putstring (";%N%Tzeroc = ");
				Initialization_file.putint (frozen_level);
				Initialization_file.putstring (";%N}%N");
			end;

			Initialization_file.close;
		end;

feature -- Workbench routine info table file generation

	generate_rout_info_table is
		local
			f: INDENT_FILE
		do
			if not byte_context.final_mode then
				f := Rout_info_file;
				f.open_write;
				f.putstring (Rout_info_table.C_string);
				f.close;
			end;
		end;

feature --Workbench option file generation

	generate_option_file is
			-- Generate compialtion option file
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
			partial_debug: DEBUG_TAG_I;
			class_type: CLASS_TYPE;
		do
			Option_file.open_write;

			Option_file.putstring ("#include %"struct.h%"%N%N");

				-- First debug keys
			from
				i := 1;
				nb := id_array.count;
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if a_class /= Void then
					partial_debug ?= a_class.debug_level;
					if partial_debug /= Void then
						partial_debug.generate_keys (Option_file, a_class.id);
					end;
				end;
				i := i + 1;
			end;

				-- Then option C array
			Option_file.putstring ("struct eif_opt foption[] = {%N");
			from
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				class_type := class_types.item (i);
				Option_file.putchar ('{');
				if class_type /= Void then
						-- Classes could be removed
					a_class := class_type.associated_class;
					a_class.assertion_level.generate (Option_file);
					Option_file.putstring (", ");
					a_class.trace_level.generate (Option_file);
					Option_file.putstring (", ");
					a_class.debug_level.generate (Option_file, a_class.id);
				else
					Option_file.putstring ("%
						%(int16) 0, (int16) 0,%
							%{(int16) 0, (int16) 0, (char **) 0}");
				end;
				Option_file.putstring ("},%N");
				i := i + 1;
			end;
			Option_file.putstring ("};%N");

			Option_file.close;
		end;

feature 

	set_code_replication_off (b: BOOLEAN) is
			-- Assign `b' to `replication_off'
		do
			code_replication_off := b;
		end;

	set_exception_stack_managed (b: BOOLEAN) is
		do
			exception_stack_managed := b;
		end;

	set_has_expanded is
			-- Set `has_expanded' to True
		do
debug ("ACTIVITY")
	io.error.putstring ("%N%NSystem has expanded%N%N");
end;
			has_expanded := True;
		end;

	process_pass (a_pass: PASS) is
			-- Process `a_pass'
		do
			current_pass := a_pass;
			a_pass.execute;
		end;

	set_current_class (a_class: CLASS_C) is
		do
			current_class := a_class
		end;

	in_pass3: BOOLEAN is
			-- Is `pass3' the current pass ?
		do
			Result := (current_pass = pass3_controler)
		end;

--	clear is
--				-- Clear the servers
--		do
--			Tmp_ast_server.clear;
--			Tmp_feat_tbl_server.clear;
--			Tmp_body_server.clear;
--			Tmp_class_info_server.clear;
--			Tmp_rep_info_server.clear;
--			Tmp_byte_server.clear;
--			Tmp_inv_byte_server.clear;
--			Tmp_inv_ast_server.clear;
--			Tmp_depend_server.clear;
--			Tmp_rep_depend_server.clear;
--			Tmp_rep_server.clear;
--			Tmp_rep_feat_server.clear;
--			Tmp_rep_info_server.clear;
--		end;

	System_chunk: INTEGER is 500;

feature -- Purge of compilation files

	purge is
			-- Purge compilation files and delete useless datas.
		require
			successfull
		do
			server_controler.remove_useless_files;

				-- Transfer datas from servers to temporary servers
			feat_tbl_server.purge;
			depend_server.purge;
			rep_depend_server.purge;
			class_info_server.purge;
			inv_byte_server.purge;
			byte_server.purge;
			ast_server.purge;
			m_feat_tbl_server.purge;
			m_feature_server.purge;
			m_rout_id_server.purge;
			m_desc_server.purge;
			rep_server.purge;
		end;

feature -- Conveniences

	set_system_name (s: STRING) is
			-- Assign `s' to `system_name'.
		do
			system_name := s;
		end;

	set_root_cluster (c: CLUSTER_I) is
			-- Assign `c' to `root_cluster'.
		do
			root_cluster := c;
		end;

	set_root_class_name (s: STRING) is
			-- Assign `s' to `root_class_name'.
		do
			root_class_name := s;
		end;

	set_creation_name (s: STRING) is
			-- Assign `s' to `creation_name'.
		do
			creation_name := s;
		end;

	set_c_file_names (l: like c_file_names) is
			-- Assign `l' to `c_file_names'.
		do
			c_file_names := l;
		end;

	set_object_file_names (l: like object_file_names) is
			-- Assign `l' to `object_file_names'.
		do
			object_file_names := l;
		end;

	set_makefile_names (l: like makefile_names) is
			-- Assign `l' to `makefile_names'.
		do
			makefile_names := l;
		end;

	reset_external_clause is
			-- Reset the external clause
			-- Incrementality of the generated makefile
		do
			c_file_names := Void;
			object_file_names := Void;
			makefile_names := Void;
		end;

	set_executable_directory (d: STRING) is
			-- Assign `d' to `executable_directory'.
		do
			executable_directory := d
		end;

	set_c_directory (d: STRING) is
			-- Assign `d' to `c_directory'.
		do
			c_directory := d
		end;

	set_object_directory (d: STRING) is
			-- Assign `d' to `object_directory'.
		do
			object_directory := d
		end;

	reset_generate_clause is
			-- Reset the generate clause
			-- Incrementality of the generated makefile
		do
			executable_directory := Void;
			c_directory := Void;
			object_directory := Void;
		end;

	reset_system_level_options is
		do
			remover_off := False;
			array_optimization_on := False;
			inlining_on := False;
			inlining_size := 4;
			code_replication_off := True;
			exception_stack_managed := False; 
			Rescue_status.set_fail_on_rescue (False)
			server_controler.set_chunk_size (10000)
		end;

	set_id_array (a: like id_array) is
			-- Assign `a' to `id_array'.
		do
			id_array := a;
		end;

	set_freeze (b: BOOLEAN) is
			-- Assign `b' to `freeze'.
		do
			freeze := b;
		end;

	set_update_sort (b: BOOLEAN) is
			-- Assign `b' to `update_sort'.
		do
			update_sort := b;
		end;

	set_max_class_id (i: INTEGER) is
			-- Assign `i' to `max_class_id'.
		do
			max_class_id := i;
		end;

	set_make_file (f: INDENT_FILE) is
		do
			make_file := f;
		end;

	root_class: CLASS_I is
			-- Root class of the system
		require
			root_cluster /= Void;
			root_class_name /= Void;
		do
			Result := root_cluster.classes.item (root_class_name);
		end;

feature -- Precompilation

	set_precompilation (b: BOOLEAN) is
			-- Set `precompilation' to `b'
		do
			precompilation := b
		end;

	init_precompilation is
			-- Initialization before a precompilation.
		do
			if not general_class.compiled then
				init;
				Workbench.change_all
			end;
			freeze := True;
		end;

	save_precompilation_info is
			-- Save usefull values for inclusion of
			-- precompiled code.
		local
			i: INTEGER
		do
			server_controler.save_precompiled_id;
			max_precompiled_id := class_counter.value;
			max_precompiled_type_id := static_type_id_counter.value;
			Universe.mark_precompiled;
		end;

	uses_precompiled: BOOLEAN is
		do
			Result := (server_controler.last_precompiled_id > 0)
		end;

feature -- Log files

	used_features_log_file: USED_FEAT_LOG_FILE;
		-- File where the names (Eiffel and encoded) of the used features
		-- are generated

	removed_log_file: REMOVED_FEAT_LOG_FILE;
		-- File where the names of the removed features are generated

	open_log_files is
		do
			if in_final_mode then
					-- removed_log_file is used only in final mode
				!!removed_log_file.make
					(build_path (Final_generation_path, Removed_log_file_name));

				!!used_features_log_file.make
					(build_path (Final_generation_path, Translation_log_file_name));

					-- Files are open using the `write' mode
				removed_log_file.open_write;
				used_features_log_file.open_write;
			else
				!!used_features_log_file.make
					(build_path (Workbench_generation_path, Translation_log_file_name));

					-- File is open using the `append' mode
					-- (refreezing)
				used_features_log_file.open_append;
			end
		end

	close_log_files is
		do
			used_features_log_file.close;
			used_features_log_file := Void
			if in_final_mode then
				removed_log_file.close
				removed_log_file := Void
			end
		end

feature -- Debug purpose

	trace is
		local
			a_class: CLASS_C;
			i: INTEGER
		do
			from
				i := 1;
			until
				i > id_array.count
			loop
				a_class := id_array.item (i);
				if a_class /= Void then
					-- Do nothing. Specific debug
					-- code can be inserted here.
				end;
				i := i + 1;
			end;
		end;

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
		external
			"C"
		end;

end
