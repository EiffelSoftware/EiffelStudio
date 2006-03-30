indexing
	description: "Internal representation of a system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	SHARED_LICENSE
		export
			{NONE} all
		end

	SHARED_OVERRIDDEN_METADATA_CACHE_PATH

	SHARED_CONF_FACTORY

	KL_SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	CONF_ACCESS

create
	make

feature {NONE} -- Initialization

	make is
			-- Create the system.
		do
			set_compilation_id (1)

				-- Set up working environment to use current as SYSTEM_I instance.
			Workbench.set_system (Current)

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
			create externals.make (10)

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

	is_rebuild: BOOLEAN
			-- Do we have to do a full rebuild (because some classes could not be found).

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

	removed_classes: SEARCH_TABLE [CLASS_C]
			-- List of removed classes from system.
			-- Filled during degree 6, processed after degree 5

	missing_classes: HASH_TABLE [SEARCH_TABLE [CLASS_C], STRING]
			-- Table indexed by missing classnames where elements are
			-- classes referencing the missing classname.

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

	set_array_make_name (a_name: STRING) is
			-- Set `name' to `array_make_name'.
		require
			a_name_not_void: a_name /= Void
		do
			array_make_name := a_name.twin
		end

	tuple_make_name: STRING
			-- Name of the C routine corresponding to the
			-- make routine of TUPLE. See also comment above.

	optimization_tables: SEARCH_TABLE [OPTIMIZE_UNIT]
			-- Tables keeping track of flags for loop optimization
			-- Based on the body_index of a feature

	names: NAMES_HEAP
			-- Fast lookup for stored name, to avoid name duplication in memory.

	is_precompile_finalized: BOOLEAN
			-- has precompiled library compilation been finalized?

	init is
			-- System initialization
		require
			new_target: universe.new_target /= Void
		local
			local_workbench: WORKBENCH_I
		do
			rebuild_configuration

			first_compilation := True

			local_workbench := Workbench

				-- add

				-- At the very beginning of a session, even class ANY is
				-- not compiled. So we must say to the workbench to compile
				-- classes ANY, DOUBLE... ARRAY
				-- It is very important that these classes were protected.

			if il_generation then
				local_workbench.change_class (system_object_class)
				local_workbench.change_class (system_value_type_class)
			end
			local_workbench.change_class (any_class)
			local_workbench.change_class (special_class)
			local_workbench.change_class (pointer_class)
			local_workbench.change_class (array_class)
			local_workbench.change_class (tuple_class)
			local_workbench.change_class (bit_class)
			local_workbench.change_class (routine_class)
			local_workbench.change_class (procedure_class)
			local_workbench.change_class (function_class)
			local_workbench.change_class (typed_pointer_class)
			local_workbench.change_class (type_class)

			if il_generation then
				local_workbench.change_class (native_array_class)
				local_workbench.change_class (system_string_class)
				local_workbench.change_class (system_type_class)
				local_workbench.change_class (arguments_class)
			end

			local_workbench.change_class (string_class)

			local_workbench.change_class (real_64_class)
			local_workbench.change_class (real_32_class)
			local_workbench.change_class (natural_8_class)
			local_workbench.change_class (natural_16_class)
			local_workbench.change_class (natural_32_class)
			local_workbench.change_class (natural_64_class)
			local_workbench.change_class (integer_8_class)
			local_workbench.change_class (integer_16_class)
			local_workbench.change_class (integer_32_class)
			local_workbench.change_class (integer_64_class)
			local_workbench.change_class (character_class)
			local_workbench.change_class (wide_char_class)
			local_workbench.change_class (boolean_class)

			protected_classes_level := boolean_class.compiled_class.class_id
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
				system_value_type_class.compiled_class.record_precompiled_class_in_system
			end
			any_class.compiled_class.record_precompiled_class_in_system
			real_64_class.compiled_class.record_precompiled_class_in_system
			real_32_class.compiled_class.record_precompiled_class_in_system
			natural_8_class.compiled_class.record_precompiled_class_in_system
			natural_16_class.compiled_class.record_precompiled_class_in_system
			natural_32_class.compiled_class.record_precompiled_class_in_system
			natural_64_class.compiled_class.record_precompiled_class_in_system
			integer_8_class.compiled_class.record_precompiled_class_in_system
			integer_16_class.compiled_class.record_precompiled_class_in_system
			integer_32_class.compiled_class.record_precompiled_class_in_system
			integer_64_class.compiled_class.record_precompiled_class_in_system
			boolean_class.compiled_class.record_precompiled_class_in_system
			character_class.compiled_class.record_precompiled_class_in_system
			wide_char_class.compiled_class.record_precompiled_class_in_system
			string_class.compiled_class.record_precompiled_class_in_system
			special_class.compiled_class.record_precompiled_class_in_system
			pointer_class.compiled_class.record_precompiled_class_in_system
			array_class.compiled_class.record_precompiled_class_in_system
			tuple_class.compiled_class.record_precompiled_class_in_system
			bit_class.compiled_class.record_precompiled_class_in_system
			routine_class.compiled_class.record_precompiled_class_in_system
			procedure_class.compiled_class.record_precompiled_class_in_system
			function_class.compiled_class.record_precompiled_class_in_system
			typed_pointer_class.compiled_class.record_precompiled_class_in_system
			type_class.compiled_class.record_precompiled_class_in_system

			if il_generation then
				native_array_class.compiled_class.record_precompiled_class_in_system
				system_string_class.compiled_class.record_precompiled_class_in_system
				arguments_class.compiled_class.record_precompiled_class_in_system
				system_type_class.compiled_class.record_precompiled_class_in_system
			end

				-- The root class could be part of the precompiled library, so
				-- we need to make sure that its `is_in_system' flag is set.
			if
				root_cluster.classes_set and then root_class.is_compiled and then
				root_class.compiled_class.is_precompiled
			then
				root_class.compiled_class.record_precompiled_class_in_system
			end
		end

	add_visible_classes is
			-- Force visible classes into System
		local
			l_conf_class: CONF_CLASS
			l_class_i: CLASS_I
		do
			from
				new_classes.start
			until
				new_classes.after
			loop
				l_class_i := new_classes.item
				l_conf_class ?= l_class_i
				check
					is_conf_class: l_conf_class /= Void
				end
				if l_conf_class.is_always_compile then
					workbench.change_class (l_class_i)
				end
				new_classes.forth
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
io.error.put_string ("%TInserting class ")
io.error.put_string (a_class.name)
io.error.put_integer (new_id)
io.error.put_new_line
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
			if a_class.is_removable then
				if removed_classes = Void then
					create removed_classes.make (10)
				end
				removed_classes.put (a_class)
				Degree_5.remove_class (a_class)
			end
		end

	record_potential_vtct_error (a_class: CLASS_C; a_name: STRING) is
			-- Record missing class name `a_name' in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_name_not_void: a_name /= Void
		local
			l_table: SEARCH_TABLE [CLASS_C]
		do
			if missing_classes = Void then
				create missing_classes.make (5)
			end
			missing_classes.search (a_name)
			if missing_classes.found then
				l_table := missing_classes.found_item
			else
				create l_table.make (1)
				missing_classes.put (l_table, a_name)
			end
			l_table.put (a_class)
		end

	report_vtct_errors is
			-- Report any remaining VTCT errors at the end of degree 5
		local
			l_vtct: VTCT
			l_name: STRING
			l_class: CLASS_C
			l_table: SEARCH_TABLE [CLASS_C]
			l_has_error: BOOLEAN
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [VTCT]
			l_sorter: DS_QUICK_SORTER [VTCT]
			l_list: DS_ARRAYED_LIST [VTCT]
		do
			if missing_classes /= Void then
				from
						-- `l_list' is used to display errors in alphabetical order
						-- This is mostly interesting for eweasel as the compiler does
						-- not always give you the same order depending on the way
						-- classes are written.
					create l_list.make (missing_classes.count)
					missing_classes.start
				until
					missing_classes.after
				loop
					l_table := missing_classes.item_for_iteration
					l_name := missing_classes.key_for_iteration
					from
						l_table.start
					until
						l_table.after
					loop
						l_class := l_table.item_for_iteration
							-- At this stage classes have not yet been removed, so we simply
							-- look into `removed_classes'.
						if
							l_class.lace_class.is_compiled and
							not (removed_classes /= Void and then removed_classes.has (l_class))
						then
							check
								same_compiled_class: l_class.lace_class.compiled_class = l_class
							end
								-- If class is still compiled then we should report the error.
							create l_vtct
							l_vtct.set_class (l_class)
							l_vtct.set_class_name (l_name)
							l_list.force_last (l_vtct)

								-- But since it is an invalid class, then we need to force
								-- a compilation again to check for the VTCT error again.
							workbench.add_class_to_recompile (l_class.lace_class)
							l_has_error := True
						end
						l_table.forth
					end
					missing_classes.forth
				end

				missing_classes := Void

				if l_has_error then
					create l_agent_sorter.make (agent {VTCT}.less_than)
					create l_sorter.make (l_agent_sorter)
					l_sorter.sort (l_list)
					from
						l_list.start
					until
						l_list.after
					loop
						Error_handler.insert_error (l_list.item_for_iteration)
						l_list.forth
					end
						-- Cannot go on here
					Error_handler.raise_error
				end
			end
		end

	class_of_id (id: INTEGER): CLASS_C is
			-- Class of id `id'
		require
			id_not_void: id /= 0
		do
			Result := classes.item (id)
debug ("CLASS_OF_ID")
io.error.put_string ("Class of id ")
io.error.put_integer (id)
io.error.put_string (": ")
if Result /= Void then
	io.error.put_string (Result.name)
end
io.error.put_new_line
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
				class_types.conservative_resize (1, type_id + System_chunk)
			end
			class_types.put (class_type, type_id)
		end

	remove_class_type (class_type: CLASS_TYPE) is
			-- Remove `class_type' from `class_types' and associated
			-- generated files if any.
		require
			good_argument: class_type /= Void
			index_big_enough: class_type.type_id > 0
		do
			class_types.put (Void, class_type.type_id)
			class_type.remove_c_generated_files
		end

	rebuild_configuration is
			-- Build or rebuild the configuration information
		local
			l_vis_build: CONF_BUILD_VISITOR
			l_vis_check: CONF_CHECKER_VISITOR
			l_classes: DS_HASH_SET [CONF_CLASS]
			l_conf_class: CONF_CLASS
			l_class_i: CLASS_I
			l_errors: LIST [CONF_ERROR]
			vd71: VD71
			vd80: VD80
			l_target: CONF_TARGET
			l_file: PLAIN_TEXT_FILE
			l_file_name: FILE_NAME
			l_ise_lib: STRING
		do
			l_target := universe.new_target
			check
				l_target_not_void: l_target /= Void
			end
				-- initialize ISE_LIBRARY with ISE_EIFFEL
			l_ise_lib := execution_environment.variable_value ("ISE_LIBRARY")
			if l_ise_lib = Void then
				l_ise_lib := execution_environment.variable_value ("ISE_EIFFEL")
			end
			l_target.environ_variables.force (l_ise_lib, "ise_library")

				-- let the configuration system build "everything"
			if universe.target /= Void then
				create l_vis_build.make_build_from_old (universe.platform, universe.build, l_target, universe.target)
			else
				create l_vis_build.make_build (universe.platform, universe.build, l_target)
			end
			if il_generation then
				l_vis_build.set_assembly_cach_folder (metadata_cache_path)
				l_vis_build.set_il_version (msil_version)
			end
			l_vis_build.set_partial_location (conf_factory.new_location_from_path (partial_generation_path, l_target))
			l_target.process (l_vis_build)
			if l_vis_build.is_error then
				from
					l_errors := l_vis_build.last_errors
					l_errors.start
				until
					l_errors.after
				loop
					create vd71.make (l_errors.item)
					Error_handler.insert_error (vd71)
					l_errors.forth
				end
				Error_handler.raise_error
			end

				-- check configuration and add warnings
			create l_vis_check.make (universe.platform, universe.build)
			l_target.process (l_vis_check)
			if l_vis_check.is_error then
				from
					l_errors := l_vis_check.last_errors
					l_errors.start
				until
					l_errors.after
				loop
					create vd80
					vd80.set_warning (l_errors.item)
					Error_handler.insert_warning (vd80)
					l_errors.forth
				end
			end

				-- modified classes
			l_classes := l_vis_build.modified_classes
			from
				l_classes.start
			until
				l_classes.after
			loop
				l_conf_class := l_classes.item_for_iteration
				l_class_i ?= l_conf_class
				check
					class_i: l_class_i /= Void
				end
					-- FIXME: Patrickr 03/14/2006 for now the compiler can't deal with changed external classes
				if not l_class_i.is_external_class then
					workbench.change_class (l_class_i)
				end
				if compilation_modes.is_precompiling then
					l_conf_class.enable_precompiled
				end
				l_conf_class.set_up_to_date
				l_classes.forth
			end
				-- added classes
			create new_classes.make
			l_classes := l_vis_build.added_classes
			from
				l_classes.start
			until
				l_classes.after
			loop
				l_conf_class := l_classes.item_for_iteration
				l_class_i ?= l_conf_class
				check
					class_i: l_class_i /= Void
				end
				record_new_class_i (l_class_i)
				l_conf_class.set_up_to_date
				if compilation_modes.is_precompiling then
					l_conf_class.enable_precompiled
				end
				l_classes.forth
			end
				-- removed classes
			if workbench.automatic_backup then
				create l_file_name.make_from_string (workbench.backup_subdirectory)
				l_file_name.set_file_name (backup_info)
				create l_file.make_open_write (l_file_name)
			end
			l_classes := l_vis_build.removed_classes
			from
				l_classes.start
			until
				l_classes.after
			loop
				l_class_i ?= l_classes.item_for_iteration
				check
					class_i: l_class_i /= Void
					class_compiled: l_class_i.is_compiled
				end
				l_class_i.compiled_class.recompile_syntactical_clients
				if workbench.automatic_backup then
					l_file.put_string (l_class_i.name+": "+l_class_i.group.name+": "+l_class_i.file_name+"%N")
				end
				remove_class (l_class_i.compiled_class)
				l_classes.forth
			end
			if workbench.automatic_backup then
				l_file.close
			end

				-- everything with the configuration system went ok, move new_target to target
			universe.new_target_to_target

				-- Try to reconnect removed classes with new classes
			revive_moved_classes

				-- check the universe
			universe.check_universe

				-- update/check root class
			update_root_class
		end

	update_root_class is
			-- Update/recheck the root class.
		require
			target_not_void: universe.target /= Void
		local
			l_target: CONF_TARGET
			l_classes_i: LIST [CLASS_I]
			l_root: CONF_ROOT
			l_cluster: CLUSTER_I
			vd19: VD19
			vd20: VD20
			vd29: VD29
		do
			l_target := universe.target
				-- update root class/feature
			l_root := l_target.root
			if l_root /= Void then
				system.set_root_class_name (l_root.class_name.as_upper)

				if l_root.cluster_name = Void then
					l_classes_i := universe.classes_with_name (l_root.class_name.as_upper)
					if l_classes_i.count = 0 then
						create vd20
						vd20.set_class_name (l_root.class_name.as_upper)
						Error_handler.insert_error (vd20)
						Error_handler.raise_error
					elseif l_classes_i.count > 1 then
						create vd29
						vd29.set_cluster (l_classes_i.first.group)
						vd29.set_second_cluster_name (l_classes_i.last.group.name)
						vd29.set_root_class_name (l_root.class_name.as_upper)
						Error_handler.insert_error (vd29)
						Error_handler.raise_error
					else
						l_cluster ?= l_classes_i.first.group
					end
				else
					l_cluster ?= l_target.clusters.item (l_root.cluster_name)
					if l_cluster = Void then
						create vd19
						vd19.set_root_cluster_name (l_root.cluster_name)
						Error_handler.insert_error (vd19)
						Error_handler.raise_error
					elseif l_cluster.classes.item (root_class_name) = Void then
						create vd20
						vd20.set_class_name (l_root.class_name.as_upper)
						Error_handler.insert_error (vd20)
						Error_handler.raise_error
					end
				end

				system.set_root_cluster (l_cluster)
				system.set_creation_name (l_root.feature_name)
			end
		ensure
			root_class_set: root_class /= Void
			root_cluster_set: root_cluster /= Void
		end


	init_recompilation is
			-- Initialization before a recompilation.
		local
			l_vis_modified: CONF_MODIFIED_VISITOR
			l_classes: ARRAYED_LIST [CONF_CLASS]
			l_class: CLASS_I
			l_conf_class: CONF_CLASS
			l_rebuild: BOOLEAN
			l_grp: CONF_GROUP
		do
			if not compilation_modes.is_quick_melt then
					-- Patrickr 03/07/2006
					-- for now always rebuild
				is_rebuild := True
			else
				is_rebuild := is_rebuild or first_compilation
			end

				-- Mark classes to be recompiled.
			if any_class = Void or else not any_class.is_compiled then
					-- First compilation.
				is_rebuild := True
				init
			else
				if is_rebuild then
						-- Full rebuild
					rebuild_configuration
				else
						-- Let the configuration system check for compiled classes that have been modified.
					create l_vis_modified.make (universe.platform, universe.build)
					universe.target.process (l_vis_modified)
					l_classes := l_vis_modified.modified_classes
					from
						l_classes.start
					until
						l_rebuild or l_classes.after
					loop
						l_conf_class := l_classes.item
						l_grp := l_conf_class.group
						l_class ?= l_conf_class
						check
							class_i: l_class /= Void
						end
						l_rebuild := l_conf_class.is_renamed and then (l_grp.is_overriden or l_grp.is_override)
						workbench.change_class (l_class)
						l_conf_class.set_up_to_date
						l_classes.forth
					end
					if l_rebuild then
						rebuild_configuration
						is_rebuild := True
					else
						update_root_class
					end
				end

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
				end
				add_visible_classes
			end
			if
				Lace.compile_all_classes or
				(Compilation_modes.is_precompiling and root_class = any_class)
			then
				Workbench.change_all_new_classes
			end

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

				-- Reset internal data that needs to be recomputed
				-- at each recompilation in case it might changed during
				-- a recompilation. It happens if at the first compilation
				-- you do, there is an error, then those IDs from the routines
				-- of ANY/SPECIAL will definitely be changed
			internal_default_rescue_id := -1
			internal_default_create_id := -1
			internal_special_make_id := - 1
		end

feature -- ANY.default_rescue routine id

	default_rescue_id: INTEGER is
			-- Routine id of default rescue from ANY.
			-- Return 0 if ANY has not been compiled or
			-- does not have a feature named `default_rescue'.
		local
			feature_i: FEATURE_I
		do
			Result := internal_default_rescue_id
			if Result < 0 then
				Result := 0
				if any_class /= Void and then
						any_class.compiled_class /= Void then
					feature_i := any_class.compiled_class.
						feature_table.item_id (names.default_rescue_name_id)
					if feature_i /= Void then
						Result := feature_i.rout_id_set.first
					end
				end
				internal_default_rescue_id := Result
			end
		end

feature -- ANY.default_create routine id

	default_create_id: INTEGER is
			-- Routine id of default create from ANY.
			-- Return 0 if ANY has not been compiled or
			-- does not have a feature named `default_create'.
		local
			feature_i: FEATURE_I
		do
			Result := internal_default_create_id
			if Result < 0 then
				Result := 0
				if any_class /= Void and then
						any_class.compiled_class /= Void then
					feature_i := any_class.compiled_class.
						feature_table.item_id (names.default_create_name_id)
					if feature_i /= Void then
						Result := feature_i.rout_id_set.first
					end
				end
				internal_default_create_id := Result
			end
		end

feature -- SPECIAL.make routine id

	special_make_id: INTEGER is
			-- Routine id of `make' from SPECIAL.
			-- Return 0 if SPECIAL has not been compiled or
			-- does not have a feature named `make'.
		local
			feature_i: FEATURE_I
		do
			Result := internal_special_make_id
			if Result < 0 then
				Result := 0
				if special_class /= Void and then
						special_class.compiled_class /= Void then
					feature_i := special_class.compiled_class.
						feature_table.item_id (names.make_name_id)
					if feature_i /= Void then
						Result := feature_i.rout_id_set.first
					end
				end
				internal_special_make_id := Result
			end
		end

feature {NONE} -- Implementation: predefined routine IDs

	internal_default_rescue_id: INTEGER
			-- Once per compilation value of routine id of `default_rescue_id' from ANY.

	internal_default_create_id: INTEGER
			-- Once per compilation value of routine id of `default_create' from ANY.

	internal_special_make_id: INTEGER
			-- Once per compilation value of routine id of `make' from SPECIAL.

feature -- Recompilation

	set_rebuild (b: BOOLEAN) is
			-- Set `is_rebuild'.
		do
			is_rebuild := b
		end

	recompile is
			-- Incremetal recompilation of the system.
		require
			no_error: not Error_handler.has_error
		local
			precomp_r: PRECOMP_R
		do
			freezing_occurred := False

			If System.uses_precompiled then
					-- Validate the precompilation.
				create precomp_r
				precomp_r.check_version_number
			end

			has_been_changed := False
			do_recompilation

			is_rebuild := False
			successful := True
		rescue
			if Rescue_status.is_error_exception then
				successful := False
			end
		end

	revive_moved_classes is
			-- Try to revive classes that have been removed and added (= moved).
		local
			l_cli: CLASS_I
			l_clc: CLASS_C
			l_class_i_found: BOOLEAN
		do
			if new_classes /= Void and removed_classes /= Void then
				from
					removed_classes.start
				until
					removed_classes.after
				loop
					l_clc := removed_classes.item_for_iteration
					l_class_i_found := False
					from
						new_classes.start
					until
						l_class_i_found or new_classes.after
					loop
						l_cli := new_classes.item
						if l_cli.name.is_equal (l_clc.name) then
							l_cli.reset_class_c_information (l_clc)
							new_classes.remove
							removed_classes.remove (l_clc)
							l_cli.config_class.resurect
							workbench.change_class (l_cli)
							l_class_i_found := True
						else
							new_classes.forth
						end
					end
					removed_classes.forth
				end
			end
		end

	recheck_missing_classes is
			-- Recheck the classes that produced a missing class error and wipe out the list of missing classes.
		local
			l_classes: SEARCH_TABLE [CLASS_C]
			l_cl: CLASS_C
		do
			if missing_classes /= Void then
				from
					missing_classes.start
				until
					missing_classes.after
				loop
					l_classes := missing_classes.item_for_iteration
					from
						l_classes.start
					until
						l_classes.after
					loop
						l_cl := l_classes.item_for_iteration
						if removed_classes = Void or else not removed_classes.has (l_cl) then
							workbench.add_class_to_recompile (l_cl.lace_class)
						end
						l_classes.forth
					end
					missing_classes.forth
				end
				missing_classes := Void
			end
		ensure
			missing_classes_void: missing_classes = Void
		end

	do_recompilation is
			-- Incremental recompilation of the system.
		local
			root_class_c: CLASS_C
			d1, d2: DATE_TIME
			l_il_env: IL_ENVIRONMENT
			l_file: KL_TEXT_INPUT_FILE
			l_file_name: FILE_NAME
		do
			debug ("timing")
				print_memory_statistics
				create d1.make_now
			end

				-- create new backup subdir and copy config file in there
			if workbench.automatic_backup then
				workbench.create_backup_directory
				create l_file.make (lace.file_name)
				create l_file_name.make_from_string (workbench.backup_subdirectory)
				l_file_name.set_file_name ("config.acex")
				l_file.copy_file (l_file_name)
			end

				-- Set ISE_DOTNET_FRAMEWORK environment variable			
			if il_generation then
				create l_il_env.make (clr_runtime_version)
				l_il_env.register_environment_variable
			end

				-- Recompilation initialization
			init_recompilation
			if Compilation_modes.is_precompiling and il_generation then
					-- For a precompiled library we require a freeze in non-IL
					-- code generation.
				private_freeze := True
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
				new_class or else
				not Degree_5.is_empty or else
				not Degree_4.is_empty or else
				not Degree_3.is_empty or else
				not Degree_2.is_empty
			then
					-- We compiled something we need to save project file.
				has_been_changed := True

				recheck_missing_classes

					-- Perform parsing of Eiffel code
				process_degree_5
				debug ("Timing")
					create d2.make_now
					print ("Degree 5 duration: ")
					print (d2.relative_duration (d1).fine_seconds_count)
					print ("%N")
					print_memory_statistics
					create d1.make_now
				end

debug ("ACTIVITY")
	io.error.put_string ("%Tnew_class = ")
	io.error.put_boolean (new_class)
	io.error.put_new_line
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

					-- Let's report VTCT errors for classes not found at degree 5
					-- It cannot be done at degree 5 (see eweasel test incr233 for why).
				report_vtct_errors

					-- Fill parents.
				process_post_degree_5

					-- Let's get rid of the classes that have been really removed.
				process_removed_classes

debug ("ACTIVITY")
	io.error.put_string ("%Tmoved = ")
	io.error.put_boolean (moved)
	io.error.put_string ("%N%Tupdate_sort = ")
	io.error.put_boolean (update_sort)
	io.error.put_new_line
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
				debug ("Timing")
					create d2.make_now
					print ("Degree 4 duration: ")
					print (d2.relative_duration (d1).fine_seconds_count)
					print ("%N")
					print_memory_statistics
					create d1.make_now
				end


				if
					not Compilation_modes.is_precompiling and
					not Lace.compile_all_classes
				then
						-- `root_class_c' cannot be used here as `root_class.compiled_class' might be changed
					root_class.compiled_class.check_root_class_creators
				end

					-- Byte code production and type checking
				process_degree_3
				debug ("Timing")
					create d2.make_now
					print ("Degree 3 duration: ")
					print (d2.relative_duration (d1).fine_seconds_count)
					print ("%N")
					print_memory_statistics
					create d1.make_now
				end

				if
					not Compilation_modes.is_precompiling and
					not Lace.compile_all_classes
				then
					private_freeze := private_freeze or else not externals.is_equivalent
				end

					-- Process the type system
				process_type_system

					-- Process the skeleton of classes
				process_skeleton

					-- Reset `disposable_descendants' since they can have changed
					--| Note: That is important to recompute it, especially if
					--| someone removed an inheritance link to DISPOSABLE.
				reset_disposable_descendants

				debug ("Timing")
					create d2.make_now
					print ("After degreee 3 duration: ")
					print (d2.relative_duration (d1).fine_seconds_count)
					print ("%N")
					print_memory_statistics
					create d1.make_now
				end

				if not Lace.compile_all_classes then
						-- Melt the changed features
					melt

					debug ("Timing")
						create d2.make_now
						print ("Degree 2 duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
						create d1.make_now
					end
				end

					-- Finalize a successful compilation
				finish_compilation
				debug ("Timing")
					create d2.make_now
					print ("Server storing duration: ")
					print (d2.relative_duration (d1).fine_seconds_count)
					print ("%N")
					print_memory_statistics
					create d1.make_now
				end

					-- Produce the update file
				if not il_generation and then not freeze then
					Degree_output.put_melting_changes_message

						-- Create a non-empty melted file
					make_update (False)
debug ("VERBOSE")
	io.error.put_string ("Saving melted.eif%N")
end
					debug ("Timing")
						create d2.make_now
						print ("Melted file generation duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
						create d1.make_now
					end
				end
			elseif
				System.root_creation_name = Void and then
				not Compilation_modes.is_precompiling and then
				not Lace.compile_all_classes
			then
					-- We may need to update `System.creation_name'
					-- when it is not set explicitly and defaults to
					-- a redeclaration of "ANY.default_create"
				root_class.compiled_class.check_root_class_creators
			end

			if System.il_generation then
					-- Ensure unicity of names
				check_full_class_name_unicity
			end

			if not il_generation and then freeze then
				Degree_output.put_freezing_message
				freeze_system
				private_freeze := False
				debug ("Timing")
					create d2.make_now
					print ("Degree -1 duration: ")
					print (d2.relative_duration (d1).fine_seconds_count)
					print ("%N")
					print_memory_statistics
				end
			end
			if il_generation and then (private_melt or else not degree_minus_1.is_empty) and not il_quick_finalization then
				generate_il
				debug ("Timing")
					create d2.make_now
					print ("Degree 1 duration: ")
					print (d2.relative_duration (d1).fine_seconds_count)
					print ("%N")
					print_memory_statistics
				end
				Degree_minus_1.wipe_out
			end
			private_melt := False
			first_compilation := False
			il_quick_finalization := False
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

	process_post_degree_5 is
			-- Processing done after main degree 5.
			-- Check and updates parent structure. It has to be done after
			-- reporting all VTCT errors.
		do
			degree_5.post_degree_5_execute
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
	io.error.put_string ("Check generics%N")
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

	process_removed_classes is
			-- Remove classes that disappeared after a recompilation.
		do
			if removed_classes /= Void then
				from
					removed_classes.start
				until
					removed_classes.after
				loop
					internal_remove_class (removed_classes.key_for_iteration, 0)
					removed_classes.forth
				end
				removed_classes := Void
			end
		end

	remove_useless_classes is
			-- Add useless classes to `removed_classes'.
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
				system_value_type_class.compiled_class.mark_class (marked_classes)
			end
			any_class.compiled_class.mark_class (marked_classes)
			real_64_class.compiled_class.mark_class (marked_classes)
			real_32_class.compiled_class.mark_class (marked_classes)
			natural_8_class.compiled_class.mark_class (marked_classes)
			natural_16_class.compiled_class.mark_class (marked_classes)
			natural_32_class.compiled_class.mark_class (marked_classes)
			natural_64_class.compiled_class.mark_class (marked_classes)
			integer_8_class.compiled_class.mark_class (marked_classes)
			integer_16_class.compiled_class.mark_class (marked_classes)
			integer_32_class.compiled_class.mark_class (marked_classes)
			integer_64_class.compiled_class.mark_class (marked_classes)
			boolean_class.compiled_class.mark_class (marked_classes)
			character_class.compiled_class.mark_class (marked_classes)
			wide_char_class.compiled_class.mark_class (marked_classes)
			string_class.compiled_class.mark_class (marked_classes)
			special_class.compiled_class.mark_class (marked_classes)
			pointer_class.compiled_class.mark_class (marked_classes)
			array_class.compiled_class.mark_class (marked_classes)
			tuple_class.compiled_class.mark_class (marked_classes)
			bit_class.compiled_class.mark_class (marked_classes)
			routine_class.compiled_class.mark_class (marked_classes)
			procedure_class.compiled_class.mark_class (marked_classes)
			function_class.compiled_class.mark_class (marked_classes)
			typed_pointer_class.compiled_class.mark_class (marked_classes)
			type_class.compiled_class.mark_class (marked_classes)

			if il_generation then
				native_array_class.compiled_class.mark_class (marked_classes)
				system_string_class.compiled_class.mark_class (marked_classes)
				arguments_class.compiled_class.mark_class (marked_classes)
				system_type_class.compiled_class.mark_class (marked_classes)
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
io.error.put_string ("Remove useless classes: ")
io.error.put_string (a_class.name)
io.error.put_new_line
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

				-- ANY needs to be processed first so that it has static type
				-- of 1.
			if not any_class.compiled_class.has_types then
				any_class.compiled_class.init_types
			end

				-- Processing of root class if any to make it easy to find
				-- it in generated C code
			if
				root_class /= Void and then root_class.is_compiled and then
				not root_class.compiled_class.has_types
			then
				root_class.compiled_class.init_types
			end

				-- Initialize types of non-generic classes which haven't been initialized yet.
			Degree_2.initialize_non_generic_types

				-- Compute the types.
			Instantiator.process

				-- If first compilation, re-order dynamic types
			if old_value = 0 then
				process_dynamic_types
			end
		end

	process_conformance_table_for_type (set_or_reset_action: PROCEDURE [ANY, TUPLE [CLASS_TYPE]]) is
			-- Build the conformance table
		require
			set_or_reset_action_not_void: set_or_reset_action /= Void
			class_types_not_void: class_types /= Void
		local
			l_class_type: CLASS_TYPE
			l_types: ARRAY [CLASS_TYPE]
			i, nb: INTEGER
			l_tuple: TUPLE [CLASS_TYPE]
		do
			from
				l_types := class_types
				i := l_types.lower
				nb := l_types.upper
				create l_tuple
			until
				i > nb
			loop
				l_class_type := l_types.item (i)
				if l_class_type /= Void then
					l_tuple.put (l_class_type, 1)
					set_or_reset_action.call (l_tuple)
				end
				i := i + 1
			end
		end

	process_skeleton is
			-- Type skeleton processing: If skeleton of a class type changed,
			-- it must be re-processed and marked `is_changed'.
		do
			Degree_2.process_skeleton
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
				-- Purge all byte code to disk as some byte code modification
				-- is required at generation time and we do not want it to persist
				-- to disk.
			Byte_server.take_control (Tmp_byte_server)
			Inv_byte_server.take_control (Tmp_inv_byte_server)

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
			l_name: STRING
		do
debug ("ACTIVITY")
	io.error.put_string ("Updating name.eif%N")
end
				-- Find the correct melted name when there is no freeze
				--
				-- When there is no precompiled library, we need to use the `name'.
				-- When there is one, we need to check if a freeze/finalize occurred during
				-- the life cycle of the project, this can be detected by checking that
				-- `melted_file_name' from WORKBENCH_I has not been reset.
			if workbench.melted_file_name /= Void then
				l_name := Workbench.melted_file_name.twin
			else
				l_name := name.twin
			end

			l_name.append (".melted")
			create file_name.make_from_string (Workbench_generation_path)
			file_name.set_file_name (l_name)
			create melted_file.make_open_write (file_name)

				-- There is something to update
			if empty then
				melted_file.put_character ('%/000/')
			else
				melted_file.put_character ('%/001/')
			end

			if not empty then
				file_pointer := melted_file.file_pointer

					-- Update the root class info
				a_class := root_class.compiled_class
				dtype := a_class.types.first.type_id - 1
				if root_creation_name /= Void then
					root_feat := a_class.feature_table.item (root_creation_name)
					if root_feat /= Void then
						if root_feat.has_arguments then
							has_argument := 1
						end
						rout_id := root_feat.rout_id_set.first
						rout_info := rout_info_table.item (rout_id)
						rcorigin := rout_info.origin
						rcoffset := rout_info.offset
					else
						rcorigin := - 1
					end
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
					-- Write the number of original routine bodies
				write_int (file_pointer, body_index_counter.count)
					-- Write the profiler status
				if universe.target.options.is_profile then
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
	io.error.put_string ("%TMelted routine id array%N")
end
				-- Melted routine id array
			from
				m_rout_id_server.start
			until
				m_rout_id_server.after
			loop
				class_id := m_rout_id_server.key_for_iteration
debug ("ACTIVITY")
io.error.put_string ("melting routine id array of ")
io.error.put_integer (class_id)
io.error.put_string (class_of_id (class_id).name)
io.error.put_new_line
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
					cecil_class_table.make_byte_code (Byte_array)

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
	io.error.put_string ("Making option table%N")
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
	io.error.put_string ("%TClass ")
	io.error.put_string (a_class.name)
	io.error.put_new_line
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
					a_class.set_need_type_check (False)
					-- FIXME: changed4, changed5, changed6
					a_class.changed_features.clear_all
					a_class.propagators.wipe_out
				end
				i := i + 1
			end

				-- Update servers
			Feat_tbl_server.take_control (Tmp_feat_tbl_server)
			Tmp_ast_server.finalize
			Ast_server.take_control (Tmp_ast_server)
			Depend_server.take_control (Tmp_depend_server)
			M_feat_tbl_server.take_control (Tmp_m_feat_tbl_server)
			M_feature_server.take_control (Tmp_m_feature_server)
			M_rout_id_server.take_control (Tmp_m_rout_id_server)
			M_desc_server.take_control (Tmp_m_desc_server)

				-- No need to do `Byte_server' and `Inv_byte_server' because
				-- it is done in `melt'. See comment in `melt' for rationale.
			--Byte_server.take_control (Tmp_byte_server)
			--Inv_byte_server.take_control (Tmp_inv_byte_server)
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code
		require
			il_generation: il_generation
		local
			il_generator: CIL_GENERATOR
			old_remover_off: BOOLEAN
		do
			create il_generator.make (Degree_output)
			il_generator.generate
			if (in_final_mode or freeze) and then externals.count > 0 then
				externals.freeze
				old_remover_off := remover_off
				remover_off := True
				if in_final_mode then
					create {FINAL_MAKER} makefile_generator.make
				else
					create {WBENCH_MAKER} makefile_generator.make
				end
				open_log_files
				freezing_occurred := True
				externals.generate_il
				close_log_files

				makefile_generator.generate_il
				remover_off := old_remover_off

				if not in_final_mode then
					private_freeze := False
				end
			end
			il_generator.deploy
		end

feature {NONE} -- IL generation

	check_full_class_name_unicity is
			-- Ensure that two classes or more in system do not have
			-- same IL full name, i.e. namespace + class name.
		require
			il_generation: System.il_generation
			classes_not_void: classes /= Void
		local
			i, nb: INTEGER
			l_table: HASH_TABLE [CLASS_C, STRING]
			l_conflicts: HASH_TABLE [SEARCH_TABLE [CLASS_C], STRING]
			l_list: SEARCH_TABLE [CLASS_C]
			l_class: CLASS_C
			l_name: STRING
			l_vifc: VIFC
			l_types: TYPE_LIST
		do
				-- Process done in two passes. First we collect all names
				-- and we collect conflicting one in `l_conflicts'.
				-- Once this is done, we process `l_conflicts' to create
				-- the associated VIFC error.
			from
				create l_table.make (classes.count)
				create l_conflicts.make (10)
				i := classes.lower
				nb := classes.upper
			until
				i > nb
			loop
				l_class := classes.item (i)
				if l_class /= Void then
						-- We now process each generic derivation in each class,
						-- as it might be possible that we will have a class
						-- called A_INT32 and a class A [INTEGER] which resolves
						-- to the same type and we don't want that to happen.
					from
						l_types := l_class.types
						l_types.start
					until
						l_types.after
					loop
						if l_types.item.is_generated then
								-- Compute full type name. We do not need to check the
								-- `full_il_implementation_type_name' as there is no way
								-- that an Eiffel class can have a `.' in its name.
							l_name := l_types.item.full_il_type_name

							if cls_compliant then
									-- CLS compliant prevent to have two types
									-- with full name that only differs by case.
								l_name := l_name.as_lower
							end

							if l_table.has (l_name) then
									-- This name has already been inserted, we
									-- record it in `l_conflicts' to report an error later.
								if l_conflicts.has (l_name) then
										-- An error has already been processed on this type,
										-- get list of classes involved to add current `l_class'.
									l_list := l_conflicts.item (l_name)
								else
										-- No error on `l_name', we create a new list.
									create l_list.make (2)
									l_conflicts.put (l_list, l_name)
								end
									-- Add classes involved in error.
								l_list.force (l_class)
								l_list.force (l_table.item (l_name))
							else
									-- Mark `l_class' as being processed.
								l_table.put (l_class, l_name)
							end
						end
						l_types.forth
					end
				end
				i := i + 1
			end

				-- Process `l_conflicts' and generate errors if any.
			from
				l_conflicts.start
			until
				l_conflicts.after
			loop
				create l_vifc.make (l_conflicts.item_for_iteration, l_conflicts.key_for_iteration)
				Error_handler.insert_error (l_vifc)
				l_conflicts.forth
			end

			Error_handler.checksum
		end

feature -- Freeezing

	freeze_system is
			-- Worrkbench C code generation
		require
			root_class.is_compiled
		do
			Eiffel_project.terminate_c_compilation
			freezing_occurred := True

				-- We are freezing our project, we need to reset `melted_file_name'
				-- to use `name'.
			Workbench.set_melted_file_name (Void)

			if Compilation_modes.is_precompiling then
				create {PRECOMP_MAKER} makefile_generator.make
			else
				create {WBENCH_MAKER} makefile_generator.make
			end
				-- Re-process dynamic types
			-- FIXME
			--process_dynamic_types

				-- Process the C pattern table
debug ("ACTIVITY")
	io.error.put_string ("pattern_table.process%N")
end
			pattern_table.process

debug ("ACTIVITY")
	io.error.put_string ("Clear the melted code servers%N")
end
				-- Clear the melted byte code servers
			m_feat_tbl_server.clear
			m_feature_server.clear
			m_rout_id_server.clear

debug ("ACTIVITY")
	io.error.put_string ("Shake%N")
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
			generate_expanded_structures

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
			exec_table: EXECUTION_TABLE
		do
				-- Compress execution table
			exec_table := execution_table

			if not first_compilation then
				exec_table.shake
			end

				-- Reset the frozen level since the execution table
				-- is re-built now.
			nb_frozen_features := exec_table.nb_frozen_features

				-- Freeze the external table.
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
			root_class_compiled: root_class.is_compiled
		local
			old_remover_off: BOOLEAN
			old_exception_stack_managed: BOOLEAN
			old_inlining_on, old_array_optimization_on: BOOLEAN
			deg_output: DEGREE_OUTPUT
			retried: BOOLEAN
			d1, d2: DATE_TIME
			l_assertions: CONF_ASSERTIONS
		do
			eiffel_project.terminate_c_compilation
			if not retried and is_finalization_needed then
					-- Reset `disposable_descendants' since they can have changed
					--| Note: That is important to recompute it, as this is a once
					--| which is not stored in the project file, therefore if we
					--| do a finalization where no classes have been modified it
					--| will be empty (because recomputed only in `do_recompilation
					--| if some classes have been modified) unless we force its recomputation.
				reset_disposable_descendants

				debug ("Timing")
					create d1.make_now
				end

					-- Set the generation mode in final mode
				byte_context.set_final_mode
				l_assertions := universe.target.options.assertions
				keep_assertions := keep_assert and then l_assertions /= Void and then l_assertions.has_assertions
				set_is_precompile_finalized (True)

				if il_generation then
					generate_il
					debug ("Timing")
						create d2.make_now
						print ("Degree -2/-3 duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
						create d1.make_now
					end
				else
						-- Set `Server_control' to remove right away extra unused
						-- files (especially done for the TMP_POLY_SERVER).
					Server_controler.set_remove_right_away (True)

						-- Initialize `TMP_POLY_SERVER' and `TMP_OPT_BYTE_SERVER'
					Tmp_poly_server.make
					Tmp_opt_byte_server.make

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

					process_degree_minus_2
					debug ("Timing")
						create d2.make_now
						print ("Degree -2 duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
						create d1.make_now
					end

						-- Dead code removal
					if not remover_off then
						deg_output := Degree_output
						deg_output.put_start_dead_code_removal_message
						remove_dead_code
						debug ("Timing")
							create d2.make_now
							print ("Dead code removal duration: ")
							print (d2.relative_duration (d1).fine_seconds_count)
							print ("%N")
							print_memory_statistics
							create d1.make_now
						end
						deg_output.put_end_dead_code_removal_message
					end
					tmp_opt_byte_server.flush

					-- FIXME
					--process_dynamic_types

						-- Build conformance table for CLASS_TYPE instances. This is
						-- needed for proper processing of computation of `is_polymorphic'
						-- on polymorphic table and computation of expanded descendants.
					process_conformance_table_for_type (agent {CLASS_TYPE}.build_conformance_table)

						-- Generation of C files associated to the classes of
						-- the system.
					Eiffel_table.start_degree_minus_3 (History_control.max_rout_id)
					byte_context.clear_system_data
					byte_context.compute_expanded_descendants
					process_degree_minus_3
					Eiffel_table.finish_degree_minus_3

					debug ("Timing")
						create d2.make_now
						print ("Degree -3 duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
					end

					generate_main_finalized_eiffel_files

						-- Clean Eiffel table and other system-wide tables
					Eiffel_table.wipe_out
					byte_context.clear_system_data
					Tmp_poly_server.clear
					Tmp_opt_byte_server.clear

						-- Clean conformance table for CLASS_TYPE instances. We don't need
						-- to store them on disk as they are recomputed at each finalization.
					process_conformance_table_for_type (agent {CLASS_TYPE}.reset_conformance_table)

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
				end

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
			Eiffel_table.wipe_out
			History_control.wipe_out
			successful := False

				-- Restore previous value.
			remover_off := old_remover_off
			exception_stack_managed := old_exception_stack_managed
			inlining_on := old_inlining_on
			array_optimization_on := old_array_optimization_on

				-- Clean conformance table for CLASS_TYPE instances. We don't need
				-- to store them on disk as they are recomputed at each finalization.
			process_conformance_table_for_type (agent {CLASS_TYPE}.reset_conformance_table)

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
			 a_class_is_removable: a_class.is_removable
		local
			compiled_root_class: CLASS_C
			supplier: CLASS_C
			supplier_clients: ARRAYED_LIST [CLASS_C]
			related_classes: LINKED_SET [CLASS_C]
			finished: BOOLEAN
			id: INTEGER
			types: TYPE_LIST
			eif_class: EIFFEL_CLASS_C
		do
			eif_class := a_class.eiffel_class_c
			id := a_class.class_id
			if system.class_of_id (id) /= Void then

					-- Force a recompilation
				set_melt

					-- Remove class from `unref_classes' if it is referenced.
					-- It is only done if class is directly removed. Removing
					-- `a_class' does not remove any subclasses from `unref_classes',
					-- so that they are recompiled back
				if a_depth = 0 then
					unref_classes.prune_all (eif_class.lace_class)
				end


				eif_class.remove_c_generated_files

					-- Update control flags of the topological sort
				moved := True

					-- Remove type check relations
				if eif_class.parents /= Void then
					eif_class.remove_relations
				end

					-- Remove externals defined in current removed class
				externals.remove (id)

					-- Remove class `a_class' from the lists of changed classes
				Degree_5.remove_class (eif_class)
				Degree_4.remove_class (eif_class)
				Degree_3.remove_class (eif_class)
				Degree_2.remove_class (eif_class)

					-- Mark the class to remove uncompiled
				eif_class.lace_class.reset_compiled_class

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
				Inv_ast_server.remove (id)
				Depend_server.remove (id)
				M_rout_id_server.remove (id)
				M_desc_server.remove (id)
				Tmp_inv_byte_server.remove (id)
				Tmp_ast_server.remove (id)
				Tmp_feat_tbl_server.remove (id)
				Tmp_depend_server.remove (id)
				Tmp_m_rout_id_server.remove (id)
				Tmp_m_desc_server.remove (id)

				Degree_1.remove_class (eif_class)
				Degree_minus_1.remove_class (eif_class)
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
					if not eif_class.syntactical_suppliers.after then
						supplier := eif_class.syntactical_suppliers.item
						related_classes.extend (supplier)
						supplier.suppliers.remove_class (eif_class)
						eif_class.syntactical_suppliers.forth
						finished := False
					end
					if not eif_class.syntactical_clients.after then
						supplier := eif_class.syntactical_clients.item
						related_classes.extend (supplier)
						supplier.suppliers.remove_class (eif_class)
						eif_class.syntactical_clients.forth
						finished := False
					end
					if not eif_class.clients.after then
						supplier := eif_class.clients.item
						related_classes.extend (supplier)
						supplier.suppliers.remove_class (eif_class)
						eif_class.clients.forth
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
					elseif supplier.has_dep_class (eif_class) then
							-- Is it enough to remove the dependecies only on a class
							-- which is still in the system, or should we do it for
							-- all the classes even the ones that we just removed from
							-- the system? In the last case, we should put the previous
							-- test one level up.
						supplier.remove_dep_class (eif_class)
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
			if not Result then
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
						a_class.eiffel_class_c.process_polymorphism
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
			Eiffel_project.delete_generation_directory (Final_generation_path, Void, Void) -- No agent
			create {FINAL_MAKER} makefile_generator.make
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
			l_class: CLASS_C
			root_feat: FEATURE_I
			ct: CLASS_TYPE
		do
				-- Note: To have dead code removal working when assertions are enabled
				-- we need to perform two things:
				-- 1 - record all invariants
				-- 2 - record all inherited assertions of a routine.
				-- We currently can do `1' but not `2'.

			create remover.make

			if array_optimization_on then
				remover.record_array_descendants
			end

				-- First, inspection of the Eiffel code
			if root_creation_name /= Void then
				l_class := root_class.compiled_class
				root_feat := l_class.feature_table.item (root_creation_name)
				remover.record (root_feat, l_class)
			end

			remover.mark_dispose
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				l_class := class_array.item (i)
				if
					l_class /= Void and then
					(not l_class.is_precompiled or else l_class.is_in_system)
				then
					if l_class.visible_level.has_visible then
						l_class.mark_visible (remover)
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
			l_class := array_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.Make_name_id), l_class)

				-- Protection of feature `make' of class STRING.
			l_class := string_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.Make_name_id), l_class)

				-- Protection of feature `make' of class TUPLE
			l_class := tuple_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.Make_name_id), l_class)

				-- Protection of feature `set_rout_disp' of ROUTINE classes
			l_class := routine_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_rout_disp_name_id), l_class)

				-- Protection of feature `internal_correct_mismatch' of ANY
			l_class := any_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.Internal_correct_mismatch_name_id), l_class)

				-- Protection of feature `twin' of ANY
			l_class := any_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.twin_name_id), l_class)

				-- Protection of feature `set_item' of `reference BOOLEAN'
			l_class := boolean_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference CHARACTER'
			l_class := character_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference WIDE_CHARACTER'
			l_class := wide_char_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference POINTER'
			l_class := pointer_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference TYPED_POINTER_ [G]'
			l_class := typed_pointer_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference REAL'
			l_class := real_32_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference DOUBLE'
			l_class := real_64_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference NATURAL_8'
			l_class := natural_8_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference NATURAL_16'
			l_class := natural_16_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference NATURAL_32'
			l_class := natural_32_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference NATURAL_64'
			l_class := natural_64_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference INTEGER_8'
			l_class := integer_8_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference INTEGER_16'
			l_class := integer_16_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference INTEGER_32'
			l_class := integer_32_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)

				-- Protection of feature `set_item' of `reference INTEGER_64'
			l_class := integer_64_class.compiled_class
			remover.record (l_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id), l_class)


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
			generate_expanded_structures

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
	io.error.put_string ("Process dynamic types%N")
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
	io.error.put_integer (new_type_id)
	io.error.put_string (": ")
	class_type.type.trace
	io.error.put_string (" [")
	io.error.put_integer (class_type.static_type_id)
	io.error.put_string ("]%N")
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
			l_rout_id: INTEGER
			l_buf: like generation_buffer
			l_header_buf: like header_generation_buffer
			l_table_name: STRING
			l_poly_file: INDENT_FILE
			l_rout_ids: ARRAYED_LIST [INTEGER]
		do
				-- Generate tables and their initialization routines.
			Attr_generator.init (generation_buffer)
			Rout_generator.init (header_generation_buffer)

			from
				used := Eiffel_table.used
				used.start
					-- Usually we do not have that many generic tables.
				create l_rout_ids.make (100)
			until
				used.after
			loop
				table := Tmp_poly_server.item (used.item_for_iteration)
				if table.has_type_table and then not table.has_one_type then
					l_rout_ids.extend (used.item_for_iteration)
				end
				table.write
				used.forth
			end

			generate_initialization_table
			generate_expanded_creation_table
			generate_dispose_table

			Attr_generator.finish
			Rout_generator.finish

				-- Call initialization routines for all tables used in system.
			l_buf := generation_buffer
			l_buf.clear_all
			l_header_buf := header_generation_buffer
			l_header_buf.clear_all

			l_header_buf.put_string ("#include %"eif_eiffel.h%"")
			l_header_buf.put_new_line
			l_header_buf.put_new_line
			l_header_buf.start_c_specific_code

			l_buf.put_new_line
			l_buf.put_new_line

				-- Initialize tables for routines.
			l_buf.put_string ("void egc_routine_tables_init (void) {")
			l_buf.put_new_line
			l_buf.indent
			from
				used.start
			until
				used.after
			loop
				l_rout_id := used.item_for_iteration
				l_table_name := Encoder.table_name (l_rout_id)
					-- Declare initialization routine for table
				l_header_buf.put_string ("extern void ")
				l_header_buf.put_string (l_table_name)
				l_header_buf.put_string ("_init(void);")
				l_header_buf.put_new_line

					-- Call the routine
				l_buf.put_string (l_table_name)
				l_buf.put_string ("_init();")
				l_buf.put_new_line
				used.forth
			end
				-- Initialize then table used for finding out
				-- redefinition of a generic type.
			from
				l_rout_ids.start
			until
				l_rout_ids.after
			loop
				l_rout_id := l_rout_ids.item
				l_table_name := Encoder.type_table_name (l_rout_id)
					-- Declare initialization routine for table
				l_header_buf.put_string ("extern void ")
				l_header_buf.put_string (l_table_name)
				l_header_buf.put_string ("_init(void);")
				l_header_buf.put_new_line

					-- Call the routine
				l_buf.put_string (l_table_name)
				l_buf.put_string ("_init();")
				l_buf.put_new_line
				l_rout_ids.forth
			end

				-- Generate initialization for special tables.
			from
				create l_rout_ids.make (3)
				l_rout_ids.extend (routine_id_counter.dispose_rout_id)
				l_rout_ids.extend (routine_id_counter.initialization_rout_id)
				l_rout_ids.extend (routine_id_counter.creation_rout_id)
				l_rout_ids.start
			until
				l_rout_ids.after
			loop
				l_rout_id := l_rout_ids.item
				l_table_name := Encoder.table_name (l_rout_id)
					-- Declare initialization routine for table
				l_header_buf.put_string ("extern void ")
				l_header_buf.put_string (l_table_name)
				l_header_buf.put_string ("_init(void);")
				l_header_buf.put_new_line

					-- Call the routine
				l_buf.put_string (l_table_name)
				l_buf.put_string ("_init();")
				l_buf.put_new_line
				l_rout_ids.forth
			end

			l_buf.exdent
			l_buf.put_string ("};")
			l_buf.put_new_line

			l_buf.end_c_specific_code
			create l_poly_file.make_c_code_file (final_file_name (epoly, dot_c, 1))
			l_header_buf.put_in_file (l_poly_file)
			l_buf.put_in_file (l_poly_file)
			l_poly_file.close
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
				buffer.put_string ("#include %"eif_eiffel.h%"%N%
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
					buffer.put_string ("0")
				end

				buffer.put_string (",%N")
				i := i + 1
			end
			buffer.put_string ("};%N")

			create size_file.make_c_code_file (x_gen_file_name (byte_context.final_mode, Esize))
			buffer.put_in_file (size_file)
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
				buffer.put_string ("%Nlong egc_fnbref_init[] = {%N")
			until
				i > nb
			loop
				class_type := class_types.item (i)

				if class_type /= Void then
					skeleton := class_type.skeleton
					nb_ref := skeleton.nb_reference
					nb_exp := skeleton.nb_expanded
					buffer.put_integer (nb_ref + nb_exp)
				else
					-- FIXME process_dynamic_types TEMPORARILY removed
					buffer.put_integer (0)
				end

				buffer.put_string (",%N")
				i := i + 1
			end
			buffer.put_string ("%N};%N")

			create reference_file.make_c_code_file (final_file_name (eref, dot_c, 1));
			buffer.put_in_file (reference_file)
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

			buffer.put_string ("#include %"eif_eiffel.h%"%N%N");

			buffer.start_c_specific_code


			from
				i := 1;
				max_id := 0;
				nb := Type_id_counter.value;
				create used_ids.make (0, nb);
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				if cl_type /= Void then
					cl_type.generate_parent_table (buffer, final_mode);
					cid := cl_type.type.generated_id (final_mode);
					used_ids.put (True, cid);
					if cid > max_id then
						max_id := cid;
					end
				end;
				i := i + 1;
			end;

			buffer.put_string ("int egc_partab_size_init = ")
			buffer.put_integer (max_id);
			buffer.put_string (";%N");
			buffer.put_string ("struct eif_par_types *egc_partab_init[] = {%N");

			from
				i := 0
			until
				i > max_id
			loop
				if used_ids.item (i) then
					buffer.put_string ("&par");
					buffer.put_integer (i);
				else
					buffer.put_string ("NULL");
				end;
				buffer.put_string (",%N");
				i := i + 1;
			end;
			buffer.put_string ("NULL};%N");
			buffer.end_c_specific_code

			create parents_file.make_c_code_file (gen_file_name (final_mode, Eparents));
			buffer.put_in_file (parents_file)
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

			buffer.put_string ("#include %"eif_eiffel.h%"%N")

			if not final_mode then
					-- Hash table extern declaration in workbench mode
				buffer.put_new_line
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
							buffer.put_string ("extern int32 ra")
							buffer.put_integer (j)
							buffer.put_string ("[];%N")
						end
						if a_class.has_visible then
							buffer.put_string ("extern char *cl")
							buffer.put_integer (j)
							buffer.put_string ("[];%N")
							buffer.put_string ("extern uint32 cr")
							buffer.put_integer (j)
							buffer.put_string ("[];%N")
						end
						if not a_class.skeleton.is_empty then
							from
								types := a_class.types
								types.start
							until
								types.after
							loop
								id := types.item.type_id
								buffer.put_string ("extern uint32 types")
								buffer.put_integer (id)
								buffer.put_string ("[];%N")
								types.forth
							end
						end
					end
					i := i + 1
				end
				buffer.put_new_line

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

			buffer.put_string ("struct cnode egc_fsystem_init[] = {%N")
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
						buffer.put_string ("{0L,%"INVALID_TYPE%",NULL,NULL,NULL,NULL,(uint16)0L,NULL,NULL}")
					end
				else
					cl_type.generate_skeleton2 (buffer)
				end
else
		-- FIXME
	if final_mode then
		buffer.put_string ("{0L,%"INVALID_TYPE%",NULL,NULL,NULL,NULL,(uint16)0L,NULL,NULL}")
	else
		buffer.put_string
			("{%N0L,%N%"INVALID_TYPE%",%NNULL,%NNULL,%N%
			%NULL,%NNULL,%N(uint16) 0L,%NNULL,%N0L,%N0L,%N%
			%(int32) 0L,(int32) 0L,%NNULL,%N%
			%{(int32) 0, (int) 0, NULL, NULL}}")
	end
end
				buffer.put_string (",%N")
				i := i + 1
			end
			buffer.put_string ("};%N%N")

			if not final_mode then
					-- Generate the array of routine id arrays
				buffer.put_string ("int32 *egc_fcall_init[] = {%N")
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
						buffer.put_string ("ra")
						buffer.put_integer (cl_type.associated_class.class_id)
					else
						buffer.put_string ("(int32 *) 0")
					end
					buffer.put_string (",%N")
					i := i + 1
				end
				buffer.put_string ("};%N%N")
					-- Generate the correspondances stable between original
					-- dynamic types and new dynamic types
				buffer.put_string ("int16 egc_fdtypes_init[] = {%N")
				from
					i := 1
				until
					i > nb
				loop
					buffer.flush_buffer (skeleton_file)
					cl_type := cltype_array.item (i)
					buffer.put_string ("(int16) ")
					if cl_type /= Void then
						buffer.put_type_id (cl_type.type_id)
					else
						buffer.put_integer (0)
					end
					buffer.put_string (",%N")
					i := i + 1
				end
				buffer.put_string ("};%N")
			end

			buffer.end_c_specific_code

				-- Generate skeleton
			buffer.put_in_file (skeleton_file)
			skeleton_file.close
		end

	generate_expanded_structures is
			-- Generate structures for expanded class types
		local
			i, nb: INTEGER
			cl_type: CLASS_TYPE
			final_mode: BOOLEAN
			structure_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
			nb := Type_id_counter.value
			final_mode := byte_context.final_mode

			if in_final_mode then
				create structure_file.make_c_code_file (final_file_name (estructure, Dot_x, 1));
			else
				create structure_file.make_c_code_file (workbench_file_name (estructure, Dot_h, 1));
			end

			buffer := generation_buffer
			buffer.clear_all

			buffer.put_string ("#ifndef _estructure_h_%N#define _estructure_h_%N%N")
			buffer.put_string ("#include %"eif_eiffel.h%"%N")

			buffer.start_c_specific_code

			from
				nb := Type_id_counter.value
				i := 1
			until
				i > nb
			loop
				cl_type := class_types.item (i)
					-- Classes could be removed
				if cl_type /= Void then
					if final_mode then
						if
							not cl_type.associated_class.is_precompiled or else
							cl_type.associated_class.is_in_system
						then
							cl_type.generate_expanded_structure_definition (buffer)
						end
					else
						cl_type.generate_expanded_structure_definition (buffer)
					end
				end
				i := i + 1
			end

			buffer.end_c_specific_code

				-- Close header file protection
			buffer.put_string ("#endif%N")

				-- Generate file to disk
			buffer.put_in_file (structure_file)
			structure_file.close
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
			l_has_visible: BOOLEAN
		do
				-- Clear buffers for current generation
			buffer := generation_buffer
			buffer.clear_all
			header_buffer := header_generation_buffer
			header_buffer.clear_all

			final_mode := byte_context.final_mode

			buffer.put_string ("#include %"eif_eiffel.h%"%N")
			buffer.put_string ("#include %"eif_cecil.h%"%N")
			if final_mode then
				buffer.put_string ("#include %"ececil.h%"%N")
			end

			buffer.start_c_specific_code

			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void then
					if a_class.has_visible then
						l_has_visible := True
						a_class.generate_cecil
					end
				end
				i := i + 1
			end

			if final_mode then
					-- Extern declarations for previous file
				header_buffer.put_string ("#include %"eif_eiffel.h%"%N%N")
				header_buffer.start_c_specific_code
				Extern_declarations.generate (header_buffer)
				header_buffer.end_c_specific_code
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
				header_buffer.put_in_file (header_file)
				header_file.close

				if not l_has_visible then
					buffer.put_string ("%Nstruct ctable egc_ce_rname_init[")
					buffer.put_string (Type_id_counter.value.out)
					buffer.put_string ("];%N")
				else
					buffer.put_string ("%Nstruct ctable egc_ce_rname_init[] = {%N")
					from
						i := 1
						nb := Type_id_counter.value
					until
						i > nb
					loop
						cl_type := class_types.item (i)
						if cl_type /= Void and then cl_type.associated_class.has_visible then
							cl_type.generate_cecil (buffer)
						else
							buffer.put_string ("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
						end
						buffer.put_string (",%N")
						i := i + 1
					end
					buffer.put_string ("};%N")
				end
			end

			create_cecil_tables
			cecil_class_table.generate

			buffer.end_c_specific_code

			create cecil_file.make_c_code_file (gen_file_name (final_mode, Evisib));
			buffer.put_in_file (cecil_file)
			cecil_file.close
		end

	create_cecil_tables is
			-- Prepare cecil tables
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
		do
			class_array := classes
			nb := class_counter.count
			cecil_class_table.init (classes.count)
			from
				i := 1
			until
				i > nb
			loop
				a_class := class_array.item (i)
				if a_class /= Void then
					cecil_class_table.put (a_class, a_class.external_name)
				end
				i := i + 1
			end
		end

	generate_initialization_table is
			-- Generate table of initialization routines for composite objects
		local
			rout_table: ROUT_TABLE
			rout_entry: ROUT_ENTRY
			i, nb: INTEGER
			class_type: CLASS_TYPE
			l_void: VOID_I
		do
			if remover /= Void then
					-- Ensure that initialization routines are marked `used'.
				remover.used_table.put (True, body_index_counter.initialization_body_index)
			end
			from
				create rout_table.make (routine_id_counter.initialization_rout_id)
				create l_void
				i := 1
				nb := Type_id_counter.value
				rout_table.create_block (nb)
			until
				i > nb
			loop
				class_type := class_types.item (i)
				if class_type /= Void and then class_type.has_creation_routine then
					create rout_entry
					rout_entry.set_type_id (i)
					rout_entry.set_type (l_void)
					rout_entry.set_written_type_id (i)
					rout_entry.set_body_index (body_index_counter.initialization_body_index)
					rout_table.extend (rout_entry)
				end
				i := i + 1
			end
			rout_table.sort
			rout_table.generate_full (routine_id_counter.initialization_rout_id,
													header_generation_buffer)
		end

	generate_expanded_creation_table is
			-- Generate table of creation procedures for all expanded objects.
		local
			rout_table: ROUT_TABLE
			rout_entry: ROUT_ENTRY
			i, nb: INTEGER
			class_type: CLASS_TYPE
			l_class: CLASS_C
			l_void: VOID_I
		do
			from
				create rout_table.make (routine_id_counter.creation_rout_id)
				create l_void
				i := 1
				nb := Type_id_counter.value
				rout_table.create_block (nb)
			until
				i > nb
			loop
				class_type := class_types.item (i)
				if class_type /= Void then
					l_class := class_type.associated_class
					if
						(l_class.is_used_as_expanded and l_class.creation_feature /= Void) and then
						(l_class.creation_feature.is_external or else not l_class.creation_feature.is_empty)
					then
						create rout_entry
						rout_entry.set_type_id (i)
						rout_entry.set_type (l_void)
						rout_entry.set_written_type_id (
							l_class.implemented_type (l_class.creation_feature.written_in,
								class_type.type).type_id)
						rout_entry.set_body_index (l_class.creation_feature.body_index)
						rout_table.extend (rout_entry)
					end
				end
				i := i + 1
			end
			rout_table.sort
			rout_table.generate_full (routine_id_counter.creation_rout_id,
													header_generation_buffer)
		end

feature -- Dispose routine

	disposable_dispose_id: INTEGER is
			-- Dispose routine id from class DISPOSABLE.
			-- Return 0 if the DISPOSABLE class has not been compiled.
			--! (Assumed DISPOSABLE must have a dispose routine
			--! called "dispose" - DINOV).
		local
			feature_i: FEATURE_I
		once
			if disposable_class /= Void and disposable_class.is_compiled then
				feature_i := disposable_class.compiled_class.feature_table.item_id (names.dispose_name_id)
				if feature_i /= Void then
					Result := feature_i.rout_id_set.first
				end
			end
		end

	object_finalize_id: INTEGER is
			-- System.Object `Finalize routine id from class SYSTEM_OBJECT.
		local
			feature_i: FEATURE_I
		once
			if system_object_class /= Void and system_object_class.is_compiled then
				feature_i := system_object_class.compiled_class.feature_table.item_id (names.finalize_name_id)
				if feature_i /= Void then
					Result := feature_i.rout_id_set.first
				end
			end
		end

	disposable_descendants: SEARCH_TABLE [CLASS_C] is
			-- DISPOSABLE descendants.
		once
			create Result.make (50)
		end

	reset_disposable_descendants is
			-- Recompute `disposable_descendants' since some classes
			-- may not inherit from DISPOSABLE anymore.
		do
				-- Delete previous information
			disposable_descendants.clear_all

				-- Recompute it if DISPOSABLE is in system.
			if disposable_class /= Void and disposable_class.is_compiled then
				formulate_mem_descendants (disposable_class.compiled_class, disposable_descendants)
			end
		end

	formulate_mem_descendants (c: CLASS_C; desc: SEARCH_TABLE [CLASS_C]) is
			-- Formulate descendants of class DISPOSABLE.
		local
			descendants: ARRAYED_LIST [CLASS_C]
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
			if disposable_class /= Void and then disposable_class.is_compiled then
					-- Get the polymorphic table corresponding to the `dispose' routine
					-- from DISPOSABLE.
				entry ?= Eiffel_table.poly_table (disposable_dispose_id)
			end
			if entry = Void then
					-- Create an empty table needed as runtime expect this table
					-- to exist.
				create entry.make (routine_id_counter.dispose_rout_id)
			end
				-- We are using `header_generation_buffer' for the generation
				-- because this is used for routine tables (look at
				-- `generate_routine_table').
				-- We are using `routine_id_counter.dispose_rout_id' and not
				-- `disposable_dispose_id' to generate the table, because we are not
				-- generating a standard polymorphic table and so, we cannot reuse the
				-- one which could have been generated if there was any polymorphic
				-- call on `dispose'.
			entry.generate_full (routine_id_counter.dispose_rout_id,
											header_generation_buffer)
		end

feature -- Pattern table generation

	generate_pattern_table is
			-- Generate pattern table.
		do
			pattern_table.generate
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

			if not Compilation_modes.is_precompiling and then root_creation_name /= Void then
				root_feat := root_cl.feature_table.item (root_creation_name)
				has_argument := root_feat.has_arguments
				rout_id := root_feat.rout_id_set.first
			end

			buffer.put_string ("#include %"eif_eiffel.h%"%N%N")

			buffer.start_c_specific_code

			if root_creation_name /= Void then
				if final_mode then
					rout_table ?= Eiffel_table.poly_table (rout_id)
					rout_table.goto_implemented (cl_type.type_id)
					check
						is_implemented: rout_table.is_implemented
					end
					c_name := rout_table.feature_name.twin
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

--			buffer.put_string ("#ifndef EIF_THREADS%N%
--											%%Textern char *root_obj;%N%
--											%#endif%N")

			buffer.put_string ("%Troot_obj = RTLN(")
			if final_mode then
				buffer.put_integer (dtype)
			else
				buffer.put_string ("egc_rcdt")
			end
			buffer.put_string (");%N")

			if final_mode then
				if root_creation_name /= Void then
					buffer.put_string ("%T")
					buffer.put_string (c_name)
					buffer.put_string ("(root_obj")
					if root_feat.has_arguments then
						buffer.put_string (", argarr(argc, argv)")
					end
					buffer.put_string (");%N")
				end
			else
				buffer.put_string ("%Tif (egc_rcorigin != -1) {%N%
					%%T%Tif (egc_rcarg) {%N%
					%%T%T%T(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_REFERENCE)) RTWPF(egc_rcorigin, egc_rcoffset, egc_rcdt))(root_obj, argarr(argc, argv));%N%
					%%T%T} else {%N%
					%%T%T%T(FUNCTION_CAST(void, (EIF_REFERENCE)) RTWPF(egc_rcorigin, egc_rcoffset, egc_rcdt))(root_obj);%N%T%T}%N%T}%N")
			end

			buffer.put_string ("%N}%N")

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
						buffer.generate_extern_declaration ("void", Encoder.init_name (cl_type.static_type_id), <<>>)
					end
					i := i + 1
				end


				buffer.put_string ("%Nvoid egc_tabinit_init(void)%N{%N")
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
						buffer.put_character ('%T')
						buffer.put_string (Encoder.init_name (cl_type.static_type_id))
						buffer.put_string ("();%N")
					end
					i := i + 1
				end
				buffer.put_string ("}%N%N")

				buffer.generate_function_signature ("void", "egc_einit_init", True, buffer, <<>>, <<>>)

					-- Set C variable `ccount'.
				buffer.put_string ("%Tccount = ")
				buffer.put_integer (class_counter.count)

					-- Set maximum routine body index
				buffer.put_string (";%N%Teif_nb_org_routines = ")
				buffer.put_integer (body_index_counter.count)

					-- Set the frozen level
				buffer.put_string (";%N%Teif_nb_features = ")
				buffer.put_integer (nb_frozen_features)
				buffer.put_string (";%N}%N%N")
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
									"void", Encoder.module_init_name (cl_type.static_type_id), <<>>)
					end
				end
				i := i + 1
			end

				-- Declare once data fields
			byte_context.generate_once_data_definition (buffer)

			-- Module initialization
			buffer.generate_function_signature (
				"void", "egc_system_mod_init_init", True, buffer, <<>>, <<>>)

			buffer.put_new_line
			buffer.indent

			if license.is_evaluating then
					-- Set egc_type_of_gc = 25 * egc_platform_level + egc_compiler_tag - 1
				buffer.put_string ("egc_type_of_gc = 123173;")
			else
					-- Set egc_type_of_gc = 25 * egc_platform_level + egc_compiler_tag
				buffer.put_string ("egc_type_of_gc = 123174;")
			end
			buffer.put_new_line

			if final_mode and then not byte_context.is_static_system_data_safe then
					-- Set maximum routine body index
				buffer.put_string ("eif_nb_org_routines = ")
				buffer.put_integer (body_index_counter.count)
				buffer.put_character (';')
				buffer.put_new_line
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
						buffer.put_string (Encoder.module_init_name (cl_type.static_type_id))
						buffer.put_string ("();")
						buffer.put_new_line
					end
				end
				i := i + 1
			end

			byte_context.generate_system_once_data_initialization (buffer)

			buffer.exdent
			buffer.put_new_line
			buffer.put_string ("}%N%N")

			byte_context.generate_once_manifest_string_declaration (buffer)

			buffer.end_c_specific_code

			create initialization_file.make_c_code_file (gen_file_name (final_mode, Einit));
			buffer.put_in_file (initialization_file)
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

				create rout_info_file.make_c_code_file (workbench_file_name (Ecall, dot_c, 1));
				buffer.put_in_file (rout_info_file)
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

			buffer.put_string ("#include %"eif_eiffel.h%"%N%
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
			buffer.put_string ("struct eif_opt egc_foption_init[] = {%N")
			from
				i := 1
				nb := Type_id_counter.value
			until
				i > nb
			loop
				class_type := class_types.item (i)
				buffer.put_character ('{')
				if class_type /= Void then
						-- Classes could be removed
					a_class := class_type.associated_class
					a_class.assertion_level.generate (buffer)
					buffer.put_string (", ")
					a_class.trace_level.generate (buffer)
					buffer.put_string (", ")
					a_class.profile_level.generate (buffer)
					buffer.put_string (", ")
					a_class.debug_level.generate (buffer, a_class.class_id)
				else
					buffer.put_string ("(int16) 0, (int16) 0, (int16) 0,%
						%{(int16) 0, (int16) 0, (char **) 0}")
				end
				buffer.put_string ("},%N")
				i := i + 1
			end
			buffer.put_string ("};%N")
			buffer.end_c_specific_code

			create option_file.make_c_code_file (workbench_file_name (Eoption, dot_c, 1));
			buffer.put_in_file (option_file)
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
		end

	reset_lace_options is
			-- Reset all system level options to their default value.
		do
			set_remover_off (False)
			set_array_optimization_on (False)
			set_inlining_on (False)
			set_inlining_size (4)
			set_exception_stack_managed (False)
			server_controler.set_block_size (1024)
			set_do_not_check_vape (False)
			allow_address_expression (False)
			set_dynamic_def_file (Void)
			set_external_runtime (Void)
			set_il_verifiable (True)
			set_msil_key_file_name (Void)
			set_msil_generation_type ("exe")
			set_msil_culture (Void)
			set_system_namespace (Void)
			set_use_cluster_as_namespace (True)
			set_use_all_cluster_as_namespace (True)
			set_check_generic_creation_constraint (True)
			set_has_syntax_warning (False)
			set_msil_use_optimized_precompile (False)
			msil_version := Void
			msil_assembly_compatibility := Void
			set_line_generation (False)
			metadata_cache_path := overridden_metadata_cache_path
		end

	reset_loaded_precompiled_properties is
			-- Resets all loaded precompiled properties that interfer
			-- with a projects properties
		do
			is_precompiled := False
			has_precompiled_preobj := False
			cls_compliant := False
			dotnet_naming_convention := False
			internal_msil_classes_per_module := 0
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

	set_is_precompile_finalized (b: like is_precompile_finalized) is
			-- Assign `b' to `is_finalized'
		do
			is_precompile_finalized := b
		ensure
			is_precompile_finalized_set: is_precompile_finalized = b
		end

	root_class: CLASS_I is
			-- Root class of the system
		require
			root_cluster /= Void
			root_class_name /= Void
		do
			if root_cluster.classes_set then
				Result ?= root_cluster.classes.item (root_class_name)
			end
		ensure
			Computed_Result_not_void: root_cluster.classes_set implies Result /= Void
			Not_computed_void: not root_cluster.classes_set implies Result = Void
		end

feature -- Precompilation

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

feature {NONE} -- Conveniences.

	print_memory_statistics is
			-- Print memory statistics on standard output.
		local
			l_mem: MEMORY
			l_mem_info: MEM_INFO
		do
			create l_mem
			l_mem_info := l_mem.memory_statistics ({MEM_CONST}.eiffel_memory)
			print ("Total memory is " + l_mem_info.total.out + "%N")
			print ("Used memory is " + (l_mem_info.used + l_mem_info.overhead).out + "%N")
			print ("Free memory is " + l_mem_info.free.out + "%N%N")
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
			"C signature (time_t *): EIF_INTEGER use <time.h>"
		alias
			"time"
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

end -- class SYSTEM_I
