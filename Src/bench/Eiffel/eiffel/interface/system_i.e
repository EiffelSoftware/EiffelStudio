indexing
	description: "Internal representation of a system."
	date: "$Date$"
	revision: "$Revision$"

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
	SHARED_GENERATION

	SHARED_ERROR_HANDLER
		export
			{ANY} Error_handler
		end

	SHARED_TIME
	SHARED_CECIL

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		export
			{ANY} byte_context
		end

	SHARED_ARRAY_BYTE
	SHARED_DECLARATIONS
	SHARED_DEGREES
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

	body_index_counter: BODY_INDEX_COUNTER
			-- Body index counter

	feature_as_counter: COMPILER_COUNTER
			-- Counter of instances of FEATURE_AS

	init_counters is
			-- Initialize various counters when using a precompiled library.
		do
				-- Current compilation_id is just the one retrieved from the
				-- precompiled library we are using plus one.
			set_compilation_id (compilation_id + 1)

				-- We just get Current from a precompiled library,
				-- we need to increment the current counters with their
				-- respective precompiled offset for current compilation.
			body_index_counter.append (body_index_counter)
			class_counter.append (class_counter)
			feature_as_counter.append (feature_as_counter)
			routine_id_counter.append (routine_id_counter)
			static_type_id_counter.append (static_type_id_counter)
			server_controler.append (server_controler)
		end

feature -- Properties

	rout_info_table: ROUT_INFO_TABLE
			-- Global routine info table
			-- rout_id --> (origin/offset)

	sorter: CLASS_SORTER
			-- Topological sorter on classes

	type_id_counter: COUNTER
			-- Counter of valid instances of CLASS_TYPE

	class_types: ARRAY [CLASS_TYPE]
			-- Array of class types indexed by their `type_id'

	type_set: SEARCH_TABLE [INTEGER]
			-- Set of the routine ids for which a type table should
			-- be generated

	pattern_table: PATTERN_TABLE
			-- Pattern table

	address_table: ADDRESS_TABLE
			-- Generate encapsulation of function pointers ($ operator)

	successful: BOOLEAN
			-- Was the last recompilation successful?

	has_been_changed: BOOLEAN
			-- Did last recompilation changed data of compiler?

	freeze: BOOLEAN is
			-- Has the system to be frozen again ?
		do
			Result := (not Lace.compile_all_classes or else il_generation)
					and then (private_freeze or else Compilation_modes.is_freezing)
		end

	freezing_occurred: BOOLEAN
			-- Did a freezing of the system occur ?

	history_control: HISTORY_CONTROL
			-- Routine table controler
			-- Only used for final mode code generation.

	instantiator: INSTANTIATOR
			-- Tool to process the generic derivations

	externals: EXTERNALS
	il_c_externals: IL_C_EXTERNALS
			-- Table of external names currently used by the system
			-- First one in normal generation, second one for IL code
			-- generation.

	executable_directory: STRING
			-- Directory for the executable file

	c_directory: STRING
			-- Directory for the generated c files

	object_directory: STRING
			-- Directory for the object files

	first_compilation: BOOLEAN
			-- Is it the first compilation of the system
			-- Used by the time check

	project_creation_time: INTEGER
			-- Time of creation of current project.

	marked_precompiled_classes: BOOLEAN
			-- Is it the first compilation of the system
			-- using a precompiled library?

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

	degree_minus_1: DEGREE_MINUS_1
			-- List of class ids for which a source C compilation is needed
			-- when freezing

	is_conformance_table_melted: BOOLEAN
			-- Is the conformance table melted ?

	melted_parent_table: CHARACTER_ARRAY
			-- Byte array representation of the melted parent
			-- table.
			--| Once melted, it is kept in memory so it won't be re-processed
			--| each time

	nb_frozen_features: INTEGER
			-- Number of frozen features in system.

	body_index_table: ARRAY [INTEGER]
			-- Body index table
			--| Correspondance of generic body index and generic body
			--| id.

	original_body_index_table: ARRAY [INTEGER]
			-- Original body index table.
			-- | Since during second pass, correpondaces between body indexes
			-- | and body ids are changing, the second class must use a
			-- | duplicated one in order to compair versions of a same
			-- | feature.

	execution_table: EXECUTION_TABLE
			-- Execution table

	remover: REMOVER
			-- Dead code removal control

	keep_assertions: BOOLEAN
			-- Are the assertions kept in final mode?

	current_class: CLASS_C
			-- Current processed class

	makefile_generator: MAKEFILE_GENERATOR
			-- Makefile generator.

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

	set_array_make_name (name: STRING) is
			-- Set `name' to `array_make_name'.
		do
			array_make_name := clone (name)
		end

	tuple_make_name: STRING
			-- Name of the C routine corresponding to the
			-- make routine of TUPLE. See also comment above.

	optimization_tables: SEARCH_TABLE [OPTIMIZE_UNIT]
			-- Tables keeping track of flags for loop optimization
			-- Based on the body_index of a feature

	names: NAMES_HEAP
			-- Fast lookup for stored name, to avoid name duplication in memory.

	make is
			-- Create the system.
		do
			set_compilation_id (1)

				-- Creation of all the servers.
			server_make

				-- Creation of the system hash table
			create class_types.make (1, System_chunk)
			create new_classes.make

				-- Creation of a topological sorter
			create sorter.make

				-- Counter creation
			create routine_id_counter.make
			create class_counter.make
			create static_type_id_counter.make
			create body_index_counter.make
			create feature_as_counter.make
			create type_id_counter

				-- Routine table controler creation
			create history_control.make
			create instantiator.make

				-- Type set creation
			create type_set.make (100)

				-- External table creation
			create externals.make
			create il_c_externals.make (10)

				-- Pattern table creation
			create pattern_table.make

				-- Freeze control sets creation
			create degree_minus_1.make

				-- Body index table creation
			create body_index_table.make (0, System_chunk)
			create original_body_index_table.make (1, 0)

				-- Run-time table creation
			create execution_table.make
			create rout_info_table.make (500)
			create optimization_tables.make (300)

				-- Address table
			create address_table.make (100)

				-- Names heap creation
			create names.make
		end

	init is
			-- System initialization
		require
			any_class: any_class /= Void
		local
			local_workbench: WORKBENCH_I
		do
			first_compilation := True

			local_workbench := Workbench

				-- At the very beginning of a session, even class ANY is
				-- not compiled. So we must say to the workbench to compile
				-- classes ANY, DOUBLE... ARRAY
				-- It is very important that these classes were protected.

			if il_generation then
				local_workbench.change_class (system_object_class)
			end
			local_workbench.change_class (any_class)
			local_workbench.change_class (double_class)
			local_workbench.change_class (real_class)
			local_workbench.change_class (integer_8_class)
			local_workbench.change_class (integer_16_class)
			local_workbench.change_class (integer_32_class)
			local_workbench.change_class (integer_64_class)
			local_workbench.change_class (boolean_class)
			local_workbench.change_class (character_class)
			local_workbench.change_class (special_class)
			local_workbench.change_class (pointer_class)
			local_workbench.change_class (array_class)
			local_workbench.change_class (tuple_class)
			local_workbench.change_class (to_special_class)
			local_workbench.change_class (bit_class)
			local_workbench.change_class (routine_class)
			local_workbench.change_class (procedure_class)
			local_workbench.change_class (function_class)

			if not il_generation then
				local_workbench.change_class (wide_char_class)
			else
				local_workbench.change_class (native_array_class)
				local_workbench.change_class (system_string_class)
			end

			local_workbench.change_class (string_class)

			protected_classes_level := string_class.compiled_class.class_id
				-- The root class is not protected 
				-- Godammit.
			local_workbench.change_class (root_class)

			-- Now add classes with visible features.
			add_visible_classes
		end

	mark_only_used_precompiled_classes is
			-- Mark `is_in_system' flag of all 18 basic classes which
			-- are part of a precompiled library of EiffelBase.
		require
			not_is_precompiling: not Compilation_modes.is_precompiling
		do
			marked_precompiled_classes := True

			if il_generation then
				system_object_class.compiled_class.record_precompiled_class_in_system
			end
			any_class.compiled_class.record_precompiled_class_in_system
			double_class.compiled_class.record_precompiled_class_in_system
			real_class.compiled_class.record_precompiled_class_in_system
			integer_8_class.compiled_class.record_precompiled_class_in_system
			integer_16_class.compiled_class.record_precompiled_class_in_system
			integer_32_class.compiled_class.record_precompiled_class_in_system
			integer_64_class.compiled_class.record_precompiled_class_in_system
			boolean_class.compiled_class.record_precompiled_class_in_system
			character_class.compiled_class.record_precompiled_class_in_system
			string_class.compiled_class.record_precompiled_class_in_system
			special_class.compiled_class.record_precompiled_class_in_system
			pointer_class.compiled_class.record_precompiled_class_in_system
			array_class.compiled_class.record_precompiled_class_in_system
			tuple_class.compiled_class.record_precompiled_class_in_system
			to_special_class.compiled_class.record_precompiled_class_in_system
			bit_class.compiled_class.record_precompiled_class_in_system
			routine_class.compiled_class.record_precompiled_class_in_system
			procedure_class.compiled_class.record_precompiled_class_in_system
			function_class.compiled_class.record_precompiled_class_in_system

			if not il_generation then
				wide_char_class.compiled_class.record_precompiled_class_in_system
			else
				native_array_class.compiled_class.record_precompiled_class_in_system
				system_string_class.compiled_class.record_precompiled_class_in_system
			end
		end

	add_visible_classes is
			-- Force visible classes into System
		local
			local_workbench: WORKBENCH_I
			local_universe: UNIVERSE_I
			a_cluster_list: LINKED_LIST [CLUSTER_I]
			a_cluster: CLUSTER_I
			a_class_table: HASH_TABLE [CLASS_I, STRING]
			a_class_i: CLASS_I
			a_visible_i: VISIBLE_I
		do
			local_workbench := Workbench
			local_universe := Universe

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
							-- Add visible class to system if
							-- not in the system yet.
							if not a_class_i.compiled then
								local_workbench.change_class (a_class_i)
							end
						end
					end

					a_class_table.forth
				end

				a_cluster_list.forth
			end
		end

	add_unref_class (a_class: CLASS_I) is
			-- Add `a_class' to list of non-referenced classes
			-- that needs to be compiled.
			-- Force a recompilation of `a_class' for next
			-- compilation of system.
		require
			a_class_not_void: a_class /= Void
		do
				-- Force a recompilation of the system.
			set_melt
			unref_classes.extend (a_class)
		ensure
			unref_classes_updated: unref_classes.has (a_class)
			melt_forced: private_melt
		end

	remove_unref_class (a_class: CLASS_I) is
			-- Remove `a_class' from list of non-referenced classes.
			-- Force a recompilation for next compilation of system
			-- to take into account the change.
		require
			a_class_not_void: a_class /= Void
		do
				-- Force a recompilation of the system.
			set_melt
			unref_classes.prune_all (a_class)
		ensure
			unref_classes_updated: not unref_classes.has (a_class)
			melt_forced: private_melt
		end

	protected_classes_level: INTEGER
			-- Useful for remove_useless_classes
			-- Protected classes are ANY, DOUBLE, REAL,
			-- INTEGER, BOOLEAN, CHARACTER, ARRAY, BIT, POINTER, STRING,
			-- TUPLE, ROUTINE, PROCEDURE, FUNCTION

	insert_new_class (a_class: CLASS_C) is
			-- Add new class `c' to the system.
		require
			good_argument: a_class /= Void
		local
			new_id: INTEGER
		do
			new_id := class_counter.next_id

				-- Give a compiled class a frozen id
			a_class.set_class_id (new_id)
debug ("ACTIVITY")
io.error.putstring ("%TInserting class ")
io.error.putstring (a_class.name)
io.error.putint (new_id)
io.error.new_line
end

				-- Give a class id to class `c' which maybe changed 
				-- during the topological sort of a recompilation.
			a_class.set_topological_id (new_id)
				-- Insert the class
			classes.put (a_class, new_id)

				-- Update control flags of the topological sort
			moved := True

				-- Update the freeze control list: the class can have no
				-- features written in it (like ANY) and then not be
				-- included in Degree 1 after the Degree 4 and so
				-- not been generated. (we need a source file even if the
				-- class is empty in terms of features written in it.).
			Degree_1.insert_class (a_class)
		ensure
			class_id_set: a_class.class_id /= 0
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
		do
			internal_remove_class (a_class, 0)
		end

	class_of_id (id: INTEGER): CLASS_C is
			-- Class of id `id'
		require
			id_not_void: id /= 0
		do
			Result := classes.item (id)
debug ("CLASS_OF_ID")
io.error.putstring ("Class of id ")
io.error.putint (id)
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

				-- If status of compilation is successful, copy
				-- a duplication of the body index table in
				-- `origin_body_index_table' and re-initialize the
				-- melted set of feature tables.
			if successful then
					-- Important Note
					-- There are other references in the system to "THE" 
					-- Original Body Index table (Namely through onces)
					-- We CANNOT do a simple assignment of twin. We need 
					-- to ensure that the object remains the same troughout 
					-- a session. If you want to change it, think thoroughly
					-- before! (Dino, that's an allusion to you, -- FRED)
				original_body_index_table.copy (body_index_table)
				Degree_1.wipe_out
			end
		end

	change_classes is
			-- Mark classes to be recompiled.
		do
			if not any_class.compiled then
					-- First compilation.
				init
			else
				if
					not marked_precompiled_classes and then
					not Compilation_modes.is_precompiling and then uses_precompiled
				then
					mark_only_used_precompiled_classes
				end
				if root_class.compiled_class = Void then
					-- If root_class is not compiled (i.e. root class has
					-- changed since last compilaton), insert it in the
					-- changed_classes.
					Workbench.change_class (root_class)
					add_visible_classes
				else
					add_visible_classes
				end
			end
			if Lace.compile_all_classes then
					-- `None' is specified as the root class
				Workbench.change_all_new_classes
			end
		end

feature -- default_rescue routine

	default_rescue_id: INTEGER is
			-- Routine id of default rescue from ANY.
			-- Return 0 if ANY has not been compiled or
			-- does not have a feature named `default_rescue'.
		local
			feature_i: FEATURE_I
		once
			if any_class /= Void and then
					any_class.compiled_class /= Void then
				feature_i := any_class.compiled_class.
					feature_table.item_id (names.default_rescue_name_id)
				if feature_i /= Void then
					Result := feature_i.rout_id_set.first
				end
			end
		end

feature -- default_create routine

	default_create_id: INTEGER is
			-- Routine id of default create from ANY.
			-- Return 0 if ANY has not been compiled or
			-- does not have a feature named `default_create'.
		local
			feature_i: FEATURE_I
		once
			if any_class /= Void and then
					any_class.compiled_class /= Void then
				feature_i := any_class.compiled_class.
					feature_table.item_id (names.default_create_name_id)
				if feature_i /= Void then
					Result := feature_i.rout_id_set.first
				end
			end
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
				create precomp_r
				precomp_r.check_version_number
			end

			has_been_changed := False
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
		do
				-- Recompilation initialization
			if Compilation_modes.is_precompiling then
				init_precompilation
			else
				init_recompilation
			end

			if first_compilation then
				project_creation_time := current_time
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
					Degree_5.is_empty)
			end

				-- Syntax analysis: This maybe add new classes to
				-- the system (degree 5)
			if
				first_compilation or else freeze or else private_melt or else
				not Degree_5.is_empty or else
				not Degree_4.is_empty or else
				not Degree_3.is_empty or else
				not Degree_2.is_empty
			then
					-- We compiled something we need to save project file.
				has_been_changed := True

					-- Perform parsing of Eiffel code
				process_degree_5

debug ("ACTIVITY")
	io.error.putstring ("%Tnew_class = ")
	io.error.putbool (new_class)
	io.error.new_line
end
					-- Check generic validity on old classes
					-- generic parameters cannot be new classes
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

debug ("ACTIVITY")
	io.error.putstring ("%Tmoved = ")
	io.error.putbool (moved)
	io.error.putstring ("%N%Tupdate_sort = ")
	io.error.putbool (update_sort)
	io.error.new_line
end
					-- Topological sort and building of the conformance
					-- table (if new classes have been added by first pass)
				update_sort := update_sort or else moved
				if update_sort then
						-- Sort
					sorter.sort
						-- Check sum error
					Error_handler.checksum
						-- Re-sort the list of classes because the topological
						-- sort modified the topological ids.
					classes.sort
					reset_conformance_table
					build_conformance_table

						-- Clear the topo sorter
					sorter.clear

					reset_melted_conformance_table
				end
					-- Inheritance analysis: `Degree_4' is sorted by class 
					-- topological ids so the parent come first the heirs after.
				process_degree_4

				if
					not Compilation_modes.is_precompiling and
					not Lace.compile_all_classes
				then
					root_class_c.check_root_class_creators
				end

					-- Byte code production and type checking
				process_degree_3

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

					-- Reset `Memory_descendants' since they can have changed
					--| Note: That is important to recompute it, especially if
					--| someone removed an inheritance link to MEMORY.
				reset_memory_descendants

					-- Melt the changed features
				melt

					-- Finalize a successful compilation
				finish_compilation

					-- Produce the update file
				private_melt := False
				if not il_generation and then not freeze then
					Degree_output.put_melting_changes_message

						-- Create a non-empty melted file
					make_update (False)
debug ("VERBOSE")
	io.error.putstring ("Saving melted.eif%N")
end
				end
			end
			if not il_generation and then freeze then
				Degree_output.put_freezing_message
				freeze_system
				private_freeze := False
			end
			if il_generation then
				generate_il
			end
			first_compilation := False
		end

	process_degree_5 is
			-- Process Degree 5.
			-- Syntax analysis: This may add new classes to system.
			-- Unref classes analyzis: This may add new classes to system.
		local
			class_i: CLASS_I
		do
				-- Force unref classes to be compiled with Current system.
			from
				unref_classes.start
			until
				unref_classes.after
			loop
				class_i := unref_classes.item
				if class_i.compiled_class = Void then
					Workbench.change_class (class_i)
				end
				unref_classes.forth
			end
				
				-- Launch syntax analyzis of modified/added classes to system.
			Degree_5.execute
		end

	process_degree_4 is
			-- Process Degree 4.
			-- Inheritance analysis: `Degree_4' is sorted by class 
			-- topological ids so parents come first heirs after.
		do
			Degree_4.execute
		end

	process_degree_3 is
			-- Process Degree 3.
			-- Byte code production and type checking.
		do
			in_pass3 := True
			Degree_3.execute
			in_pass3 := False
		rescue
			in_pass3 := False
		end

	process_degree_2 is
			-- Process Degree 2.
			-- Melt features (write feature byte code on disk).
		do
			Degree_2.execute
		end

	process_degree_1 is
			-- Process Degree 1.
			-- Melt the feature tables.
			-- Open first the file for writing on disk melted feature
			-- tables.
		do
			Degree_1.execute
		end

	process_degree_minus_1 is
			-- Process Degree -1.
			-- Freeze system: generate C files.
		do
			Degree_minus_1.execute
		end

	check_generics is
			-- Check generic validity on old classes
			-- generic parameters cannot be new classes
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
		do
debug ("ACTIVITY")
	io.error.putstring ("Check generics%N")
end
			class_array := classes
			nb := class_counter.count
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
			Error_handler.checksum
		end

	remove_useless_classes is
			-- Remove useless classes.
		local
			a_class: CLASS_C
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			root_class_c: CLASS_C
			marked_classes: SEARCH_TABLE [INTEGER]
		do
				-- First mark all the classes that can be reached
				-- from the root class
			create marked_classes.make (System_chunk)

			root_class_c := root_class.compiled_class
			root_class_c.mark_class (marked_classes)

			if il_generation then
				system_object_class.compiled_class.mark_class (marked_classes)
			end
			any_class.compiled_class.mark_class (marked_classes)
			double_class.compiled_class.mark_class (marked_classes)
			real_class.compiled_class.mark_class (marked_classes)
			integer_8_class.compiled_class.mark_class (marked_classes)
			integer_16_class.compiled_class.mark_class (marked_classes)
			integer_32_class.compiled_class.mark_class (marked_classes)
			integer_64_class.compiled_class.mark_class (marked_classes)
			boolean_class.compiled_class.mark_class (marked_classes)
			character_class.compiled_class.mark_class (marked_classes)
			string_class.compiled_class.mark_class (marked_classes)
			special_class.compiled_class.mark_class (marked_classes)
			pointer_class.compiled_class.mark_class (marked_classes)
			array_class.compiled_class.mark_class (marked_classes)
			tuple_class.compiled_class.mark_class (marked_classes)
			to_special_class.compiled_class.mark_class (marked_classes)
			bit_class.compiled_class.mark_class (marked_classes)
			routine_class.compiled_class.mark_class (marked_classes)
			procedure_class.compiled_class.mark_class (marked_classes)
			function_class.compiled_class.mark_class (marked_classes)

			if not il_generation then
				wide_char_class.compiled_class.mark_class (marked_classes)
			else
				native_array_class.compiled_class.mark_class (marked_classes)
				system_string_class.compiled_class.mark_class (marked_classes)
			end

				-- Now mark all classes reachable from `unref_classes'.
			from
				unref_classes.start
			until
				unref_classes.after
			loop
				check
					unref_class_compiled:
						unref_classes.item.compiled_class /= Void
				end
				unref_classes.item.compiled_class.mark_class (marked_classes)
				unref_classes.forth
			end

				-- Now mark all classes reachable from visible classes.
			from
				class_array := classes
				nb := class_counter.count
				i := 1
			until
				i > nb
			loop
				a_class := class_array.item (i)

				if a_class /= Void and then
						a_class.has_visible and then
							not marked_classes.has (a_class.class_id) then
					a_class.mark_class (marked_classes)
				end
				i := i + 1
			end

				-- Remove all the classes that cannot be reached if they are
				-- not protected
			from
				i := 1
			until
				i > nb
			loop
				a_class := class_array.item (i)

				if
					a_class /= Void and then
					not marked_classes.has (a_class.class_id)
				then
debug ("REMOVE_CLASS")
io.error.putstring ("Remove useless classes: ")
io.error.putstring (a_class.name)
io.error.new_line
end
						-- Recursively remove `a_class' from system.
					remove_class (a_class)
				end
				i := i + 1
			end
			Error_handler.checksum
		end

	reset_conformance_table is
			-- Reset all conformance tables.
		local
			a_class: CLASS_C
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
		do
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void then
					a_class.reset_dep_classes
				end
				i := i + 1
			end
		end

	build_conformance_table is
			-- Build the conformance table
		local
			a_class: CLASS_C
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
		do
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void then
					a_class.fill_conformance_table
				end
				i := i + 1
			end
		end

	process_type_system is
			-- Compute the type system
		local
			old_value: INTEGER
		do
			old_value := type_id_counter.value
				-- Initialize types of non-generic classes.
			Degree_2.initialize_non_generic_types
				-- For generic classes, compute the types.
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
			compile_all_classes: BOOLEAN
		do
			compile_all_classes := Compilation_modes.is_precompiling or Lace.compile_all_classes
			Degree_2.process_skeleton (compile_all_classes)
				-- Check expanded client relation.
			check_expanded
				-- Check sum error.
			Error_handler.checksum
		end

	check_vtec is
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
		do
			class_array := classes
			nb := class_counter.count
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
		end

	check_expanded is
			-- Check expanded client relation
		do
			Degree_2.check_expanded (has_expanded)
		end

	melt is
			-- Melt the changed features and feature and
			-- descriptor tables in the system.
		require
			no_error: not Error_handler.has_error
		do
				-- Melt features
				-- Open the file for writing on disk feature byte code
			process_degree_2

				-- The execution table are now updated.

			if not il_generation and then not freeze then
					-- Melt the feature tables
					-- Open first the file for writing on disk melted feature
					-- tables
				process_degree_1
			end
				-- Transfer classes of Degree 1 into Degree -1 so that
				-- next time we will freeze, all the melted classes will
				-- be in `Degree_minus_1'.
			Degree_1.transfer_to (Degree_minus_1)
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
			rout_id: INTEGER
			melted_file: RAW_FILE
			file_name: FILE_NAME
			name: STRING
			precomp_makefile: PRECOMP_MAKER
		do
debug ("ACTIVITY")
	io.error.putstring ("Updating system_name.eif%N")
end
			if empty then
					-- We are generating an empty melted file, this means that
					-- we froze our system.
				name := clone (system_name)
			else
					-- Find the correct melted name when there is no freeze
					--
					-- When there is no precompiled library, we need to use the `system_name'.
					-- When there is one, we need to check if a freeze occurred during
					-- the life cycle of the project, this can be detected by checking the
					-- type of `makefile_generator' which should be either WKBENCH_MAKER or
					-- FINAL_MAKER.
				precomp_makefile ?= makefile_generator
				if precomp_makefile = Void then
						-- We already froze our project, so we can keep `system_name'
					name := clone (system_name)
				else
					check
						Uses_precompiled_library: Workbench.precompiled_directories /= Void	
						Not_multiple_precompiled: Workbench.precompiled_directories.count = 1
					end
					name := clone (Workbench.melted_file_name)
				end	
			end
			name.append (".melted")
			create file_name.make_from_string (Workbench_generation_path)
			file_name.set_file_name (name)
			create melted_file.make_open_write (file_name)

				-- There is something to update
			if empty then
				melted_file.putchar ('%/000/')
			else
				melted_file.putchar ('%/001/')
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
					rout_info := rout_info_table.item (rout_id)
					rcorigin := rout_info.origin
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
				write_int (file_pointer, class_counter.count)
					-- Write the profiler status
				if Lace.ace_options.has_profile then
					write_int (file_pointer, 3)
				else
					write_int (file_pointer, 0)
				end
				make_update_feature_tables (melted_file)
				make_update_rout_id_arrays (melted_file)
					-- Open the file for reading byte code for melted features
					-- Update the execution table
				Execution_table.make_update (melted_file)
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
		do
			Degree_minus_1.make_update_feature_tables (file)
		end

	make_update_rout_id_arrays (file: RAW_FILE) is
			-- Write the melted routine id arrays into `file'.
		require
			file_not_void: file /= Void
			file_open_write: file.is_open_write
		local
			class_id: INTEGER
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
io.error.putint (class_id)
io.error.putstring (class_of_id (class_id).name)
io.error.new_line
end
				write_int (file_pointer, class_id)
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
					write_int (file_pointer, cl_type.static_type_id - 1)
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
			class_id: INTEGER
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
			melted_parent_table := Void
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

					create_cecil_tables
					Cecil2.make_byte_code (Byte_array)
					Cecil3.make_byte_code (Byte_array)

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
			mem: MEMORY
		do
				-- Reinitialization of control flags of the topological
				-- sort.
			update_sort := False
			moved := False

				-- Reset the classes as unchanged
			class_array := classes
			nb := class_counter.count
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

				-- Update servers
			Feat_tbl_server.take_control (Tmp_feat_tbl_server)
			Tmp_body_server.finalize
			Tmp_inv_ast_server.finalize
			Ast_server.take_control (Tmp_ast_server)
			Class_info_server.take_control (Tmp_class_info_server)
			Byte_server.take_control (Tmp_byte_server)
			Inv_byte_server.take_control (Tmp_inv_byte_server)
			Depend_server.take_control (Tmp_depend_server)
			M_feat_tbl_server.take_control (Tmp_m_feat_tbl_server)
			M_feature_server.take_control (Tmp_m_feature_server)
			M_rout_id_server.take_control (Tmp_m_rout_id_server)
			M_desc_server.take_control (Tmp_m_desc_server)
			Class_comments_server.take_control (Tmp_class_comments_server)

				-- Clean Memory
			create mem
			mem.full_collect
			mem.full_coalesce
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code
		require
			il_generation: il_generation
		local
			il_generator: IL_GENERATOR
		do
			create il_generator.make (Degree_output)
			il_generator.generate
			if il_c_externals.count > 0 then
				if in_final_mode then
					create {FINAL_MAKER} makefile_generator.make
				else
					create {WBENCH_MAKER} makefile_generator.make
				end
				open_log_files
				freezing_occurred := True
				il_c_externals.generate_il
				close_log_files

				makefile_generator.generate_il
			end
		end

feature -- Freeezing

	freeze_system is
			-- Worrkbench C code generation
		require
			root_class.compiled
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
				-- Rebuild the execution table
			shake

				-- Generation of the descriptor tables
			process_degree_minus_1
			m_desc_server.clear
			generate_main_eiffel_files
		end

	generate_main_eiffel_files is
			-- Generate the "e*.c" files.
		local
			deg_output: DEGREE_OUTPUT
			t: AUXILIARY_FILES
			degree_message: STRING
		do
			create t.make (Current, byte_context)
			degree_message := "Generation of auxiliary files"
			deg_output := Degree_output

			deg_output.display_degree_output (degree_message, 10, 10)
			generate_cecil

			deg_output.display_degree_output (degree_message, 9, 10)
			generate_skeletons

			deg_output.display_degree_output (degree_message, 8, 10)
			generate_parent_tables
			is_conformance_table_melted := False
			melted_parent_table      := Void

			deg_output.display_degree_output (degree_message, 7, 10)
			t.generate_plug

			deg_output.display_degree_output (degree_message, 6, 10)
			t.generate_dynamic_lib_file

			deg_output.display_degree_output (degree_message, 5, 10)
			generate_init_file

			deg_output.display_degree_output (degree_message, 4, 10)
			generate_option_file
			address_table.generate (False)

			deg_output.display_degree_output (degree_message, 3, 10)
			generate_rout_info_table

			deg_output.display_degree_output (degree_message, 2, 10)
			generate_pattern_table

			deg_output.display_degree_output (degree_message, 1, 10)
			execution_table.generate
				-- Empty melted list of execution table
			execution_table.freeze

			deg_output.display_degree_output (degree_message, 0, 10)
			t.generate_make_file

				-- Create an empty update file ("melted.eif")
			make_update (True)
		end

	shake is
		local
			exec_unit: EXECUTION_UNIT
			external_unit: EXT_EXECUTION_UNIT
			info: EXTERNAL_INFO
			exec_table: EXECUTION_TABLE
		do
				-- Compress execution table
			exec_table := execution_table

			if not first_compilation then
				exec_table.shake
			end

			from
				exec_table.start
			until
				exec_table.after
			loop
				exec_unit := exec_table.item_for_iteration
				if exec_unit.is_external then
					external_unit ?= exec_unit
					check
						externals.has (external_unit.external_name_id)
					end
					info := externals.item (external_unit.external_name_id)
					info.set_execution_unit (external_unit)
				end
				exec_table.forth
			end

				-- Reset the frozen level since the execution table
				-- is re-built now.
			nb_frozen_features := exec_table.nb_frozen_features

				-- Freeze the external table: reset the real body ids,
				-- remove all unused externals and make the duplication
			externals.freeze
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
			mem: MEMORY
			retried: BOOLEAN
		do
			if not retried and is_finalization_needed then
					-- Set `Server_control' to remove right away extra unused
					-- files (especially done for the TMP_POLY_SERVER).
				Server_controler.set_remove_right_away (True)

					-- Initialize `TMP_POLY_SERVER' and `TMP_OPT_BYTE_SERVER'
				Tmp_poly_server.make
				Tmp_opt_byte_server.make

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

				process_degree_minus_2
				
					-- Clean Memory
				create mem
				mem.full_collect
				mem.full_coalesce

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
				Eiffel_table.start_degree_minus_3 (History_control.max_rout_id)
				process_degree_minus_3
				Eiffel_table.finish_degree_minus_3

				generate_main_finalized_eiffel_files

					-- Clean Eiffel table
				Eiffel_table.wipe_out
				Tmp_poly_server.clear
				Tmp_opt_byte_server.clear

				remover := Void

					-- Set `Server_control' not to remove right away extra unused
					-- files (especially done for the TMP_POLY_SERVER, but since we
					-- are back now to a normal compilation we should not remove the
					-- useless files).
				Server_controler.set_remove_right_away (False)

					-- Restore previous value
				remover_off := old_remover_off
				exception_stack_managed := old_exception_stack_managed
				inlining_on := old_inlining_on
				array_optimization_on := old_array_optimization_on

					-- Clean `finalization_needed' tag from all CLASS_C
				clean_finalization_tag
				private_finalize := False
			end
		rescue
				-- Clean the servers if the finalization is aborted
			Tmp_poly_server.flush
			Tmp_poly_server.clear
			Tmp_opt_byte_server.flush
			Tmp_opt_byte_server.clear
			successful := False
			if rescue_status.is_error_exception then
				retried := True
				if not compilation_modes.is_precompiling then
					compilation_modes.reset_modes
				end
				rescue_status.set_is_error_exception (False)
				error_handler.trace
				set_current_class (Void)
				retry
			end
		end

feature {NONE} -- Implementation

	internal_remove_class (a_class: CLASS_C; a_depth: INTEGER) is
			-- Remove class `a_class' from the system even if
			-- it has syntactical_clients.
		require
			 good_argument: a_class /= Void
			 valid_depth: a_depth >= 0
		local
			compiled_root_class: CLASS_C
			supplier: CLASS_C
			supplier_clients: LINKED_LIST [CLASS_C]
			related_classes: LINKED_SET [CLASS_C]
			finished: BOOLEAN
			ftable: FEATURE_TABLE
			id: INTEGER
			types: TYPE_LIST
			f: FEATURE_I
			ext: EXTERNAL_I
		do
			if a_class.is_removable then
					-- Force a recompilation
				set_melt

					-- Remove class from `unref_classes' if it is referenced.
					-- It is only done if class is directly removed. Removing
					-- `a_class' does not remove any subclasses from `unref_classes',
					-- so that they are recompiled back
				if a_depth = 0 then
					unref_classes.prune_all (a_class.lace_class)
				end

				id := a_class.class_id

				a_class.remove_c_generated_files

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
						if f.is_c_external and then f.written_in = id then
							ext ?= f
								-- If the external is encapsulated then it was not added to
								-- the list of new externals in inherit_table. Same thing
								-- if it has to be removed
							if not ext.encapsulated then
								Externals.remove_occurrence (ext.external_name_id)
							end
						end
						ftable.forth
					end
				end

				if il_generation then
					Il_c_externals.remove (id)
				end

					-- Remove class `a_class' from the lists of changed classes
				Degree_5.remove_class (a_class)
				Degree_4.remove_class (a_class)
				Degree_3.remove_class (a_class)
				Degree_2.remove_class (a_class)

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
				Inv_byte_server.remove (id)
				Ast_server.remove (id)
				Feat_tbl_server.remove (id)
				Class_info_server.remove (id)
				Inv_ast_server.remove (id)
				Depend_server.remove (id)
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
				Tmp_inv_ast_server.remove (id)
				Tmp_depend_server.remove (id)
				Tmp_m_rout_id_server.remove (id)
				Tmp_m_desc_server.remove (id)

				Degree_1.remove_class (a_class)
				Degree_minus_1.remove_class (a_class)
				classes.remove (id)

					-- Create linked_set of classes that depends on current class.
					-- We use `syntactical_suppliers', `syntactical_clients' and `clients'.
				from
					a_class.syntactical_suppliers.start
					a_class.syntactical_clients.start
					a_class.clients.start
					create related_classes.make
				until
					finished
				loop
					finished := True
					if not a_class.syntactical_suppliers.after then
						supplier := a_class.syntactical_suppliers.item.supplier
						related_classes.extend (supplier)
						supplier.suppliers.remove_class (a_class)
						a_class.syntactical_suppliers.forth
						finished := False
					end
					if not a_class.syntactical_clients.after then
						supplier := a_class.syntactical_clients.item
						related_classes.extend (supplier)
						supplier.suppliers.remove_class (a_class)
						a_class.syntactical_clients.forth
						finished := False
					end
					if not a_class.clients.after then
						supplier := a_class.clients.item
						related_classes.extend (supplier)
						supplier.suppliers.remove_class (a_class)
						a_class.clients.forth
						finished := False
					end
				end

					-- Remove supplier/clients syntactical relations of `a_class'
					-- and remove classes recursively if needed.
				from
					related_classes.start
					if root_class /= Void then
						compiled_root_class := root_class.compiled_class
					end
				until
					related_classes.after
				loop
					supplier := related_classes.item

						-- Remove from `syntactical_clients'
					supplier_clients := supplier.syntactical_clients
					supplier_clients.start
					supplier_clients.compare_references
					supplier_clients.search (a_class)
					if not supplier_clients.after then
						supplier_clients.remove
					end

					if
						supplier_clients.is_empty and then
							-- The root class is not removed
							-- true only if the root class has changed and
							-- was a client for a removed class
						supplier /= compiled_root_class and then
							-- Cannot propagate for a protected class
						supplier.class_id > protected_classes_level and then
							-- A recursion may occur when removing a cluster
						class_of_id (supplier.class_id) /= Void
					then
							-- Recursively remove class.
						internal_remove_class (supplier, a_depth + 1)
					elseif supplier.has_dep_class (a_class) then
							-- Is it enough to remove the dependecies only on a class
							-- which is still in the system, or should we do it for
							-- all the classes even the ones that we just removed from
							-- the system? In the last case, we should put the previous
							-- test one level up.
						supplier.remove_dep_class (a_class)
					end

					related_classes.forth
				end
			end
		end

feature {NONE} -- Finalization implementation

	is_finalization_needed: BOOLEAN is
			-- Has system not yet be finalized or has system
			-- changed since last finalization.
		local
			a_class: CLASS_C
			i, j, nb: INTEGER
			class_array: ARRAY [CLASS_C]
		do
			Result := private_finalize
			if not Result and then not il_generation then
				i := classes.count
				class_array := classes
				nb := class_counter.count
				from
					j := 1
				until
					Result or j > nb
				loop
					a_class := class_array.item (j)
						-- Since a class can be removed, test if `a_class'
						-- is not Void.
					Result := a_class /= Void and then
						((not a_class.is_precompiled or a_class.is_in_system)
						and a_class.finalization_needed)
					j := j + 1
				end
			end
		end

	clean_finalization_tag is
			-- Reset all CLASS_C.finalization_needed to False.
		local
			a_class: CLASS_C
			i, j, nb: INTEGER
			class_array: ARRAY [CLASS_C]
		do
			i := classes.count
			class_array := classes
			nb := class_counter.count
			from
				j := 1
			until
				j > nb
			loop
				a_class := class_array.item (j)
					-- Since a class can be removed, test if `a_class'
					-- is not Void.
				if
					a_class /= Void and then
					(not a_class.is_precompiled or a_class.is_in_system)
				then
					a_class.set_finalization_needed (False)
				end
				j := j + 1
			end
		end

	process_degree_minus_2 is
			-- Process Degree -2.
		local
			a_class: CLASS_C
			i, j, nb: INTEGER
			deg_output: DEGREE_OUTPUT
			class_array: ARRAY [CLASS_C]
		do
			i := classes.count
			deg_output := Degree_output
			deg_output.put_start_degree (-2, i)
			class_array := classes
			nb := class_counter.count
			from
				j := 1
			until
				j > nb
			loop
				a_class := class_array.item (j)
					-- Since a class can be removed, test if `a_class'
					-- is not Void.
				if a_class /= Void then
					if not a_class.is_precompiled or else a_class.is_in_system then
						deg_output.put_degree_minus_2 (a_class, i)
						a_class.process_polymorphism
						History_control.check_overload
					end
					i := i - 1
				end
				j := j + 1
			end

			History_control.transfer
			tmp_poly_server.flush
			deg_output.put_end_degree
		end

	process_degree_minus_3 is
			-- Process Degree -3.
			-- Generation of C files associated to the classes of
			-- the system.
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			j: INTEGER
			deg_output: DEGREE_OUTPUT
		do
			Eiffel_project.delete_f_code_content (Void, Void) -- No agent
			!FINAL_MAKER! makefile_generator.make
			open_log_files
			j := classes.count
			deg_output := Degree_output
			deg_output.put_start_degree (-3, j)
			class_array := classes
			nb := class_counter.count
			from
				i := 1
			until
				i > nb
			loop
				a_class := class_array.item (i)
					-- Since a class can be removed, test if `a_class´
					-- is not Void.
				if a_class /= Void then
					if not a_class.is_precompiled or else a_class.is_in_system then
						deg_output.put_degree_minus_3 (a_class, j)
						current_class := a_class
						a_class.pass4
					end
					j := j - 1
				end
				i := i + 1
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
		do
			create remover.make

			if array_optimization_on then
				remover.record_array_descendants
			end

				-- First, inspection of the Eiffel code
			if creation_name /= Void then
				a_class := root_class.compiled_class
				root_feat := a_class.feature_table.item (creation_name)
				remover.record (root_feat, a_class)
			end

			remover.mark_dispose
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if
					a_class /= Void and then
					(not a_class.is_precompiled or else a_class.is_in_system)
				then
					if a_class.visible_level.has_visible then
						a_class.mark_visible (remover)
					end
				end
				i := i + 1
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

				-- Protection of `make' from ARRAY
			array_class.compiled_class.mark_all_used (remover)

				-- Protection of feature `make' of class STRING
			string_class.compiled_class.mark_all_used (remover)

				-- Protection of feature `make' of class TUPLE
			tuple_class.compiled_class.mark_all_used (remover)

				-- Protection of features in ROUTINE classes
			routine_class.compiled_class.mark_all_used (remover)
			procedure_class.compiled_class.mark_all_used (remover)
			function_class.compiled_class.mark_all_used (remover)
debug ("DEAD_CODE")
			remover.dump_alive
			remover.dump_marked
end
		end

	is_used (f: FEATURE_I): BOOLEAN is
			-- Is feature `f' used in the system ?
		require
			good_argument: f /= Void
		do
			Result := remover_off or else remover.is_alive (f.body_index)
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
			create t.make (Current, byte_context)
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

				-- Cecil structures generation
			deg_output.display_degree_output (degree_message, 7, 10)
			generate_cecil

				-- Generation of the skeletons
			deg_output.display_degree_output (degree_message, 6, 10)
			generate_skeletons

				-- Generation of the parent table
			deg_output.display_degree_output (degree_message, 5, 10)
			generate_parent_tables
	
				-- Generate plug with run-time.
				-- Has to be done before `generate_routine_table' because
				-- this is were we mark `used' the attribute table of `lower' and
				-- `area' used with `array_optimization'.
			deg_output.display_degree_output (degree_message, 4, 10)
			t.generate_plug

				-- Routine table generation
			deg_output.display_degree_output (degree_message, 3, 10)
			generate_routine_table

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
		do
				-- First re-process all the type id of instances of
				-- CLASS_TYPE available in attribute list `types' of
				-- instances of CLASS_C

debug ("ACTIVITY")
	io.error.putstring ("Process dynamic types%N")
end
				-- Sort the class_list by type id in `class_list'.
			create class_list.make (1, max_class_id)
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void then
					class_list.put (a_class, a_class.topological_id)
				end
				i := i + 1
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
	io.error.putint (class_type.static_type_id)
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
			table: POLY_TABLE [ENTRY]
			used: SEARCH_TABLE [INTEGER]
		do
			Attr_generator.init (generation_buffer)
			Rout_generator.init (header_generation_buffer)

			from
				used := Eiffel_table.used
				used.start
			until
				used.after
			loop
				table := Tmp_poly_server.item (used.item_for_iteration)
				table.write
				used.forth
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
			size_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
			from
					-- Clear buffer for current generation
				buffer := generation_buffer
				buffer.clear_all

				i := 1
				nb := type_id_counter.value
				buffer.putstring ("#include %"eif_macros.h%"%N%
								%#include %"eif_malloc.h%"%N%
								%%Nlong egc_fsize_init[] = {%N")
			until
				i > nb
			loop
				class_type := class_types.item (i)

				if class_type /= Void then
					class_type.skeleton.generate_size (buffer)
				else
					-- FIXME
					-- Process_dynamic_types has been TEMPORARILY removed
					buffer.putstring ("0")
				end

				buffer.putstring (",%N")
				i := i + 1
			end
			buffer.putstring ("};%N")

			create size_file.make_c_code_file (x_gen_file_name (byte_context.final_mode, Esize))
			size_file.put_string (buffer)
			size_file.close
		end

	generate_reference_table is
			-- Generate the table of reference number per type.
		local
			i, nb, nb_ref, nb_exp: INTEGER
			class_type: CLASS_TYPE
			skeleton: SKELETON
			reference_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
			from
					-- Clear buffer for current generation
				buffer := generation_buffer
				buffer.clear_all

				i := 1
				nb := type_id_counter.value
				buffer.putstring ("%Nlong egc_fnbref_init[] = {%N")
			until
				i > nb
			loop
				class_type := class_types.item (i)

				if class_type /= Void then
					skeleton := class_type.skeleton
					nb_ref := skeleton.nb_reference
					nb_exp := skeleton.nb_expanded
					buffer.putint (nb_ref + nb_exp)
				else
					-- FIXME process_dynamic_types TEMPORARILY removed
					buffer.putint (0)
				end

				buffer.putstring (",%N")
				i := i + 1
			end
			if has_separate then
				buffer.putint (0)
			end
			buffer.putstring ("%N};%N")

			create reference_file.make_c_code_file (final_file_name (Eref, Dot_c, 1));
			reference_file.put_string (buffer)
			reference_file.close
		end

	generate_parent_tables is
			-- Generates parent tables.
		local
			i, nb, cid: INTEGER;
			cl_type: CLASS_TYPE;
			parents_file: INDENT_FILE;
			final_mode: BOOLEAN;
			max_id: INTEGER;
			used_ids: ARRAY [BOOLEAN]
			buffer: GENERATION_BUFFER
		do
				-- Clear buffer for current generation
			buffer := generation_buffer
			buffer.clear_all

			final_mode := byte_context.final_mode;

			buffer.putstring ("#include %"eif_eiffel.h%"%N%N");

			buffer.start_c_specific_code
			
			max_id := 0;

			from
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				if cl_type /= Void then
					cl_type.generate_parent_table (buffer, final_mode);
					cid := cl_type.type.generated_id (final_mode);

					if cid <= -256 then
							-- Expanded reference
						cid := -256-cid
					end

					if cid > max_id then
						max_id := cid;
					end
				end;
				i := i + 1;
			end;

			-- Now create 'used_ids' array and fill it

			create used_ids.make (0, max_id);

			from
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				if cl_type /= Void then
					cid := cl_type.type.generated_id (final_mode);

					if cid <= -256 then
							-- Expanded reference
						cid := -256-cid
					end
					used_ids.put (True, cid);
				end;
				i := i + 1;
			end;

			buffer.putstring ("int    egc_partab_size_init = ")
			buffer.putint (max_id);
			buffer.putstring (";%N");
			buffer.putstring ("struct eif_par_types *egc_partab_init[] = {%N");

			from
				i := 0
			until
				i > max_id
			loop
				if used_ids.item (i) then
					buffer.putstring ("&par");
					buffer.putint (i);
				else
					buffer.putstring ("(struct eif_par_types *)0");
				end;
				buffer.putstring (",%N");
				i := i + 1;
			end;
			buffer.putstring ("(struct eif_par_types *)0};%N");
			buffer.end_c_specific_code

			create parents_file.make_c_code_file (gen_file_name (final_mode, Eparents));
			parents_file.put_string (buffer)
			parents_file.close;
		end;

	generate_skeletons is
			-- Generate skeletons of class types
		local
			class_array: ARRAY [CLASS_C]
			j, i, nb, id: INTEGER
			cl_type: CLASS_TYPE
			a_class: CLASS_C
			final_mode: BOOLEAN
			types: TYPE_LIST
				-- cltype_array is indexed by `id' not by `type_id'
				-- as `class_types'
			cltype_array: ARRAY [CLASS_TYPE]
			skeleton_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
			nb := Type_id_counter.value
			final_mode := byte_context.final_mode

				-- Since generated file `eskelet.[cx]' can be very big 
				-- every 500K we write onto disk.
			create skeleton_file.make_c_code_file (x_gen_file_name (final_mode, Eskelet));

			buffer := generation_buffer
			buffer.clear_all

			buffer.putstring ("#include %"eif_project.h%"%N%
								%#include %"eif_struct.h%"%N%
								%#include %"eif_malloc.h%"%N")

			if not final_mode then
					-- Hash table extern declaration in workbench mode
				buffer.putstring ("#include %"eif_macros.h%"")
				buffer.new_line
				buffer.start_c_specific_code
				
				class_array := classes
				nb := class_counter.count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						j := a_class.class_id
						if
							not Compilation_modes.is_precompiling and
							not a_class.is_precompiled
						then
							buffer.putstring ("extern int32 ra")
							buffer.putint (j)
							buffer.putstring ("[];%N")
						end
						if a_class.has_visible then
							buffer.putstring ("extern char *cl")
							buffer.putint (j)
							buffer.putstring ("[];%N")
							buffer.putstring ("extern uint32 cr")
							buffer.putint (j)
							buffer.putstring ("[];%N")
						end
						if not a_class.skeleton.is_empty then
							from
								types := a_class.types
								types.start
							until
								types.off
							loop
								id := types.item.type_id
								buffer.putstring ("extern uint32 types")
								buffer.putint (id)
								buffer.putstring ("[];%N")
								types.forth
							end
						end
					end
					i := i + 1
				end
				buffer.new_line

				create cltype_array.make (1, static_type_id_counter.count)
			else
				buffer.start_c_specific_code
			end

			from
				nb := Type_id_counter.value
				i := 1
			until
				i > nb
			loop
				buffer.flush_buffer (skeleton_file)
				cl_type := class_types.item (i)
					-- Classes could be removed
if cl_type /= Void then
				if final_mode then
					if
						not cl_type.associated_class.is_precompiled or else
						cl_type.associated_class.is_in_system
					then
						cl_type.generate_skeleton1 (buffer)
					end
				else
					cl_type.generate_skeleton1 (buffer)
				end
				if not final_mode then
						-- Doesn't use `cl_type' as first argument:
						-- LINKED_LIST [INTEGER] introduced in two precompiled projects
						-- must have only one derivation in the generated code, i.e. objects
						-- created by one precompiled project can be used by the other as they are
						-- of the same type.
						-- Using cl_type.type.associated_class_type will make sure that both
						-- derivations will share the same dynamic type.
					cltype_array.put (cl_type.type.associated_class_type, cl_type.static_type_id)
				end
else
		-- FIXME
end
				i := i + 1
			end

			buffer.putstring ("struct cnode egc_fsystem_init[] = {%N")
			from
				i := 1
			until
				i > nb
			loop
				buffer.flush_buffer (skeleton_file)
				cl_type := class_types.item (i)
if cl_type /= Void then
				if final_mode then
					if
						not cl_type.associated_class.is_precompiled or else
						cl_type.associated_class.is_in_system
					then
						cl_type.generate_skeleton2 (buffer)
					else
							-- Type not inserted in system because it was coming
							-- from a precompiled library.
						buffer.putstring ("{ 0, %"INVALID_TYPE%", (char**)0,0,0,0,0,0}")
					end
				else
					cl_type.generate_skeleton2 (buffer)
				end
else
		-- FIXME
	if final_mode then
		buffer.putstring ("{ 0, %"INVALID_TYPE%", (char**)0,0,0,0,0,0}")
	else
		buffer.putstring 
			("{%N0L,%N%"INVALID_TYPE%",%N(char**) 0,%N(int*) 0,%N%
			%(uint32*) 0,%N(int16**) 0,%N(int32*) 0,%N0L,%N0L,%N'\0',%N'\0',%N%
			%(int32) 0,(int32) 0,'\0',%N(int32*) 0,%N%
			%{(int32) 0, (int) 0, (char**) 0, (char*) 0}}")
	end
end
				buffer.putstring (",%N")
				i := i + 1
			end
			if has_separate then
				if not final_mode then
					buffer.putstring 
						("{%N0L,%N%"SEP_OBJ%",%N(char**) 0,%N(int*) 0,%N%
						%(uint32*) 0,%N(int16**)0,%N(int32*) 0,%N0L,%N0L,%N'\0',%N'\0',%N%
						%(int32) 0,(int32) 0, %N1,%N(int32*) 0,%N%
						%{(int32) 0, (int) 0, (char**) 0, (char*) 0}}%N")
				end
			end
			buffer.putstring ("};%N%N")

			if not final_mode then
					-- Generate the array of routine id arrays
				buffer.putstring ("int32 *egc_fcall_init[] = {%N")
				from
					i := 1
					nb := cltype_array.upper
				until
					i > nb
				loop
					buffer.flush_buffer (skeleton_file)
					cl_type := cltype_array.item (i)
					if
						not Compilation_modes.is_precompiling and
						cl_type /= Void and then
						not cl_type.associated_class.is_precompiled
					then
						buffer.putstring ("ra")
						buffer.putint (cl_type.associated_class.class_id)
					else
						buffer.putstring ("(int32 *) 0")
					end
					buffer.putstring (",%N")
					i := i + 1
				end
				buffer.putstring ("};%N%N")
					-- Generate the correspondances stable between original
					-- dynamic types and new dynamic types
				buffer.putstring ("int16 egc_fdtypes_init[] = {%N")
				from
					i := 1
				until
					i > nb
				loop
					buffer.flush_buffer (skeleton_file)
					cl_type := cltype_array.item (i)
					buffer.putstring ("(int16) ")
					if cl_type /= Void then
						buffer.putint (cl_type.type_id - 1)
					else
						buffer.putint (0)
					end
					buffer.putstring (",%N")
					i := i + 1
				end
				buffer.putstring ("};%N")
			end

			buffer.end_c_specific_code
			
				-- Generate skeleton
			skeleton_file.put_string (buffer)
			skeleton_file.close
		end

	generate_cecil is
			-- Generate Cecil structures
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			cl_type: CLASS_TYPE
			a_class: CLASS_C
			final_mode: BOOLEAN
			temp: STRING
			subdir: DIRECTORY
			f_name: FILE_NAME
			dir_name: DIRECTORY_NAME
			cecil_file, header_file: INDENT_FILE
			buffer, header_buffer: GENERATION_BUFFER
		do
				-- Clear buffers for current generation
			buffer := generation_buffer
			buffer.clear_all
			header_buffer := header_generation_buffer
			header_buffer.clear_all

			final_mode := byte_context.final_mode

			buffer.putstring ("#include %"eif_project.h%"%N")
			buffer.putstring ("#include %"eif_cecil.h%"%N")
			if final_mode then
				buffer.putstring ("#include %"ececil.h%"%N")
			end
			buffer.putstring ("#include %"eif_struct.h%"%N%N")
			
			buffer.start_c_specific_code

			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void then
					if a_class.has_visible then
						a_class.generate_cecil
					end
				end
				i := i + 1
			end

			if final_mode then
					-- Extern declarations for previous file
				Extern_declarations.generate_header (header_buffer)
				Extern_declarations.generate (header_buffer)
				Extern_declarations.wipe_out

					-- Generation in file (we need to create the subdirectory
				create temp.make (2)
				temp.append_character (System_object_prefix)
				temp.append_integer (1)
				create dir_name.make_from_string (Final_generation_path)
				dir_name.extend (temp)
				create subdir.make (dir_name)
				if not subdir.exists then
					subdir.create_dir
				end
				create f_name.make_from_string (dir_name)
				f_name.set_file_name ("ececil.h")
				create header_file.make_open_write (f_name)
				header_file.put_string (header_buffer)
				header_file.close

				buffer.putstring ("%Nstruct ctable egc_ce_rname_init[] = {%N")
				from
					i := 1
					nb := Type_id_counter.value
				until
					i > nb
				loop
					cl_type := class_types.item (i)
					if cl_type /= Void then
						cl_type.generate_cecil (buffer)
					else
							-- FIXME
						buffer.putstring ("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
					end
					buffer.putstring (",%N")
					i := i + 1
				end
				buffer.putstring ("};%N")

				if System.has_separate then
						-- Now, generate for Concurrent Eiffel
					buffer.putstring ("%Nstruct ctable fce_sep_pat[] = {%N")
					from
						i := 1
						nb := Type_id_counter.value
					until
						i > nb
					loop
						cl_type := class_types.item (i)
						if cl_type /= Void then
							cl_type.generate_separate_pattern (buffer)
						else
								-- FIXME
							buffer.putstring ("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
						end
						buffer.putstring (",%N")
						i := i + 1
					end
					buffer.putstring ("};%N%Nstruct ctable *ce_sep_pat = fce_sep_pat;%N%N")
				end
			end

			create_cecil_tables
			Cecil2.generate
			Cecil3.generate

			buffer.end_c_specific_code
			
			create cecil_file.make_c_code_file (gen_file_name (final_mode, Evisib));
			cecil_file.put_string (buffer)
			cecil_file.close
		end

	create_cecil_tables is
			-- Prepare cecil tables
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			generic, no_generic: INTEGER
			a_class: CLASS_C
			upper_class_name: STRING
		do
			class_array := classes
			nb := class_counter.count
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

			Cecil2.init (no_generic)
			Cecil3.init (generic)

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
				create rout_table.make (routine_id_counter.initialization_rout_id)
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
					create rout_entry
					rout_entry.set_type_id (i)
					rout_entry.set_written_type_id (i)
					rout_entry.set_body_index (body_index_counter.initialization_body_index)
					rout_table.extend (rout_entry)
				end
end
				i := i + 1
			end
			rout_table.sort_till_position
			rout_table.write
		end

feature -- Dispose routine

	memory_dispose_id: INTEGER is
			-- Memory dispose routine id from class MEMORY. 
			-- Return 0 if the MEMORY class has not been compiled.
			--! (Assumed memory must have a dispose routine
			--! called "dispose" - DINOV).
		local
			feature_i: FEATURE_I
		once
			if memory_class /= Void then
				feature_i := memory_class.feature_table.item_id (names.dispose_name_id)
				if feature_i /= Void then
					Result := feature_i.rout_id_set.first
				end
			end
		end

	memory_class: CLASS_C is
			-- MEMORY class of system. Void if it has
			-- not been compiled.
		require
			memory_class_i_not_void: memory_class_i /= Void
		once
			Result := memory_class_i.compiled_class
		end

	memory_descendants: SEARCH_TABLE [CLASS_C] is
			-- Memory descendants.
		once
			create Result.make (50)
		end
	
	reset_memory_descendants is
			-- Recompute `memory_descendants' since some classes
			-- may not inherit from MEMORY anymore.
		do
				-- Delete previous information
			memory_descendants.clear_all

				-- Recompute it if MEMORY is in system.
			if memory_class_i /= Void then
				formulate_mem_descendants (memory_class, memory_descendants)
			end
		end
 
	formulate_mem_descendants (c: CLASS_C; desc: SEARCH_TABLE [CLASS_C]) is
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
				desc.put (d)
				formulate_mem_descendants (d, desc)
				descendants.forth
			end
		end

	generate_dispose_table is
			-- Generate dispose table
		local
			entry: ROUT_TABLE
		do
				-- Get the polymorphic table corresponding to the `dispose' routine
				-- from MEMORY.
			entry ?= Eiffel_table.poly_table (memory_dispose_id)

				-- We are using `header_generation_buffer' for the generation
				-- because this is used for routine tables (look at
				-- `generate_routine_table').
				-- We are using `routine_id_counter.dispose_rout_id' and not
				-- `memory_dispose_id' to generate the table, because we are not
				-- generating a standard polymorphic table and so, we cannot reuse the
				-- one which could have been generated if there was any polymorphic
				-- call on `dispose'.
			entry.generate_dispose_table (routine_id_counter.dispose_rout_id,
											header_generation_buffer)
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
			c_name: STRING
			dtype: INTEGER
			final_mode: BOOLEAN
			cl_type: CLASS_TYPE

			has_argument: BOOLEAN
			i, nb: INTEGER
			initialization_file: INDENT_FILE
			buffer: GENERATION_BUFFER

			rout_id: INTEGER
			rout_table: ROUT_TABLE
		do
				-- Clear buffer for current generation
			buffer := generation_buffer
			buffer.clear_all

			final_mode := byte_context.final_mode

			root_cl := root_class.compiled_class
			cl_type := root_cl.types.first
			dtype := cl_type.type_id - 1

			if not Compilation_modes.is_precompiling and then creation_name /= Void then
				root_feat := root_cl.feature_table.item (creation_name)
				has_argument := root_feat.has_arguments
				rout_id := root_feat.rout_id_set.first
			end

			buffer.putstring ("%
				%#include %"eif_project.h%"%N%
				%#include %"eif_macros.h%"%N%
				%#include %"eif_struct.h%"%N%N")

			if has_separate then
				buffer.putstring ("#include %"eif_curextern.h%"%N%N")
			end

			buffer.start_c_specific_code
			
			if creation_name /= Void then
				if final_mode then
					rout_table ?= Eiffel_table.poly_table (rout_id)
					rout_table.goto_implemented (cl_type.static_type_id)
					check
						is_implemented: rout_table.is_implemented
					end
					c_name := clone (rout_table.feature_name)
					if root_feat.has_arguments then
						buffer.generate_extern_declaration
							("void", c_name, <<"EIF_REFERENCE", "EIF_REFERENCE">>)
					else
						buffer.generate_extern_declaration
							("void", c_name, <<"EIF_REFERENCE">>)
					end
				end
			end

			buffer.generate_function_signature ("void", "emain", True, buffer,
						<<"argc", "argv">>, <<"int", "char **">>)

--			buffer.putstring ("#ifndef EIF_THREADS%N%
--											%%Textern char *root_obj;%N%
--											%#endif%N")


			if has_separate then
				buffer.putstring ("%Tif (argc < 2) {%N%
					%%T%Tsprintf(crash_info, CURERR7, 1);%N%
					%%T%Tdefault_rescue();%N%
					%%T}%N")
				buffer.putstring ("%
					%%Tif (strcmp(argv[1], constant_init_flag) && strcmp(argv[1], constant_creation_flag)) {%N%
					%%T%Tsprintf(crash_info, CURERR8);%N%
					%%T%Tdefault_rescue();%N%
					%%T}%N")
				buffer.putstring ("%
					%%Tif (!memcmp(argv[1], constant_init_flag, strlen(argv[1]))) {%N%
					%%T%Tchar **root_argv;%N%
					%%T%Tint i;%N%
					%%T%Troot_argv = (char **) cmalloc(argc*sizeof(char *));%N%
					%%T%Tvalid_memory(root_argv);%N")
				buffer.putstring ("%
					%%T%Troot_argv[0] = argv[0];%N%
					%%T%Tfor(i=2; i<argc; i++)%N%
					%%T%T%Troot_argv[i-1] = argv[i];%N%
					%%T%Troot_argv[argc-1] = NULL;%N%
					%%T%T_concur_root_of_the_application = 1;%N%
					%%T%T_concur_invariant_checked = 1;%N")
					-- The last line Only for Workbench Mode
			end

			buffer.putstring ("%Troot_obj = RTLN(")
			if final_mode then
				buffer.putint (dtype)
			else
				buffer.putstring ("egc_rcdt")
			end
			buffer.putstring (");%N")

			if has_separate then
				buffer.putstring ("%T%TCURIS;%N")
			end

			if final_mode then
				if creation_name /= Void then
					buffer.putstring ("%T%T")
					buffer.putstring (c_name)
					buffer.putstring ("(root_obj")
					if root_feat.has_arguments then
						if has_separate then
							buffer.putstring (", argarr(argc-1, root_argv)")
						else
							buffer.putstring (", argarr(argc, argv)")
						end
					end
					buffer.putstring (");%N")
				end
			else
				if has_separate then
					buffer.putstring ("%T%Tif (egc_rcorigin != -1)%N%
						%%T%T%Tif (egc_rcarg)%N%
						%%T%T%T%T(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_REFERENCE)) RTWPF(egc_rcorigin, egc_rcoffset, egc_rcdt))(root_obj, argarr(argc-1, root_argv));%N%
						%%T%T%Telse%N%
						%%T%T%T%T(FUNCTION_CAST(void, (EIf_REFERENCE)) RTWPF(egc_rcorigin, egc_rcoffset, egc_rcdt))(root_obj);%N")
				else
					buffer.putstring ("%Tif (egc_rcorigin != -1)%N%
						%%T%Tif (egc_rcarg)%N%
						%%T%T%T(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_REFERENCE)) RTWPF(egc_rcorigin, egc_rcoffset, egc_rcdt))(root_obj, argarr(argc, argv));%N%
						%%T%Telse%N%
						%%T%T%T(FUNCTION_CAST(void, (EIF_REFERENCE)) RTWPF(egc_rcorigin, egc_rcoffset, egc_rcdt))(root_obj);%N")
				end
			end

			if has_separate then
				buffer.putstring ("%T}%N")

				buffer.putstring ("%Telse {%N%
					%%T%T_concur_root_of_the_application = 0;%N%
					%%T%Troot_obj = RTLN(eif_type_id(argv[4]));%N")
				buffer.putstring ("%T%TCURIS;%N")

					-- Only for Workbench Mode
				buffer.putstring ("%T%Tif (!strcmp(argv[5], %"_no_cf%")) {%N%
					%%T%T%TRTCI(root_obj);%N%
					%%T%T%T_concur_invariant_checked = 1;%N%
					%%T%T}%N%
					%%T%Telse%N%
					%%T%T%T_concur_invariant_checked = 0;%N")

				buffer.putstring ("%T}%N")
				buffer.putstring ("%Tserver_execute();%N")
			end

			buffer.putstring ("%N}%N")

			-- Generation of egc_einit_init() and egc_tabinit_init(). Only for workbench
			-- mode.

			if not final_mode then
					-- Prototypes
				buffer.generate_extern_declaration ("void", "egc_tabinit_init", <<>>)
				from
					i := 1
					nb := type_id_counter.value
				until
					i > nb
				loop
					cl_type := class_types.item (i)
					if cl_type /= Void then
						buffer.generate_extern_declaration ("void", Encoder.init_name (cl_type.static_type_id), <<"void">>)
					end
					i := i + 1
				end


				buffer.putstring ("%Nvoid egc_tabinit_init(void)%N{%N")
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
						buffer.putchar ('%T')
						buffer.putstring (Encoder.init_name (cl_type.static_type_id))
						buffer.putstring ("();%N")
					end
					i := i + 1
				end
				buffer.putstring ("}%N%N")

				buffer.generate_function_signature ("void", "egc_einit_init", True, buffer, <<"">>, <<"void">>)

					-- Set C variable `ccount'.
				buffer.putstring ("%Tccount = ")
				buffer.putint (class_counter.count)
					-- Set the frozen level
				buffer.putstring (";%N%Teif_nb_features = ")
				buffer.putint (nb_frozen_features)
				buffer.putstring (";%N}%N%N")
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

				if cl_type /= Void and then not makefile_generator.empty_class_types.has (cl_type.static_type_id) then
					if
						not final_mode or else
						(not cl_type.is_precompiled or else cl_type.associated_class.is_in_system)
					then
						buffer.generate_extern_declaration (
									"void", Encoder.module_init_name (cl_type.static_type_id), <<"void">>)
					end
				end
				i := i + 1
			end



			-- Module initialization
			buffer.generate_function_signature (
				"void", "egc_system_mod_init_init", True, buffer, <<"">>, <<"void">>)

			if license.demo_mode or else license.non_commercial_mode then
					-- Set egc_type_of_gc = 25 * egc_platform_level + egc_compiler_tag - 1
				buffer.putstring ("%N%Tegc_type_of_gc = 123173;%N")
			else
					-- Set egc_type_of_gc = 25 * egc_platform_level + egc_compiler_tag
				buffer.putstring ("%N%Tegc_type_of_gc = 123174;%N")
			end

			from
				i := 1
				nb := type_id_counter.value
			until
				i > nb
			loop
				cl_type := class_types.item (i)

				if cl_type /= Void and then not makefile_generator.empty_class_types.has (cl_type.static_type_id) then
					if
						not final_mode or else
						(not cl_type.is_precompiled or else cl_type.associated_class.is_in_system)
					then
						buffer.putstring ("%T")
						buffer.putstring (Encoder.module_init_name (cl_type.static_type_id))
						buffer.putstring ("();%N")
					end
				end
				i := i + 1
			end

			buffer.putstring ("%N}%N%N")

			buffer.end_c_specific_code

			create initialization_file.make_c_code_file (gen_file_name (final_mode, Einit));
			initialization_file.put_string (buffer)
			initialization_file.close
		end

feature -- Workbench routine info table file generation

	generate_rout_info_table is
		local
			buffer: GENERATION_BUFFER
			rout_info_file: INDENT_FILE
		do
			if not byte_context.final_mode then
					-- Clear buffer for current generation
				buffer := generation_buffer
				buffer.clear_all
				rout_info_table.generate (buffer)

				create rout_info_file.make_c_code_file (workbench_file_name (Ecall));
				rout_info_file.put_string (buffer)
				rout_info_file.close
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
			option_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
				-- Clear buffer for Current generation
			buffer := generation_buffer
			buffer.clear_all

			buffer.putstring ("#include %"eif_project.h%"%N%
								%#include %"eif_struct.h%"%N%
								%#include %"eif_option.h%"%N%N")

			buffer.start_c_specific_code
			
				-- First debug keys
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void then
					partial_debug ?= a_class.debug_level
					if partial_debug /= Void then
						partial_debug.generate_keys (buffer, a_class.class_id)
					end
				end
				i := i + 1
			end

				-- Then option C array
			buffer.putstring ("struct eif_opt egc_foption_init[] = {%N")
			from
				i := 1
				nb := Type_id_counter.value
			until
				i > nb
			loop
				class_type := class_types.item (i)
				buffer.putchar ('{')
				if class_type /= Void then
						-- Classes could be removed
					a_class := class_type.associated_class
					a_class.assertion_level.generate (buffer)
					buffer.putstring (", ")
					a_class.trace_level.generate (buffer)
					buffer.putstring (", ")
					a_class.profile_level.generate (buffer)
					buffer.putstring (", ")
					a_class.debug_level.generate (buffer, a_class.class_id)
				else
					buffer.putstring ("(int16) 0, (int16) 0, (int16) 0,%
						%{(int16) 0, (int16) 0, (char **) 0}")
				end
				buffer.putstring ("},%N")
				i := i + 1
			end
			buffer.putstring ("};%N")
			buffer.end_c_specific_code

			create option_file.make_c_code_file (workbench_file_name (Eoption));
			option_file.put_string (buffer)
			option_file.close
		end

feature 

	set_current_class (a_class: CLASS_C) is
		do
			current_class := a_class
		end

	in_pass3: BOOLEAN
			-- Is Degree 3 the current Degree?

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
			if not any_class.compiled then
				init
			else
				add_visible_classes
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
				create f_name.make_from_string (Final_generation_path)
				f_name.set_file_name (Removed_log_file_name)
				create removed_log_file.make (f_name)

				create f_name.make_from_string (Final_generation_path)
				f_name.set_file_name (Translation_log_file_name)
				create used_features_log_file.make (f_name)

					-- Files are open using the `write' mode
				removed_log_file.open_write
				used_features_log_file.open_write
			else
				create f_name.make_from_string (Workbench_generation_path)
				f_name.set_file_name (Translation_log_file_name)
				create used_features_log_file.make (f_name)

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
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void then
					-- Do nothing. Specific debug
					-- code can be inserted here.
				end
				i := i + 1
			end
		end

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
		external
			"C"
		end

	current_time: INTEGER is
			-- Elapsed time since the Epoch (00:00:00 UTC, January 1, 1970),
			-- measured in seconds.
		do
			Result := c_time (default_pointer)
		end
		
	c_time (p: POINTER): INTEGER is
			-- Elapsed time since the Epoch (00:00:00 UTC, January 1, 1970),
			-- measured in seconds.
			-- If `p /= default_pointer' result will be stored in memory pointed
			-- by `p'.
		external
			"C (time_t *): EIF_INTEGER | <time.h>"
		alias
			"time"
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
