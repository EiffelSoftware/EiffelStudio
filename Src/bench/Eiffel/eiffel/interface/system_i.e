
-- Internal representation of a system.

class SYSTEM_I 

inherit
	BASIC_SYSTEM_I

	SYSTEM_SERVER
		rename
			make as server_make
		end

	SYSTEM_OPTIONS

	SYSTEM_DESCRIPTION

	SYSTEM_DOCUMENTATION

	SHARED_EXPANDED_CHECKER
	SHARED_TYPEID_TABLE
	SHARED_TABLE
	SHARED_CODE_FILES
	SHARED_GENERATOR

	SHARED_ERROR_HANDLER
		export
			{ANY} Error_handler
		end

	SHARED_TIME
	SHARED_CECIL
	SHARED_USED_TABLE

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		export
			{ANY} byte_context
		end

	SHARED_ARRAY_BYTE
	SHARED_DECLARATIONS
	SHARED_PASS
	SHARED_RESCUE_STATUS
	COMPILER_EXPORTER
	SHARED_EIFFEL_PROJECT
	SHARED_CONFIGURE_RESOURCES
	SHARED_BENCH_LICENSES


feature -- Counters

	routine_id_counter: ROUTINE_COUNTER
			-- Counter for routine ids

	class_counter: CLASS_COUNTER
			-- Counter of classes

	static_type_id_counter: TYPE_COUNTER
			-- Counter of instances of CLASS_TYPE

	body_id_counter: BODY_ID_COUNTER
			-- Counter for body ids

	body_index_counter: BODY_INDEX_COUNTER
			-- Body index counter

	feature_as_counter: FEATURE_AS_COUNTER
			-- Counter of instances of FEATURE_AS

	init_counters is
			-- Initialize various counters.
		do
			set_compilation_id
			classes.init_server
			routine_id_counter.init_counter
			class_counter.init_counter
			static_type_id_counter.init_counter
			body_id_counter.init_counter
			body_index_counter.init_counter
			dispatch_table.counter.init_counter
			execution_table.counter.init_counter
			server_controler.file_counter.init_counter
			feature_as_counter.init_counter
			pattern_table.pattern_id_counter.init_counter
		end

feature -- Properties

	changed_body_ids: EXTEND_TABLE [CHANGED_BODY_ID_INFO, BODY_ID] is
		once
			!! Result.make (2)
		end

	rout_info_table: ROUT_INFO_TABLE
			-- Global routine info table
			-- rout_id --> (origin/offset)

	sorter: CLASS_SORTER
			-- Topological sorter on classes

	type_id_counter: COUNTER
			-- Counter of valid instances of CLASS_TYPE

	class_types: ARRAY [CLASS_TYPE]
			-- Array of class types indexed by their `type_id'

	type_set: ROUT_ID_SET
			-- Set of the routine ids for which a type table should
			-- be generated

	pattern_table: PATTERN_TABLE
			-- Pattern table

	address_table: ADDRESS_TABLE
			-- Generate encapsulation of function pointers ($ operator)

	successful: BOOLEAN
			-- Was the last recompilation successful?

	freeze: BOOLEAN is
			-- Has the system to be frozen again ?
		do
			if not java_generation then
				Result := (not Lace.compile_all_classes)
					and then (private_freeze or else Compilation_modes.is_freezing)
			else
				-- Avoid freezing or re-freezing at all costs!
			end
		end

	freezing_occurred: BOOLEAN
			-- Did a freezing of the system occur ?

	history_control: HISTORY_CONTROL
			-- Routine table controler
			-- Only used for final mode code generation.

	instantiator: INSTANTIATOR
			-- Tool to process the generic derivations

	externals: EXTERNALS
			-- Table of external names currently used by the system

	executable_directory: STRING
			-- Directory for the executable file

	c_directory: STRING
			-- Directory for the generated c files

	object_directory: STRING
			-- Directory for the object files

	first_compilation: BOOLEAN
			-- Is it the first compilation of the system
			-- Used by the time check

	poofter_finalization: BOOLEAN
			-- Will the next finalization be a poofter finalization?
			-- i.e. not straight.
			-- If it is not a poofter finalization we know how to 
			-- generate the routine tables much quicker (see classes
			-- ATTR_TABLE and ROUT_TABLE)

	new_class: BOOLEAN
			-- Has a new class been inserted in the universe ?
			-- It is different from moved because new_class is set
			-- even if the class is not used

	new_classes: LINKED_LIST [CLASS_I]
			-- New classes in the system
			-- Used during the time check

	moved: BOOLEAN
			-- Has the system potentially moved in terms of classes ?
			-- [Each time a new class is inserted/removed in/from the system
			-- a topological sort has to be done.]

	update_sort: BOOLEAN
			-- Has the conformance table to be updated ?
			-- [A class id has changed beetween two recompilation.]

	max_class_id: INTEGER
			-- Greater class id: computed by class CLASS_SORTER

	min_type_id: INTEGER is 1
			-- Value from which to start the dynamic type_id numbering
			-- for newly created class types

	melted_set: SEARCH_TABLE [CLASS_C]
			-- Set of class ids for which feature table needs to be updated
			-- when melting

	freeze_set1: SEARCH_TABLE [CLASS_C]
			-- List of class ids for which a source C compilation is
			-- needed when freezing.

	freeze_set2: SEARCH_TABLE [CLASS_C]
			-- List of class ids for which a hash table recompilation
			-- is needed when freezing

	is_conformance_table_melted: BOOLEAN
			-- Is the conformance table melted ?

	melted_conformance_table: CHARACTER_ARRAY
			-- Byte array representation of the melted conformance
			-- table.
			--| Once melted, it is kept in memory so it won't be re-processed
			--| each time

	melted_parent_table: CHARACTER_ARRAY
			-- Byte array representation of the melted parent
			-- table.
			--| Once melted, it is kept in memory so it won't be re-processed
			--| each time

	frozen_level: INTEGER
			-- Frozen level

	body_index_table: BODY_INDEX_TABLE
			-- Body index table
			--| Correspondance of generic body index and generic body
			--| id.

	original_body_index_table: BODY_INDEX_TABLE
			-- Original body index table.
			-- | Since during second pass, correpondaces between body indexes
			-- | and body ids are changing, the second class must use a
			-- | duplicated one in order to compair versions of a same
			-- | feature.

	onbidt: O_N_TABLE [BODY_ID]
			-- Correspondance table between old body ids
			-- (changed trough `change_body_id' of FEATURE_I)
			-- and new body id.

	dispatch_table: DISPATCH_TABLE
			-- Dispatch table

	execution_table: EXECUTION_TABLE
			-- Execution table

	remover: REMOVER
			-- Dead code removal control

	keep_assertions: BOOLEAN
			-- Are the assertions kept in final mode?

	current_pass: PASS
			-- Current compiler pass
			-- Useful for `current_class'

	current_class: CLASS_C
			-- Current processed class

	makefile_generator: MAKEFILE_GENERATOR
			-- Makefile generator.

	cecil_file: INDENT_FILE

	skeleton_file: INDENT_FILE

	array_make_name: STRING
			-- Name of the C routine corresponding to the
			-- make routine of ARRAY[ANY]. Needed for the
			-- "strip" functionality.
			-- Having an attribute is a temporary solution.
			-- There is a problem when ARRAY[ANY] is precompiled
			-- and a new generic derivation is introduced later on
			-- (the name will change, and not be compatible with the
			-- content of the precompiled object file). The patch 
			-- consists of saving the name the very first time it
			-- is computed.

	optimization_tables: OPTIMIZATION_TABLES
			-- Tables keeping track of flags for optimization
			-- Based on the body_index of a feature

	make is
			-- Create the system.
		do
			set_compilation_id

				-- Creation of all the servers.
			server_make

				-- Creation of the system hash table
			!! class_types.make (1, System_chunk)
			!! new_classes.make

				-- Creation of a topological sorter
			!! sorter.make

				-- Counter creation
			!! routine_id_counter.make
			!! class_counter.make
			!! static_type_id_counter.make
			!! body_id_counter.make
			!! body_index_counter.make
			!! feature_as_counter.make
			!! type_id_counter

				-- Routine table controler creation
			!! history_control.make
			!! instantiator.make
			instantiator.compare_objects

				-- Type set creation
			!! type_set.make (100)

				-- External table creation
			!! externals.make

				-- Pattern table creation
			!! pattern_table.make

				-- Freeze control sets creation
			!! freeze_set1.make (200)
			!! freeze_set2.make (200)

				-- Body index table creation
			!! body_index_table.make (System_chunk)
			!! original_body_index_table.make (1)

				-- Run-time table creation
			!! dispatch_table.make
			!! execution_table.make
			!! melted_set.make (200)
			!! rout_info_table.make (500)
			!! onbidt.make (50)
			!! optimization_tables.make

				-- Address table
			!! address_table.make (100)
		end

	reset_debug_counter is
			-- Reset the debugger counters.
		do
			if execution_table /= Void then
				execution_table.reset_debug_counter
			end
		end

	init is
			-- System initialization
		require
			general_class: general_class /= Void
		local
			local_workbench: WORKBENCH_I
			local_universe: UNIVERSE_I
			local_root_cluster: CLUSTER_I
			a_cluster_list    : LINKED_LIST [CLUSTER_I]
			a_cluster         : CLUSTER_I
			a_class_table     : EXTEND_TABLE [CLASS_I, STRING]
			a_class_i         : CLASS_I
			a_visible_i       : VISIBLE_I
		do
			first_compilation := True

			local_workbench := Workbench
			local_universe := Universe
			local_root_cluster := root_cluster

				-- At the very beginning of a session, even class ANY is
				-- not compiled. So we must say to the workbench to compile
				-- classes ANY, DOUBLE... ARRAY
				-- It is very important that these classes were protected.
			protected_classes := True
			local_workbench.change_class (general_class)
			local_workbench.change_class (any_class)
			local_workbench.change_class (double_class)
			local_workbench.change_class (real_class)
			local_workbench.change_class (integer_class)
			local_workbench.change_class (boolean_class)
			local_workbench.change_class (character_class)
			local_workbench.change_class (array_class)
			local_workbench.change_class (bit_class)
			local_workbench.change_class (pointer_class)
			local_workbench.change_class (string_class)
			protected_classes := False
				-- The root class is not protected 
				-- Godammit.
			local_workbench.change_class (root_class)

			-- Now add classes with visible features.

			from
				a_cluster_list := local_universe.clusters
				a_cluster_list.start
			until
				a_cluster_list.after
			loop
				a_cluster := a_cluster_list.item

				from
					a_class_table := a_cluster.classes
					if a_class_table /= Void then a_class_table.start end
				until
					a_class_table = Void or else a_class_table.after
				loop
					a_class_i := a_class_table.item_for_iteration

					if a_class_i /= Void then
						a_visible_i := a_class_i.visible_level

						if a_visible_i /= Void and then a_visible_i.has_visible then
							-- Add visible class to system.
							local_workbench.change_class (a_class_i)
						end
					end

					a_class_table.forth
				end

				a_cluster_list.forth
			end

		end

	protected_classes: BOOLEAN
			-- Useful for remove_useless_classes
			-- Protected classes are GENERAL, ANY, DOUBLE, REAL,
			-- INTEGER, BOOLEAN, CHARACTER, ARRAY, BIT, POINTER, STRING

	insert_new_class (a_class: CLASS_C) is
			-- Add new class `c' to the system.
		require
			good_argument: a_class /= Void
		local
			new_id: CLASS_ID
		do
			if protected_classes then
				new_id := class_counter.next_protected_id
			else
				new_id := class_counter.next_id
			end
				-- Give a compiled class a frozen id
			a_class.set_id (new_id)
debug ("ACTIVITY")
io.error.putstring ("%TInserting class ")
io.error.putstring (a_class.name)
new_id.trace
io.error.new_line
end

				-- Give a class id to class `c' which maybe changed 
				-- during the topological sort of a recompilation.
			a_class.set_topological_id (new_id.id)
				-- Insert the class
			classes.put (a_class, new_id)

				-- Update control flags of the topological sort
			moved := True

				-- Update the freeze control list: the class can have no
				-- features written in it (like ANY) and then not be
				-- included in `freeze_set1' after the second pass and so
				-- not been generated. (we need a source file even if the
				-- class is empty in terms of features written in it.).
			freeze_set1.put (a_class)
			freeze_set2.put (a_class)

			melted_set.put (a_class)

		ensure
			class_id_set: a_class.id /= Void
		end

	record_new_class_i (a_class: CLASS_I) is
			-- Record a new CLASS_I
			-- Used during the time check and the genericity check after pass1
		do
			new_class := True
			new_classes.put_front (a_class)
		end

	remove_class (a_class: CLASS_C) is
			-- Remove class `a_class' from the system even if
			-- it has syntactical_clients.
		require
			 good_argument: a_class /= Void
		local
			parents: ARRAYED_LIST [CL_TYPE_A]
			compiled_root_class: CLASS_C
			descendants, suppliers, clients: LINKED_LIST [CLASS_C]
			supplier: CLASS_C
			supplier_clients: LINKED_LIST [CLASS_C]
			id: CLASS_ID
			types: TYPE_LIST
			ftable: FEATURE_TABLE
			f: FEATURE_I
			ext: EXTERNAL_I
		do
			if a_class.is_removable then
				id := a_class.id

debug ("ACTIVITY", "REMOVE_CLASS")
	io.error.putstring ("%TRemoving class ")
	io.error.putstring (a_class.name)
	io.error.new_line
end
					-- Update control flags of the topological sort
				moved := True

					-- Remove type check relations
				if a_class.parents /= Void then
					a_class.remove_relations
				end

					-- Remove one occurrence for each external written
					-- in the class
				if Feat_tbl_server.has (id) then
					from
						ftable := Feat_tbl_server.item (id)
						ftable.start
					until
						ftable.after
					loop
						f := ftable.item_for_iteration
						if f.is_external and then f.written_in.is_equal (id) then
							ext ?= f
								-- If the external is encapsulated then it was not added to
								-- the list of new externals in inherit_table. Same thing
								-- if it has to be removed
							if not ext.encapsulated then
								Externals.remove_occurence (ext.external_name)
							end
						end
						ftable.forth
					end
				end

					-- Remove class `a_class' from the lists of changed classes
				pass1_controler.remove_class (a_class)
				pass2_controler.remove_class (a_class)
				pass3_controler.remove_class (a_class)
				pass4_controler.remove_class (a_class)

					-- Mark the class to remove uncompiled
				a_class.lace_class.reset_compiled_class

					-- Remove its types
				from
					types := a_class.types
					types.start
				until
					types.after
				loop
					class_types.put (Void, types.item.type_id)
					types.forth
				end

					-- Remove if from the servers
debug ("ACTIVITY")
	io.error.putstring ("%TRemoving id from servers: ")
	id.trace
	io.error.new_line
end
				Inv_byte_server.remove (id)
				Ast_server.remove (id)
				Feat_tbl_server.remove (id)
				Class_info_server.remove (id)
				Inv_ast_server.remove (id)
				Depend_server.remove (id)
				Rep_depend_server.remove (id)
				M_rout_id_server.remove (id)
				M_desc_server.remove (id)
				if Compilation_modes.is_precompiling then
						-- Do not need to remove id from
						-- Class_comments_server since
						-- we are not able to remove a
						-- precompiled class
					Tmp_class_comments_server.remove (id)
				end
				Tmp_inv_byte_server.remove (id)
				Tmp_ast_server.remove (id)
				Tmp_feat_tbl_server.remove (id)
				Tmp_class_info_server.remove (id)
				Tmp_rep_info_server.remove (id)
				Tmp_inv_ast_server.remove (id)
				Tmp_depend_server.remove (id)
				Tmp_rep_depend_server.remove (id)
				Tmp_m_rout_id_server.remove (id)
				Tmp_m_desc_server.remove (id)

				freeze_set1.prune (a_class)
				freeze_set2.prune (a_class)
				melted_set.prune (a_class)
				classes.remove (id)

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
					supplier := a_class.syntactical_suppliers.item.supplier
					supplier_clients := supplier.syntactical_clients
					supplier_clients.start
					supplier_clients.compare_references
					supplier_clients.search (a_class)
					check
						not_after: not supplier_clients.after
					end
					supplier_clients.remove
					if
						supplier_clients.empty and then
							-- The root class is not removed
							-- true only if the root class has changed and
							-- was a client for a removed class
						supplier /= compiled_root_class and then
							-- Cannot propagate for a protected class
						not supplier.id.protected and then
							-- A recursion may occur when removing a cluster
						supplier.id.associated_class /= Void
					then
						remove_class (supplier)
					elseif supplier.has_dep_class (a_class) then
							-- Is it enough to remove the dependecies only on a class
							-- which is still in the system, or should we do it for
							-- all the classes even the ones that we just removed from
							-- the system? In the last case, we should put the previous
							-- test one level up.
						supplier.remove_dep_class (a_class)
					end

					a_class.syntactical_suppliers.forth
				end
			end
		end

	class_of_id (id: CLASS_ID): CLASS_C is
			-- Class of id `id'
		require
			id_not_void: id /= Void
		do
			Result := id.associated_class
debug ("CLASS_OF_ID")
io.error.putstring ("Class of id ")
id.trace
io.error.putstring (": ")
if Result /= Void then
	io.error.putstring (Result.name)
end
io.error.new_line
end
		end

	class_type_of_id (type_id: INTEGER): CLASS_TYPE is
			-- Class type of type id `type_id'.
		require
			index_small_enough: type_id <= class_types.count
				-- Removed: if the index is bigger than type_id_counter.value
				-- then the corresponding entry is Void
			--valid_index: type_id <= type_id_counter.value
		do
			Result := class_types.item (type_id)
		end

	insert_class_type (class_type: CLASS_TYPE) is
			-- Insert `class_type' in `class_types'.
		require
			good_argument: class_type /= Void
			index_big_enough: class_type.type_id > 0
		local
			type_id: INTEGER
		do
			type_id := class_type.type_id
			if type_id > class_types.count then
				class_types.resize (1, type_id + System_chunk)
			end
			class_types.put (class_type, type_id)
		end

	init_recompilation is
			-- Initialization before a recompilation.
		do
			change_classes

			private_freeze := private_freeze or else frozen_level = 0

				-- If status of compilation is successful, copy
				-- a duplication of the body index table in
				-- `origin_body_index_table' and re-initialize the
				-- melted set of feature tables.
			if successful then
					-- !!!!!!!!!!!!!!
					-- Important Note
					-- !!!!!!!!!!!!!!
					-- There are other references in the system to "THE" 
					-- Original Body Index table (Namely through onces)
					-- We CANNOT do a simple assignment of twin. We need 
					-- to ensure that the object remains the same troughout 
					-- a session. If you want to change it, think thoroughly
					-- before! (Dino, that's an allusion to you, -- FRED)
				original_body_index_table.copy (body_index_table)
				melted_set.wipe_out
			end
		end

	change_classes is
			-- Mark classes to be recompiled.
		do
			if not general_class.compiled then
					-- First compilation.
				init
			elseif root_class.compiled_class = Void then
				-- If root_class is not compiled (i.e. root class has
				-- changed since last compilaton), insert it in the
				-- changed_classes.
				Workbench.change_class (root_class)
			end
			if Lace.compile_all_classes then
					-- `None' is specified as the root class
				Workbench.change_all_new_classes
			end
		end

feature -- default_rescue routine

	default_rescue_id: ROUTINE_ID is
			-- Routine id of default rescue from GENERAL.
			-- Return 0 if GENERAL has not been compiled or
			-- does not have a feature named `default_rescue'.
		local
			feature_i: FEATURE_I
		once
			if general_class /= Void and then
					general_class.compiled_class /= Void then
				feature_i := general_class.compiled_class.feature_table.item 
														("default_rescue")
				if feature_i /= Void then
					Result := feature_i.rout_id_set.first
				end
			end
		end

feature -- Merging

	merge (other: like Current) is
			-- Merge `other' into `Current'.
		require
			other_not_void: other /= Void
		local
			was_precompiling: BOOLEAN
		do
			was_precompiling := Compilation_modes.is_precompiling
			Compilation_modes.set_is_precompiling (True)
			byte_context.set_workbench_mode
			set_freeze
				-- Counters.
			body_id_counter.append (other.body_id_counter)
			body_index_counter.append (other.body_index_counter)
			class_counter.append (other.class_counter)
			feature_as_counter.append (other.feature_as_counter)
			routine_id_counter.append (other.routine_id_counter)
			static_type_id_counter.append (other.static_type_id_counter)

			classes.append (other.classes)
			has_expanded := has_expanded or other.has_expanded
			onbidt.append (other.onbidt)
			body_index_table.append (other.body_index_table)
			type_set.merge (other.type_set)
			address_table.merge (other.address_table)
			rout_info_table.append (other.rout_info_table)
			execution_table.append (other.execution_table)
			dispatch_table.append (other.dispatch_table)
			frozen_level := execution_table.frozen_level
			externals.append (other.externals)
			pattern_table.append (other.pattern_table)

				-- Servers.
			server_controler.append (other.server_controler)
			ast_server.take_control (other.ast_server)
			body_server.merge (other.body_server)
			byte_server.take_control (other.byte_server)
			class_comments_server.take_control (other.class_comments_server)
			class_info_server.take_control (other.class_info_server)
			depend_server.take_control (other.depend_server)
			feat_tbl_server.take_control (other.feat_tbl_server)
			inv_ast_server.merge (other.inv_ast_server)
			inv_byte_server.take_control (other.inv_byte_server)
			rep_depend_server.take_control (other.rep_depend_server)
			rep_feat_server.merge (other.rep_feat_server)
			rep_server.take_control (other.rep_server)
			server_controler.init

				-- Topological sort
			sorter.sort
			Error_handler.checksum
			build_conformance_table
			sorter.clear
			process_dynamic_types

			Compilation_modes.set_is_precompiling (was_precompiling)
		end

feature -- Recompilation 

	recompile is
			-- Incremetal recompilation of the system.
		require
			no_error: not Error_handler.has_error
		local
			precomp_r: PRECOMP_R
		do
			freezing_occurred := False

			If System.uses_precompiled then
				check_precompiled_licenses
					-- Validate the precompilation.
				!! precomp_r
				precomp_r.check_version_number
			end

			do_recompilation
			successful := True
		rescue
			if Rescue_status.is_error_exception then
				successful := False
			end
		end

	do_recompilation is
			-- Incremetal recompilation of the system.
		local
			root_class_c: CLASS_C
			deg_output: DEGREE_OUTPUT
		do
				-- Recompilation initialization
			if Compilation_modes.is_precompiling then
				init_precompilation
			else
				init_recompilation
			end

				-- Set the generation mode in workbench mode
			byte_context.set_workbench_mode

				-- The time checker just checks if there is a possible
				-- conflict for the suppliers of a class, i.e. a new class
				-- has been introduced and can create a conflict
			Time_checker.check_suppliers_of_unchanged_classes

				-- The `new_classes' list is not used after the time
				-- check. If it was successful, the list can be wiped out.
			new_classes.wipe_out

				-- If the finalization is still believed to
				-- be straight at this point we need to pervert it
				-- into being a poofter once and for all if if is not
				-- the first compilation and if there are actual classes
				-- to be parsed.
			if not poofter_finalization then
				poofter_finalization := not (first_compilation or else
					pass1_controler.changed_classes.empty)
			end

				-- Syntax analysis: This maybe add new classes to
				-- the system (degree 5)
			process_pass (pass1_controler)

				-- Check generic validity on old classes
				-- generic parameters cannot be new classes
debug ("ACTIVITY")
	io.error.putstring ("%Tnew_class = ")
	io.error.putbool (new_class)
	io.error.new_line
end
			if not first_compilation and then new_class then
				check_generics
					-- The association name <==> supplier has been done in pass1
					-- so even if the compilation fails after this point, the
					-- check must not be done again if no classes are introduced
					-- before the recompilation
			end
			new_class := False

			if
				not Compilation_modes.is_precompiling and
				not Lace.compile_all_classes
			then
					-- The root class is not generic
				root_class_c := root_class.compiled_class
				current_class := root_class_c
				root_class_c.check_non_genericity_of_root_class
				current_class := Void
					-- Remove useless classes i.e classes without 
					-- syntactical clients
				remove_useless_classes
			end

				-- Topological sort and building of the conformance
				-- table (if new classes have been added by first pass)
debug ("ACTIVITY")
	io.error.putstring ("%Tmoved = ")
	io.error.putbool (moved)
	io.error.putstring ("%N%Tupdate_sort = ")
	io.error.putbool (update_sort)
	io.error.new_line
end
			update_sort := update_sort or else moved
			if update_sort then
					-- Sort
				sorter.sort
					-- Check sum error
				Error_handler.checksum
					-- Re-sort the list `changed_classes' of `pass2',
					-- because the topological sort modified the class ids,
					-- and the second pass needs it and rebuild the
					-- conformance tables
				pass2_controler.sort
				pass3_controler.sort
				pass4_controler.sort
				build_conformance_table

					-- Clear the topo sorter
				sorter.clear

				reset_melted_conformance_table
			end
				-- Inheritance analysis: list `changed_classes' is
				-- sorted by class ids so the parent come first the
				-- heirs after
			process_pass (pass2_controler)

			if
				not Compilation_modes.is_precompiling and
				not Lace.compile_all_classes
			then
				root_class_c.check_root_class_creators
			end

				-- Byte code production and type checking
			process_pass (pass3_controler)

			Error_handler.set_error_position (0)

			if
				not Compilation_modes.is_precompiling and
				not Lace.compile_all_classes
			then
					-- Externals incrementality
				private_freeze := private_freeze or else not externals.equiv
			end

				-- Process the type system
			process_type_system

				-- Process the skeleton of classes
			process_skeleton

				-- Melt the changed features
			melt

				-- Finalize a successful compilation
			finish_compilation

				-- Produce the update file
			deg_output := Degree_output
			if freeze then
				deg_output.put_freezing_message

				freeze_system
				private_freeze := False
			else
				deg_output.put_melting_changes_message

				execution_table.set_levels
					-- Create a non-empty update file ("melted.eif")
				make_update (False)
debug ("VERBOSE")
	io.error.putstring ("Saving melted.eif%N")
end
			end
			first_compilation := False
		end

	check_generics is
			-- Check generic validity on old classes
			-- generic parameters cannot be new classes
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			local_classes: CLASS_C_SERVER
		do
debug ("ACTIVITY")
	io.error.putstring ("Check generics%N")
end
			from
				local_classes := classes
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from
					i := 1
				until
					i > nb
				loop
					a_class := class_array.item (i)
					if a_class /= Void then
						if
							a_class.generics /= Void
							-- If the class is changed then `pass1' has been
							-- done successfully on the class
							and then not a_class.changed
						then
							a_class.check_generic_parameters
						end
					end
					i := i + 1
				end
				local_classes.forth
			end
			Error_handler.checksum
		end

	remove_useless_classes is
			-- Remove useless classes.
		local
			a_class: CLASS_C
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			root_class_c: CLASS_C
			marked_classes: SEARCH_TABLE [CLASS_ID]
			local_classes: CLASS_C_SERVER
		do
				-- First mark all the classes that can be reached
				-- from the root class
			!! marked_classes.make (System_chunk)

			root_class_c := root_class.compiled_class
			root_class_c.mark_class (marked_classes)
			general_class.compiled_class.mark_class (marked_classes)
			any_class.compiled_class.mark_class (marked_classes)
			double_class.compiled_class.mark_class (marked_classes)
			real_class.compiled_class.mark_class (marked_classes)
			integer_class.compiled_class.mark_class (marked_classes)
			boolean_class.compiled_class.mark_class (marked_classes)
			character_class.compiled_class.mark_class (marked_classes)
			array_class.compiled_class.mark_class (marked_classes)
			bit_class.compiled_class.mark_class (marked_classes)
			pointer_class.compiled_class.mark_class (marked_classes)

				-- Now mark all classes reachable from visible classes.

			from
				local_classes := classes
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from
					i := 1
				until
					i > nb
				loop
					a_class := class_array.item (i)

					if a_class /= Void and then
							a_class.has_visible and then
								not marked_classes.has (a_class.id) then
						a_class.mark_class (marked_classes)
					end
					i := i + 1
				end
				local_classes.forth
			end

				-- Remove all the classes that cannot be reached if they are
				-- not protected
			from
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from
					i := 1
				until
					i > nb
				loop
					a_class := class_array.item (i)

					if
						a_class /= Void and then
						not marked_classes.has (a_class.id)
					then
debug ("REMOVE_CLASS")
	io.error.putstring ("Remove useless classes: ")
	io.error.putstring (a_class.name)
	io.error.new_line
end
						remove_class (a_class)
					end
					i := i + 1
				end
				local_classes.forth
			end
			Error_handler.checksum
		end

	build_conformance_table is
			-- Build the conformance table
		local
			a_class: CLASS_C
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			local_classes: CLASS_C_SERVER
		do
			from
				local_classes := classes
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						a_class.fill_conformance_table
					end
					i := i + 1
				end
				local_classes.forth
			end
		end

	process_type_system is
			-- Compute the type system
		local
			a_class: CLASS_C
			old_value: INTEGER
			pass4_changed_classes: PART_SORTED_TWO_WAY_LIST [PASS4_C]
		do
			old_value := type_id_counter.value
			from
				pass4_changed_classes := pass4_controler.changed_classes
				pass4_changed_classes.start
			until
				pass4_changed_classes.after
			loop
				a_class := pass4_changed_classes.item.associated_class
				if a_class.changed and then a_class.generics = Void then
					if a_class.types.empty then
							-- For non generic classes, standard initialization
							-- of their attribute `types'.
						a_class.init_types
					end
				end
				pass4_changed_classes.forth
			end
				-- For generic classes, compute the types
			Instantiator.process

				-- If first compilation, re-order dynamic types
			if old_value = 0 then
				process_dynamic_types
			end
		end

	process_skeleton is
			-- Type skeleton processing: for a class marked `changed2', the
			-- feature table has changed so the skeleton of its class
			-- types must be re-processed and markged `is_changed' if different.
			-- For a class marked `changed4', inspection of the types (instance
			-- of CLASS_TYPE) looking for a new one (marked `is_changed also).
		local
			a_class: CLASS_C
			skeleton: SKELETON
			pass4_changed_classes: PART_SORTED_TWO_WAY_LIST [PASS4_C]
		do
debug ("ACTIVITY", "SKELETON")
io.error.putstring ("Process_skeleton%N")
end
			pass4_changed_classes := pass4_controler.changed_classes
			if
				not Compilation_modes.is_precompiling and
				not Lace.compile_all_classes
			then
				from
					pass4_changed_classes.start
				until
					pass4_changed_classes.after
				loop
					a_class := pass4_changed_classes.item.associated_class
debug ("ACTIVITY", "SKELETON")
io.error.putstring ("%T")
io.error.putstring (a_class.name)
io.error.new_line
end
						-- Process skeleton(s) for `a_class'.
					a_class.process_skeleton

					check
						has_class_type: not a_class.types.empty
					end
						-- Check valididty of special classes ARRAY, STRING,
						-- TO_SPECIAL, SPECIAL
					a_class.check_validity
					pass4_changed_classes.forth
				end
			else
				from
					pass4_changed_classes.start
				until
					pass4_changed_classes.after
				loop
					a_class := pass4_changed_classes.item.associated_class
debug ("ACTIVITY", "SKELETON")
io.error.putstring ("%T")
io.error.putstring (a_class.name)
io.error.new_line
end
					if a_class.has_types then
							-- Process skeleton(s) for `a_class'.
						a_class.process_skeleton
	
						check
							has_class_type: not a_class.types.empty
						end
							-- Check valididty of special classes ARRAY, STRING,
							-- TO_SPECIAL, SPECIAL
						a_class.check_validity
					end
					pass4_changed_classes.forth
				end
			end

				-- Check expanded client relation
			check_expanded

				-- Check sum error
			Error_handler.checksum
		end

	check_vtec is
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			local_classes: CLASS_C_SERVER	
		do
			from
				local_classes := classes
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						if
							a_class.has_expanded or else
							a_class.is_used_as_expanded
						then
							set_current_class (a_class)
							a_class.check_expanded
						end
					end
					i := i + 1
				end
				local_classes.forth
			end
		end

	check_expanded is
			-- Check expanded client relation
		local
			class_type: CLASS_TYPE
			types: TYPE_LIST
			a_class: CLASS_C
			check_exp: BOOLEAN
			pass4_changed_classes: PART_SORTED_TWO_WAY_LIST [PASS4_C]
		do
			check_exp := has_expanded
			from
				pass4_changed_classes := pass4_controler.changed_classes
				pass4_changed_classes.start
			until
				pass4_changed_classes.after
			loop
				a_class := pass4_changed_classes.item.associated_class

debug ("CHECK_EXPANDED")
	io.error.putstring ("Check expanded on ")
	io.error.putstring (a_class.name)
	io.error.new_line
end
				from
					types := a_class.types
					types.start
				until
					types.after
				loop
					class_type := types.item
					if class_type.is_changed then

debug ("CHECK_EXPANDED")
	io.error.putstring ("Check expanded on type of ")
	io.error.putstring (a_class.name)
	io.error.new_line
end
						if check_exp then
							Expanded_checker.set_current_type (class_type)
							Expanded_checker.check_expanded
						end
						class_type.set_is_changed (False)
					end

					types.forth
				end
				pass4_changed_classes.forth
			end
		end

	melt is
			-- Melt the changed features and feature and
			-- descriptor tables in the system.
		require
			no_error: not Error_handler.has_error
		local
			a_class: CLASS_C
			class_list: SEARCH_TABLE [CLASS_C]
			i: INTEGER
			deg_output: DEGREE_OUTPUT
		do
				-- Melt features
				-- Open the file for writing on disk feature byte code
			process_pass (pass4_controler)
			current_pass := Void

				-- The dispatch and execution tables are now updated.

			if not freeze then
debug ("COUNT")
	i := melted_set.count
end
					-- Melt the feature tables
					-- Open first the file for writing on disk melted feature
					-- tables
				from
					class_list := melted_set
					i := class_list.count
					deg_output := Degree_output
					deg_output.put_start_degree (1, i)
					class_list.start
				until
					class_list.after
				loop
					a_class := class_list.item_for_iteration
						-- Verbose
debug ("COUNT")
	io.error.putstring ("[")
	io.error.putint (i)
	io.error.putstring ("] ")
	i := i - 1
end
					deg_output.put_degree_1 (a_class, i)
					a_class.melt_feature_table
					a_class.melt_descriptor_tables
					class_list.forth
					i := i - 1
				end
				deg_output.put_end_degree
				melted_set.wipe_out
			end
		end

	make_update (empty: BOOLEAN) is
			-- Produce the update file resulting of the consecutive
			-- melting process. It can be `empty' (if the system has
			-- been frozen.
		local
			a_class: CLASS_C
			file_pointer: POINTER
			root_feat: FEATURE_I
			dtype: INTEGER
			has_argument: INTEGER
			rout_info: ROUT_INFO
			rcorigin, rcoffset: INTEGER
			rout_id: ROUTINE_ID
			melted_file: RAW_FILE
		do
debug ("ACTIVITY")
	io.error.putstring ("Updating melted.eif%N")
end
			melted_file := Update_file
			melted_file.open_write

				-- There is something to update
			if empty then
				melted_file.putchar ('%/000/')
			else
				melted_file.putchar ('%/001/')
			end

				-- Flag indicating whether it's Java or Eiffel byte-code
			if java_generation then
					-- This is a Java byte-code file
				melted_file.putchar ('%/001/')
			else
					-- This is an Eiffel byte-code file
				melted_file.putchar ('%/000/')
			end

			if not empty then
				file_pointer := melted_file.file_pointer

					-- Update the root class info
				a_class := root_class.compiled_class
				dtype := a_class.types.first.type_id - 1
				if creation_name /= Void then
					root_feat := a_class.feature_table.item (creation_name)
					if root_feat.has_arguments then
						has_argument := 1
					end
					rout_id := root_feat.rout_id_set.first
					rout_info := System.rout_info_table.item (rout_id)
					rcorigin := rout_info.origin.id
					rcoffset := rout_info.offset
				else
					rcorigin := -1
				end
				write_int (file_pointer, rcorigin)
				write_int (file_pointer, dtype)
				write_int (file_pointer, rcoffset)
				write_int (file_pointer, has_argument)
	
					-- Write first the number of class types now available
				write_int (file_pointer, type_id_counter.value)
					-- Write the number of classes now available
				write_int (file_pointer, class_counter.total_count)
					-- Write the profiler status
				if Lace.ace_options.has_profile then
					write_int (file_pointer, 3)
				else
					write_int (file_pointer, 0)
				end
				make_update_feature_tables (melted_file)
				make_update_rout_id_arrays (melted_file)
					-- Write first the new size of the dispatch table
				Dispatch_table.write_dispatch_count (melted_file)
					-- Update the dispatch table
				Dispatch_table.make_update (melted_file)
					-- Open the file for reading byte code for melted features
					-- Update the execution table
				execution_table.make_update (melted_file)
				make_conformance_table_byte_code (melted_file)
				make_parent_table_byte_code (melted_file)
				make_option_table (melted_file)
				make_rout_info_table (melted_file)
				make_update_descriptors (melted_file)
					-- End mark
				write_int (file_pointer, -1)
			end

			melted_file.close
		end
	
	make_update_feature_tables (file: RAW_FILE) is
			-- Write the byte code for feature tables to be updated
			-- into `file'.
		require
			file_not_void: file /= Void
			file_open_write: file.is_open_write
		local
			class_list: SEARCH_TABLE [CLASS_C]
			types: TYPE_LIST
			nb_tables: INTEGER
			feat_tbl: MELTED_FEATURE_TABLE
		do
debug ("ACTIVITY")
	io.error.putstring ("%Tfeature tables%N")
end
				-- Count of feature tables to update
			from
				class_list := freeze_set2
				class_list.start
			until
				class_list.after
			loop
debug ("ACTIVITY")
	io.error.putstring ("%T%T")
	io.error.putstring (class_list.item_for_iteration.name)
	io.error.new_line
end
				nb_tables := nb_tables + class_list.item_for_iteration.types.nb_modifiable_types
				class_list.forth
			end

				-- Write the number of feature tables to update
			write_int (file.file_pointer, nb_tables)

debug ("ACTIVITY")
	io.error.putstring ("%Tbyte code%N")
end

				-- Write then the byte code for feature tables to update.
			from
				class_list.start
			until
				class_list.after
			loop
debug ("ACTIVITY")
	io.error.putstring ("%T%T")
	io.error.putstring (class_list.item_for_iteration.name)
	io.error.new_line
end
				types := class_list.item_for_iteration.types
				from
					types.start
				until
					types.after
				loop
					if types.item.is_modifiable then
						feat_tbl := m_feat_tbl_server.item (types.item.id)

debug ("ACTIVITY")
	io.error.putstring ("melting class desc of ")
	types.item.type.trace
	io.error.new_line
end
						feat_tbl.store (file)
					end
					types.forth
				end
				class_list.forth
			end
		end

	make_update_rout_id_arrays (file: RAW_FILE) is
			-- Write the melted routine id arrays into `file'.
		require
			file_not_void: file /= Void
			file_open_write: file.is_open_write
		local
			class_id: CLASS_ID
			file_pointer: POINTER
			types: TYPE_LIST
			cl_type: CLASS_TYPE
		do
			file_pointer := file.file_pointer
debug ("ACTIVITY")
	io.error.putstring ("%TMelted routine id array%N")
end
				-- Melted routine id array
			from
				m_rout_id_server.start
			until
				m_rout_id_server.after
			loop
				class_id := m_rout_id_server.key_for_iteration
debug ("ACTIVITY")
io.error.putstring ("melting routine id array of ")
class_id.trace
io.error.putstring (class_of_id (class_id).name)
io.error.new_line
end
				write_int (file_pointer, class_id.id)
				m_rout_id_server.item (class_id).store (file)
				types := class_of_id (class_id).types
				from
					types.start
				until
					types.after
				loop
					cl_type := types.item
						-- Write dynamic type
					write_int (file_pointer, cl_type.type_id - 1)
						-- Write original dynamic type (first freezing)
					write_int (file_pointer, cl_type.id.id - 1)
					types.forth
				end
				write_int (file_pointer, -1)
				m_rout_id_server.forth
			end
			write_int (file_pointer, -1)
		end

	make_update_descriptors (file: RAW_FILE) is
			-- Write melted descriptors into `file'.
		require
			file_not_void: file /= Void
			file_open_write: file.is_open_write
		local
			class_id: CLASS_ID
		do
			from
				M_desc_server.start
			until
				M_desc_server.after
			loop
				class_id := M_desc_server.key_for_iteration
				M_desc_server.item (class_id).store (file)
				M_desc_server.forth
			end
		end

	reset_melted_conformance_table is
			-- Forget the `melted_conformance_table', i.e. a new
			-- class or class type has been added to the system.
		do
				-- Mark the conformance table melted
			is_conformance_table_melted := True
				-- Trigger the recompuation of the conformance table
				-- byte code
			melted_conformance_table := Void
			melted_parent_table := Void
		end

	make_conformance_table_byte_code (file: RAW_FILE) is
			-- Generates conformance tables byte code in `file'.
		local
			i, nb: INTEGER
			cl_type: CLASS_TYPE
			to_append: CHARACTER_ARRAY
		do
			Byte_array.clear

			if is_conformance_table_melted then
				if melted_conformance_table = Void then
						-- Compute `melted_conformance_table'.
debug ("ACTIVITY")
	io.error.putstring ("Generating conformance table%N")
end
					Byte_array.append ('%/001/')
					from
						i := 1
						nb := Type_id_counter.value
					until
						i > nb
					loop
						cl_type := class_types.item (i)
						if cl_type /= Void then
								-- Classes could be removed
							cl_type.make_conformance_table_byte_code (Byte_array)
						end
						i := i + 1
					end

						-- End mark
					Byte_array.append_short_integer (-1)

						-- Cecil structure
					make_cecil_tables
					Cecil2.make_byte_code (Byte_array)
					Cecil3.make_byte_code (Byte_array)

					melted_conformance_table := Byte_array.character_array
				end
				to_append := melted_conformance_table
			else
debug ("ACTIVITY")
	io.error.putstring ("No changes in conformance table%N")
end
				Byte_array.append ('%U')
				to_append := Byte_array.character_array
			end

				-- Put the condormance table in `file'.
			to_append.store (file)

		end

	make_parent_table_byte_code (file: RAW_FILE) is
			-- Generates parent tables byte code in `file'.
		local
			i, nb: INTEGER;
			cl_type: CLASS_TYPE;
			to_append: CHARACTER_ARRAY;
		do
			Byte_array.clear

			if is_conformance_table_melted then
				if melted_parent_table = Void then
						-- Compute `melted_parent_table'.
					Byte_array.append ('%/001/')
					from
						i := 1
						nb := Type_id_counter.value
					until
						i > nb
					loop
						cl_type := class_types.item (i)
						if cl_type /= Void then
								-- Classes could be removed
							cl_type.make_parent_table_byte_code (Byte_array)
						end
						i := i + 1
					end

						-- End mark
					Byte_array.append_short_integer (-1)

					melted_parent_table := Byte_array.character_array
				end
				to_append := melted_parent_table
			else
				Byte_array.append ('%U')
				to_append := Byte_array.character_array
			end

				-- Put the parent table in `file'.
			to_append.store (file)
		end;

	make_option_table (file: RAW_FILE) is
			-- Generate byte code for the option table.
		require
			file_not_void: file /= Void
			file_is_open_write: file.is_open_write
		local
			i, nb: INTEGER
			cl_type: CLASS_TYPE
			a_class: CLASS_C
		do
debug ("OPTIONS")
	io.error.putstring ("Making option table%N")
end
			Byte_array.clear
			from
				i := min_type_id
				nb := Type_id_counter.value
			until
				i > nb
			loop
				cl_type := class_types.item (i)
				if cl_type /= Void then
						-- Classes could be removed
					Byte_array.append_short_integer (cl_type.type_id - 1)
					a_class := cl_type.associated_class
debug ("OPTIONS")
	io.error.putstring ("%TClass ")
	io.error.putstring (a_class.name)
	io.error.new_line
end
					a_class.assertion_level.make_byte_code (Byte_array)
					a_class.debug_level.make_byte_code (Byte_array)
					a_class.trace_level.make_byte_code (Byte_array)
					a_class.profile_level.make_byte_code (Byte_array)
				end
				i := i + 1
			end
				-- End mark
			Byte_array.append_short_integer (-1)

				-- Put the byte code description of the option table
				-- in update file
			Byte_array.character_array.store (file)
		end

	make_rout_info_table (file: RAW_FILE) is
			-- Generate byte code for the routine info table
			-- and store it in `file'.
		do
			Rout_info_table.melted.store (file)
		end

	finish_compilation is
			-- Finish a successful recompilation and update the
			-- compilation files.
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			local_classes: CLASS_C_SERVER
		do
				-- Reinitialization of control flags of the topological
				-- sort.
			update_sort := False
			moved := False

				-- Reset the classes as unchanged
			from
				local_classes := classes
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						a_class.set_changed (False)
						a_class.set_changed2 (False)
						a_class.set_changed3a (False)
						-- FIXME: changed4, changed5, changed6
						a_class.changed_features.clear_all
						a_class.propagators.wipe_out
					end
					i := i + 1
				end
				local_classes.forth
			end

				-- Update servers
			Feat_tbl_server.take_control (Tmp_feat_tbl_server)
			Tmp_body_server.finalize
			Tmp_inv_ast_server.finalize
			Tmp_rep_feat_server.finalize
			Ast_server.take_control (Tmp_ast_server)
			Class_info_server.take_control (Tmp_class_info_server)
			Byte_server.take_control (Tmp_byte_server)
			Inv_byte_server.take_control (Tmp_inv_byte_server)
			Depend_server.take_control (Tmp_depend_server)
			Rep_depend_server.take_control (Tmp_rep_depend_server)
			M_feat_tbl_server.take_control (Tmp_m_feat_tbl_server)
			M_feature_server.take_control (Tmp_m_feature_server)
			M_rout_id_server.take_control (Tmp_m_rout_id_server)
			M_desc_server.take_control (Tmp_m_desc_server)
			Rep_server.take_control (Tmp_rep_server)
			Class_comments_server.take_control (Tmp_class_comments_server)
				-- Just clear the rep info server
			Tmp_rep_info_server.clear

			-- NO !!!!!!! See comment in `init_recompilation'
			--original_body_index_table := Void

				-- DLE: get rid of the data stored during the last
				-- final mode compilation normally used when finalizing
				-- the Dynamic Class Set.
		end

feature -- Freeezing

	freeze_system is
			-- Worrkbench C code generation
		require
			root_class.compiled
		local
			a_class: CLASS_C
			class_list: SEARCH_TABLE [CLASS_C]
			i, nb: INTEGER
			temp: STRING
			descriptors: ARRAY [CLASS_ID]
			deg_output: DEGREE_OUTPUT
		do
			freezing_occurred := True
			if Compilation_modes.is_precompiling then
				!PRECOMP_MAKER!makefile_generator.make
			else
				!WBENCH_MAKER!makefile_generator.make
			end
				-- Re-process dynamic types
			-- FIXME
			--process_dynamic_types

				-- Process the C pattern table
debug ("ACTIVITY")
	io.error.putstring ("pattern_table.process%N")
end
			pattern_table.process

debug ("ACTIVITY")
	io.error.putstring ("Clear the melted code servers%N")
end
				-- Clear the melted byte code servers
			m_feat_tbl_server.clear
			m_feature_server.clear
			m_rout_id_server.clear

debug ("ACTIVITY")
	io.error.putstring ("Shake%N")
end
				-- Rebuild the dispatch table and the execution tables
			shake

			deg_output := Degree_output
				-- Generation of the descriptor tables
			if First_compilation then
				from
					class_list := freeze_set2
					i := class_list.count
					deg_output.put_start_degree (-1, i)
					class_list.start
				until
					class_list.after
				loop
					a_class := class_list.item_for_iteration
					deg_output.put_degree_minus_1 (a_class, i)
debug ("COUNT")
	io.error.putstring ("[")
	io.error.putint (i)
	io.error.putstring ("] ")
end
					a_class.generate_descriptor_tables

					i := i - 1
					class_list.forth
				end
			else
				from
					descriptors := m_desc_server.current_keys
					i := 1
					nb := descriptors.count
				until
					i > nb
				loop
					a_class := class_of_id (descriptors.item (i))
					if a_class /= Void then
						melted_set.put (a_class)
					end
					i := i + 1
				end

				from
					class_list := melted_set
					i := class_list.count
					deg_output.put_start_degree (-1, i)
					class_list.start
				until
					class_list.after
				loop
					a_class := class_list.item_for_iteration
debug ("COUNT")
	io.error.putstring ("[")
	io.error.putint (i)
	io.error.putstring ("] ")
end
					if a_class /= Void then
						deg_output.put_degree_minus_1 (a_class, i)
						a_class.generate_descriptor_tables
					end
					i := i - 1
					class_list.forth
				end
			end
			deg_output.put_end_degree

			m_desc_server.clear
			melted_set.wipe_out

			from
				class_list := freeze_set1
				i := class_list.count
				class_list.start
				deg_output.put_start_degree (-2, i)
				open_log_files
			until
				class_list.after
			loop
				a_class := class_list.item_for_iteration
				deg_output.put_degree_minus_2 (a_class, i)
debug ("COUNT")
	io.error.putstring ("[")
	io.error.putint (i)
	io.error.putstring ("] ")
end
				a_class.pass4

				class_list.forth
				i := i - 1
			end
			deg_output.put_end_degree
			close_log_files

			if not Compilation_modes.is_precompiling then
				from
					class_list := freeze_set2
					i := class_list.count
					deg_output.put_start_degree (-3, i)
					class_list.start
				until
					class_list.after
				loop
					a_class := class_list.item_for_iteration
debug ("COUNT")
	io.error.putstring ("[")
	io.error.putint (i)
	io.error.putstring ("] ")
end
					if a_class.is_modifiable then
						deg_output.put_degree_minus_3 (a_class, i)
	
						a_class.generate_feature_table
					end

					class_list.forth
					i := i - 1
				end
				deg_output.put_end_degree
			end

debug ("ACTIVITY")
io.error.putstring ("Generating tables...%N")
end

			freeze_set1.wipe_out
			freeze_set2.wipe_out
			generate_main_eiffel_files
		end

	generate_main_eiffel_files is
			-- Generate the "e*.c" files.
		local
			deg_output: DEGREE_OUTPUT
			t: AUXILIARY_FILES
			degree_message: STRING
		do
			!! t.make (Current, byte_context)
			degree_message := "Generation of auxiliary files"
			deg_output := Degree_output

			deg_output.display_degree_output (degree_message, 12, 12)
			generate_skeletons

			deg_output.display_degree_output (degree_message, 11, 12)
			generate_cecil

			deg_output.display_degree_output (degree_message, 10, 12)
			t.generate_conformance_table
			is_conformance_table_melted := False
			melted_conformance_table := Void
			melted_parent_table      := Void

			deg_output.display_degree_output (degree_message, 9, 12)
			generate_parent_tables

			deg_output.display_degree_output (degree_message, 8, 12)
			t.generate_plug

			deg_output.display_degree_output (degree_message, 7, 12)
			t.generate_dynamic_lib_file

			deg_output.display_degree_output (degree_message, 6, 12)
			generate_init_file

			deg_output.display_degree_output (degree_message, 5, 12)
			generate_option_file
			address_table.generate (False)

			deg_output.display_degree_output (degree_message, 4, 12)
			generate_rout_info_table

			deg_output.display_degree_output (degree_message, 3, 12)
			generate_pattern_table

			deg_output.display_degree_output (degree_message, 2, 12)
			generate_dispatch_table

			deg_output.display_degree_output (degree_message, 1, 12)
			generate_exec_table

			deg_output.display_degree_output (degree_message, 0, 12)
			t.generate_make_file

				-- Create an empty update file ("melted.eif")
			make_update (True)
		end

	update_valid_body_ids is
		local
			class_list: SEARCH_TABLE [CLASS_C]
		do
				-- If we are not using any precompilation, ie classes.count = 1
				-- which correspond to the classes.item (Normal_compilation),
				-- we don't need to update the body ids at the first compilation
			if not (First_compilation and then classes.ht_count = 1) then
				from
					class_list := freeze_set1
					class_list.start
				until
					class_list.after
				loop
					class_list.item_for_iteration.update_valid_body_ids
					class_list.forth
				end
			end
		end

	shake is
		local
			exec_unit: EXECUTION_UNIT
			external_unit: EXT_EXECUTION_UNIT
			info: EXTERNAL_INFO
		do
				-- Real shake compresses the dispatch and execution tables
				-- Not called because the descriptors must be reprocessed
				-- if a dispatch unit is moved (real_body_index changes)

			update_valid_body_ids

			execution_table.shake
			dispatch_table.shake

			from
				execution_table.start
			until
				execution_table.after
			loop
				exec_unit := execution_table.item_for_iteration
				if exec_unit.is_external and then exec_unit.is_valid then
					external_unit ?= exec_unit
					check
						externals.has (external_unit.external_name)
					end
					info := externals.item (external_unit.external_name)
					info.set_execution_unit (external_unit)
				end
				execution_table.forth
			end

				-- Reset the frozen level since the execution table
				-- is re-built now.
			frozen_level := execution_table.frozen_level
			execution_table.set_levels

				-- Freeze the external table: reset the real body ids,
				-- remove all unused externals and make the duplication
			externals.freeze
		end

	shake_tables is
		do
		end

feature -- Final mode generation

	in_final_mode: BOOLEAN is
			-- Generation of Final code ?
		do
			Result := byte_context.final_mode
		end

	finalize_system (keep_assert: BOOLEAN) is
			-- Finalized generation.
		require
			root_class_compiled: root_class.compiled
		local
			old_remover_off: BOOLEAN
			old_exception_stack_managed: BOOLEAN
			old_inlining_on, old_array_optimization_on: BOOLEAN
			deg_output: DEGREE_OUTPUT
		do

			keep_assertions := keep_assert and then Lace.has_assertions

				-- Save the value of `remover_off'
				-- and `exception_stack_managed'
			old_remover_off := remover_off
			old_exception_stack_managed := exception_stack_managed
			old_inlining_on := inlining_on
			old_array_optimization_on := array_optimization_on

				-- Should dead code be removed?
			if not remover_off then
				remover_off := keep_assertions
			end

			if not exception_stack_managed then
				exception_stack_managed := keep_assertions
			end

			inlining_on := inlining_on and not remover_off
			array_optimization_on := array_optimization_on and not remover_off

				-- Set the generation mode in final mode
			byte_context.set_final_mode

			degree_minus_4
			
				-- Dead code removal
			if not remover_off then
				deg_output := Degree_output
				deg_output.put_start_dead_code_removal_message
				remove_dead_code
				deg_output.put_end_dead_code_removal_message
			end
			tmp_opt_byte_server.flush

			-- FIXME
			--process_dynamic_types

				-- Generation of C files associated to the classes of
				-- the system.
			degree_minus_5

			generate_main_finalized_eiffel_files
	
			Tmp_poly_server.clear

				-- Clean Eiffel table
			Eiffel_table.wipe_out
			Tmp_opt_byte_server.clear

			remover := Void

			remover_off := old_remover_off
			exception_stack_managed := old_exception_stack_managed
			inlining_on := old_inlining_on
			array_optimization_on := old_array_optimization_on
		rescue
				-- Clean the servers if the finalization is aborted
			Tmp_poly_server.flush
			Tmp_poly_server.clear
			Tmp_opt_byte_server.flush
			Tmp_opt_byte_server.clear
		end

	degree_minus_4 is
			-- Process Degree -4.
		local
			a_class: CLASS_C
			i, j, nb: INTEGER
			deg_output: DEGREE_OUTPUT
			class_array: ARRAY [CLASS_C]
			local_classes: CLASS_C_SERVER
		do
			local_classes := classes
			i := local_classes.count
			deg_output := Degree_output
			deg_output.put_start_degree (-4, i)
			from
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from
					j := 1
				until
					j > nb
				loop
					a_class := class_array.item (j)
					if a_class /= Void then
						deg_output.put_degree_minus_4 (a_class, i)
						a_class.process_polymorphism
						History_control.check_overload
						i := i - 1
					end
					j := j + 1
				end
				local_classes.forth
			end
			deg_output.put_end_degree
			History_control.transfer
			tmp_poly_server.flush
		end

	degree_minus_5 is
			-- Process Degree -5.
			-- Generation of C files associated to the classes of
			-- the system.
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			j: INTEGER
			deg_output: DEGREE_OUTPUT
			local_classes: CLASS_C_SERVER
		do
			from
				local_classes := classes
				!FINAL_MAKER! makefile_generator.make
				open_log_files
				j := local_classes.count
				deg_output := Degree_output
				deg_output.put_start_degree (-5, j)
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from
					i := 1
				until
					i > nb
				loop
					a_class := class_array.item (i)
					if a_class /= Void then
						deg_output.put_degree_minus_5 (a_class, j)
						current_class := a_class
						a_class.pass4
						j := j - 1
					end
					i := i + 1
				end
				local_classes.forth
			end
			deg_output.put_end_degree
			close_log_files
		end

feature -- Dead code removal

	remove_dead_code is
			-- Dead code removal
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			root_feat: FEATURE_I
			ct: CLASS_TYPE
			local_classes: CLASS_C_SERVER
		do
			!! remover.make

			if array_optimization_on then
				remover.record_array_descendants
			end

				-- First, inspection of the Eiffel code
			if creation_name /= Void then
				a_class := root_class.compiled_class
				root_feat := a_class.feature_table.item (creation_name)
				remover.record (root_feat, a_class)
			end

			from
				local_classes := classes
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						a_class.mark_dispose (remover)
						if a_class.visible_level.has_visible then
							a_class.mark_visible (remover)
						end
					end
					i := i + 1
				end
				local_classes.forth
			end

			if has_expanded then
				from
					i := 1
					nb := Type_id_counter.value
				until
					i > nb
				loop
					ct := class_types.item (i)
					if ct /= Void then
						ct.mark_creation_routine (remover)
					end
					i := i + 1
				end
			end

				-- Protection of the attribute `area' in class TO_SPECIAL
			to_special_class.compiled_class.mark_all_used (remover)

				-- Protection of `make' from ARRAY
			array_class.compiled_class.mark_all_used (remover)

				-- Protection of features written in basic reference classes
			character_ref_class.compiled_class.mark_all_used (remover)
			boolean_ref_class.compiled_class.mark_all_used (remover)
			integer_ref_class.compiled_class.mark_all_used (remover)
			real_ref_class.compiled_class.mark_all_used (remover)
			double_ref_class.compiled_class.mark_all_used (remover)
			pointer_ref_class.compiled_class.mark_all_used (remover)

				-- Protection of feature `make' of class STRING
			string_class.compiled_class.mark_all_used (remover)
		end

	is_used (f: FEATURE_I): BOOLEAN is
			-- Is feature `f' used in the system ?
		require
			good_argument: f /= Void
		do
			Result := remover_off or else remover.is_alive (f)
		end

feature -- Generation

	generate_main_finalized_eiffel_files is
			-- Generation of all the tables needed by the finalized
			-- Eiffel executable.
		local
			deg_output: DEGREE_OUTPUT
			t: AUXILIARY_FILES
			degree_message: STRING
		do
			!! t.make (Current, byte_context)
			degree_message := "Generation of auxiliary files"
			deg_output := Degree_output

				-- Address table
			deg_output.display_degree_output (degree_message, 10, 10)
			address_table.generate (True)

				-- Generation of type size table
			deg_output.display_degree_output (degree_message, 9, 10)
			generate_size_table

				-- Generation of the reference number table
			deg_output.display_degree_output (degree_message, 8, 10)
			generate_reference_table

				-- Generation of the skeletons
			deg_output.display_degree_output (degree_message, 7, 10)
			generate_skeletons

				-- Cecil structures generation
			deg_output.display_degree_output (degree_message, 6, 10)
			generate_cecil

				-- Generation of the conformance table
			deg_output.display_degree_output (degree_message, 5, 10)
			t.generate_conformance_table

				-- Generation of the parent table
			deg_output.display_degree_output (degree_message, 4, 10)
			generate_parent_tables

				-- Routine table generation
			deg_output.display_degree_output (degree_message, 3, 10)
			generate_routine_table

				-- Generate plug with run-time.
			deg_output.display_degree_output (degree_message, 2, 10)
			t.generate_plug
			--generate_plug

				-- Generate edynlib with run-time.
			deg_output.display_degree_output (degree_message, 2, 10)
			t.generate_dynamic_lib_file

				-- Generate init file
			deg_output.display_degree_output (degree_message, 1, 10)
			generate_init_file

				-- Generate makefile
			deg_output.display_degree_output (degree_message, 0, 10)
			t.generate_make_file

			if System.has_separate then
				generate_only_separate_pattern_table
			end
		end

	process_dynamic_types is
			-- Processing of the dynamic types.
		local
			class_array: ARRAY [CLASS_C]
			class_list: ARRAY [CLASS_C]
			a_class: CLASS_C
			types: TYPE_LIST
			i, nb: INTEGER
			local_classes: CLASS_C_SERVER
		do
				-- First re-process all the type id of instances of
				-- CLASS_TYPE available in attribute list `types' of
				-- instances of CLASS_C

debug ("ACTIVITY")
	io.error.putstring ("Process dynamic types%N")
end
				-- Sort the class_list by type id in `class_list'.
			!!class_list.make (1, max_class_id)
			from
				local_classes := classes
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						class_list.put (a_class, a_class.topological_id)
					end
					i := i + 1
				end
				local_classes.forth
			end

			nb := max_class_id
				-- Iteration on `class_list' in order to compute new type
				-- id's
			from
				type_id_counter.set_value (0)	-- 0 = min_type_id - 1
				i := 1
			until
				i > nb
			loop
					-- Types of the class
				types := class_list.item (i).types
				from
					types.start
				until
					types.after
				loop
					reset_type_id (types.item)
					types.forth
				end
				i := i + 1
			end
		end

	reset_type_id (class_type: CLASS_TYPE) is
			-- Assign a new dynamic type id to `class_type'.
		require
			class_type_not_void: class_type /= Void
		local
			new_type_id: INTEGER
		do
			new_type_id := type_id_counter.next
			class_type.set_type_id (new_type_id)
debug ("ACTIVITY")
	io.error.putint (new_type_id)
	io.error.putstring (": ")
	class_type.type.trace
	io.error.putstring (" [")
	class_type.id.trace
	io.error.putstring ("]%N")
end
				-- Update `class_types'
			insert_class_type (class_type)
		end

	generate_routine_table is
			-- Generate routine and attribute tables.
		require
			in_final_mode: byte_context.final_mode
		local
			rout_id: ROUTINE_ID
			table: POLY_TABLE [ENTRY]
		do
			Attr_generator.init
			Rout_generator.init

			from
				Tmp_poly_server.start
			until
				Tmp_poly_server.after
			loop
				rout_id := Tmp_poly_server.key_for_iteration

				if Eiffel_table.is_used (rout_id) then
					table := Tmp_poly_server.item (rout_id)
					table.write
				end
				Tmp_poly_server.forth
			end

			generate_initialization_table
			generate_dispose_table

			Attr_generator.finish
			Rout_generator.finish
		end

	generate_size_table is
			-- Generate the size table.
		local
			i, nb: INTEGER
			class_type: CLASS_TYPE
			file: INDENT_FILE
		do
			from
				file := Size_file (byte_context.final_mode)
				i := 1
				nb := type_id_counter.value
				file.open_write
				file.putstring ("#include %"eif_macros.h%"%N%N%
								%long egc_fsize_init[] = {%N")
			until
				i > nb
			loop
				class_type := class_types.item (i)

				if class_type /= Void then
					class_type.skeleton.generate_size (file)
				else
					-- FIXME
					-- Process_dynamic_types has been TEMPORARILY removed
					file.putstring ("0")
				end

				file.putstring (",%N")
				i := i + 1
			end
			file.putstring ("};%N")
			file.close
		end

	generate_reference_table is
			-- Generate the table of reference number per type.
		local
			i, nb, nb_ref, nb_exp: INTEGER
			class_type: CLASS_TYPE
			skeleton: SKELETON
		do
			from
				i := 1
				nb := type_id_counter.value
				Reference_file.open_write
				Reference_file.putstring ("long egc_fnbref_init[] = {%N")
			until
				i > nb
			loop
				class_type := class_types.item (i)

				if class_type /= Void then
					skeleton := class_type.skeleton
					nb_ref := skeleton.nb_reference
					nb_exp := skeleton.nb_expanded
					Reference_file.putint (nb_ref + nb_exp)
				else
					-- FIXME process_dynamic_types TEMPORARILY removed
					Reference_file.putint (0)
				end

				Reference_file.putstring (",%N")
				i := i + 1
			end
			if has_separate then
				Reference_file.putint (0)
			end
			Reference_file.putstring ("%N};%N")
			Reference_file.close
		end

	generate_parent_tables is
			-- Generates parent tables.
		local
			i, nb, cid   : INTEGER;
			cl_type      : CLASS_TYPE;
			parents_file : INDENT_FILE;
			final_mode   : BOOLEAN;
			max_id       : INTEGER;
			used_ids     : ARRAY [BOOLEAN]
		do
			final_mode := byte_context.final_mode;

			parents_file := parent_f (final_mode);
			parents_file.open_write;
			parents_file.putstring ("#include %"eif_struct.h%"%N%N");

			max_id := 0;

			from
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				if cl_type /= Void then
					cl_type.generate_parent_table (parents_file, final_mode);
					cid := cl_type.type.generated_id (final_mode);

					if cid > max_id then
						max_id := cid;
					end
				end;
				i := i + 1;
			end;

			-- Now create 'used_ids' array and fill it

			!!used_ids.make (0, max_id);

			from
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				if cl_type /= Void then
					cid := cl_type.type.generated_id (final_mode);
					used_ids.put (True, cid);
				end;
				i := i + 1;
			end;

			parents_file.putstring ("int    egc_partab_size_init = ")
			parents_file.putint (max_id);
			parents_file.putstring (";%N");
			parents_file.putstring ("struct eif_par_types *egc_partab_init[] = {%N");

			from
				i := 0
			until
				i > max_id
			loop
				if used_ids.item (i) then
					parents_file.putstring ("&par");
					parents_file.putint (i);
				else
					parents_file.putstring ("(struct eif_par_types *)0");
				end;
				parents_file.putstring (",%N");
				i := i + 1;
			end;
			parents_file.putstring ("(struct eif_par_types *)0};%N");
			parents_file.close;
			parents_file := Void;
		end;

	generate_skeletons is
			-- Generate skeletons of class types
		local
			class_array: ARRAY [CLASS_C]
			j, i, nb, nb_class: INTEGER
			cl_type: CLASS_TYPE
			a_class: CLASS_C
			has_attribute, final_mode: BOOLEAN
			types: TYPE_LIST
			temp: STRING
				-- cltype_array is indexed by `id' not by `type_id'
				-- as `class_types'
			cltype_array: ARRAY [CLASS_TYPE]
			local_classes: CLASS_C_SERVER
	--		skeleton_file: INDENT_FILE
		do
			nb := Type_id_counter.value
			final_mode := byte_context.final_mode

				-- Open skeleton file
			Skeleton_file := Skeleton_f (final_mode)
			Skeleton_file.open_write

			Skeleton_file.putstring ("#include %"eif_project.h%"%N%
									 %#include %"eif_struct.h%"%N")
			if final_mode then
				Skeleton_file.putstring ("#include %"")
				Skeleton_file.putstring (Eskelet)
				Skeleton_file.putstring (Dot_h)
				Skeleton_file.putstring ("%"%N%N")
				from
					i := 1
				until
					i > nb
				loop

					if class_types.item (i) /= Void then
						-- FIXME
						class_types.item (i).skeleton.make_extern_declarations
					end

					i := i + 1
				end
				Extern_declarations.generate_header (final_file_name (Eskelet, Dot_h))
				Extern_declarations.generate (final_file_name (Eskelet, Dot_h))
				Extern_declarations.wipe_out
			else
					-- Hash table extern declaration in workbench mode
				Skeleton_file.putstring ("#include %"eif_macros.h%"%N")
				Skeleton_file.new_line
				from
					local_classes := classes
					local_classes.start
				until
					local_classes.after
				loop
					class_array := local_classes.item_for_iteration
					nb := class_counter.item (local_classes.key_for_iteration).count
					from i := 1 until i > nb loop
						a_class := class_array.item (i)
						if a_class /= Void then
							j := a_class.id.id
							if
								not Compilation_modes.is_precompiling and
								not a_class.is_precompiled
							then
								Skeleton_file.putstring ("extern int32 ra")
								Skeleton_file.putint (j)
								Skeleton_file.putstring ("[];%N")
							end
							if a_class.has_visible then
								Skeleton_file.putstring ("extern char *cl")
								Skeleton_file.putint (j)
								Skeleton_file.putstring ("[];%N")
								Skeleton_file.putstring ("extern uint32 cr")
								Skeleton_file.putint (j)
								Skeleton_file.putstring ("[];%N")
							end
							if not a_class.skeleton.empty then
								from
									types := a_class.types
									types.start
								until
									types.off
								loop
									Skeleton_file.putstring ("extern uint32 types")
									Skeleton_file.putint (types.item.type_id)
									Skeleton_file.putstring ("[];%N")
									types.forth
								end
							end
						end
						i := i + 1
					end
					local_classes.forth
				end
				Skeleton_file.new_line

				!!cltype_array.make (1, static_type_id_counter.total_count)
			end

			from
				nb := Type_id_counter.value
				i := 1
			until
				i > nb
			loop
				cl_type := class_types.item (i)
					-- Classes could be removed
if cl_type /= Void then
				cl_type.generate_skeleton1 (skeleton_file)
				if not final_mode then
						-- Doesn't use `cl_type' as first argument:
						-- LINKED_LIST [INTEGER] introduced in two precompiled projects
						-- must have only one derivation in the generated code, i.e. objects
						-- created by one precompiled project can be used by the other as they are
						-- of the same type.
						-- Using cl_type.type.associated_class_type will make sure that both
						-- derivations will share the same dynamic type.
					cltype_array.put (cl_type.type.associated_class_type, cl_type.id.id)
				end
else
		-- FIXME
end
				i := i + 1
			end

			Skeleton_file.putstring ("struct cnode egc_fsystem_init[] = {%N")
			from
				i := 1
			until
				i > nb
			loop
				cl_type := class_types.item (i)
if cl_type /= Void then
				cl_type.generate_skeleton2 (skeleton_file)
else
		-- FIXME
	if final_mode then
		Skeleton_file.putstring ("{ 0, %"INVALID_TYPE%", (char**)0, 0,0,0,0}")
	else
		Skeleton_file.putstring 
			("{%N0L,%N%"INVALID_TYPE%",%N(char**) 0,%N(int*) 0,%N%
			%(uint32*) 0,%N(int32*) 0,%N0L,%N0L,%N'\0',%N'\0',%N%
			%(int32) 0,(int32) 0,'\0',%N(int32*) 0,%N%
			%{(int32) 0, (int) 0, (char**) 0, (char*) 0}}")
	end
end
				Skeleton_file.putstring (",%N")
				i := i + 1
			end
			if has_separate then
				if not final_mode then
					Skeleton_file.putstring 
						("{%N0L,%N%"SEP_OBJ%",%N(char**) 0,%N(int*) 0,%N%
						%(uint32*) 0,%N(int32*) 0,%N0L,%N0L,%N'\0',%N'\0',%N%
						%(int32) 0,(int32) 0, %N1,%N(int32*) 0,%N%
						%{(int32) 0, (int) 0, (char**) 0, (char*) 0}}%N")
				end
			end
			Skeleton_file.putstring ("};%N%N")

			if not final_mode then
					-- Generate the array of routine id arrays
				Skeleton_file.putstring ("int32 *egc_fcall_init[] = {%N")
				from
					i := 1
					nb := cltype_array.upper
				until
					i > nb
				loop
					cl_type := cltype_array.item (i)
					if
						not Compilation_modes.is_precompiling and
						cl_type /= Void and then
						not cl_type.associated_class.is_precompiled
					then
						Skeleton_file.putstring ("ra")
						Skeleton_file.putint (cl_type.associated_class.id.id)
					else
						Skeleton_file.putstring ("(int32 *) 0")
					end
					Skeleton_file.putstring (",%N")
					i := i + 1
				end
				Skeleton_file.putstring ("};%N%N")
					-- Generate the correspondances stable between original
					-- dynamic types and new dynamic types
				Skeleton_file.putstring ("int16 egc_fdtypes_init[] = {%N")
				from
					i := 1
				until
					i > nb
				loop
					cl_type := cltype_array.item (i)
					Skeleton_file.putstring ("(int16) ")
					if cl_type /= Void then
						Skeleton_file.putint (cl_type.type_id - 1)
					else
						Skeleton_file.putint (0)
					end
					Skeleton_file.putstring (",%N")
					i := i + 1
				end
				Skeleton_file.putstring ("};%N")
			end
				-- Close skeleton file
			Skeleton_file.close
			Skeleton_file := Void
		end

	generate_cecil is
			-- Generate Cecil structures
		local
			class_array: ARRAY [CLASS_C]
			i, nb, generic, no_generic: INTEGER
			cl_type: CLASS_TYPE
			a_class: CLASS_C
			final_mode: BOOLEAN
			temp: STRING
			subdir: DIRECTORY
			f_name: FILE_NAME
			dir_name: DIRECTORY_NAME
			local_classes: CLASS_C_SERVER
		do
			final_mode := byte_context.final_mode

			Cecil_file := cecil_f (final_mode)
			Cecil_file.open_write
			Cecil_file.putstring ("#include %"eif_project.h%"%N")
			Cecil_file.putstring ("#include %"eif_cecil.h%"%N")
			if final_mode then
				Cecil_file.putstring ("#include %"ececil.h%"%N")
			end
			Cecil_file.putstring ("#include %"eif_struct.h%"%N%N")

			from
				local_classes := classes
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						if a_class.has_visible then
							a_class.generate_cecil
						end
					end
					i := i + 1
				end
				local_classes.forth
			end

			if final_mode then
					-- Extern declarations for previous file
				temp := clone (System_object_prefix)
				temp.append_integer (1)
				!!dir_name.make_from_string (Final_generation_path)
				dir_name.extend (temp)
				!! subdir.make (dir_name)
				if not subdir.exists then
					subdir.create_dir
				end
				!!f_name.make_from_string (dir_name)
				f_name.set_file_name ("ececil.h")
				Extern_declarations.generate_header (f_name)
				Extern_declarations.generate (f_name)
				Extern_declarations.wipe_out
				Cecil_file.putstring ("%Nstruct ctable egc_ce_rname_init[] = {%N")
				from
					i := 1
					nb := Type_id_counter.value
				until
					i > nb
				loop
if class_types.item (i) /= Void then
					class_types.item (i).generate_cecil (Cecil_file)
else
		-- FIXME
		Cecil_file.putstring ("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
end
					Cecil_file.putstring (",%N")
					i := i + 1
				end
				Cecil_file.putstring ("};%N")

				if System.has_separate then
						-- Now, generate for Concurrent Eiffel
					Cecil_file.putstring ("%Nstruct ctable fce_sep_pat[] = {%N")
					from
						i := 1
						nb := Type_id_counter.value
					until
						i > nb
					loop
if class_types.item (i) /= Void then
					class_types.item (i).generate_separate_pattern (Cecil_file)
else
		-- FIXME
		Cecil_file.putstring ("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
end
						Cecil_file.putstring (",%N")
						i := i + 1
					end
					Cecil_file.putstring ("};%N%Nstruct ctable *ce_sep_pat = fce_sep_pat;%N%N")
				end
			end

			make_cecil_tables
			Cecil2.generate
			Cecil3.generate

			Cecil_file.close
			Cecil_file := Void
		end

	make_cecil_tables is
			-- Prepare cecil tables
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			generic, no_generic: INTEGER
			a_class: CLASS_C
			upper_class_name: STRING
			local_classes: CLASS_C_SERVER
		do
			from
				local_classes := classes
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						if a_class.generics = Void then
							no_generic := no_generic + 1
						else
							generic := generic + 1
						end
					end
					i := i + 1
				end
				local_classes.forth
			end

			Cecil2.init (no_generic)
			Cecil3.init (generic)
			from
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						upper_class_name := clone (a_class.external_name)
						upper_class_name.to_upper
						if a_class.generics = Void then
							Cecil2.put (a_class, upper_class_name)
						else
							Cecil3.put (a_class, upper_class_name)
						end
					end
					i := i + 1
				end
				local_classes.forth
			end
		end


	generate_initialization_table is
			-- Generate table of initialization routines
		local
			rout_table: SPECIAL_TABLE
			rout_entry: SPECIAL_ENTRY
			i, nb: INTEGER
			class_type: CLASS_TYPE
		do
			from
				!! rout_table
				rout_table.set_rout_id (routine_id_counter.initialization_rout_id)
				i := 1
				nb := Type_id_counter.value
				rout_table.create_block (nb)
			until
				i > nb
			loop
				class_type := class_types.item (i)
if class_type /= Void then
-- FIXME
				if class_type.has_creation_routine then
					!!rout_entry
					rout_entry.set_type_id (i)
					rout_entry.set_written_type_id (i)
					rout_entry.set_body_id (body_id_counter.initialization_body_id)
					rout_table.extend (rout_entry)
				end
end
				i := i + 1
			end
			rout_table.sort_till_position
			rout_table.write
		end

feature -- Dispose routine

	memory_dispose_id: ROUTINE_ID is
			-- Memory dispose routine id from class MEMORY. 
			-- Return 0 if the MEMORY class has not been compiled.
			--! (Assumed memory must have a dispose routine
			--! called "dispose" - DINOV).
		require
			checked_desc: memory_descendants /= Void
		local
			feature_i: FEATURE_I
		once
			if memory_class /= Void then
				feature_i := memory_class.feature_table.item ("dispose")
				if feature_i /= Void then
					Result := feature_i.rout_id_set.first
				end
			end
		end

	memory_class: CLASS_C is
			-- MEMORY class of system. Void if it has
			-- not been compiled.
		once
			Result := memory_class_i.compiled_class
		end

	memory_descendants: LINKED_LIST [CLASS_C] is
			-- Memory descendants.
		once
			!! Result.make
			if memory_class /= Void then
				formulate_mem_descendants (memory_class, Result)
			end
		end
 
	formulate_mem_descendants (c: CLASS_C; desc: LINKED_LIST [CLASS_C]) is
			-- Formulate descendants of class MEMORY. 
		local
			descendants: LINKED_LIST [CLASS_C]
			d: CLASS_C
		do
			from
				descendants := c.descendants
				descendants.start
			until
				descendants.after
			loop
				d := descendants.item
				desc.extend (d)
				desc.forth
				formulate_mem_descendants (d, desc)
				descendants.forth
			end
		end
 
	generate_dispose_table is
			-- Generate dispose table
		local
			rout_table: SPECIAL_TABLE
			rout_entry: SPECIAL_ENTRY
			i, nb: INTEGER
			class_type: CLASS_TYPE
			feature_i: FEATURE_I
			written_type: CL_TYPE_I
			written_class: CLASS_C
		do
			from
				!! rout_table
				rout_table.set_rout_id (routine_id_counter.dispose_rout_id)
				i := 1
				nb := Type_id_counter.value
				rout_table.create_block (nb)
			until
				i > nb 
			loop
				class_type := class_types.item (i)
if class_type /= Void then
	-- FIXME
				feature_i := class_type.dispose_feature
				if feature_i /= Void then
						-- FIXME: extra check to see if it's the one from MEMORY:
						-- no need to add an empty routine
						-- Ooops, maybe we need to do it if the Eiffel code
						-- includes a call obj.dispose (you never know what users
						-- or Dave Hollenberg are going to do)
						-- But this call may generate a new table of its own (check)
						-- Yes it does (check done) so we can optimize the `dispose'
						-- table
						-- Xavier
					!!rout_entry
					rout_entry.set_type_id (i)
					written_class := class_of_id (feature_i.written_in)
					written_type := written_class.meta_type (class_type.type)
					rout_entry.set_written_type_id (written_type.type_id)
 					rout_entry.set_body_id (feature_i.body_id)
					rout_table.extend (rout_entry)
				end
end
				i := i + 1
			end
			rout_table.sort_till_position
			rout_table.write
		end

feature -- Dispatch and execution tables generation

	generate_dispatch_table is
			-- Generate `dispatch_table'.
		do
			Dispatch_file.open_write
			dispatch_table.generate (Dispatch_file)
			dispatch_table.freeze
			Dispatch_file.close
				-- The melted list of the dispatch table
				-- is now empty
		end

	generate_exec_table is
			-- Generate `execution_table'.
		do
			Frozen_file.open_write_c
			execution_table.generate (Frozen_file)
			execution_table.freeze
			Frozen_file.close_c
				-- The melted list of the execution table
				-- is now empty
		end

feature -- Pattern table generation

	generate_pattern_table is
			-- Generate pattern table.
		do
			pattern_table.generate
		end

	generate_only_separate_pattern_table is
			-- Generate pattern table.
		require
			finalized_mode: byte_context.final_mode
		do
			pattern_table.generate_in_finalized_mode
		end

	generate_init_file is
			-- Generation of the main file
		local
			root_cl: CLASS_C
			root_feat: FEATURE_I
			ext_feat: EXTERNAL_I
			c_name: STRING
			dtype: INTEGER
			final_mode: BOOLEAN
			cl_type: CLASS_TYPE

			has_argument: BOOLEAN
			i, nb: INTEGER
			Initialization_file: INDENT_FILE

			rout_id: ROUTINE_ID
			rout_table: ROUT_TABLE

			rout_info: ROUT_INFO
			rcorigin: INTEGER
			rcoffset: INTEGER

			a_class: CLASS_C
			class_array: ARRAY [CLASS_C]
		do

			final_mode := byte_context.final_mode
			Initialization_file := Init_f (final_mode)

			root_cl := root_class.compiled_class
			cl_type := root_cl.types.first
			dtype := cl_type.type_id - 1

			if creation_name /= Void then
				root_feat := root_cl.feature_table.item (creation_name)
				if root_feat.has_arguments then
					has_argument := True
				end
				rout_id := root_feat.rout_id_set.first
				rout_info := System.rout_info_table.item (rout_id)
				rcorigin := rout_info.origin.id
				rcoffset := rout_info.offset
			else
				rcorigin := -1
			end

			Initialization_file.open_write_c

			Initialization_file.putstring ("%
				%#include %"eif_project.h%"%N%
				%#include %"eif_macros.h%"%N%
				%#include %"eif_struct.h%"%N%N")

			if not final_mode then
				class_counter.generate_offsets (Initialization_file)
				static_type_id_counter.generate_offsets (Initialization_file)
				execution_table.counter.generate_offsets (Initialization_file)
				dispatch_table.counter.generate_offsets (Initialization_file)
				Initialization_file.putstring ("int32 egc_rcorigin = ")
				Initialization_file.putint (rcorigin)
				Initialization_file.putstring (";%Nint32 egc_rcdt = ")
				Initialization_file.putint (dtype)
				Initialization_file.putstring (";%Nint32 egc_rcoffset = ")
				Initialization_file.putint (rcoffset)
				Initialization_file.putstring (";%Nint32 egc_rcarg = ")
				if has_argument then
					Initialization_file.putstring ("1")
				else
					Initialization_file.putstring ("0")
				end
				Initialization_file.putstring (";%N%N")
			end

			if has_separate then
				Initialization_file.putstring ("#include %"eif_curextern.h%"%N%N")
			end

			if creation_name /= Void then
				if final_mode then
					rout_table ?= Eiffel_table.poly_table (rout_id)
					c_name := rout_table.feature_name (cl_type.id.id)
					if root_feat.has_arguments then
						Initialization_file.generate_extern_declaration
							("void", c_name, <<"EIF_REFERENCE", "EIF_REFERENCE">>)
					else
						Initialization_file.generate_extern_declaration
							("void", c_name, <<"EIF_REFERENCE">>)
					end
				end
			end

			Initialization_file.generate_function_signature ("void", "emain", True, Initialization_file,
						<<"argc", "argv">>, <<"int", "char **">>)

			Initialization_file.putstring ("#ifndef EIF_THREADS%N%
											%%Textern char *root_obj;%N%
											%#endif%N")

			if final_mode then
					-- Set C variable `scount'.
				Initialization_file.putstring ("%Tscount = ")
				Initialization_file.putint (type_id_counter.value)
				Initialization_file.putstring (";%N")
			end

			if has_separate then
				Initialization_file.putstring ("%Tif (argc < 2) {%N%
					%%T%Tsprintf(crash_info, CURERR7, 1);%N%
					%%T%Tdefault_rescue();%N%
					%%T}%N")
				Initialization_file.putstring ("%
					%%Tif (strcmp(argv[1], constant_init_flag) && strcmp(argv[1], constant_creation_flag)) {%N%
					%%T%Tsprintf(crash_info, CURERR8);%N%
					%%T%Tdefault_rescue();%N%
					%%T}%N")
				Initialization_file.putstring ("%
					%%Tif (!memcmp(argv[1], constant_init_flag, strlen(argv[1]))) {%N%
					%%T%Tchar **root_argv;%N%
					%%T%Tint i;%N%
					%%T%Troot_argv = (char **) cmalloc(argc*sizeof(char *));%N%
					%%T%Tvalid_memory(root_argv);%N")
				Initialization_file.putstring ("%
					%%T%Troot_argv[0] = argv[0];%N%
					%%T%Tfor(i=2; i<argc; i++)%N%
					%%T%T%Troot_argv[i-1] = argv[i];%N%
					%%T%Troot_argv[argc-1] = NULL;%N%
					%%T%T_concur_root_of_the_application = 1;%N%
					%%T%T_concur_invariant_checked = 1;%N")
					-- The last line Only for Workbench Mode
			end

			Initialization_file.putstring ("%T%Troot_obj = RTLN(")
			if final_mode then
				Initialization_file.putint (dtype)
			else
				Initialization_file.putstring ("egc_rcdt")
			end
			Initialization_file.putstring (");%N")

			if has_separate then
				Initialization_file.putstring ("%T%TCURIS;%N")
			end

			if final_mode then
				if creation_name /= Void then
					Initialization_file.putstring ("%T%T")
					Initialization_file.putstring (c_name)
					Initialization_file.putstring ("(root_obj")
					if root_feat.has_arguments then
						if has_separate then
							Initialization_file.putstring (", argarr(argc-1, root_argv)")
						else
							Initialization_file.putstring (", argarr(argc, argv)")
						end
					end
					Initialization_file.putstring (");%N")
				end
			else
				if has_separate then
					Initialization_file.putstring ("%T%Tif (egc_rcorigin != -1)%N%
						%%T%T%Tif (egc_rcarg)%N%
						%%T%T%T%T(FUNCTION_CAST(void, (char *, char *)) RTWPF(egc_rcorigin, egc_rcoffset, egc_rcdt))(root_obj, argarr(argc-1, root_argv));%N%
						%%T%T%Telse%N%
						%%T%T%T%T(FUNCTION_CAST(void, (char *)) RTWPF(egc_rcorigin, egc_rcoffset, egc_rcdt))(root_obj);%N")
				else
					Initialization_file.putstring ("%Tif (egc_rcorigin != -1)%N%
						%%T%Tif (egc_rcarg)%N%
						%%T%T%T(FUNCTION_CAST(void, (char *, char *)) RTWPF(egc_rcorigin, egc_rcoffset, egc_rcdt))(root_obj, argarr(argc, argv));%N%
						%%T%Telse%N%
						%%T%T%T(FUNCTION_CAST(void, (char *)) RTWPF(egc_rcorigin, egc_rcoffset, egc_rcdt))(root_obj);%N")
				end
			end

			if has_separate then
				Initialization_file.putstring ("%T}%N")

				Initialization_file.putstring ("%Telse {%N%
					%%T%T_concur_root_of_the_application = 0;%N%
					%%T%Troot_obj = RTLN(eif_type_id(argv[4]));%N")
				Initialization_file.putstring ("%T%TCURIS;%N")

					-- Only for Workbench Mode
				Initialization_file.putstring ("%T%Tif (!strcmp(argv[5], %"_no_cf%")) {%N%
					%%T%T%TRTCI(root_obj);%N%
					%%T%T%T_concur_invariant_checked = 1;%N%
					%%T%T}%N%
					%%T%Telse%N%
					%%T%T%T_concur_invariant_checked = 0;%N")

				Initialization_file.putstring ("%T}%N")
				Initialization_file.putstring ("%Tserver_execute();%N")
			end

			Initialization_file.putstring ("%N}%N")

			-- Generation of egc_einit_init() and egc_tabinit_init(). Only for workbench
			-- mode.

			if not final_mode then
					-- Prototypes
				Initialization_file.generate_extern_declaration ("void", "egc_tabinit_init", <<>>)
				from
					i := 1
					nb := type_id_counter.value
				until
					i > nb
				loop
					cl_type := class_types.item (i)
					if cl_type /= Void then
						Initialization_file.generate_extern_declaration ("void", cl_type.id.init_name, <<"void">>)
					end
					i := i + 1
				end


				Initialization_file.putstring ("%Nvoid egc_tabinit_init(void)%N{%N")
				from
					i := 1
					nb := type_id_counter.value
				until
					i > nb
				loop
					cl_type := class_types.item (i)

-- FIXME ???
-- cl_type cannot be Void if process_dynamic_types has been done in
-- freeze_system.
					if cl_type /= Void then
						Initialization_file.putchar ('%T')
						Initialization_file.putstring (cl_type.id.init_name)
						Initialization_file.putstring ("();%N")
					end
					i := i + 1
				end
				Initialization_file.putstring ("}%N%N")

				Initialization_file.generate_function_signature ("void", "egc_einit_init", True, Initialization_file, <<"">>, <<"void">>)

					-- Set C variable `scount'.
				Initialization_file.putstring ("%Tscount = ")
				Initialization_file.putint (type_id_counter.value)
					-- Set C variable `ccount'.
				Initialization_file.putstring (";%N%Tccount = ")
				Initialization_file.putint (class_counter.total_count)
					-- Set C variable `dcount'.
				Initialization_file.putstring (";%N%Tdcount = ")
				Initialization_file.putint (dispatch_table.counter.total_count)
					-- Set the frozen level
				Initialization_file.putstring (";%N%Tzeroc = ")
				Initialization_file.putint (frozen_level)
				Initialization_file.putstring (";%N}%N")
			end

			-- Module initialization routine 'egc_system_mod_init_init'

			-- Declarations



			from
				i  := 1
				nb := type_id_counter.value
			until
				i > nb
			loop
				cl_type := class_types.item (i)

				if cl_type /= Void and then not makefile_generator.empty_class_types.has (cl_type.id) then
					Initialization_file.generate_extern_declaration (
									"void", cl_type.id.module_init_name, <<"void">>
																	)
				end
				i := i + 1
			end



			-- Module initialization
			Initialization_file.generate_function_signature (
				"void", "egc_system_mod_init_init", True, Initialization_file, <<"">>, <<"void">>
															)
			from
				i := 1
				nb := type_id_counter.value
			until
				i > nb
			loop
				cl_type := class_types.item (i)

				if cl_type /= Void and then not makefile_generator.empty_class_types.has (cl_type.id) then
					Initialization_file.putstring ("%T")
					Initialization_file.putstring (cl_type.id.module_init_name)
					Initialization_file.putstring ("();%N")
				end
				i := i + 1
			end

			Initialization_file.putstring ("%N}%N%N")

			Initialization_file.close_c
		end

feature -- Workbench routine info table file generation

	generate_rout_info_table is
		local
			f: INDENT_FILE
		do
			if not byte_context.final_mode then
				f := Rout_info_file
				f.open_write
				Rout_info_table.generate (f)
				f.close
			end
		end

feature --Workbench option file generation

	generate_option_file is
			-- Generate compialtion option file
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			partial_debug: DEBUG_TAG_I
			class_type: CLASS_TYPE
			local_classes: CLASS_C_SERVER
		do
			Option_file.open_write

			Option_file.putstring ("#include %"eif_project.h%"%N%
								   %#include %"eif_struct.h%"%N%N")

				-- First debug keys
			from
				local_classes := classes
				local_classes.start
			until
				local_classes.after
			loop
				class_array := local_classes.item_for_iteration
				nb := class_counter.item (local_classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						partial_debug ?= a_class.debug_level
						if partial_debug /= Void then
							partial_debug.generate_keys (Option_file, a_class.id)
						end
					end
					i := i + 1
				end
				local_classes.forth
			end

				-- Then option C array
			Option_file.putstring ("struct eif_opt egc_foption_init[] = {%N")
			from
				i := 1
				nb := Type_id_counter.value
			until
				i > nb
			loop
				class_type := class_types.item (i)
				Option_file.putchar ('{')
				if class_type /= Void then
						-- Classes could be removed
					a_class := class_type.associated_class
					a_class.assertion_level.generate (Option_file)
					Option_file.putstring (", ")
					a_class.trace_level.generate (Option_file)
					Option_file.putstring (", ")
					a_class.profile_level.generate (Option_file)
					Option_file.putstring (", ")
					a_class.debug_level.generate (Option_file, a_class.id)
				else
					Option_file.putstring ("%
						%(int16) 0, (int16) 0, (int16) 0,%
						%{(int16) 0, (int16) 0, (char **) 0}")
				end
				Option_file.putstring ("},%N")
				i := i + 1
			end
			Option_file.putstring ("};%N")

			Option_file.close
		end

feature 

	process_pass (a_pass: PASS) is
			-- Process `a_pass'
		do
			current_pass := a_pass
			a_pass.execute
		end

	set_current_class (a_class: CLASS_C) is
		do
			current_class := a_class
		end

	in_pass3: BOOLEAN is
			-- Is `pass3' the current pass ?
		do
			Result := (current_pass = pass3_controler)
		end

	System_chunk: INTEGER is 500

feature -- Conveniences

	reset_external_clause is
			-- Reset the external clause
			-- Incrementality of the generated makefile
		do
			c_file_names := Void
			include_paths := Void
			object_file_names := Void
			makefile_names := Void
		end

	set_executable_directory (d: STRING) is
			-- Assign `d' to `executable_directory'.
		do
			executable_directory := d
		end

	set_c_directory (d: STRING) is
			-- Assign `d' to `c_directory'.
		do
			c_directory := d
		end

	set_object_directory (d: STRING) is
			-- Assign `d' to `object_directory'.
		do
			object_directory := d
		end

	reset_generate_clause is
			-- Reset the generate clause
			-- Incrementality of the generated makefile
		do
			executable_directory := Void
			c_directory := Void
			object_directory := Void
		end

	reset_system_level_options is
		do
			remover_off := False
			array_optimization_on := False
			inlining_on := False
			inlining_size := 4
			code_replication_off := True
			exception_stack_managed := False; 
			server_controler.set_block_size (1024)

			do_not_check_vape := False
			address_expression_allowed := False
		end

	set_update_sort (b: BOOLEAN) is
			-- Assign `b' to `update_sort'.
		do
			update_sort := b
		end

	set_max_class_id (i: INTEGER) is
			-- Assign `i' to `max_class_id'.
		do
			max_class_id := i
		end

	root_class: CLASS_I is
			-- Root class of the system
		require
			root_cluster /= Void
			root_class_name /= Void
		do
			Result := root_cluster.classes.item (root_class_name)
		end

feature -- Precompilation

	init_precompilation is
			-- Initialization before a precompilation.
		do
			if not general_class.compiled then
				init
			end
			Workbench.change_all
			private_freeze := True
		end

	save_precompilation_info is
			-- Save usefull values for inclusion of
			-- precompiled code.
		do
			is_precompiled := True
			uses_precompiled := True
			Universe.mark_precompiled
		end

feature -- Log files

	used_features_log_file: USED_FEAT_LOG_FILE
		-- File where the names (Eiffel and encoded) of the used features
		-- are generated

	removed_log_file: REMOVED_FEAT_LOG_FILE
		-- File where the names of the removed features are generated

	open_log_files is
		local
			f_name: FILE_NAME
		do
			if in_final_mode then
					-- removed_log_file is used only in final mode
				!!f_name.make_from_string (Final_generation_path)
				f_name.set_file_name (Removed_log_file_name)
				!!removed_log_file.make (f_name)

				!!f_name.make_from_string (Final_generation_path)
				f_name.set_file_name (Translation_log_file_name)
				!!used_features_log_file.make (f_name)

					-- Files are open using the `write' mode
				removed_log_file.open_write
				used_features_log_file.open_write
			else
				!!f_name.make_from_string (Workbench_generation_path)
				f_name.set_file_name (Translation_log_file_name)
				!!used_features_log_file.make (f_name)

					-- File is open using the `append' mode
					-- (refreezing)
				used_features_log_file.open_append
			end
		end

	close_log_files is
		do
			used_features_log_file.close
			used_features_log_file := Void
			if in_final_mode then
				removed_log_file.close
				removed_log_file := Void
			end
		end

feature -- Debug purpose

	trace is
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
		do
			from
				classes.start
			until
				classes.after
			loop
				class_array := classes.item_for_iteration
				nb := class_counter.item (classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						-- Do nothing. Specific debug
						-- code can be inserted here.
					end
					i := i + 1
				end
				classes.forth
			end
		end

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
		external
			"C"
		end

feature -- Concurrent Eiffel

	Concurrent_eiffel: BOOLEAN is
			-- Can this compiler generate Concurrent Eiffel code?
			--| This should be called only during the initial steps
			--| of the compilation or after retrieving a project
			--| s this can raise an error
		do
			Result := Concurrency_license.licensed
		end

	has_separate: BOOLEAN
			-- Is there a separate declaration in the system?

	set_has_separate is
			-- Set `has_separate' to True.
		require
			concurrent_eiffel_allowed: Concurrent_eiffel
		do
			if not has_separate then
				has_separate := True
					-- We need to link with the Concurrent Eiffel
					-- run-time
				set_freeze
			end
		end

end -- class SYSTEM_I
