note
	description: "Internal representation of a system."

class SYSTEM_I

inherit
	BASIC_SYSTEM_I
	CLASS_ID_VALIDATOR
		rename
			has as has_existing_class_of_id,
			is_valid as has_class_of_id
		end

	SYSTEM_SERVER
		rename
			make as server_make
		end

	SYSTEM_OPTIONS

	SYSTEM_DESCRIPTION

	SYSTEM_DOCUMENTATION

	SYSTEM_EXPORT

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

	SHARED_OVERRIDDEN_METADATA_CACHE_PATH

	KL_SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	CONF_ACCESS

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_STATEFUL_VISITOR
		export
			{NONE} all
		end

	SHARED_COMPILER_PROFILE

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make
			-- Create the system.
		do
			set_compilation_id (1)

				-- Use names heap created from parser library.
			names := Workbench.names_heap

				-- Set up working environment to use current as SYSTEM_I instance.
			Workbench.set_system (Current)


				-- Creation of all the servers.
			server_make

				-- Creation of the system hash table
			create class_types.make_filled (Void, 1, System_chunk)
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
			create feature_counter.make

				-- Routine table controler creation
			create history_control.make
			create instantiator.make

				-- External table creation
			create externals.make (10)

				-- Pattern table creation
			create pattern_table.make
			create separate_patterns.make

				-- Freeze control sets creation
			create degree_minus_1.make

				-- Body index table creation
			create body_index_table.make_filled (0, 0, System_chunk)
			create original_body_index_table.make_empty

				-- Run-time table creation
			create execution_table.make
			create rout_info_table.make (500)
			create optimization_tables.make (300)

				-- Address table
			create address_table.make

				-- Real removed classes
			create real_removed_classes.make (10)

				-- create root lists
				--
				-- Note: for now all root lists are initialized with a capacity of 2, one for the root class
				--       obtained from the configuration and one for the testing root class
			create root_creators.make (2)
			create explicit_roots.make

				-- Create test system
			create test_system
		end

feature -- Counters

	routine_id_counter: ROUTINE_COUNTER
			-- Counter for routine ids

	feature_counter: COMPILER_COUNTER
			-- Counter for FEATURE_I objects.

	class_counter: CLASS_COUNTER
			-- Counter of classes

	static_type_id_counter: TYPE_COUNTER
			-- Counter of instances of CLASS_TYPE

	body_index_counter: BODY_INDEX_COUNTER
			-- Body index counter

	feature_as_counter: COMPILER_COUNTER
			-- Counter of instances of FEATURE_AS

	init_counters
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
			server_controler.file_counter.append (server_controler.file_counter)
		end

feature -- Properties

	is_rebuild: BOOLEAN
			-- Do we have to do a full rebuild (because some classes could not be found).

	is_using_new_special: BOOLEAN
			-- Are we using the new SPECIAL implementation, i.e. with
			-- `make_empty' as creation procedure?
		do
			Result := not compiler_profile.is_compatible_mode
		end

	is_using_new_generating_type: BOOLEAN
			-- Are we using the new signature of `{ANY}.generating_type' which
			-- returns an instance of TYPE [like Current]?
		do
			Result := not compiler_profile.is_compatible_mode
		end

	rout_info_table: ROUT_INFO_TABLE
			-- Global routine info table
			-- rout_id --> (origin/offset)

	sorter: CLASS_SORTER
			-- Topological sorter on classes

	type_id_counter: COUNTER
			-- Counter of valid instances of CLASS_TYPE

	class_types: ARRAY [detachable CLASS_TYPE]
			-- Array of class types indexed by their `type_id'

	skeleton_table: HASH_TABLE [STRING, STRING]
			-- Table where all the offsets/sizes generated in finalized mode are stored.
			-- It is then used to generate a header file that has a mapping between macros and the
			-- actual macro for computing the object size. This is to avoid having to generate
			-- `Dot_x' files in finalized mode.

	pattern_table: PATTERN_TABLE
			-- Pattern table

	separate_patterns: SEPARATE_PATTERNS
			-- Patterns for separate feature calls

	address_table: ADDRESS_TABLE
			-- Generate encapsulation of function pointers ($ operator)

	successful: BOOLEAN
			-- Was the last recompilation successful?

	has_warning: BOOLEAN
			-- Were there warnings during last compilation?

	is_config_changed: BOOLEAN
			-- Has configuration file changed?

	has_potential_class_name_mismatch: BOOLEAN
			-- Did we find a file in which there is a class name whose name is different
			-- than its file name?

	has_been_changed: BOOLEAN
			-- Did last recompilation changed data of compiler?

	has_compilation_started: BOOLEAN
			-- Has compilation part after processing configuration started?

	freeze: BOOLEAN
			-- Has the system to be frozen again ?
		do
			Result := (not Lace.compile_all_classes or else compilation_modes.is_precompiling or else il_generation)
					and then (is_freeze_requested or else Compilation_modes.is_freezing)
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

	compilation_straight: BOOLEAN
			-- Is the first compilation of the system straight?
			-- IE: Without any incrementality (ie: Compilation from scratch without errors, etc)

	project_creation_time: INTEGER
			-- Time of creation of current project.

	marked_precompiled_classes: BOOLEAN
			-- Is it the first compilation of the system
			-- using a precompiled library?

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

	real_removed_classes: SEARCH_TABLE [CLASS_I]
			-- List of removed classes form configuration system.
			-- ie. classes that have been removed from disk.

	missing_classes: HASH_TABLE [ARRAYED_LIST [TUPLE [CLASS_C, LOCATION_AS]], INTEGER]
			-- Table indexed by missing classnames where elements are
			-- classes referencing the missing classname.

	unref_classes_snapshot: like unref_classes
			-- Snapshot of `unref_classes'
		do
			Result := unref_classes.twin
		end

	missing_classes_warning: like missing_classes
			-- Table indexed by missing classnames for which we only generate a
			-- warning where elements are classes referencing the missing classname.

	moved: BOOLEAN
			-- Has the system potentially moved in terms of classes ?
			-- [Each time a new class is inserted/removed in/from the system
			-- a topological sort has to be done.]

	update_sort: BOOLEAN
			-- Has the conformance table to be updated ?
			-- [A class id has changed beetween two recompilation.]

	max_class_id: INTEGER
			-- Greater class id: computed by class CLASS_SORTER

	min_type_id: INTEGER = 1
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

	set_array_make_name (a_name: STRING)
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

	init
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
			local_workbench.change_class (routine_class)
			local_workbench.change_class (procedure_class)
			local_workbench.change_class (function_class)
			local_workbench.change_class (predicate_class)
			local_workbench.change_class (typed_pointer_class)
			local_workbench.change_class (type_class)
			if rt_extension_class /= Void then
				local_workbench.change_class (rt_extension_class)
			end

			if il_generation then
				local_workbench.change_class (native_array_class)
				local_workbench.change_class (system_string_class)
				local_workbench.change_class (system_type_class)
				local_workbench.change_class (arguments_class)
			end

			local_workbench.change_class (string_8_class)
			local_workbench.change_class (string_32_class)
			local_workbench.change_class (immutable_string_8_class)
			local_workbench.change_class (immutable_string_32_class)

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
			local_workbench.change_class (character_8_class)
			local_workbench.change_class (character_32_class)
			local_workbench.change_class (boolean_class)

				-- Exception manager
			local_workbench.change_class (ise_exception_manager_class)
			if exception_class /= Void then
				local_workbench.change_class (exception_class)
			end

			protected_classes_level := boolean_class.compiled_class.class_id
				-- The root class is not protected
			root_creators.do_all (
				agent (l_root: SYSTEM_ROOT; l_wkbench: WORKBENCH_I)
					do
						l_wkbench.change_class (l_root.root_class)
					end (?, local_workbench))
		end

	mark_only_used_precompiled_classes
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
			character_8_class.compiled_class.record_precompiled_class_in_system
			character_32_class.compiled_class.record_precompiled_class_in_system
			string_8_class.compiled_class.record_precompiled_class_in_system
			string_32_class.compiled_class.record_precompiled_class_in_system
			immutable_string_8_class.compiled_class.record_precompiled_class_in_system
			immutable_string_32_class.compiled_class.record_precompiled_class_in_system
			special_class.compiled_class.record_precompiled_class_in_system
			pointer_class.compiled_class.record_precompiled_class_in_system
			array_class.compiled_class.record_precompiled_class_in_system
			tuple_class.compiled_class.record_precompiled_class_in_system
			routine_class.compiled_class.record_precompiled_class_in_system
			procedure_class.compiled_class.record_precompiled_class_in_system
			function_class.compiled_class.record_precompiled_class_in_system
			predicate_class.compiled_class.record_precompiled_class_in_system
			typed_pointer_class.compiled_class.record_precompiled_class_in_system
			type_class.compiled_class.record_precompiled_class_in_system
			if rt_extension_class /= Void and then rt_extension_class.is_compiled then
				rt_extension_class.compiled_class.record_precompiled_class_in_system
			end

				-- Exception manager
			ise_exception_manager_class.compiled_class.record_precompiled_class_in_system
			if exception_class /= Void and then exception_class.is_compiled then
				exception_class.compiled_class.record_precompiled_class_in_system
			end

			if il_generation then
				native_array_class.compiled_class.record_precompiled_class_in_system
				system_string_class.compiled_class.record_precompiled_class_in_system
				arguments_class.compiled_class.record_precompiled_class_in_system
				system_type_class.compiled_class.record_precompiled_class_in_system
			end

				-- The root class could be part of the precompiled library, so
				-- we need to make sure that its `is_in_system' flag is set.
			root_creators.do_all (
				agent (a_root: SYSTEM_ROOT)
					local
						cl: CLASS_C
					do
						cl := a_root.class_type.base_class
						if cl.original_class.is_compiled and then
						   cl.is_precompiled then
							cl.record_precompiled_class_in_system
						end
					end)
		end

	add_unref_class (a_class: CLASS_I)
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

	remove_unref_class (a_class: CLASS_I)
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

	insert_new_class (a_class: CLASS_C)
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

	record_new_class_i (a_class: CLASS_I)
			-- Record a new CLASS_I
			-- Used during the time check and the genericity check after pass1
		do
			new_class := True
			new_classes.put_front (a_class)
		end

	remove_class (a_class: CLASS_C)
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

	record_potential_vtct_error (a_class: CLASS_C; a_name: ID_AS)
			-- Record missing class name `a_name' in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_name_not_void: a_name /= Void
		local
			locations: ARRAYED_LIST [TUPLE [CLASS_C, LOCATION_AS]]
			name_id: INTEGER
		do
			if missing_classes = Void then
				create missing_classes.make (5)
			end
			name_id := a_name.name_id
			missing_classes.search (name_id)
			if missing_classes.found then
				locations := missing_classes.found_item
			else
				create locations.make (1)
				missing_classes.put (locations, name_id)
			end
			locations.extend ([a_class, a_name])
		end

	record_potential_vtcm_warning (a_class: CLASS_C; a_name: ID_AS)
			-- Record missing class name `a_name' in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_name_not_void: a_name /= Void
		local
			locations: ARRAYED_LIST [TUPLE [CLASS_C, LOCATION_AS]]
			name_id: INTEGER
		do
			if missing_classes_warning = Void then
				create missing_classes_warning.make (5)
			end
			name_id := a_name.name_id
			missing_classes_warning.search (name_id)
			if missing_classes_warning.found then
				locations := missing_classes_warning.found_item
			else
				create locations.make (1)
				missing_classes_warning.put (locations, name_id)
			end
			locations.extend ([a_class, a_name])
		end

	report_vtct_errors
			-- Report any remaining VTCT errors at the end of degree 5
		local
			l_name: STRING
			l_class: CLASS_C
			locations: ARRAYED_LIST [TUPLE [c: CLASS_C; l: LOCATION_AS]]
			location: TUPLE [c: CLASS_C; l: LOCATION_AS]
			l_has_error: BOOLEAN
			l_agent_sorter: AGENT_EQUALITY_TESTER [VTCT]
			l_sorter: QUICK_SORTER [VTCT]
			l_list: ARRAYED_LIST [VTCT]
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
					locations := missing_classes.item_for_iteration
					l_name := names.item (missing_classes.key_for_iteration)
					from
						locations.start
					until
						locations.after
					loop
						location := locations.item_for_iteration
						l_class := location.c
							-- At this stage classes have not yet been removed, so we simply
							-- look into `removed_classes'.
						if
							l_class.original_class.is_compiled and
							not (removed_classes /= Void and then removed_classes.has (l_class))
						then
							check
								same_compiled_class: l_class.original_class.compiled_class = l_class
							end
								-- If class is still compiled then we should report the error.
							l_list.extend (create {VTCT}.make (l_name, location.l, l_class))

								-- But since it is an invalid class, then we need to force
								-- a compilation again to check for the VTCT error again.
							workbench.add_class_to_recompile (l_class.original_class)
							l_class.set_changed (True)
							l_has_error := True
						end
						locations.forth
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

	report_vtcm_warnings
			-- Report any remaining VTCM warnings at the end of degree 5
		local
			l_name: STRING
			l_class: CLASS_C
			locations: ARRAYED_LIST [TUPLE [c: CLASS_C; l: LOCATION_AS]]
			location: TUPLE [c: CLASS_C; l: LOCATION_AS]
			l_has_error: BOOLEAN
			l_agent_sorter: AGENT_EQUALITY_TESTER [VTCM]
			l_sorter: QUICK_SORTER [VTCM]
			l_list: ARRAYED_LIST [VTCM]
		do
			if missing_classes_warning /= Void then
				from
						-- `l_list' is used to display errors in alphabetical order
						-- This is mostly interesting for eweasel as the compiler does
						-- not always give you the same order depending on the way
						-- classes are written.
					create l_list.make (missing_classes_warning.count)
					missing_classes_warning.start
				until
					missing_classes_warning.after
				loop
					locations := missing_classes_warning.item_for_iteration
					l_name := names.item (missing_classes_warning.key_for_iteration)
					from
						locations.start
					until
						locations.after
					loop
						location := locations.item_for_iteration
						l_class := location.c
							-- At this stage classes have not yet been removed, so we simply
							-- look into `removed_classes'.
						if
							l_class.original_class.is_compiled and
							not (removed_classes /= Void and then removed_classes.has (l_class))
						then
							check
								same_compiled_class: l_class.original_class.compiled_class = l_class
							end
								-- If class is still compiled then we should report the error.
							l_list.extend (create {VTCM}.make (l_name, location.l, l_class))
							l_has_error := True
						end
						locations.forth
					end
					missing_classes_warning.forth
				end

				missing_classes_warning := Void

				if l_has_error then
					create l_agent_sorter.make (agent {VTCM}.less_than)
					create l_sorter.make (l_agent_sorter)
					l_sorter.sort (l_list)
					across l_list as w loop
						error_handler.insert_warning (w.item, w.item.associated_class.is_warning_reported_as_error (w_export_class_missing))
					end
				end
			end
		end

	has_class_of_id (id: INTEGER): BOOLEAN
			-- Is `id' a valid class ID?
		do
			Result := classes.valid_index (id)
		end

	has_existing_class_of_id (class_id: like {CLASS_C}.class_id): BOOLEAN
			-- Is class of ID `id` in the system?
		do
			Result := attached classes [class_id]
		end

	class_of_id (id: INTEGER): CLASS_C
			-- Class of id `id'
		require
			id_not_void: id /= 0
			is_valid_class_id: has_class_of_id (id)
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

	class_type_of_id (a_type_id: INTEGER): CLASS_TYPE
			-- Class type of type id `a_type_id'.
		require
			index_small_enough: class_types.valid_index (a_type_id)
		do
			Result := class_types.item (a_type_id)
		ensure
			valid_class_type: Result /= Void implies Result.type_id = a_type_id
		end

	class_type_of_static_type_id (id: INTEGER): CLASS_TYPE
			-- Class type of static type id `id'.
		local
			cts: ARRAY [CLASS_TYPE]
			i: INTEGER
		do
			cts := class_types
			from
				i := cts.lower
			until
				i > cts.upper or Result /= Void
			loop
				Result := cts [i]
				if Result /= Void and then Result.static_type_id /= id then
					Result := Void
				end
				i := i + 1
			end
		end

	insert_class_type (class_type: CLASS_TYPE)
			-- Insert `class_type' in `class_types'.
		require
			good_argument: class_type /= Void
			index_big_enough: class_type.type_id > 0
			no_class_type_present: class_types.valid_index (class_type.type_id) implies
				class_types.item (class_type.type_id) = Void
		local
			a_type_id: INTEGER
		do
			a_type_id := class_type.type_id
			if a_type_id > class_types.count then
				class_types.conservative_resize_with_default (Void, 1, a_type_id + System_chunk)
			end
			class_types.put (class_type, a_type_id)
		end

	remove_class_type (class_type: CLASS_TYPE)
			-- Remove `class_type' from `class_types' and associated
			-- generated files if any.
		require
			good_argument: class_type /= Void
			index_big_enough: class_type.type_id > 0
		do
			class_types.put (Void, class_type.type_id)
			class_type.remove_c_generated_files
		end

	rebuild_configuration
			-- Build or rebuild the configuration information
		local
			l_vis_build: CONF_BUILD_VISITOR
			l_classes: SEARCH_TABLE [CONF_CLASS]
			l_conf_class: CONF_CLASS
			l_class_i: CLASS_I
			l_errors, l_warnings: LIST [CONF_ERROR]
			vd71: VD71
			vd80: VD80
			vd25: VD25
			l_target: CONF_TARGET
			l_file: PLAIN_TEXT_FILE
			d1, d2: DATE_TIME
			l_factory: CONF_COMP_FACTORY
			l_state: CONF_STATE
			w: ARRAYED_LIST [ERROR]
		do
			debug ("timing")
				print_memory_statistics
				create d1.make_now
			end

			if equal (universe.new_target, universe.target) or else universe.new_target = Void then
				lace.force_new_target
					-- Remove previously reported configuration  warnings.
				from
					w := error_handler.warning_list
					w.start
				until
					w.after
				loop
					if
						attached {VD01} w.item or else
						attached {VD80} w.item or else
						attached {VD81} w.item
					then
						w.remove
					else
						w.forth
					end
				end
				lace.recompile
			end

			create l_factory
			l_target := universe.new_target

			check
				l_target_not_void: l_target /= Void
			end

				-- We need to check that there is a root, otherwise compiler
				-- would crash later in `update_root_class'. See eweasel test#incr380.
			if l_target.root = Void then
				create vd25.make (l_target.name)
				Error_handler.insert_error (vd25)
				Error_handler.raise_error
			else
					-- Check for testing library in current config
				test_system.check_for_testing_configuration (l_target)

					-- Use target's settings for compilation.
					-- This should be done before any class options are set (test#config049),
					-- but only once per compilation so that updated options are not
					-- used for capability checks.
				lace.update_capabilities

					-- let the configuration system build "everything"
				l_state := universe.conf_state_from_target (l_target)
				if universe.target /= Void then
					create l_vis_build.make_build_from_old
						(l_state,
						l_target,
						universe.target,
						if il_generation then metadata_cache_path else {STRING_32} "" end,
						if il_generation then clr_runtime_version else {STRING_32} "" end,
						l_factory.new_location_from_path (project_location.partial_generation_path.name, l_target),
						l_factory)
				else
					create l_vis_build.make_build
						(l_state,
						l_target,
						if il_generation then metadata_cache_path else {STRING_32} "" end,
						if il_generation then clr_runtime_version else {STRING_32} "" end,
						l_factory.new_location_from_path (project_location.partial_generation_path.name, l_target),
						l_factory)
				end
				if has_potential_class_name_mismatch then
					has_potential_class_name_mismatch := False
					l_vis_build.set_is_full_class_name_analyzis (True)
				else
					has_potential_class_name_mismatch := True
					l_vis_build.set_is_full_class_name_analyzis (False)
				end

					-- set observers
				l_vis_build.consume_assembly_observer.extend (agent degree_output.put_consume_assemblies)
				l_vis_build.process_group_observer.extend (agent degree_output.put_process_group)
				l_vis_build.process_directory.extend (agent degree_output.put_degree_6)

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
					set_is_force_rebuild (True)
					Error_handler.raise_error
				end
				l_warnings := l_vis_build.last_warnings
				from
					l_warnings.start
				until
					l_warnings.after
				loop
					create vd80
					vd80.set_warning (l_warnings.item)
					error_handler.insert_warning (vd80, l_target.options.is_warning_as_error)
					l_warnings.forth
				end

					-- modified classes
				l_classes := l_vis_build.modified_classes
				create new_classes.make
				from
					l_classes.start
				until
					l_classes.after
				loop
					l_conf_class := l_classes.item_for_iteration
						-- FIXME: Patrickr 03/14/2006 for now the compiler can't deal with changed
						-- external or precompiled classes
					if not l_conf_class.is_class_assembly then
						l_class_i ?= l_conf_class
						check l_class_i_not_void: l_class_i /= Void end
						if not l_class_i.compiled_class.is_precompiled then
							workbench.change_class (l_class_i)
							if l_conf_class.is_renamed then
								l_class_i.compiled_class.recompile_syntactical_clients
							end
						end
					end
					l_classes.forth
				end
					-- added classes
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

						-- add visible classes
					if l_conf_class.is_always_compile then
						workbench.change_class (l_class_i)
					end
					record_new_class_i (l_class_i)

					l_classes.forth
				end

					-- removed classes
				if automatic_backup then
					create l_file.make_with_path (workbench.backup_info_file_name)
					l_file.open_append
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
					if automatic_backup then
						l_file.put_string_32 ({STRING_32} "REMOVED: " +
							l_class_i.name + " " +
							l_class_i.group.target.system.uuid.out + " " +
							l_class_i.group.name + "%N")
					end
					remove_class (l_class_i.compiled_class)
					real_removed_classes.force (l_class_i)
					l_classes.forth
				end

				if automatic_backup then
						-- Process classes that are not in the override.
					l_classes := l_vis_build.removed_classes_from_override
					from
						l_classes.start
					until
						l_classes.after
					loop
						l_class_i ?= l_classes.item_for_iteration
						l_file.put_string_32 ({STRING_32} "OVERRIDE_REMOVED: " +
							l_class_i.name + " " +
							l_class_i.group.target.system.uuid.out + " " +
							l_class_i.group.name + "%N")
						l_classes.forth
					end
					l_file.close
				end

					-- partly removed classes
				recheck_partly_removed (l_vis_build.partly_removed_classes)

				debug ("timing")
					create d2.make_now
					print ("Degree 6 rebuild duration: ")
					print (d2.relative_duration (d1).fine_seconds_count)
					print ("%N")
					print_memory_statistics
					create d1.make_now
				end

					-- everything with the configuration system went ok, move new_target to target
				universe.new_target_to_target

					-- Try to reconnect removed classes with new classes
				revive_moved_classes

					-- check the universe if we don't use a precompile
				universe.check_universe

					-- update/check root class
				update_root_class

					-- if enabled, check system wide uniqueness of class names
				if l_target.setting_enforce_unique_class_names then
					check_unique_class_names
				end

				rebuild_configuration_actions.call (Void)

				set_is_force_rebuild (False)
			end
		rescue
				-- An exception occur during system analysis, we should force a rebuild
				-- at next compilation. This addresses bug#12911.
			set_is_force_rebuild (True)
		end

	rebuild_configuration_actions: attached ACTION_SEQUENCE [TUPLE]
			-- Rebuild configuration actions hooks.
		once
			create Result
		end

	check_unique_class_names
			-- Check if all the classes in the system have unique names.
		local
			l_table: HASH_TABLE [CLASS_I, STRING]
			l_classes: SEARCH_TABLE [CLASS_I]
			l_class: CLASS_I
			l_name: STRING
			l_vd87: VD87
		do
			from
				l_classes := universe.all_classes
				create l_table.make (l_classes.count)
				l_classes.start
			until
				l_classes.after
			loop
				l_class := l_classes.item_for_iteration
				l_name := l_class.name
				if not l_class.config_class.does_override then
					if not l_table.has_key (l_name) then
						l_table.force (l_class, l_name)
					else
						set_is_force_rebuild (True)
						create l_vd87.make (l_table.found_item, l_class)
						error_handler.insert_error (l_vd87)
						error_handler.checksum
					end
				end
				l_classes.forth
			end
		end

	recheck_partly_removed (a_classes: ARRAYED_LIST [TUPLE [conf_class: CONF_CLASS; system: CONF_SYSTEM]])
			-- Recheck clients of classes that have been removed from one place but still exists in another.
		require
			a_classes_not_void: a_classes /= Void
		local
			l_class_i: CLASS_I
			l_system: CONF_SYSTEM
			l_clients: ARRAYED_LIST [CLASS_C]
			l_client: CLASS_C
		do
			from
				a_classes.start
			until
				a_classes.after
			loop
				l_system := a_classes.item.system
				l_class_i ?= a_classes.item.conf_class
				check
					correct_class: l_class_i /= Void and then l_class_i.is_compiled
				end
				from
					l_clients := l_class_i.compiled_class.syntactical_clients
					l_clients.start
				until
					l_clients.after
				loop
					l_client := l_clients.item
					if l_client.lace_class.config_class.group.target.system = l_system then
						workbench.add_class_to_recompile (l_client.original_class)
						l_client.set_changed (True)
					end
					l_clients.forth
				end
				a_classes.forth
			end

		end


	init_recompilation
			-- Initialization before a recompilation.
		local
			l_vis_modified: CONF_MODIFIED_VISITOR
			l_classes: ARRAYED_LIST [CONF_CLASS]
			l_class: CLASS_I
			l_vis_check: CONF_CHECKER_VISITOR
			l_errors: LIST [CONF_ERROR]
			vd80: VD80
		do
			degree_output.put_start_degree (6, 1)

				-- reset the compiler side removed classes and readd the configuration side removed classes
			removed_classes := Void
			from
				real_removed_classes.start
			until
				real_removed_classes.after
			loop
				l_class := real_removed_classes.item_for_iteration
				check
					class_compiled: l_class.is_compiled
				end
				remove_class (l_class.compiled_class)
				real_removed_classes.forth
			end

				-- Mark classes to be recompiled.
			if any_class = Void or else not any_class.is_compiled then
					-- First compilation.
				set_rebuild (True)
				init
				compilation_straight := True
			else
				compilation_straight := False

				reset_cached_class_i_options
					-- Reset any existing class info.

				if is_rebuild or is_force_rebuild then
						-- Full rebuild
					rebuild_configuration
				else
						-- Let the configuration system check for compiled classes that have been modified.
					create l_vis_modified.make (universe.conf_state)
					if compilation_modes.is_override_scan then
						l_vis_modified.enable_override_only
					end
					l_vis_modified.process_group_observer.extend (agent degree_output.put_process_group)
					universe.target.process (l_vis_modified)

					if not l_vis_modified.is_error and then not l_vis_modified.is_force_rebuild then
						from
							l_classes := l_vis_modified.modified_classes
							l_classes.start
						until
							l_classes.after
						loop
							l_class ?= l_classes.item
							check
								class_i: l_class /= Void
							end
							workbench.change_class (l_class)
							l_classes.forth
						end
						update_root_class
					else
						rebuild_configuration
						set_rebuild (True)
					end
				end

					-- If root_class is not compiled (i.e. root class has
					-- changed since last compilaton), insert it in the
					-- changed_classes.
				root_creators.do_all (
					agent (a_root: SYSTEM_ROOT)
						do
							if not a_root.root_class.is_compiled then
								workbench.change_class (a_root.root_class)
							end
						end)
			end

				-- check configuration and add warnings
			create l_vis_check.make (universe.conf_state)
			universe.target.process (l_vis_check)
			if l_vis_check.is_error then
				from
					l_errors := l_vis_check.last_errors
					l_errors.start
				until
					l_errors.after
				loop
					create vd80
					vd80.set_warning (l_errors.item)
					Error_handler.insert_warning (vd80, universe.target.options.is_warning_as_error)
					l_errors.forth
				end
			end

			if
				Lace.compile_all_classes or (Compilation_modes.is_precompiling and
				root_creators.there_exists (
					agent (a_root: SYSTEM_ROOT): BOOLEAN
						do
							Result := a_root.root_class = any_class
						end))
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
				-- Update capability settings used during compilation.
			lace.update_capability_root
		end

feature -- Modification

	set_dead_code (v: like {CONF_TARGET_OPTION}.dead_code_index_all)
			-- Set `dead_code` to `v`.
		do
			dead_code := v
			if v = {CONF_TARGET_OPTION}.dead_code_index_none then
				remover := Void
			end
		ensure
			dead_code_set: dead_code = v
			remover_set: v = {CONF_TARGET_OPTION}.dead_code_index_none implies not attached remover
		end

feature -- Final code geneation

	has_trampoline (e: ROUT_ENTRY; p: like {ROUT_ENTRY}.pattern_id; r: like {ROUT_TABLE}.rout_id): BOOLEAN
			-- Is there a trampoline for a routine entry `e` with the pattern of ID `p`
			-- associated with a routine ID `r`.
		do
			if attached trampoline_table [r] as s then
				Result := s.has (e.type_id.as_natural_64 |<< 32 + p.as_natural_64)
			end
		end

	request_trampoline (e, c: ROUT_ENTRY; r: like {ROUT_TABLE}.rout_id)
			-- Request generation of a trampoline for a routine entry `e`
			-- called in the context identified by `c` associated with a routine ID `r`.
		require
			e.pattern_id /= c.pattern_id
		local
			s: like trampoline_table.item
		do
			s := trampoline_table [r]
			if not attached s then
				create s.make (1)
				trampoline_table [r] := s
			end
			s.extend (e.type_id.as_natural_64 |<< 32 + c.pattern_id.as_natural_64)
		ensure
			has_trampoline (e, c.pattern_id, r)
		end

	remove_trampoline (e: ROUT_ENTRY; p: like {ROUT_ENTRY}.pattern_id; t: ROUT_TABLE)
			-- Remove the trampoline for a routine entry `e` with the pattern of ID `p`
			-- associated with a routine table `t`.
		require
			has_trampoline (e, p, t.rout_id)
		do
			if attached trampoline_table [t.rout_id] as s then
				s.prune (e.type_id.as_natural_64 |<< 32 + p.as_natural_64)
				if s.is_empty then
					trampoline_table.remove (t.rout_id)
				end
			end
		ensure
			not has_trampoline (e, p, t.rout_id)
		end

feature {NONE} -- Final code geneation

	trampoline_table: HASH_TABLE [ARRAYED_SET [NATURAL_64], like {ROUT_TABLE}.rout_id]
			-- Trampolines to be generated, indexed by routine ID,
			-- with sets of values built from pairs of type IDs and context pattern IDs.
		once
			create Result.make (0)
		end

feature -- ANY.default_rescue routine id

	default_rescue_rout_id: INTEGER
			-- Routine id of default rescue from ANY.
			-- Return 0 if ANY has not been compiled or
			-- does not have a feature named `default_rescue'.
		local
			feature_i: FEATURE_I
		do
			Result := internal_default_rescue_rout_id
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
				internal_default_rescue_rout_id := Result
			end
		end

feature -- ANY.default_create routine id

	default_create_rout_id: INTEGER
			-- Routine id of default create from ANY.
			-- Return 0 if ANY has not been compiled or
			-- does not have a feature named `default_create'.
		local
			feature_i: FEATURE_I
		do
			Result := internal_default_create_rout_id
			if Result < 0 then
				Result := 0
				if any_class /= Void and then any_class.compiled_class /= Void then
					feature_i := any_class.compiled_class.
						feature_table.item_id (names.default_create_name_id)
					if feature_i /= Void then
						Result := feature_i.rout_id_set.first
					end
				end
				internal_default_create_rout_id := Result
			end
		end

feature -- ANY.is_equal_rout_id routine id

	is_equal_rout_id: INTEGER
			-- Routine id of is_equal create from ANY.
			-- Return 0 if ANY has not been compiled or
			-- does not have a feature named `is_equal'.
		local
			feature_i: FEATURE_I
		do
			Result := internal_is_equal_rout_id
			if Result < 0 then
				Result := 0
				if any_class /= Void and then any_class.compiled_class /= Void then
					feature_i := any_class.compiled_class.feature_table.item_id (names.is_equal_name_id)
					if feature_i /= Void then
						Result := feature_i.rout_id_set.first
					end
				end
				internal_is_equal_rout_id := Result
			end
		end

feature -- SPECIAL.make routine id

	special_make_rout_id: INTEGER
			-- Routine id of `make' from SPECIAL.
			-- Return 0 if SPECIAL has not been compiled or does not have a feature named `make'.
		local
			feature_i: FEATURE_I
		do
			Result := internal_special_make_rout_id
			if Result < 0 then
				Result := 0
				if special_class /= Void and then special_class.compiled_class /= Void then
					feature_i := special_class.compiled_class.feature_table.item_id ({PREDEFINED_NAMES}.make_name_id)
					if feature_i /= Void then
						Result := feature_i.rout_id_set.first
					end
				end
				internal_special_make_rout_id := Result
			end
		end

	special_make_empty_rout_id: INTEGER
			-- Routine id of `make_empty' from SPECIAL.
			-- Return 0 if SPECIAL has not been compiled or does not have a feature named `make_empty'.
		local
			feature_i: FEATURE_I
		do
			Result := internal_special_make_empty_rout_id
			if Result < 0 then
				Result := 0
				if special_class /= Void and then special_class.compiled_class /= Void then
					feature_i := special_class.compiled_class.feature_table.item_id ({PREDEFINED_NAMES}.make_empty_name_id)
					if feature_i /= Void then
						Result := feature_i.rout_id_set.first
					end
				end
				internal_special_make_empty_rout_id := Result
			end
		end

	special_make_filled_rout_id: INTEGER
			-- Routine id of `make_filled' from SPECIAL.
			-- Return 0 if SPECIAL has not been compiled or
			-- does not have a feature named `make_filled'.
		local
			feature_i: FEATURE_I
		do
			Result := internal_special_make_filled_rout_id
			if Result < 0 then
				Result := 0
				if special_class /= Void and then special_class.compiled_class /= Void then
					feature_i := special_class.compiled_class.feature_table.item_id ({PREDEFINED_NAMES}.make_filled_name_id)
					if feature_i /= Void then
						Result := feature_i.rout_id_set.first
					end
				end
				internal_special_make_filled_rout_id := Result
			end
		end

feature -- Routine IDS update

	reset_routine_ids
			-- Reset internal data that needs to be recomputed
			-- at each recompilation in case it might changed during
			-- a recompilation. It happens if at the first compilation
			-- you do, there is an error, then those IDs from the routines
			-- of ANY/SPECIAL will definitely be changed
		do
			internal_default_rescue_rout_id := -1
			internal_default_create_rout_id := -1
			internal_is_equal_rout_id := -1
			internal_special_make_rout_id := - 1
			internal_special_make_empty_rout_id := - 1
			internal_special_make_filled_rout_id := - 1
		end

feature {NONE} -- Implementation: predefined routine IDs

	internal_default_rescue_rout_id: INTEGER
			-- Once per compilation value of routine id of `default_rescue_id' from ANY.

	internal_default_create_rout_id: INTEGER
			-- Once per compilation value of routine id of `default_create' from ANY.

	internal_is_equal_rout_id: INTEGER
			-- Once per compilation value of routine id of `default_create' from ANY.

	internal_special_make_rout_id: INTEGER
			-- Once per compilation value of routine id of `make' from SPECIAL.

	internal_special_make_empty_rout_id: INTEGER
			-- Once per compilation value of routine id of `make' from SPECIAL.

	internal_special_make_filled_rout_id: INTEGER
			-- Once per compilation value of routine id of `make_filled' from SPECIAL.

feature -- Feature declaration

	seed_of_routine_id (routine_id: INTEGER): FEATURE_I
			-- Seed with the given `routine_id'
		require
			valid_routine_id: routine_id > 0 and then routine_id_counter.is_feature_routine_id (routine_id) -- and `routine_id' is used
		do
			Result := class_of_id (rout_info_table.item (routine_id).origin).feature_of_rout_id (routine_id)
		ensure
			result_attached: Result /= Void
		end

feature -- Recompilation

	set_rebuild (b: BOOLEAN)
			-- Set `is_rebuild'.
		do
			is_rebuild := b
		ensure
			is_rebuild_set: is_rebuild = b
		end

	force_rebuild
			-- Force a rebuild
		do
			set_is_force_rebuild (True)
		end

	set_config_changed (b: BOOLEAN)
			-- Set `is_config_changed'.
		do
			is_config_changed := b
		end

	reset_has_compilation_started
			-- Reset `has_compilation_started'.
		do
			has_compilation_started := False
		end

	reset_has_potential_class_name_mismatch
			-- Reset `has_potential_class_name_mismatch'.
		do
			has_potential_class_name_mismatch := False
		ensure
			has_potential_class_name_mismatch_set: not has_potential_class_name_mismatch
		end

	set_has_potential_class_name_mismatch
			-- Set `has_potential_class_name_mismatch'.
		do
			has_potential_class_name_mismatch := True
		ensure
			has_potential_class_name_mismatch_set: has_potential_class_name_mismatch
		end

	recompile (is_for_finalization, a_syntax_analysis, a_system_check, a_generate_code: BOOLEAN)
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

			has_been_changed := is_config_changed
			lace.check_shared_library_definition_stamp
			do_recompilation (is_for_finalization, a_syntax_analysis, a_system_check, a_generate_code)

			successful := True
			has_warning := error_handler.has_warning
		rescue
			if Rescue_status.is_error_exception then
				successful := False
				has_warning := error_handler.has_warning
			end
		end

	revive_moved_classes
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
							removed_classes.remove (l_clc)
							real_removed_classes.remove (l_clc.original_class)
							l_cli.reset_class_c_information (l_clc)
							new_classes.remove
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

	recheck_missing_classes
			-- Recheck the classes that produced a missing class error and wipe out the list of missing classes.
		local
			locations: ARRAYED_LIST [TUPLE [c: CLASS_C; l: LOCATION_AS]]
			l_cl: CLASS_C
		do
			if missing_classes /= Void then
				from
					missing_classes.start
				until
					missing_classes.after
				loop
					locations := missing_classes.item_for_iteration
					from
						locations.start
					until
						locations.after
					loop
						l_cl := locations.item_for_iteration.c
						if removed_classes = Void or else not removed_classes.has (l_cl) then
							workbench.add_class_to_recompile (l_cl.original_class)
							l_cl.set_changed (True)
						end
						locations.forth
					end
					missing_classes.forth
				end
				missing_classes := Void
			end
		ensure
			missing_classes_void: missing_classes = Void
		end

	do_recompilation (is_for_finalization, a_syntax_analysis, a_system_check, a_generate_code: BOOLEAN)
			-- Incremental recompilation of the system.
		require
			valid_options: (a_generate_code implies a_system_check) and then (a_system_check implies a_syntax_analysis)
		local
			d1, d2: DATE_TIME
			l_il_env: IL_ENVIRONMENT
			l_needs_code_generation: BOOLEAN
			l_new_unref_classes_added_to_system, l_old_moved, l_compiled_classes_added, l_compiled_classes_removed, l_missing_classes_added_to_system: BOOLEAN
		do
			debug ("timing")
					-- Enable time accounting to get some precise GC statistics.
				(create {MEMORY}).enable_time_accounting
			end

				-- create new backup subdir
			if automatic_backup then
				workbench.create_backup_directory
			end

				-- Set ISE_DOTNET_FRAMEWORK environment variable			
			if il_generation then
				create l_il_env.make (clr_runtime_version)
				l_il_env.register_environment_variable
			end


				-- Recompilation initialization
			init_recompilation

			if Compilation_modes.is_precompiling and then il_generation then
					-- For a precompiled library we require a freeze in non-IL
					-- code generation.
				is_freeze_requested := True
			end

			if first_compilation then
				project_creation_time := current_time
			end

				-- Set the generation mode in workbench mode
			byte_context.set_workbench_mode

				-- The time checker just checks if there is a possible
				-- conflict for the suppliers of a class, i.e. a new class
				-- has been introduced and can create a conflict
			if not first_compilation or else has_compilation_started then
				Time_checker.check_suppliers_of_unchanged_classes
			end

				-- The `new_classes' list is not used after the time
				-- check. If it was successful, the list can be wiped out.
			new_classes.wipe_out

				-- Syntax analysis: This maybe add new classes to
				-- the system (degree 5)
			if
				a_syntax_analysis and then (
				first_compilation or else freeze or else private_melt or else
				new_class or else
				not Degree_5.is_empty or else
				not Degree_4.is_empty or else
				not Degree_3.is_empty or else
				not Degree_2.is_empty)
			then
					-- We compiled something we need to save project file.
				has_been_changed := True
				has_compilation_started := True


					-- Check if missing classes need to be recompiled back in to the system.
				l_old_moved := moved
				moved := False
				recheck_missing_classes
				l_missing_classes_added_to_system := moved

					-- Force new unref'd classes are added to the system.
					-- Record if any unref classes are added to the system.
				moved := False
				force_unref_classes_in_to_system
				l_new_unref_classes_added_to_system := moved

					-- Perform parsing of Eiffel code
				debug ("timing")
					print_memory_statistics
					create d1.make_now
				end
					-- Temporarily reset `moved' to see if classes are added/removed by the system in degree 5.
				moved := False
				process_degree_5
				l_compiled_classes_added := moved

					-- Reset `moved' back to its correct value.
				moved := l_compiled_classes_added or l_new_unref_classes_added_to_system or l_missing_classes_added_to_system or l_old_moved


				debug ("timing")
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
				if a_system_check then
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
						current_class := Void
							-- Remove useless classes i.e classes without
							-- syntactical clients
						remove_useless_classes
					end


						-- Let's report VTCT errors for classes not found at degree 5
						-- It cannot be done at degree 5 (see eweasel test incr233 for why).
					report_vtct_errors
					report_vtcm_warnings

						-- Fill parents.
					process_post_degree_5

						-- Let's get rid of the classes that have been really removed.
						-- This has to be performed at all times even if no explicit code generation takes place
						-- as classes may be manipulated outside of EiffelStudio in addition to adding a new class
						-- to the system, the configuration system will record this change permanently meaning
						-- that it has to be handled immediately otherwise the change is lost to the next compilation.
					l_old_moved := moved
					moved := False
					process_removed_classes
					l_compiled_classes_removed := moved
					moved := l_compiled_classes_removed or l_old_moved
					real_removed_classes.wipe_out

						-- Set whether code generation is needed. This is either explicitly
						-- via `a_generate_code', or whether the previous compilation was unsuccessful,
						-- whether a class in the system has moved or a missing class is added to the system.

						-- If the previous compilation was not successful and we have a Degree-4 only compilation then
						-- we must force code generation as the erroneous code in question may reference the newly
						-- added class, if this happens and we don't not force code generation then there is a
						-- mismatch in class ids and a crash occurs in the client code where the error originates.
						-- See bug#18115.

						-- If classes have changed/moved outside of EiffelStudio, ie: manually via shell or via repository update
						-- we need to make sure that a code generation always occurs otherwise potential changes in the ecf will be lost
						-- as the configuration system does not undo changes if an error occurs during a degree-4 only compilation.
					l_needs_code_generation := not successful or else a_generate_code or else (l_compiled_classes_added or l_compiled_classes_removed or l_missing_classes_added_to_system)


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

						if not first_compilation then
								-- Conformance table only needs to be reset upon incremental compilation.
							reset_conformance_table
						end
						build_conformance_table

							-- Clear the topo sorter
						sorter.clear

						reset_melted_conformance_table
					end

						-- Inheritance analysis: `Degree_4' is sorted by class
						-- topological ids so the parent come first the heirs after.
					process_degree_4
					debug ("timing")
						create d2.make_now
						print ("Degree 4 duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
						create d1.make_now
					end

						-- Compute the root type
					compute_root_type
					if
						not marked_precompiled_classes and then
						not Compilation_modes.is_precompiling and then uses_precompiled
					then
						mark_only_used_precompiled_classes
					end

						-- Remove any classes which have previously been added by {TEST_SYSTEM_I}
						-- and are not needed for testing.
						-- We only do this if code generation is needed to avoid side effects
					if l_needs_code_generation and then test_system.is_testing_enabled then
							-- We only remove classes from the system during a full compilation otherwise
							-- the system may become invalid if the compiler servers are manipulated without
							-- being stored to disk, which is only the case during code generation.
						test_system.remove_unused_classes
							-- If classes have been removed, we have to clean up our types.
						if instantiator.is_clean_up_requested then
							instantiator.clean_all
						end
					end

				end -- if a_system_check



				if l_needs_code_generation then

						-- Byte code production and type checking
					process_degree_3

						-- Reset built in processor so that any referenced CLASS_AS object is garbage collected.
					built_in_processor.reset_all

					debug ("timing")
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
						is_freeze_requested := is_freeze_requested or else not externals.is_equivalent
					end

						-- Process the type system
					process_type_system

						-- Process the skeleton of classes
					process_skeleton

						-- Reset `disposable_descendants' since they can have changed
						--| Note: That is important to recompute it, especially if
						--| someone removed an inheritance link to DISPOSABLE.
					reset_disposable_descendants

						-- Process the C pattern table
					pattern_table.process

					debug ("timing")
						create d2.make_now
						print ("After degreee 3 duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
						create d1.make_now
					end

						-- Melt the changed features
					melt

					debug ("timing")
						create d2.make_now
						print ("Degree 2 duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
						create d1.make_now
					end

						-- Finalize a successful compilation
					finish_compilation (l_needs_code_generation)
					debug ("timing")
						create d2.make_now
						print ("Server storing duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
						create d1.make_now
					end

						-- Produce the update file
					if not il_generation and then not freeze and then not lace.compile_all_classes then
						Degree_output.put_melting_changes_message

							-- Create a non-empty melted file
						make_update (False)
	debug ("VERBOSE")
		io.error.put_string ("Saving melted.eif%N")
	end
						debug ("timing")
							create d2.make_now
							print ("Melted file generation duration: ")
							print (d2.relative_duration (d1).fine_seconds_count)
							print ("%N")
							print_memory_statistics
							create d1.make_now
						end
					end
				else
					compute_root_type
					finish_compilation (False)
				end -- if a_generate_code

				if System.il_generation then
						-- Ensure unicity of names
					check_full_class_name_unicity
				end

				if not il_generation and then freeze and then not is_for_finalization then
					Degree_output.put_freezing_message
					freeze_system
					is_freeze_requested := False
					debug ("timing")
						create d2.make_now
						print ("Degree -1 duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
					end
				end
				if il_generation and then (private_melt or else not degree_minus_1.is_empty) and not il_quick_finalization then
					generate_il
					debug ("timing")
						create d2.make_now
						print ("Degree 1 duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
					end
					Degree_minus_1.wipe_out
				end
			else
				compute_root_type
			end -- if a_syntax_analysis

			reset_cached_class_i_options
			private_melt := False
			first_compilation := False
			il_quick_finalization := False

			if l_needs_code_generation then
				display_catcall_statistics
			end
		end

	reset_cached_class_i_options
			-- Reset any previously cached class_i options.
		local
			l_vis_all: CONF_ALL_CLASSES_VISITOR
			l_classes: ARRAYED_LIST [CONF_CLASS]
		do
			create l_vis_all.make
			universe.target.process (l_vis_all)
			if not l_vis_all.is_error then
				from
					l_classes := l_vis_all.classes
					l_classes.start
				until
					l_classes.after
				loop
					if attached {CLASS_I} l_classes.item as l_class_i then
						l_class_i.reset_options
					end
					l_classes.forth
				end
			end
		end

	force_unref_classes_in_to_system
			-- Unref classes analyzis: This may add new classes to system.
		local
			l_class_i: CLASS_I
			l_unref_classes: like unref_classes
			l_workbench: like workbench
		do
				-- Force unref classes to be compiled with Current system.
			from
				l_unref_classes := unref_classes
				l_workbench := workbench
				l_unref_classes.start
			until
				l_unref_classes.after
			loop
				l_class_i := l_unref_classes.item
					-- remove class if it has become invalid
				if not l_class_i.is_valid then
					l_unref_classes.remove
				else
					if l_class_i.compiled_class = Void then
						if l_class_i.config_class.does_override then
							l_class_i ?= l_class_i.config_class.overrides.first
							l_unref_classes.remove
							l_unref_classes.force (l_class_i)
						end
						l_workbench.change_class (l_class_i)
					end
					l_unref_classes.forth
				end
			end
		end

	process_degree_5
			-- Process Degree 5.
			-- Syntax analysis: This may add new classes to system.
		do
				-- Launch syntax analyzis of modified/added classes to system.
			Degree_5.execute
		end

	process_post_degree_5
			-- Processing done after main degree 5.
			-- Check and updates parent structure. It has to be done after
			-- reporting all VTCT errors.
		do
			degree_5.post_degree_5_execute
		end

	process_degree_4
			-- Process Degree 4.
			-- Inheritance analysis: `Degree_4' is sorted by class
			-- topological ids so parents come first heirs after.
		do
			Degree_4.execute
		end

	process_degree_3
			-- Process Degree 3.
			-- Byte code production and type checking.
		do
			in_pass3 := True
			Degree_3.execute
			in_pass3 := False
		rescue
			in_pass3 := False
		end

	process_degree_2
			-- Process Degree 2.
			-- Melt features (write feature byte code on disk).
		do
			Degree_2.execute
		end

	process_degree_1
			-- Process Degree 1.
			-- Melt the feature tables.
			-- Open first the file for writing on disk melted feature
			-- tables.
		do
			Degree_1.execute
		end

	process_degree_minus_1
			-- Process Degree -1.
			-- Freeze system: generate C files.
		do
			Degree_minus_1.execute
		end

	check_generics
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
				if
					a_class /= Void and then
					a_class.generics /= Void and then
						-- If the class is changed then `pass1' has been
						-- done successfully on the class
					not a_class.changed
				then
					a_class.check_generic_parameters
				end
				i := i + 1
			end
			Error_handler.checksum
		end

	process_removed_classes
			-- Remove classes that disappeared after a recompilation.
		do
			if removed_classes /= Void then
				from
					removed_classes.start
				until
					removed_classes.after
				loop
					if removed_classes.key_for_iteration.is_removable then
						internal_remove_class (removed_classes.key_for_iteration, 0)
						instantiator.request_clean_up
					end
					removed_classes.forth
				end
				removed_classes := Void
			end
		end

	remove_useless_classes
			-- Add useless classes to `removed_classes'.
		local
			a_class: CLASS_C
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			marked_classes: SEARCH_TABLE [INTEGER]
		do
				-- First mark all the classes that can be reached
				-- from the root class
			create marked_classes.make (System_chunk)

				-- Mark all root classes
			root_creators.do_all (
				agent (a_root: SYSTEM_ROOT; st: SEARCH_TABLE [INTEGER])
					do
						a_root.root_class.compiled_class.mark_class (st)
					end (?, marked_classes))

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
			character_8_class.compiled_class.mark_class (marked_classes)
			character_32_class.compiled_class.mark_class (marked_classes)
			string_8_class.compiled_class.mark_class (marked_classes)
			string_32_class.compiled_class.mark_class (marked_classes)
			immutable_string_8_class.compiled_class.mark_class (marked_classes)
			immutable_string_32_class.compiled_class.mark_class (marked_classes)
			special_class.compiled_class.mark_class (marked_classes)
			pointer_class.compiled_class.mark_class (marked_classes)
			array_class.compiled_class.mark_class (marked_classes)
			tuple_class.compiled_class.mark_class (marked_classes)
			routine_class.compiled_class.mark_class (marked_classes)
			procedure_class.compiled_class.mark_class (marked_classes)
			function_class.compiled_class.mark_class (marked_classes)
			predicate_class.compiled_class.mark_class (marked_classes)
			typed_pointer_class.compiled_class.mark_class (marked_classes)
			type_class.compiled_class.mark_class (marked_classes)

			ise_exception_manager_class.compiled_class.mark_class (marked_classes)
			if exception_class /= Void and then exception_class.is_compiled then
				exception_class.compiled_class.mark_class (marked_classes)
			end
			if rt_extension_class /= Void and then rt_extension_class.is_compiled then
				rt_extension_class.compiled_class.mark_class (marked_classes)
			end

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
				if unref_classes.item.is_valid then
					check
						unref_class_compiled:
							unref_classes.item.compiled_class /= Void
					end
					unref_classes.item.compiled_class.mark_class (marked_classes)
				end
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
				if
					a_class /= Void and then a_class.lace_class.config_class.is_always_compile and then
					not marked_classes.has (a_class.class_id)
				then
					a_class.mark_class (marked_classes)
				end
				i := i + 1
			end

				-- Mark classes possibly needed for testing
			if test_system.is_testing_enabled then
				test_system.mark_suppliers (marked_classes)
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

	reset_conformance_table
			-- Reset all conformance tables.
		local
			a_class: CLASS_C
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
		do
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array [i]
				if a_class /= Void then
					a_class.reset_dep_classes
				end
				i := i + 1
			end
		end

	build_conformance_table
			-- Build the conformance table
		local
			a_class: CLASS_C
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
		do
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array [i]
				if a_class /= Void then
					a_class.fill_conformance_table
				end
				i := i + 1
			end
		end

	process_type_system
			-- Compute the type system
		do
				-- ANY needs to be processed first so that it has static type
				-- of 1.
			if not any_class.compiled_class.has_types then
				any_class.compiled_class.init_types
			end

				-- Processing of root class if any to make it easy to find
				-- it in generated C code
			root_creators.do_all (
				agent (a_root: SYSTEM_ROOT)
					do
						instantiator.dispatch (a_root.class_type, a_root.class_type.base_class)
					end)

				-- Initialize types of non-generic classes which haven't been initialized yet.
			Degree_2.initialize_non_generic_types

				-- Compute the types.
			instantiator.process
		end

	process_conformance_table_for_type (set_or_reset_action: PROCEDURE [CLASS_TYPE])
			-- Build the conformance table
		require
			set_or_reset_action_not_void: set_or_reset_action /= Void
			class_types_not_void: class_types /= Void
		local
			l_types: ARRAY [CLASS_TYPE]
			i, nb: INTEGER
		do
			from
				l_types := class_types
				i := l_types.lower
				nb := l_types.upper
			until
				i > nb
			loop
				if attached l_types [i] as class_type then
					set_or_reset_action (class_type)
				end
				i := i + 1
			end
		end

	process_skeleton
			-- Type skeleton processing: If skeleton of a class type changed,
			-- it must be re-processed and marked `is_changed'.
		do
			Degree_2.process_skeleton
				-- Check expanded client relation.
			check_expanded
				-- Check sum error.
			Error_handler.checksum
		end

	check_vtec
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
		do
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void and then (a_class.has_expanded or else a_class.is_used_as_expanded) then
					set_current_class (a_class)
					a_class.check_expanded
				end
				i := i + 1
			end
		end

	check_expanded
			-- Check expanded client relation
		do
			Degree_2.check_expanded (has_expanded)
		end

	melt
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

			if not il_generation and then not freeze and then not lace.compile_all_classes then
					-- Melt the feature tables
					-- Open first the file for writing on disk melted feature
					-- tables
				process_degree_1
			end
				-- Transfer classes of Degree 1 into Degree -1 so that
				-- next time we will freeze, all the melted classes will
				-- be in `Degree_minus_1'.
			Degree_1.transfer_to (Degree_minus_1)

				-- Compress execution table.
			execution_table.melt
		end

	make_update (empty: BOOLEAN)
			-- Produce the update file resulting of the consecutive
			-- melting process. It can be `empty' (if the system has
			-- been frozen.
		local
			file_pointer: POINTER
			melted_file: RAW_FILE
			l_name: STRING_32
			l_ba: BYTE_ARRAY

			cs: CURSOR
			l_root: SYSTEM_ROOT
			l_root_cl: CLASS_C
			l_root_ft: detachable FEATURE_I
			l_root_rout_id: INTEGER
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
				l_name := Workbench.melted_file_name
			else
				l_name := name
			end
			create melted_file.make_with_path (project_location.workbench_path.extended (l_name + ".melted"))
			melted_file.open_write

				-- There is something to update
			melted_file.put_boolean (not empty)

			if not empty then
				file_pointer := melted_file.file_pointer

					-- Write whether or not we use IEEE arithmetic or not
				melted_file.put_boolean (total_order_on_reals)
					-- Write the number of dynamic types now available
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
					-- Open the file for reading byte code for melted feature
					-- Update the execution table
				Execution_table.make_update (melted_file)
				make_parent_table_byte_code (melted_file)
				make_option_table (melted_file)
				make_rout_info_table (melted_file)
				make_update_descriptors (melted_file)
					-- End mark
				write_int (file_pointer, -1)

					-- Update the root class info

					-- First write number of root procedures to file
				write_int (file_pointer, root_creators.count)
				from
					cs := root_creators.cursor
					root_creators.start
				until
					root_creators.after
				loop
					l_root := root_creators.item_for_iteration
					l_root_cl := l_root.class_type.base_class
					l_root_ft := l_root_cl.feature_table.item (l_root.procedure_name)
					if l_root_ft /= Void then
						l_root_rout_id := l_root_ft.rout_id_set.first

						write_int (file_pointer, l_root_cl.name.count + l_root_ft.feature_name.count + 1)
						melted_file.put_string (l_root_cl.name.as_upper)
						melted_file.put_character ('.')
						melted_file.put_string (l_root_ft.feature_name.as_lower)
					else
						write_int (file_pointer, 0)
						l_root_rout_id := -1
					end

					write_int (file_pointer, l_root_rout_id)

						-- Generate type ID for ANY
					write_int (file_pointer, any_class.compiled_class.types.first.type_id - 1)
						-- Generate data to create the root full dynamic type ID.
					create l_ba.make
					byte_context.init (root_class_type (l_root.class_type))
					l_root.class_type.make_full_type_byte_code (l_ba, byte_context.context_class_type.type)
						-- Write number of bytes in byte array.
					l_ba.character_array.store (melted_file)

					if l_root_ft /= Void and then l_root_ft.has_arguments then
						write_int (file_pointer, 1)
					else
						write_int (file_pointer, 0)
					end

					root_creators.forth
				end
				root_creators.go_to (cs)
			end

			melted_file.close
		end

	make_update_feature_tables (file: RAW_FILE)
			-- Write the byte code for feature tables to be updated
			-- into `file'.
		require
			file_not_void: file /= Void
			file_open_write: file.is_open_write
		do
			Degree_minus_1.make_update_feature_tables (file)
		end

	make_update_descriptors (file: RAW_FILE)
			-- Write melted descriptors into `file'.
		require
			file_not_void: file /= Void
			file_open_write: file.is_open_write
		do
			from
				M_desc_server.start
			until
				M_desc_server.after
			loop
				M_desc_server.item (M_desc_server.key_for_iteration).store (file)
				M_desc_server.forth
			end
		end

	reset_melted_conformance_table
			-- Forget the `melted_conformance_table', i.e. a new
			-- class or class type has been added to the system.
		do
				-- Mark the conformance table melted
			is_conformance_table_melted := True
				-- Trigger the recompuation of the conformance table
				-- byte code
			melted_parent_table := Void
		end

	make_parent_table_byte_code (file: RAW_FILE)
			-- Generates parent tables byte code in `file'.
		local
			i, nb: INTEGER
			to_append: CHARACTER_ARRAY
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
						if attached class_types [i] as class_type then
								-- Classes could be removed
							class_type.make_parent_table_byte_code (Byte_array)
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
		end

	make_option_table (file: RAW_FILE)
			-- Generate byte code for the option table.
		require
			file_not_void: file /= Void
			file_is_open_write: file.is_open_write
		local
			i, nb: INTEGER
			a_class: CLASS_C
		do
			Byte_array.clear
			from
				i := min_type_id
				nb := Type_id_counter.value
			until
				i > nb
			loop
				if attached class_types [i] as class_type then
						-- Classes could be removed
					Byte_array.append_short_integer (class_type.type_id - 1)
					a_class := class_type.associated_class
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

	make_rout_info_table (file: RAW_FILE)
			-- Generate byte code for the routine info table
			-- and store it in `file'.
		do
			Rout_info_table.melted.store (file)
		end

	finish_compilation (a_code_generation: BOOLEAN)
			-- Finish a successful recompilation and update the
			-- compilation files.
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			l_class: CLASS_C
			l_eiffel_class: EIFFEL_CLASS_C
		do
				-- Reinitialization of control flags of the topological
				-- sort.
			update_sort := False
			moved := False

				-- Reset the classes as unchanged
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				l_class := class_array.item (i)
				if l_class /= Void then
					if a_code_generation then
						l_class.set_changed (False)
						l_class.set_changed2 (False)
						l_class.set_changed3a (False)
						l_class.set_need_type_check (False)
						-- FIXME: changed4, changed5, changed6
						l_class.changed_features.clear_all
						l_class.propagators.wipe_out
						l_eiffel_class ?= l_class
						if l_eiffel_class /= Void then
							l_eiffel_class.set_new_byte_code_needed (False)
						end
					end

					if l_class.current_feature_table /= Void then
						l_class.set_previous_feature_table (l_class.current_feature_table)
						l_class.set_current_feature_table (Void)
					end
				end
				i := i + 1
			end

				-- Update servers
			Tmp_ast_server.finalize
			Ast_server.take_control (Tmp_ast_server)
				-- It is important to do `feature_server' after the AST server
				-- because before processing them all the AST are in memory
				-- and {FEATURE_SERVER}.take_control may increase the overall memory usage.
				-- Therefore freeing some memory via the the AST server first
				-- would most likely not cause a memory increase here.
			feature_server.take_control (tmp_feature_server)
			feature_table_cache.wipe_out
			Depend_server.take_control (Tmp_depend_server)
			creation_server.take_control (tmp_creation_server)
			M_feat_tbl_server.take_control (Tmp_m_feat_tbl_server)
			M_feature_server.take_control (Tmp_m_feature_server)
			M_desc_server.take_control (Tmp_m_desc_server)

				-- No need to do `Byte_server' and `Inv_byte_server' because
				-- it is done in `melt'. See comment in `melt' for rationale.
			--Byte_server.take_control (Tmp_byte_server)
			--Inv_byte_server.take_control (Tmp_inv_byte_server)
		end

feature -- IL code generation

	generate_il
			-- Generate IL code
		require
			il_generation: il_generation
		local
			il_generator: CIL_GENERATOR
			old_dead_code: like dead_code
		do
			create il_generator.make (Degree_output)
			il_generator.generate
			if (in_final_mode or freeze) and then externals.count > 0 then
				externals.freeze
				freezing_occurred := True
				old_dead_code := dead_code
				set_dead_code ({CONF_TARGET_OPTION}.dead_code_index_none)

				if in_final_mode then
					create {FINAL_MAKER} makefile_generator.make
				else
					create {WBENCH_MAKER} makefile_generator.make
				end
				open_log_files
				externals.generate_il (makefile_generator)
				close_log_files

				set_dead_code (old_dead_code)

				if not in_final_mode then
					is_freeze_requested := False
				end
			end
			il_generator.deploy
		end

feature {NONE} -- IL generation

	check_full_class_name_unicity
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

							if not l_types.item.is_external and then not l_types.item.is_basic then
								if l_table.has (l_name) then
										-- This name has already been inserted, we
										-- record it in `l_conflicts' to report an error later.
										-- This need not to be done for external class types.
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

	freeze_system
			-- Workbench C code generation.
		require
			root_types_compiled: are_root_classes_compiled
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

			address_table.update_ids

debug ("ACTIVITY")
	io.error.put_string ("Clear the melted code servers%N")
end
				-- Clear the melted byte code servers
			m_feat_tbl_server.clear
			m_feature_server.clear

debug ("ACTIVITY")
	io.error.put_string ("Shake%N")
end
				-- Compress execution table.
			if not first_compilation then
				execution_table.freeze
			end

				-- Freeze the external table.
			externals.freeze

				-- Generation of the descriptor tables
			process_degree_minus_1
			m_desc_server.clear
			generate_main_eiffel_files
		end

	generate_main_eiffel_files
			-- Generate the "e*.c" files.
		local
			deg_output: DEGREE_OUTPUT
			t: AUXILIARY_FILES
			degree_message: STRING
		do
			create t.make (Current, byte_context)
			degree_message := "Generating Auxiliary Files"
			deg_output := Degree_output

			deg_output.put_degree_output (degree_message, 10, 10)
			generate_cecil

			deg_output.put_degree_output (degree_message, 9, 10)
			generate_skeletons
			generate_expanded_structures

			deg_output.put_degree_output (degree_message, 8, 10)
			generate_parent_tables
			is_conformance_table_melted := False
			melted_parent_table      := Void

			deg_output.put_degree_output (degree_message, 7, 10)
			t.generate_plug

			deg_output.put_degree_output (degree_message, 6, 10)
			t.generate_dynamic_lib_file

			deg_output.put_degree_output (degree_message, 5, 10)
			generate_init_file

			deg_output.put_degree_output (degree_message, 4, 10)
			generate_option_file (True)
			address_table.generate (False)

			deg_output.put_degree_output (degree_message, 3, 10)
			generate_rout_info_table

			deg_output.put_degree_output (degree_message, 2, 10)
			generate_pattern_table

			deg_output.put_degree_output (degree_message, 1, 10)
			execution_table.generate

			deg_output.put_degree_output (degree_message, 0, 10)
			t.generate_make_file

				-- Create an empty update file ("melted.eif")
			make_update (True)
		end

feature -- Final mode generation

	in_final_mode: BOOLEAN
			-- Generation of Final code ?
		do
			Result := byte_context.final_mode
		end

	finalize_system (keep_assert: BOOLEAN)
			-- Finalized generation.
		require
			root_classes_compiled: are_root_classes_compiled
		local
			old_dead_code: like dead_code
			old_exception_stack_managed: BOOLEAN
			old_inlining_on, old_array_optimization_on: BOOLEAN
			deg_output: DEGREE_OUTPUT
			retried: BOOLEAN
			d1, d2: DATE_TIME
			l_type_id_mapping: ARRAY [INTEGER]
			l_old_type_id_counter: INTEGER
		do
			eiffel_project.terminate_c_compilation
			if not retried and then is_finalization_needed then
				trampoline_table.wipe_out
				create skeleton_table.make (400)
				if not il_generation then
					internal_retrieved_finalized_type_mapping := Void
					create l_type_id_mapping.make_filled (0, 0, static_type_id_counter.count)
					l_old_type_id_counter := type_id_counter.value
					process_dynamic_types (False, l_type_id_mapping, 0)
				end
					-- Reset `disposable_descendants' since they can have changed
					--| Note: That is important to recompute it, as this is a once
					--| which is not stored in the project file, therefore if we
					--| do a finalization where no classes have been modified it
					--| will be empty (because recomputed only in `do_recompilation
					--| if some classes have been modified) unless we force its recomputation.
				reset_disposable_descendants

				debug ("timing")
					create d1.make_now
				end

					-- Set the generation mode in final mode
				byte_context.set_final_mode

				if il_generation then
					create l_type_id_mapping.make_filled (0, 0, static_type_id_counter.count)
					process_optimized_single_types (False, l_type_id_mapping)
				end

				keep_assertions := keep_assert
				set_is_precompile_finalized (is_precompiled)

				if il_generation then
						-- Build binding tables for CLASS_TYPE instances. This is
						-- needed for proper processing of computation of `is_polymorphic'
						-- on polymorphic table and computation of expanded descendants.
					process_conformance_table_for_type (agent {CLASS_TYPE}.build_binding_table)

					byte_context.clear_system_data
					byte_context.compute_expanded_descendants
					generate_il
					byte_context.clear_system_data
					debug ("timing")
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
					old_dead_code := dead_code
					old_exception_stack_managed := exception_stack_managed
					old_inlining_on := inlining_on
					old_array_optimization_on := array_optimization_on

						-- Should dead code be removed?
					if
						old_dead_code /= {CONF_TARGET_OPTION}.dead_code_index_none and then
						keep_assertions
					then
						set_dead_code ({CONF_TARGET_OPTION}.dead_code_index_none)
					end

					if not exception_stack_managed then
						exception_stack_managed := keep_assertions
					end

						-- Inlining is disabled when dead code removal is off or when checking
						-- for catcalls.
					inlining_on :=
						inlining_on and
						dead_code /= {CONF_TARGET_OPTION}.dead_code_index_none and
						not check_for_catcall_at_runtime
					array_optimization_on :=
						array_optimization_on and
						dead_code /= {CONF_TARGET_OPTION}.dead_code_index_none

					byte_context.clear_system_data
					process_degree_minus_2
					debug ("timing")
						create d2.make_now
						print ("Degree -2 duration: ")
						print (d2.relative_duration (d1).fine_seconds_count)
						print ("%N")
						print_memory_statistics
						create d1.make_now
					end

					address_table.update_ids

						-- Dead code removal.
					is_class_type_alive_storage.make (class_types.count)
					is_class_type_reachable_storage.make (class_types.count)
					if dead_code = {CONF_TARGET_OPTION}.dead_code_index_none then
						across
							class_types as t
						loop
							is_class_type_alive_storage [t.target_index] :=
								attached t.item as class_type and then
								is_type_reachable (class_type.type)
						end
						is_class_type_reachable_storage.copy (is_class_type_alive_storage)
					else
						deg_output := Degree_output
						deg_output.put_start_dead_code_removal_message
						remove_dead_code
						debug ("timing")
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

						-- Build binding tables for CLASS_TYPE instances. This is
						-- needed for proper processing of computation of `is_polymorphic'
						-- on polymorphic table and computation of expanded descendants.
					process_conformance_table_for_type (agent {CLASS_TYPE}.build_binding_table)

						-- Generation of C files associated to the classes of
						-- the system.
					Eiffel_table.start_degree_minus_3 (History_control.max_rout_id)
					byte_context.compute_expanded_descendants
					process_degree_minus_3

					debug ("timing")
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

						-- Clean binding tables for CLASS_TYPE instances. We don't need
						-- to store them on disk as they are recomputed at each finalization.
					process_conformance_table_for_type (agent {CLASS_TYPE}.reset_binding_table)

					is_class_type_alive_storage.make (0)
					is_class_type_reachable_storage.make (0)
					remover := Void

						-- Set `Server_control' not to remove right away extra unused
						-- files (especially done for the TMP_POLY_SERVER, but since we
						-- are back now to a normal compilation we should not remove the
						-- useless files).
					Server_controler.set_remove_right_away (False)

						-- Restore previous value
					set_dead_code (old_dead_code)
					exception_stack_managed := old_exception_stack_managed
					inlining_on := old_inlining_on
					array_optimization_on := old_array_optimization_on
				end

					-- Clean `finalization_needed' tag from all CLASS_C
				clean_finalization_tag
				if l_type_id_mapping /= Void then
					if il_generation then
						process_optimized_single_types (True, l_type_id_mapping)
					else
						if universe.target.options.is_profile then
							store_finalized_type_mapping (l_type_id_mapping)
						end
						process_dynamic_types (True, l_type_id_mapping, l_old_type_id_counter)
					end
				end
				skeleton_table := Void
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
			has_warning := error_handler.has_warning

				-- Restore previous value.
			set_dead_code (old_dead_code)
			exception_stack_managed := old_exception_stack_managed
			inlining_on := old_inlining_on
			array_optimization_on := old_array_optimization_on
			skeleton_table := Void
			remover := Void

				-- Clean binding tables for CLASS_TYPE instances. We don't need
				-- to store them on disk as they are recomputed at each finalization.
			process_conformance_table_for_type (agent {CLASS_TYPE}.reset_binding_table)

				-- Reset `class_types'
			if l_type_id_mapping /= Void then
				if il_generation then
					process_optimized_single_types (True, l_type_id_mapping)
				else
					process_dynamic_types (True, l_type_id_mapping, l_old_type_id_counter)
				end
			end

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

	internal_remove_class (a_class: CLASS_C; a_depth: INTEGER)
			-- Remove class `a_class' from the system even if
			-- it has syntactical_clients.
		require
			 good_argument: a_class /= Void
			 valid_depth: a_depth >= 0
			 a_class_is_removable: a_class.is_removable
		local
			supplier: CLASS_C
			supplier_clients: ARRAYED_LIST [CLASS_C]
			related_classes: LINKED_SET [CLASS_C]
			finished: BOOLEAN
			id: INTEGER
			types: TYPE_LIST
		do
			id := a_class.class_id
			if system.class_of_id (id) /= Void then

					-- Force a recompilation
				set_melt

					-- Remove class from `unref_classes' if it is referenced.
					-- It is only done if class is directly removed. Removing
					-- `a_class' does not remove any subclasses from `unref_classes',
					-- so that they are recompiled back
				if a_depth = 0 then
					unref_classes.prune_all (a_class.original_class)
				end

				check attached a_class.eiffel_class_c as l_eif_class then
					l_eif_class.remove_c_generated_files
				end

					-- Update control flags of the topological sort
				moved := True

					-- Remove type check relations
				if a_class.parents /= Void then
					a_class.remove_relations
				end

					-- Remove externals defined in current removed class
				externals.remove (id)

					-- Remove class `a_class' from the lists of changed classes
				Degree_5.remove_class (a_class)
				Degree_4.remove_class (a_class)
				Degree_3.remove_class (a_class)
				Degree_2.remove_class (a_class)

					-- Mark the class to remove uncompiled
				a_class.original_class.reset_compiled_class

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
				Inv_ast_server.remove (id)
				Depend_server.remove (id)
				creation_server.remove (id)
				M_desc_server.remove (id)
				Tmp_inv_byte_server.remove (id)
				Tmp_ast_server.remove (id)
				Tmp_depend_server.remove (id)
				tmp_creation_server.remove (id)
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
						supplier := a_class.syntactical_suppliers.item
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

					if supplier.has_dep_class (a_class) then
							-- Remove the dependecies recursively.
							-- (See test#incr381 that fails of the removal is not done recursively.)
						remove_dependencies (supplier, a_class)
					end
					if
						supplier_clients.is_empty and then
							-- The root class is not removed
							-- true only if the root class has changed and
							-- was a client for a removed class
						not is_compiled_root_class (supplier) and then
							-- Cannot propagate for a protected class
						supplier.class_id > protected_classes_level and then
							-- A recursion may occur when removing a cluster
						class_of_id (supplier.class_id) /= Void and then
							-- removable
						supplier.is_removable
					then
							-- Recursively remove class.
						internal_remove_class (supplier, a_depth + 1)
					end

					related_classes.forth
				end
			end
		end

	remove_dependencies (supplier, dependant: CLASS_C)
		require
			has_dependency: supplier.has_dep_class (dependant)
		do
			supplier.remove_dep_class (dependant)
			if attached supplier.conforming_parents_classes as cs then
				across
					cs as c
				loop
					if c.item.has_dep_class (dependant) then
						remove_dependencies (c.item, dependant)
					end
				end
			end
			if attached supplier.non_conforming_parents_classes as cs then
				across
					cs as c
				loop
					if c.item.has_dep_class (dependant) then
						remove_dependencies (c.item, dependant)
					end
				end
			end
		ensure
			has_no_dependency: not supplier.has_dep_class (dependant)
		end

feature {NONE} -- Finalization implementation

	is_finalization_needed: BOOLEAN
			-- Has system not yet be finalized or has system
			-- changed since last finalization.
		local
			a_class: CLASS_C
			j, nb: INTEGER
			class_array: ARRAY [CLASS_C]
		do
			Result := private_finalize
			if not Result then
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

	clean_finalization_tag
			-- Reset all CLASS_C.finalization_needed to False.
		local
			a_class: CLASS_C
			j, nb: INTEGER
			class_array: ARRAY [CLASS_C]
		do
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

	process_degree_minus_2
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

	process_degree_minus_3
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
			Eiffel_project.delete_generation_directory (project_location.final_path, Void, Void) -- No agent
			create {FINAL_MAKER} makefile_generator.make
			open_log_files
			j := classes.count
			deg_output := Degree_output
			deg_output.put_start_degree (-3, j)
			class_array := classes
			nb := class_counter.count
-- Comment out the line below to quickly debug generation bug in finalized mode:
--			universe.class_named ("TEST", root_type.base_class.group).compiled_class.pass4
			from
				i := 1
			until
				i > nb
			loop
				a_class := class_array.item (i)
					-- Since a class can be removed, test if `a_class' is not Void.
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

	is_basic_class_alive: BOOLEAN = True
			-- Is basic class included in the system?

	is_string_class_alive: BOOLEAN = True
			-- Are string classes for manifest strings included in the system?

	is_array_class_alive: BOOLEAN = True
			-- Is array class included in the system?

	is_tuple_class_alive: BOOLEAN = True
			-- Is tuple class included in the system?

	remove_dead_code
			-- Dead code removal
		local
			visible_classes: ARRAYED_LIST [CLASS_C]
			r: like remover
		do
				-- Note: To have dead code removal working when assertions are enabled
				-- we need to perform two things:
				-- 1 - record all invariants
				-- 2 - record all inherited assertions of a routine.
				-- We currently can do `1' but not `2'.

			create r.make
			remover := r

				-- Mark classes that are known by the run-time.
			if is_basic_class_alive then
				r.mark_class_alive (boolean_class.compiled_class.class_id)
				r.mark_class_alive (character_8_class.compiled_class.class_id)
				r.mark_class_alive (character_32_class.compiled_class.class_id)
				r.mark_class_alive (integer_8_class.compiled_class.class_id)
				r.mark_class_alive (integer_16_class.compiled_class.class_id)
				r.mark_class_alive (integer_32_class.compiled_class.class_id)
				r.mark_class_alive (integer_64_class.compiled_class.class_id)
				r.mark_class_alive (natural_8_class.compiled_class.class_id)
				r.mark_class_alive (natural_16_class.compiled_class.class_id)
				r.mark_class_alive (natural_32_class.compiled_class.class_id)
				r.mark_class_alive (natural_64_class.compiled_class.class_id)
				r.mark_class_alive (pointer_class.compiled_class.class_id)
				r.mark_class_alive (real_32_class.compiled_class.class_id)
				r.mark_class_alive (real_64_class.compiled_class.class_id)
				r.mark_class_alive (typed_pointer_class.compiled_class.class_id)
			end
			if is_string_class_alive then
				r.mark_class_alive (string_8_id)
				r.mark_class_alive (string_32_id)
				r.mark_class_alive (immutable_string_8_id)
				r.mark_class_alive (immutable_string_32_id)
			end
			if is_array_class_alive then
				r.mark_class_alive (array_id)
			end
			if is_tuple_class_alive then
				r.mark_class_alive (tuple_id)
			end

			r.mark_class_alive (exception_class_id)
			r.mark_class_alive (ise_exception_manager_class_id)

			if array_optimization_on then
				r.record_array_descendants
			end

			if dead_code = {CONF_TARGET_OPTION}.dead_code_index_feature then
					-- Mark all classes as alive.
				across
					classes as cc
				loop
					if
						attached cc.item as c and then
						c.is_valid and then
						(c.is_precompiled implies c.is_in_system)
					then
						if c.is_deferred then
							r.mark_class_reachable (c.class_id)
						else
							r.mark_class_alive (c.class_id)
						end
					end
				end
			end

				-- It is more efficient to mark classes before marking features.
			create visible_classes.make (0)
			across
				classes as cc
			loop
				if
					attached cc.item as c and then
					(c.is_precompiled implies c.is_in_system) and then
					c.visible_level.has_visible
				then
					c.mark_visible_class (r)
					visible_classes.extend (c)
				end
			end

				-- First, inspection of the Eiffel code
			root_creators.do_all (
				agent (a_root: SYSTEM_ROOT)
					local
						f: FEATURE_I
						c: CLASS_C
					do
						if not a_root.procedure_name.is_empty and not a_root.is_explicit then
							check
								valid_root: a_root.is_class_type_set
							end
							c := a_root.class_type.base_class
								-- An object of a root class is created automatically.
							remover.mark_class_alive (c.class_id)
							f := c.feature_table.item (a_root.procedure_name)
							if f.argument_count > 0 then
									-- Arguments are created automatically.
								remover.mark_class_alive (array_id)
								remover.mark_class_alive (string_8_id)
							end
							remover.register_monomorphic (f, c.class_id)
						end
					end)

			register_polymorphic ({PREDEFINED_NAMES}.dispose_name_id, disposable_class)
			register_polymorphic ({PREDEFINED_NAMES}.copy_name_id, any_class)
			register_polymorphic ({PREDEFINED_NAMES}.is_equal_name_id, any_class)

			across
				visible_classes as c
			loop
				c.item.mark_visible_features (remover)
			end

			if has_expanded then
				across
					class_types as cc
				loop
					if attached cc.item as c then
						c.mark_creation_routine (remover)
					end
				end
			end

				-- Protection of `make' from ARRAY.
			register_monomorphic ({PREDEFINED_NAMES}.Make_name_id, array_class)

				-- Protection of `to_array' from SPECIAL.
			register_monomorphic ({PREDEFINED_NAMES}.to_array_name_id, special_class)

				-- Protection of feature `make' of class STRING.
			register_monomorphic ({PREDEFINED_NAMES}.Make_name_id, string_8_class)

				-- Protection of feature `make' of class STRING_32.
			register_monomorphic ({PREDEFINED_NAMES}.Make_name_id, string_32_class)

				-- Protection of feature `make_from_c_byte_array' of class IMMUTABLE_STRING_8.
			register_monomorphic ({PREDEFINED_NAMES}.make_from_c_byte_array_name_id, immutable_string_8_class)

				-- Protection of feature `make_from_c_byte_array' of class IMMUTABLE_STRING_32.
			register_monomorphic ({PREDEFINED_NAMES}.make_from_c_byte_array_name_id, immutable_string_32_class)

				-- Protection of ROUTINE class features.
			register_polymorphic ({PREDEFINED_NAMES}.set_rout_disp_final_name_id, routine_class)

				-- Protection of ISE_EXCEPTION_MANAGER class features.
			register_monomorphic ({PREDEFINED_NAMES}.last_exception_name_id, ise_exception_manager_class)
			register_monomorphic ({PREDEFINED_NAMES}.set_last_exception_name_id, ise_exception_manager_class)
			register_monomorphic ({PREDEFINED_NAMES}.set_exception_data_name_id, ise_exception_manager_class)
			register_monomorphic ({PREDEFINED_NAMES}.is_code_ignored_name_id, ise_exception_manager_class)
			register_monomorphic ({PREDEFINED_NAMES}.once_raise_name_id, ise_exception_manager_class)
			register_monomorphic ({PREDEFINED_NAMES}.init_exception_manager_name_id, ise_exception_manager_class)
			register_monomorphic ({PREDEFINED_NAMES}.free_preallocated_trace_name_id, ise_exception_manager_class)

				-- Protection of feature `internal_correct_mismatch' of ANY.
			register_polymorphic ({PREDEFINED_NAMES}.Internal_correct_mismatch_name_id, any_class)

				-- Protection of feature `twin' of ANY.
			register_polymorphic ({PREDEFINED_NAMES}.twin_name_id, any_class)

				-- Protection of feature `set_item' of `reference BOOLEAN'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, boolean_class)

				-- Protection of feature `set_item' of `reference CHARACTER'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, character_8_class)

				-- Protection of feature `set_item' of `reference WIDE_CHARACTER'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, character_32_class)

				-- Protection of feature `set_item' of `reference POINTER'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, pointer_class)

				-- Protection of feature `set_item' of `reference TYPED_POINTER_ [G]'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, typed_pointer_class)

				-- Protection of feature `set_item' of `reference REAL'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, real_32_class)

				-- Protection of feature `set_item' of `reference DOUBLE'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, real_64_class)

				-- Protection of feature `set_item' of `reference NATURAL_8'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, natural_8_class)

				-- Protection of feature `set_item' of `reference NATURAL_16'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, natural_16_class)

				-- Protection of feature `set_item' of `reference NATURAL_32'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, natural_32_class)

				-- Protection of feature `set_item' of `reference NATURAL_64'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, natural_64_class)

				-- Protection of feature `set_item' of `reference INTEGER_8'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, integer_8_class)

				-- Protection of feature `set_item' of `reference INTEGER_16'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, integer_16_class)

				-- Protection of feature `set_item' of `reference INTEGER_32'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, integer_32_class)

				-- Protection of feature `set_item' of `reference INTEGER_64'.
			register_polymorphic ({PREDEFINED_NAMES}.set_item_name_id, integer_64_class)

			r.analyze
debug ("DEAD_CODE")
			r.dump_alive
end
			across
				class_types as t
			loop
				if attached t.item as class_type and then is_type_reachable (class_type.type) then
					is_class_type_alive_storage [t.target_index] := r.is_class_alive (class_type.type.class_id)
					is_class_type_reachable_storage [t.target_index] := r.is_class_reachable (class_type.type.class_id)
				else
					is_class_type_alive_storage [t.target_index] := False
					is_class_type_reachable_storage [t.target_index] := False
				end
			end
		end

	register_monomorphic  (n: INTEGER; i: detachable CLASS_I)
			-- Register a non-polymorphic call to a feature of name `n` on a target of class `i`.
		do
			if
				attached i and then
				attached i.compiled_class as c and then
				attached c.feature_table.item_id (n) as f
			then
				remover.register_monomorphic (f, c.class_id)
			end
		end

	register_polymorphic (n: INTEGER; i: detachable CLASS_I)
			-- Register a polymorphic call to a feature of name `n` on a target of a type with a base class `i`.
		do
			if
				attached i and then
				attached i.compiled_class as c and then
				attached c.feature_table.item_id (n) as f
			then
				remover.register_polymorphic (f, c.class_id)
			end
		end

	is_used (f: FEATURE_I): BOOLEAN
			-- Is feature `f' used in the system ?
		require
			good_argument: f /= Void
		do
			Result := attached remover as r implies r.is_code_reachable (f.body_index)
		end

	is_class_reachable (c: CLASS_C): BOOLEAN
			-- Are features of the class `c` potentially reachable during execution?
			-- E.g., are there live decendants (including the class itself) or is the class used in a non-object call?
		require
			in_final_mode
		do
			Result :=
				if attached remover as r then
						-- Use reachability information from the remover.
					r.is_class_reachable (c.class_id)
				else
						-- Use general information about class usage.
					c.is_precompiled implies c.is_in_system
				end
		end

	is_class_type_alive (i: like {CLASS_TYPE}.type_id): BOOLEAN
			-- Is class type of ID `i` alive (i.e., an object of that type can be created) when executing the system?
		require
			in_final_mode
			class_types.valid_index (i)
		do
			Result := is_class_type_alive_storage [i]
		end

	is_class_type_reachable (i: like {CLASS_TYPE}.type_id): BOOLEAN
			-- Is class type of ID `i` reachable (i.e., code of that type could be executed) when executing the system?
		require
			in_final_mode
			class_types.valid_index (i)
		do
			Result := is_class_type_reachable_storage [i]
		end

feature {NONE} -- Generation

	is_type_reachable (t: TYPE_A): BOOLEAN
			-- Is type `t` built using only reachable classes?
		require
			in_final_mode
		do
			Result :=
				attached t.base_class as c implies
				(c.is_precompiled implies c.is_in_system) and then
				(attached t.generics as gs implies across gs as g all is_type_reachable (g.item) end)
		end

	is_class_type_alive_storage: BOOL_STRING
			-- Storage for precomputed values of `is_class_type_alive`.
		require
			in_final_mode
		once
			create Result.make (0)
		end

	is_class_type_reachable_storage: BOOL_STRING
			-- Storage for precomputed values of `is_class_type_reachable`.
		require
			in_final_mode
		once
			create Result.make (0)
		end

feature -- Generation

	generate_main_finalized_eiffel_files
			-- Generation of all the tables needed by the finalized
			-- Eiffel executable.
		local
			deg_output: DEGREE_OUTPUT
			t: AUXILIARY_FILES
			degree_message: STRING
		do
			create t.make (Current, byte_context)
			degree_message := "Generating Auxiliary Files"
			deg_output := Degree_output

				-- Address table
			deg_output.put_degree_output (degree_message, 10, 10)
			address_table.generate (True)

				-- Generation of the reference number table
			deg_output.put_degree_output (degree_message, 9, 10)
			generate_reference_table

				-- Cecil structures generation
			deg_output.put_degree_output (degree_message, 8, 10)
			generate_cecil

				-- Generation of the skeletons
			deg_output.put_degree_output (degree_message, 7, 10)
			generate_skeletons
			generate_expanded_structures

				-- Generation of the parent table
			deg_output.put_degree_output (degree_message, 6, 10)
			generate_parent_tables

				-- Generate plug with run-time.
				-- Has to be done before `generate_routine_table' because
				-- this is were we mark `used' the attribute table of `lower' and
				-- `area' used with `array_optimization'.
			deg_output.put_degree_output (degree_message, 5, 10)
			t.generate_plug

				-- Routine table generation
			deg_output.put_degree_output (degree_message, 4, 10)
			generate_routine_table

				-- Generate edynlib with run-time.
			deg_output.put_degree_output (degree_message, 3, 10)
			t.generate_dynamic_lib_file

				-- Generate init file
			deg_output.put_degree_output (degree_message, 2, 10)
			generate_init_file

				-- Generate option file
			if keep_assertions then
				generate_option_file (False)
			end

				-- Generate stubs to perform separate calls.
			separate_patterns.generate

				-- Generation of type size table
			deg_output.put_degree_output (degree_message, 1, 10)
			generate_size_table

				-- Generate makefile
			deg_output.put_degree_output (degree_message, 0, 10)
			t.generate_make_file
		end

	store_finalized_type_mapping (a_backup: ARRAY [INTEGER])
			-- Store the mapping between workbench `type_id' and the finalized one.
			-- This mapping is needed for the profiler wizard when displaying finalized result.
		require
			in_final_mode
			a_backup_not_void: a_backup /= Void
			a_backup_valid: a_backup.lower >= 0 and a_backup.upper <= static_type_id_counter.count
		local
			class_array: ARRAY [CLASS_C]
			a_class: CLASS_C
			types: TYPE_LIST
			i, nb: INTEGER
			l_new_old_mapping: ARRAY [INTEGER]
			l_writer: SED_MEDIUM_READER_WRITER
			l_facility: SED_STORABLE_FACILITIES
			l_mapping_file: RAW_FILE
		do
				-- Build mapping between the new IDs and the old ones.
			from
				class_array := classes
				nb := class_counter.count
				create l_new_old_mapping.make_filled (0, a_backup.lower, a_backup.upper)
				i := 1
			until
				i > nb
			loop
				a_class := class_array.item (i)
				if a_class /= Void then
					from
						types := a_class.types
						types.start
					until
						types.after
					loop
						l_new_old_mapping [types.item.type_id] := a_backup [types.item.static_type_id]
						types.forth
					end
				end
				i := i + 1
			end

			create l_mapping_file.make_with_path (project_location.final_path.extended (finalized_type_mapping))
			l_mapping_file.open_write
			create l_writer.make (l_mapping_file)
			l_writer.set_for_writing
			create l_facility
			l_facility.store (l_new_old_mapping, l_writer)
			l_mapping_file.close
		end

	internal_retrieved_finalized_type_mapping: like retrieved_finalized_type_mapping
			-- Storage for `retrieved_finalized_type_mapping'.

	retrieved_finalized_type_mapping: ARRAY [INTEGER]
			-- Mapping between finalized type IDs and the workbench one if present. Void otherwise.
		local
			l_file: RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			retried: BOOLEAN
		do
			if not retried then
				Result := internal_retrieved_finalized_type_mapping
				if Result = Void then
					create l_file.make_with_path (project_location.final_path.extended (finalized_type_mapping))
					if l_file.exists then
						l_file.open_read
						create l_reader.make (l_file)
						l_reader.set_for_reading
						create l_facility
						Result ?=  l_facility.retrieved (l_reader, True)
						l_file.close
						internal_retrieved_finalized_type_mapping := Result
					end
				end
			end
		rescue
			retried := True
			retry
		end

	process_dynamic_types (is_restoring: BOOLEAN; a_backup: ARRAY [INTEGER]; a_type_id_counter_value: INTEGER)
			-- Processing of the dynamic types.
			-- This is only needed when finalizing because this is where it is important
			-- to have `type_id' sorted in topological order. This solves eweasel test#exec256.
		require
			is_finalizing: compilation_modes.is_finalizing
			a_backup_not_void: a_backup /= Void
			a_backup_valid_for_restoring: is_restoring implies
				(a_backup.lower >= 0 and a_backup.upper <= static_type_id_counter.count)
			valid_counter_value: is_restoring implies a_type_id_counter_value > 0
		local
			class_array: ARRAY [CLASS_C]
			class_list: ARRAY [detachable CLASS_C]
			a_class: CLASS_C
			types: TYPE_LIST
			i, nb: INTEGER
			l_class_is_finalized: BOOLEAN
		do
			if is_restoring then
					-- Restore modified types.
				from
					class_types.clear_all
					class_array := classes
					nb := class_counter.count
					i := 1
				until
					i > nb
				loop
					a_class := class_array.item (i)
					if a_class /= Void then
						from
							types := a_class.types
							types.start
						until
							types.after
						loop
							reset_type_id (types.item, a_backup [types.item.static_type_id])
							types.forth
						end
					end
					i := i + 1
				end
				type_id_counter.set_value (a_type_id_counter_value)
			else
					-- We simply take types in their topological order from CLASS_C.topological_id
					-- and then traverse the list and reset the dynamic type id.

					-- Sort the class_list by type id in `class_list'.
				create class_list.make_filled (Void, 1, max_class_id)
				class_array := classes
				nb := class_counter.count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						class_list.put (a_class, a_class.topological_id)
					end
					i := i + 1
				end

					-- Iteration on `class_list' in order to compute new type id's
				from
					nb := max_class_id
					class_types.clear_all
					type_id_counter.set_value (0)
					i := 1
				until
					i > nb
				loop
						-- Types of the class
					a_class := class_list.item (i)

						-- The following check is needed as `class_list' can contain Void items after Degree 4
						-- when {TEST_SYSTEM_I} removed unused classes.
					if a_class /= Void then
						types := a_class.types
						l_class_is_finalized := not a_class.is_precompiled or else a_class.is_in_system
							-- If an expanded type is in a precompiled library, then there will always
							-- be a generic derivation for TYPE [my_expanded_class] due to the presence
							-- of `generating_type: TYPE [detachable like Current]' in ANY. Even if the
							-- expanded class is not really used in the system, we need to compile it in
							-- so that we can generate the generic derivation of `{TYPE}' that includes it.
							-- This solves many eweasel tests such as test#time002 when
							-- UTF_CONVERTER expanded class was added to EiffelBase.
						l_class_is_finalized := l_class_is_finalized or else a_class.is_expanded
							-- The following line is a hack so that `types.sort' works.
						current_class := a_class
						types.sort (a_class)
						from
							types.start
						until
							types.after
						loop
							a_backup [types.item.static_type_id] := types.item.type_id
							if l_class_is_finalized then
									-- Only update `type_id' for types of classes which are really
									-- part of the system for a finalization. Classes that are not
									-- part of the system are not in `class_types' anymore and this
									-- is why we don't bother updating their `type_id'. It will be
									-- properly restored when `is_restoring' is True.
								reset_type_id (types.item, type_id_counter.next)
							end
							types.forth
						end
					end
					i := i + 1
				end
			end
		end

	process_optimized_single_types (is_restoring: BOOLEAN; a_backup: ARRAY [INTEGER])
			-- Modifies the implementation ids of all class marked as now being single genereation types.
			--
			-- The purpose of this routine is to temporarly set an applicable type's implementation id to
			-- a static id. This is require for finalizing and optimizing .NET types, where non-single types
			-- may be generated a single types during finalization.			
		require
			is_finalizing: compilation_modes.is_finalizing
			il_generation: il_generation
			a_backup_not_void: a_backup /= Void
			a_backup_valid_for_restoring: is_restoring implies
				(a_backup.lower >= 0 and a_backup.upper <= static_type_id_counter.count)
		local
			i, l_count: INTEGER
			l_types: like class_types
		do
			l_types := class_types
			l_count := l_types.count
			if is_restoring then
				from i := 1 until i = l_count loop
					if
						attached l_types [i] as class_type and then not class_type.is_precompiled and then
						not class_type.is_external and then class_type.is_generated_as_single_type
					then
						class_type.set_implementation_id (a_backup [i])
					end
					i := i + 1
				end
			else
				from i := 1 until i = l_count loop
					if
						attached l_types [i] as class_type and then not class_type.is_precompiled and then
						not class_type.is_external and then class_type.is_generated_as_single_type
					then
						a_backup.put (class_type.implementation_id, i)
							-- Set implementation id to static id for .NET types that have been marked a single.
						class_type.set_implementation_id (class_type.static_type_id)
					end
					i := i + 1
				end
			end
		end

	reset_type_id (class_type: CLASS_TYPE; an_id: INTEGER)
			-- Assign a new dynamic type id to `class_type'.
		require
			class_type_not_void: class_type /= Void
			an_id_positive: an_id > 0
		do
			class_type.set_type_id (an_id)
				-- Update `class_types'
			insert_class_type (class_type)
		end

	generate_routine_table
			-- Generate routine and attribute tables.
		require
			in_final_mode: byte_context.final_mode
		local
			table: POLY_TABLE [ENTRY]
			i, nb: INTEGER
			used, used_for_routines, used_for_types: PACKED_BOOLEANS
			l_rout_id: INTEGER
			l_buf: like generation_buffer
			l_header_buf: like header_generation_buffer
			l_table_name: STRING
			l_poly_file: INDENT_FILE
			l_rout_ids: ARRAYED_LIST [INTEGER]
			l_tmp_poly_server: like tmp_poly_server
			l_encoder: like encoder
			l_processed: HASH_TABLE [BOOLEAN, INTEGER]
			l_done: BOOLEAN
			trampoline_code: NATURAL_64
		do
			l_buf := generation_buffer
			l_header_buf := header_generation_buffer
			l_tmp_poly_server := tmp_poly_server
			l_encoder := encoder

				-- Generate tables and their initialization routines.
			attr_generator.init (l_buf)
			rout_generator.init (l_header_buf)
			rout_generator.reset_counter

			used := Eiffel_table.used
			used_for_types := Eiffel_table.used_for_types
			used_for_routines := Eiffel_table.used_for_routines

				-- Iterate until no more tables are marked used.
				-- This solves test#anchor040 where during `table.write_for_type'
				-- new routine IDs are marked alive.
			from
				create l_processed.make (used.count)
			until
				l_done
			loop
				from
					l_done := True
					i := used.lower
					nb := used.upper
				until
					i > nb
				loop
					if used.item (i) and not l_processed.item (i) then
						table := l_tmp_poly_server.item (i)
						if used_for_routines.valid_index (i) and then used_for_routines.item (i) then
							table.write
						end
						if used_for_types.valid_index (i) and then used_for_types.item (i) then
							table.write_for_type
						end
						l_processed.put (True, i)
						l_done := False
					end
					i := i + 1
				end
			end

			generate_initialization_table
			generate_expanded_creation_table
			generate_dispose_table
			generate_copy_table
			generate_is_equal_table

			attr_generator.finish
			rout_generator.finish

			trampoline_generator.init (l_buf)
			across
				trampoline_table.twin as t
			loop
				if attached {ROUT_TABLE} l_tmp_poly_server.item (t.key) as r then
					across
						t.item.twin as s
					loop
						trampoline_code := s.item
						r.generate_trampoline ((trampoline_code |>> 32).as_integer_32, (trampoline_code & 0xFFFFFFFF).as_integer_32, trampoline_generator)
					end
				end
			end
			trampoline_generator.finish

				-- Call initialization routines for all tables used in system.

			l_buf.clear_all
			l_header_buf.clear_all

			l_header_buf.put_string ("#include %"eif_eiffel.h%"")
			l_header_buf.start_c_specific_code

				-- Initialize tables for routines.
			l_buf.put_new_line
			l_buf.put_string ("void egc_routine_tables_init (void)")
			l_buf.generate_block_open

				-- Allocate `egc_routines_types', `egc_routines_gen_types' and `egc_routiness_offset'.
			l_buf.put_new_line
			l_buf.put_string ("egc_routines_types = (EIF_TYPE_INDEX **) eif_malloc (sizeof(EIF_TYPE_INDEX *) * ")
			l_buf.put_integer (routine_id_counter.count + 1)
			l_buf.put_string (");")
			l_buf.put_new_line
			l_buf.put_string ("egc_routines_gen_types = (EIF_TYPE_INDEX ***) eif_malloc (sizeof(EIF_TYPE_INDEX **) * ")
			l_buf.put_integer (routine_id_counter.count + 1)
			l_buf.put_string (");")
			l_buf.put_new_line
			l_buf.put_string ("egc_routines_offset = (int *) eif_malloc (sizeof(int) * ")
			l_buf.put_integer (routine_id_counter.count + 1)
			l_buf.put_string (");")
			l_buf.put_new_line

			from
				i := used.lower
				nb := used.upper
			until
				i > nb
			loop
				if used.item (i) then
					table := l_tmp_poly_server.item (i)
					if used_for_routines.valid_index (i) and then used_for_routines.item (i) then
						table.generate_initialization (l_buf, l_header_buf)
					end
					if used_for_types.valid_index (i) and then used_for_types.item (i) then
						l_table_name := l_encoder.type_table_name (i)
							-- Declare initialization routine for table
						l_header_buf.put_new_line
						l_header_buf.put_string ("extern void ")
						l_header_buf.put_string (l_table_name)
						l_header_buf.put_string ("_init(void);")

							-- Call the routine
						l_buf.put_new_line
						l_buf.put_string (l_table_name)
						l_buf.put_string ("_init();")
					end
				end
				i := i + 1
			end

				-- Generate initialization for special tables.
			from
				create l_rout_ids.make (4)
				l_rout_ids.extend (routine_id_counter.dispose_rout_id)
				l_rout_ids.extend (routine_id_counter.copy_rout_id)
				l_rout_ids.extend (routine_id_counter.is_equal_rout_id)
				l_rout_ids.extend (routine_id_counter.initialization_rout_id)
				l_rout_ids.extend (routine_id_counter.creation_rout_id)
				l_rout_ids.start
			until
				l_rout_ids.after
			loop
				l_rout_id := l_rout_ids.item
				l_table_name := l_encoder.routine_table_name (l_rout_id)
					-- Declare initialization routine for table
				l_header_buf.put_new_line
				l_header_buf.put_string ("extern void ")
				l_header_buf.put_string (l_table_name)
				l_header_buf.put_string ("_init(void);")

					-- Call the routine
				l_buf.put_new_line
				l_buf.put_string (l_table_name)
				l_buf.put_string ("_init();")
				l_rout_ids.forth
			end

			l_buf.generate_block_close
			l_buf.end_c_specific_code
			create l_poly_file.make_c_code_file (final_file_name (epoly, dot_c, 1))
			l_header_buf.put_in_file (l_poly_file)
			l_buf.put_in_file (l_poly_file)
			l_poly_file.close
		end

	extend_skeleton_table (a_macro_name, a_macro_definition: STRING)
			-- Add `a_macro_name' and `a_macro_definition' into `skeleton_table'.
		require
			in_final_mode: in_final_mode
			a_macro_name_not_void: a_macro_name /= Void
			a_macro_definition_not_void: a_macro_definition /= Void
			skeleton_table_not_void: skeleton_table /= Void
		do
			skeleton_table.put (a_macro_name, a_macro_definition)
		ensure
			inserted: skeleton_table.has (a_macro_definition) and then skeleton_table.item (a_macro_definition).is_equal (a_macro_name)
		end

	generate_size_table
			-- Generate the size table.
		require
			final_mode: in_final_mode
		local
			i, nb: INTEGER
			class_type: CLASS_TYPE
			size_file: INDENT_FILE
			buffer: GENERATION_BUFFER
			l_skeleton_table: like skeleton_table
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
				check class_type_not_void: class_type /= Void end
				class_type.skeleton.generate_size (buffer, False)
				buffer.put_character (',')
				if class_type.type /= Void then
					buffer.put_string (" /* " + class_type.type.dump + " */")
				else
					buffer.put_string (" /* " + class_type.associated_class.name_in_upper + " */")
				end
				buffer.put_character ('%N')
				i := i + 1
			end
			buffer.put_string ("};%N")
			create size_file.make_c_code_file (x_gen_file_name (in_final_mode, Esize))
			buffer.put_in_file (size_file)
			size_file.close

				-- Generate the mapping between macros and the actual computation of the size.
			from
					-- Clear buffer for current generation
				buffer := generation_buffer
				buffer.clear_all
				buffer.put_string ("#ifndef _eoffsets_h_%N#define _eoffsets_h_")
				buffer.put_new_line
				buffer.put_new_line
				l_skeleton_table := skeleton_table
				l_skeleton_table.start
			until
				l_skeleton_table.after
			loop
				buffer.put_string ("#define ")
				buffer.put_string (l_skeleton_table.item_for_iteration)
				buffer.put_character (' ')
				buffer.put_string (l_skeleton_table.key_for_iteration)
				buffer.put_new_line
				l_skeleton_table.forth
			end
			buffer.put_new_line
			buffer.put_string ("#endif%N")
			create size_file.make_c_code_file (x_gen_file_name (in_final_mode, Eoffsets))
			buffer.put_in_file (size_file)
			size_file.close
		end

	generate_reference_table
			-- Generate the table of reference number per type.
		require
			in_final_mode
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

	generate_parent_tables
			-- Generates parent tables.
		local
			i, nb, cid: INTEGER
			cl_type: CLASS_TYPE
			parents_file: INDENT_FILE
			final_mode: BOOLEAN
			max_id: INTEGER
			used_ids: ARRAY [BOOLEAN]
			buffer: GENERATION_BUFFER
		do
				-- Clear buffer for current generation
			buffer := generation_buffer
			buffer.clear_all

			final_mode := byte_context.final_mode

			buffer.put_string ("[
				#include "eif_eiffel.h"
			]")

			buffer.start_c_specific_code

			from
				i := 1
				max_id := 0
				nb := Type_id_counter.value
				create used_ids.make_filled (False, 0, nb)
			until
				i > nb
			loop
				cl_type := class_types.item (i)
				if cl_type /= Void then
					cl_type.generate_parent_table (buffer, final_mode)
					cid := cl_type.type.generated_id (final_mode, Void)
					used_ids.force (True, cid)
					if cid > max_id then
						max_id := cid
					end
				end
				i := i + 1
			end

			buffer.put_new_line
			buffer.put_string ("int egc_partab_size_init = ")
			buffer.put_integer (max_id)
			buffer.put_string ("[
				;
				struct eif_par_types *egc_partab_init[] = {

			]")

			from
				i := 0
			until
				i > max_id
			loop
				if used_ids.item (i) then
					buffer.put_string ("&par")
					buffer.put_integer (i)
				else
					buffer.put_string ("NULL")
				end
				buffer.put_string (",%N")
				i := i + 1
			end
			buffer.put_string ("NULL};")
			buffer.end_c_specific_code

			create parents_file.make_c_code_file (gen_file_name (final_mode, Eparents));
			buffer.put_in_file (parents_file)
			parents_file.close
		end

	generate_skeletons
			-- Generate skeletons of class types.
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			final_mode: BOOLEAN
			types: TYPE_LIST
			skeleton_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
			final_mode := byte_context.final_mode

				-- Since generated file `eskelet.[cx]' can be very big
				-- every 500K we write onto disk.
			create skeleton_file.make_c_code_file (x_gen_file_name (final_mode, Eskelet));

			buffer := generation_buffer
			buffer.clear_all

			buffer.put_string ("#include %"eif_eiffel.h%"")

			if not final_mode then
					-- Hash table extern declaration in workbench mode
				buffer.start_c_specific_code

				class_array := classes
				nb := class_counter.count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if
						attached a_class and then
						a_class.has_visible
					then
						buffer.put_string ("extern const char *cl")
						buffer.put_integer (a_class.class_id)
						buffer.put_string ("[];%N")
						from
							types := a_class.types
							types.start
						until
							types.after
						loop
							buffer.put_string ("extern const uint32 cr")
							buffer.put_integer (types.item.type_id)
							buffer.put_string ("[];%N")
							types.forth
						end
					end
					i := i + 1
				end
				buffer.put_new_line
			else
				buffer.start_c_specific_code
			end

				-- Generates the skeleton data used to fill skeleton.
			from
				nb := Type_id_counter.value
				i := 1
			until
				i > nb
			loop
				buffer.flush_buffer (skeleton_file)
					-- Classes could be removed
				if attached class_types [i] as class_type then
					class_type.generate_skeleton1 (buffer)
				end
				i := i + 1
			end

				-- Generate skeleton.
			buffer.put_string ("const struct cnode egc_fsystem_init[] = {")
			from
				i := 1
			until
				i > nb
			loop
				buffer.flush_buffer (skeleton_file)
				if attached class_types [i] as class_type then
					if final_mode then
						if
							not class_type.associated_class.is_precompiled or else
							class_type.associated_class.is_in_system
						then
							class_type.generate_skeleton2 (buffer)
						else
								-- Type not inserted in system because it was coming
								-- from a precompiled library.
							buffer.put_string ("%N{0L, 0L,%"INVALID_TYPE%",NULL,NULL,NULL,NULL,(uint16)0L,NULL,NULL}")
						end
					else
						class_type.generate_skeleton2 (buffer)
					end
				else
					if final_mode then
						buffer.put_string ("%N{0L, 0L,%"INVALID_TYPE%",NULL,NULL,NULL,NULL,(uint16)0L,NULL,NULL}")
					else
						buffer.put_string
							("%N{%N0L,%N0L,%N%"INVALID_TYPE%",%NNULL,%NNULL,%N%
							%NULL,%NNULL,%N(uint16) 0L,%NNULL,%N0L,%N0L,%N%
							%(int32) 0L,%N%
							%{(int32) 0, (int) 0, NULL, NULL}, NULL}")
					end
				end
				buffer.put_character (',')
				i := i + 1
			end
			buffer.put_string ("};%N")

			buffer.end_c_specific_code

				-- Generate skeleton
			buffer.put_in_file (skeleton_file)
			skeleton_file.close

				-- Generates the attribute names outside of `eskelet.c' because it slows
				-- down the Visual Studio C++ 2005 compiler on 64-bit.
			create skeleton_file.make_c_code_file (gen_file_name (final_mode, Enames));
			buffer.clear_all
			buffer.start_c_specific_code
			buffer.put_new_line
			from
				nb := Type_id_counter.value
				i := 1
			until
				i > nb
			loop
				buffer.flush_buffer (skeleton_file)
					-- Classes could be removed
				if attached class_types [i] as class_type then
					class_type.generate_attribute_names (buffer)
				end
				i := i + 1
			end
			buffer.end_c_specific_code
			buffer.put_in_file (skeleton_file)
			skeleton_file.close
		end

	generate_expanded_structures
			-- Generate structures for expanded class types
		local
			i, nb: INTEGER
			cl_type: CLASS_TYPE
			structure_file: INDENT_FILE
			buffer: GENERATION_BUFFER
			final_mode: BOOLEAN
		do
			final_mode := in_final_mode
			create structure_file.make_c_code_file
				(if final_mode then
					final_file_name (estructure, Dot_x, 1)
				else
					workbench_file_name (estructure, Dot_h, 1)
				end)

			buffer := generation_buffer
			buffer.clear_all

			buffer.put_string ("#ifndef _estructure_h_%N#define _estructure_h_%N%N")
			buffer.put_string ("#include %"eif_eiffel.h%"")

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
					cl_type.generate_expanded_structure_definition (buffer)
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

	generate_cecil
			-- Generate Cecil structures
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			final_mode: BOOLEAN
			temp: STRING
			subdir: DIRECTORY
			dir_name: PATH
			cecil_file, header_file: INDENT_FILE
			buffer, header_buffer: GENERATION_BUFFER
			l_has_visible: BOOLEAN
			generated_wrappers: SEARCH_TABLE [STRING]
		do
				-- Clear buffers for current generation
			buffer := generation_buffer
			buffer.clear_all
			header_buffer := header_generation_buffer
			header_buffer.clear_all

			final_mode := byte_context.final_mode

			buffer.put_string ("#include %"eif_eiffel.h%"")
			buffer.put_string ("%N#include %"eif_cecil.h%"")
			if final_mode then
				buffer.put_string ("%N#include %"ececil.h%"")
			end

			buffer.start_c_specific_code

			create generated_wrappers.make (10)
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void and then a_class.has_visible then
					l_has_visible := True
					set_current_class (a_class)
					a_class.generate_cecil (generated_wrappers)
				end
				i := i + 1
			end

			if final_mode then
					-- Extern declarations for previous file
				header_buffer.put_string ("#include %"eif_eiffel.h%"")
				header_buffer.start_c_specific_code
				Extern_declarations.generate (header_buffer)
				header_buffer.end_c_specific_code
				Extern_declarations.wipe_out

					-- Generation in file (we need to create the subdirectory
				create temp.make (2)
				temp.append_character (System_object_prefix)
				temp.append_integer (1)
				dir_name := project_location.final_path.extended (temp)
				create subdir.make_with_path (dir_name)
				if not subdir.exists then
					subdir.create_dir
				end
				create header_file.make_open_write (dir_name.extended ("ececil.h"))
				header_buffer.put_in_file (header_file)
				header_file.close

				if not l_has_visible then
					buffer.put_string ("%Nstruct ctable egc_ce_rname_init[")
					buffer.put_integer (Type_id_counter.value)
					buffer.put_three_character (']', ';', '%N')
				else
					buffer.put_string ("%Nstruct ctable egc_ce_rname_init[] = {%N")
					from
						i := 1
						nb := Type_id_counter.value
					until
						i > nb
					loop
						if attached class_types [i] as class_type and then class_type.associated_class.has_visible then
							class_type.generate_cecil (buffer)
						else
							buffer.put_string (once "%N{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
						end
						buffer.put_character (',')
						i := i + 1
					end
					buffer.put_new_line
					buffer.put_three_character ('}', ';', '%N')
				end
			end

			create_cecil_tables
			cecil_class_table.generate

			buffer.end_c_specific_code

			create cecil_file.make_c_code_file (gen_file_name (final_mode, Evisib));
			buffer.put_in_file (cecil_file)
			cecil_file.close
		end

	create_cecil_tables
			-- Prepare cecil tables.
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

	generate_initialization_table
			-- Generate table of initialization routines for composite objects.
		require
			in_final_mode
		local
			rout_table: ROUT_TABLE
			rout_entry: ROUT_ENTRY
			i, nb: INTEGER
			l_void: VOID_A
			l_c_pattern_id: INTEGER
			l_arg_types: SPECIAL [TYPE_C]
		do
			if attached remover as r then
					-- Ensure that initialization routines are marked `used'.
				r.mark_code_reachable (body_index_counter.initialization_body_index)
			end
			i := 1
			nb := Type_id_counter.value
			if i <= nb then
					-- Fetch the C pattern ID of the initialization routine.
				create l_arg_types.make_empty (2)
				l_arg_types.extend (create {REFERENCE_I})
				l_arg_types.extend (create {REFERENCE_I})
				l_c_pattern_id := pattern_table.c_pattern_id
					(create {C_PATTERN}.make (create {VOID_I}, l_arg_types))
				from
					create rout_table.make (routine_id_counter.initialization_rout_id)
					create l_void
					rout_table.create_block (nb)
				until
					i > nb
				loop
					if
						attached class_types.item (i) as class_type
						and then class_type.has_creation_routine
					then
						create rout_entry.make
							(l_void,
							i,
							0,
							False,
							body_index_counter.initialization_body_index,
							l_c_pattern_id,
							i,
							class_type.associated_class.class_id,
							class_type.associated_class.class_id,
							False,
							class_type.associated_class.class_id)
						rout_table.extend (rout_entry)
					end
					i := i + 1
				end
				rout_table.sort
			end
			rout_table.generate_full (routine_id_counter.initialization_rout_id, header_generation_buffer)
		end

	generate_expanded_creation_table
			-- Generate table of creation procedures for all expanded objects.
		local
			rout_table: ROUT_TABLE
			rout_entry: ROUT_ENTRY
			i, nb: INTEGER
			l_class: CLASS_C
		do
			from
				create rout_table.make (routine_id_counter.creation_rout_id)
				i := 1
				nb := Type_id_counter.value
				rout_table.create_block (nb)
			until
				i > nb
			loop
				if attached class_types.item (i) as class_type then
					l_class := class_type.associated_class
					if
						l_class.is_used_as_expanded and then
						attached l_class.creation_feature as f and then
						(f.is_external or else not f.is_empty)
					then
						rout_entry := l_class.creation_feature.new_rout_entry (class_type, l_class.is_deferred, l_class.class_id)
						rout_table.extend (rout_entry)
					end
				end
				i := i + 1
			end
			rout_table.sort
			rout_table.generate_full (routine_id_counter.creation_rout_id, header_generation_buffer)
		end

feature -- Dispose routine

	disposable_dispose_id: INTEGER
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

	object_finalize_id: INTEGER
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

	disposable_descendants: SEARCH_TABLE [CLASS_C]
			-- DISPOSABLE descendants.
		once
			create Result.make (50)
		end

	reset_disposable_descendants
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

	formulate_mem_descendants (c: CLASS_C; desc: SEARCH_TABLE [CLASS_C])
			-- Formulate descendants of class DISPOSABLE.
		local
			descendants: ARRAYED_LIST [CLASS_C]
			d: CLASS_C
		do
			from
				descendants := c.direct_descendants
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

	generate_dispose_table
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

feature -- Copy routine

	any_copy_id: INTEGER
			-- Copy routine id from class ANY.
			-- Return 0 if the ANY class has not been compiled
			-- or has no copy routine.
		once
			if
				attached any_class as c and then
				c.is_compiled and then
				attached c.compiled_class.feature_table.item_id (names.copy_name_id) as f
			then
				Result := f.rout_id_set.first
			end
		end

	generate_copy_table
			-- Generate copy table.
		local
			entry: ROUT_TABLE
		do
			if any_class /= Void and then any_class.is_compiled then
					-- Get the polymorphic table corresponding to the `copy' routine from ANY.
				entry ?= Eiffel_table.poly_table (any_copy_id)
			end
			if entry = Void then
					-- Create an empty table needed as runtime expect this table
					-- to exist.
				create entry.make (routine_id_counter.copy_rout_id)
			end
				-- We are using `header_generation_buffer' for the generation
				-- because this is used for routine tables (look at
				-- `generate_routine_table').
				-- We are using `routine_id_counter.copy_rout_id' and not
				-- `any_copy_id' to generate the table, because we are not
				-- generating a standard polymorphic table and so, we cannot reuse the
				-- one which could have been generated if there was any polymorphic
				-- call on `copy'.
			entry.generate_full (routine_id_counter.copy_rout_id,
											header_generation_buffer)
		end

	generate_is_equal_table
			-- Generate is_equal table.
		local
			entry: ROUT_TABLE
		do
			if any_class /= Void and then any_class.is_compiled then
					-- Get the polymorphic table corresponding to the `is_equal' routine from ANY.
				entry ?= Eiffel_table.poly_table (is_equal_rout_id)
			end
			if entry = Void then
					-- Create an empty table needed as runtime expect this table
					-- to exist.
				create entry.make (routine_id_counter.is_equal_rout_id)
			end
				-- We are using `header_generation_buffer' for the generation
				-- because this is used for routine tables (look at
				-- `generate_routine_table').
				-- We are using `routine_id_counter.is_equal_rout_id' and not
				-- `is_equal_rout_id' to generate the table, because we are not
				-- generating a standard polymorphic table and so, we cannot reuse the
				-- one which could have been generated if there was any polymorphic
				-- call on `is_equal'.
			entry.generate_full (routine_id_counter.is_equal_rout_id,
											header_generation_buffer)
		end

feature -- Pattern table generation

	generate_pattern_table
			-- Generate pattern table.
		do
			pattern_table.generate
		end

	generate_init_file
			-- Generation of the main file
		local
			final_mode: BOOLEAN
			i, nb: INTEGER
			initialization_file: INDENT_FILE
			buffer: GENERATION_BUFFER
			l_empty_array: ARRAY [STRING_8]
			l_encoder: like encoder
			cs: CURSOR
			l_root: SYSTEM_ROOT
			l_root_cl: CLASS_C
			l_root_ft: FEATURE_I
			l_root_type: CLASS_TYPE
			l_root_rout_table: ROUT_TABLE
			l_root_rout_cname, l_root_caller: STRING
			l_root_callers: ARRAYED_LIST [STRING]
		do
				-- Clear buffer for current generation
			buffer := generation_buffer
			buffer.clear_all

			l_encoder := encoder

			final_mode := byte_context.final_mode

			create l_empty_array.make_empty

			buffer.put_string ("#include %"eif_eiffel.h%"")

			buffer.start_c_specific_code

			if final_mode then
				from
					cs := root_creators.cursor
					root_creators.start
					create l_root_callers.make (root_creators.count)
				until
					root_creators.after
				loop
					l_root := root_creators.item_for_iteration

						-- In a final systems explicit roots are no longer present
					if not l_root.procedure_name.is_empty and not l_root.is_explicit then
						l_root_type := root_class_type (l_root.class_type)
						l_root_cl := l_root_type.associated_class
						l_root_ft := l_root_cl.feature_table.item (l_root.procedure_name)
						l_root_rout_table ?= eiffel_table.poly_table (l_root_ft.rout_id_set.first)
						l_root_rout_table.goto_implemented (l_root_type.type, l_root_type)
						check
							implemented: l_root_rout_table.is_implemented
						end
						l_root_rout_cname := l_root_rout_table.feature_name.string
						if l_root_ft.has_arguments then
							buffer.generate_extern_declaration
								("void", l_root_rout_cname, <<"EIF_REFERENCE", "EIF_REFERENCE">>)
						else
							buffer.generate_extern_declaration
								("void", l_root_rout_cname, <<"EIF_REFERENCE">>)
						end

						l_root_caller := l_root_rout_cname.string
						l_root_caller.append ("(root_obj")
						if l_root_ft.has_arguments then
							l_root_caller.append (", eif_arg_array()")
						end
						l_root_caller.append (");")
						l_root_callers.force (l_root_caller)
					end
					root_creators.forth
				end
				root_creators.go_to (cs)
			end

			buffer.generate_function_signature ("void", "emain", True, buffer,
						<<"argc", "argv">>, <<"int", "EIF_NATIVE_CHAR **">>)

			buffer.generate_block_open
			buffer.put_gtcx
			buffer.put_new_line
			buffer.put_string ("root_obj = RTLNSMART(")
			buffer.put_string ("egc_rcdt[egc_ridx]")
			buffer.put_string (");")
			if not final_mode then
				buffer.put_new_line
				buffer.put_string ("if (egc_rt_extension_dt != INVALID_DTYPE) {")
				buffer.indent
				buffer.put_new_line
				buffer.put_string ("rt_extension_obj = RTLNSMART(")
				buffer.put_string ("egc_rt_extension_dt")
				buffer.put_string (");")
				buffer.exdent
				buffer.put_new_line
				buffer.put_string ("};")
			end

			if final_mode then
				check
					callers_attached: l_root_callers /= Void
				end
				if keep_assertions then
						-- Always set `nstcall' to 0 to fix eweasel test#exec289.
					buffer.put_string ("nstcall = 0;")
					buffer.put_new_line
				end
				buffer.put_new_line
				buffer.put_string ("switch (egc_ridx)")
				buffer.generate_block_open
				buffer.put_new_line
				from
					l_root_callers.start
					i := 0
				until
					l_root_callers.after
				loop
					buffer.put_string ("case ")
					buffer.put_integer (i)
					buffer.put_string (":%N")
					buffer.indent
					buffer.put_new_line
					buffer.put_string (l_root_callers.item_for_iteration)
					buffer.put_new_line
					buffer.put_string ("break;")
					buffer.exdent
					i := i + 1
					l_root_callers.forth
				end
				buffer.generate_block_close
				-- REPLACE
			else
				buffer.put_new_line_only
				buffer.put_string (
					"{
	if (egc_rcrid[egc_ridx] != -1) {
		if (egc_rcarg[egc_ridx]) {
			EIF_TYPED_VALUE u_args;
			u_args.type = SK_REF;
			u_args.it_r = eif_arg_array();
			(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(egc_rcrid[egc_ridx], Dtype(root_obj)))(root_obj, u_args);
		} else {
			(FUNCTION_CAST(void, (EIF_REFERENCE)) RTWF(egc_rcrid[egc_ridx], Dtype(root_obj)))(root_obj);
		}
	}
					}"
				)
			end

			if is_scoop then
					-- Wait for SCOOP Processor redundancy.
				buffer.put_new_line
				buffer.put_string ("RTS_WPR")
			end

			buffer.generate_block_close

			-- Generation of egc_einit_init() and egc_tabinit_init(). Only for workbench
			-- mode.

			if not final_mode then
					-- Separation for formatting
				buffer.put_new_line
					-- Prototypes
				buffer.generate_extern_declaration ("void", "egc_tabinit_init", l_empty_array)
				from
					i := 1
					nb := type_id_counter.value
				until
					i > nb
				loop
					if attached class_types [i] as class_type then
						buffer.generate_extern_declaration (once "void", l_encoder.init_name (class_type.static_type_id), l_empty_array)
					end
					i := i + 1
				end

					-- Separation for formatting
				buffer.put_new_line
				buffer.put_new_line
				buffer.put_string ("void egc_tabinit_init(void)")
				buffer.generate_block_open
				from
					i := 1
					nb := type_id_counter.value
				until
					i > nb
				loop
					if attached class_types [i] as class_type then
						buffer.put_new_line
						buffer.put_string (l_encoder.init_name (class_type.static_type_id))
						buffer.put_string (once "();")
					end
					i := i + 1
				end
				buffer.generate_block_close

					-- Separation for formatting
				buffer.put_new_line
				buffer.generate_function_signature ("void", "egc_einit_init", True, buffer, l_empty_array, l_empty_array)
				buffer.generate_block_open

					-- Set C variable `ccount'.
				buffer.put_new_line
				buffer.put_string ("ccount = ")
				buffer.put_integer (class_counter.count)
				buffer.put_character (';')

					-- Set maximum routine body index
				buffer.put_new_line
				buffer.put_string ("eif_nb_org_routines = ")
				buffer.put_integer (body_index_counter.count)
				buffer.put_character (';')

					-- Set the frozen level
				buffer.put_new_line
				buffer.put_string ("eif_nb_features = ")
				buffer.put_integer (execution_table.nb_frozen_features)
				buffer.put_character (';')

				buffer.generate_block_close
			end

				-- Separation for formatting
			buffer.put_new_line

				-- Module initialization routine 'egc_system_mod_init_init'
				-- Declarations
			from
				i := 1
				nb := type_id_counter.value
			until
				i > nb
			loop
				if
					attached class_types [i] as class_type and then
					(not (final_mode and then makefile_generator.empty_class_types.has (class_type.static_type_id)) and then
						(class_type.is_precompiled implies class_type.associated_class.is_in_system) or else
					not (final_mode or else makefile_generator.empty_class_types.has (class_type.static_type_id)))
				then
					buffer.generate_extern_declaration
						(once "void", l_encoder.module_init_name (class_type.static_type_id), l_empty_array)
				end
				i := i + 1
			end

				-- Declare once data fields
			byte_context.generate_once_data_definition (buffer)

				-- Separation for formatting
			buffer.put_new_line

				-- Module initialization
			buffer.generate_function_signature (
				"void", "egc_system_mod_init_init", True, buffer, l_empty_array, l_empty_array)

			buffer.generate_block_open

				-- Set egc_type_of_gc = 25 * egc_platform_level + egc_compiler_tag
			buffer.put_new_line
			buffer.put_string ("egc_type_of_gc = 123174;")

			if final_mode and then not byte_context.is_static_system_data_safe then
					-- Set maximum routine body index
				buffer.put_new_line
				buffer.put_string ("eif_nb_org_routines = ")
				buffer.put_integer (body_index_counter.count)
				buffer.put_character (';')
			end

			from
				i := 1
				nb := type_id_counter.value
			until
				i > nb
			loop
				if
					attached class_types [i] as class_type and then
					(not (final_mode and then makefile_generator.empty_class_types.has (class_type.static_type_id)) and then
						(class_type.is_precompiled implies class_type.associated_class.is_in_system) or else
					not (final_mode or else makefile_generator.empty_class_types.has (class_type.static_type_id)))
				then
					buffer.put_new_line
					buffer.put_string (Encoder.module_init_name (class_type.static_type_id))
					buffer.put_string (once "();")
				end
				i := i + 1
			end

			byte_context.generate_system_once_data_initialization (buffer)

			buffer.generate_block_close

			byte_context.generate_once_manifest_string_declaration (buffer)

			buffer.end_c_specific_code

			create initialization_file.make_c_code_file (gen_file_name (final_mode, Einit))
			buffer.put_in_file (initialization_file)
			initialization_file.close
		end

feature -- Workbench routine info table file generation

	generate_rout_info_table
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

feature --option file generation

	generate_option_file (is_workbench_mode: BOOLEAN)
			-- Generate compialtion option file
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			class_type: CLASS_TYPE
			option_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
				-- Clear buffer for Current generation
			buffer := generation_buffer
			buffer.clear_all

			buffer.put_string ("#include %"eif_eiffel.h%"%N%
								%#include %"eif_option.h%"")

			buffer.start_c_specific_code

				-- First debug keys
			class_array := classes
			nb := class_counter.count
			from i := 1 until i > nb loop
				if attached class_array.item (i) as c then
					c.debug_level.generate_keys (buffer, c.class_id)
				end
				i := i + 1
			end

				-- Then option C array
			buffer.put_new_line
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
					buffer.put_string ("(int16) 0, (int16) 0, (int16) 0, {(int16) 0, (int16) 0, (char **) 0}")
				end
				buffer.put_string ("},%N")
				i := i + 1
			end
			buffer.put_string ("};")
			buffer.end_c_specific_code

			create option_file.make_c_code_file
				(if is_workbench_mode then
					workbench_file_name (Eoption, dot_c, 1)
				else
					final_file_name (Eoption, dot_c, 1)
				end)
			buffer.put_in_file (option_file)
			option_file.close
		end

feature

	set_current_class (a_class: detachable CLASS_C)
		do
			current_class := a_class
		end

	in_pass3: BOOLEAN
			-- Is Degree 3 the current Degree?

	System_chunk: INTEGER = 500

feature -- Conveniences

	reset_external_clause
			-- Reset the external clause
			-- Incrementality of the generated makefile
		do
			c_file_names := Void
		end

	reset_loaded_precompiled_properties
			-- Resets all loaded precompiled properties that interfer
			-- with a projects properties
		do
			is_precompiled := False
			has_precompiled_preobj := False
			cls_compliant := False
			dotnet_naming_convention := False
			internal_msil_classes_per_module := 0
		end

	set_executable_directory (d: STRING)
			-- Assign `d' to `executable_directory'.
		do
			executable_directory := d
		end

	set_c_directory (d: STRING)
			-- Assign `d' to `c_directory'.
		do
			c_directory := d
		end

	set_object_directory (d: STRING)
			-- Assign `d' to `object_directory'.
		do
			object_directory := d
		end

	reset_generate_clause
			-- Reset the generate clause
			-- Incrementality of the generated makefile
		do
			executable_directory := Void
			c_directory := Void
			object_directory := Void
		end

	set_update_sort (b: BOOLEAN)
			-- Assign `b' to `update_sort'.
		do
			update_sort := b
		end

	set_max_class_id (i: INTEGER)
			-- Assign `i' to `max_class_id'.
		do
			max_class_id := i
		end

	set_is_precompile_finalized (b: like is_precompile_finalized)
			-- Assign `b' to `is_finalized'
		do
			is_precompile_finalized := b
		ensure
			is_precompile_finalized_set: is_precompile_finalized = b
		end

feature -- Access: Root creators

	root_creators: ARRAYED_LIST [SYSTEM_ROOT]
			-- Available root creation procedures
			--
			-- Note: this is a first step to support multiple root creation procedures. Currently the root
			--       procedure defined in the config will be the first item in `root_creators'. That way
			--       existing code relying on a single root will continue to work.
			--       Additional root creation procedures can be added through `add_explicit_root'.

	root_type: TYPE_A
			--
		do
			Result := root_creators.first.class_type
		end

	root_creation_name: STRING
		do
			Result := root_creators.first.procedure_name
		ensure
			root_creation_name_not_void: Result /= Void
		end

feature -- Access: Testing

	test_system: TEST_SYSTEM_I
			-- System containing testing properties of current system

feature {NONE} -- Access: Root creators

	explicit_roots: LINKED_LIST [TUPLE [cluster_name: STRING_32; class_name: STRING; feature_name: STRING]]
			-- Root creation procedures added internally.
			--
			-- cluster_name: Cluster name in which root class is located
			-- class_name: Class name in which creation procedure is defined
			-- feature_name: Name of creation procedure

feature {INTERNAL_COMPILER_STRING_EXPORTER, TEST_SYSTEM_I} -- Status report: Root creators

	is_explicit_root (a_class_name, a_feature_name: READABLE_STRING_8): BOOLEAN
			-- Has an explicit root been added for given class and feature name.
			--
			-- `a_class_name': Class name in which creation procedure is defined
			-- `a_feature_name': Feature name of creation procedure
			-- `Result': True if explicit root exists for class and feature name, False otherwise.
		do
			Result := explicit_roots.there_exists (
				agent (a_tuple: TUPLE [clst: STRING_32; clss: STRING; ft: STRING]; a_cl, a_ft: READABLE_STRING_8): BOOLEAN
					do
						Result := a_tuple.clss.same_string (a_cl) and a_tuple.ft.same_string (a_ft)
					end (?, a_class_name, a_feature_name))
		end

feature -- Query: Root creators

	root_class_type (a_root_type: TYPE_A): CLASS_TYPE
			-- CLASS_TYPE of root type
		require
			root_type_exists: root_creators.there_exists (
				agent (a_root: SYSTEM_ROOT; a_type: TYPE_A): BOOLEAN
					do
						Result := a_root.class_type = a_type
					end (?, a_root_type))
		do
			check
					-- Should be ensured by semantic analysis.
				class_type_exists: a_root_type.has_associated_class_type (system.any_class.compiled_class.types.first.type)
			end
			Result := a_root_type.associated_class_type (system.any_class.compiled_class.types.first.type)
		end

	is_root_class (a_class: CLASS_I): BOOLEAN
			-- Is class used as root class?
			--
			-- `a_class': Class for which we want to determine whether it is a root class.
			-- `Result': True if class is used a root class, False otherwise.
		do
			Result := root_creators.there_exists (
				agent (a_root: SYSTEM_ROOT; a_cl: CLASS_I): BOOLEAN
					do
						Result := a_root.root_class = a_cl
					end (?, a_class))
		end

	is_compiled_root_class (a_class: CLASS_C): BOOLEAN
			-- Is compiled class used as root class?
			--
			-- `a_class': Class for which we want to determine whether it is a root class.
			-- `Result': True if class is used a root class, False otherwise.
		do
			Result := is_root_class (a_class.original_class)
		end

	are_root_classes_compiled: BOOLEAN
			-- Are all root classes in `root_creators' compiled?
		do
			Result := root_creators.for_all (
				agent (l_root: SYSTEM_ROOT): BOOLEAN
					do
						if l_root.is_class_type_set then
							Result := l_root.class_type.base_class.original_class.is_compiled
						end
					end)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER, TEST_SYSTEM_I} -- Element change: Root creators

	add_explicit_root (a_cluster_name: STRING_32; a_class_name, a_feature_name: STRING_8)
			-- Add an explicit root class
		require
			a_class_name_not_empty: a_class_name /= Void and then not a_class_name.is_empty
			a_feature_name_not_void: a_feature_name /= Void
		local
			l_tpl: TUPLE [clst: STRING_32; clss: STRING; ft: STRING]
			l_added: BOOLEAN
		do
			from
				explicit_roots.start
			until
				explicit_roots.after or l_added
			loop
				l_tpl := explicit_roots.item_for_iteration
				if l_tpl.clss.same_string (a_class_name) and l_tpl.ft.same_string (a_feature_name) then
					l_added := True
				end
				explicit_roots.forth
			end
			if not l_added then
				explicit_roots.force ([a_cluster_name, a_class_name, a_feature_name])
			end
		ensure
			added: is_explicit_root (a_class_name, a_feature_name)
		end

	remove_explicit_root (a_class_name, a_feature_name: READABLE_STRING_8)
			-- Remove an explicit root class
		local
			l_tpl: TUPLE [clst: STRING_32; clss: STRING; ft: STRING]
		do
			from
				explicit_roots.start
			until
				explicit_roots.after
			loop
				l_tpl := explicit_roots.item_for_iteration
				if l_tpl.clss.same_string (a_class_name) and l_tpl.ft.same_string (a_feature_name) then
					explicit_roots.remove
				else
					explicit_roots.forth
				end
			end
		ensure
			removed: not is_explicit_root (a_class_name,a_feature_name)
		end

feature {NONE} -- Element change: Root creators

	update_root_class
			-- Refill root creator list.
		require
			universe_not_void: universe /= Void
			target_not_void: universe.target /= Void
			root_not_void: universe.target.root /= Void
		local
			l_root: CONF_ROOT
			l_root_type_name: STRING
			l_tpl: TUPLE [clst: STRING_32; clss: STRING; ft: STRING]
			l_feat: STRING
			u: UTF_CONVERTER
		do
			root_creators.wipe_out

				-- update root class/feature
			l_root := universe.target.root
				-- Compiler keeps its internal data in UTF-8.
			l_root_type_name := u.utf_32_string_to_utf_8_string_8 (l_root.class_type_name.as_upper)
			if attached l_root.feature_name as l_feat_name then
				l_feat := u.utf_32_string_to_utf_8_string_8 (l_root.feature_name)
			else
				create l_feat.make_empty
			end
			add_root_feature (l_root.cluster_name, l_root_type_name, l_feat, False)
			from
				explicit_roots.start
			until
				explicit_roots.after
			loop
				l_tpl := explicit_roots.item_for_iteration
				add_root_feature (l_tpl.clst, l_tpl.clss, l_tpl.ft, True)
				explicit_roots.forth
			end
		ensure
			root_creators_added: not root_creators.is_empty
		end

	add_root_feature (a_cluster_name: detachable STRING_32; a_class_name, a_feature_name: STRING; a_explicit: BOOLEAN)
			-- Add root creation procedure for given class and feature name.
			--
			-- `a_cluster_name': Name of cluster in which class is located (can be Void).
			-- `a_class_name': Name of class in which creation procedure is declared.
			-- `a_feature_name': Name of creation procedure (if Eempty, it will be replaced with the name
			--                   of the default create feature of the corresponding class.
			-- `a_explicit': True if root is read from `explicit_root', False if it represents CONF_ROOT.
		require
			universe_not_void: universe /= Void
			target_not_void: universe.target /= Void
			a_class_name_not_void: a_class_name /= Void
			a_class_name_in_upper: a_class_name.is_equal (a_class_name.as_upper)
			a_feature_name_not_void: a_feature_name /= Void
		local
			l_classes_i: LIST [CLASS_I]
			l_group: CONF_GROUP
			vd19: VD19
			vd20: VD20
			vd29: VD29
			l_type_as: detachable CLASS_TYPE_AS
			l_system_root: SYSTEM_ROOT
			l_class: detachable CLASS_I
		do
			type_parser.parse_from_string_32 ("type " + a_class_name, Void)
			l_type_as ?= type_parser.type_node

			if l_type_as = Void then
				-- Error: syntactically not a valid type
				-- should already be captured by the config system
				check false end
			else
				if a_cluster_name = Void then

					l_classes_i := universe.classes_with_name (l_type_as.class_name.name.as_upper)
						-- remove overriding classes
					from
						l_classes_i.start
					until
						l_classes_i.after
					loop
						if l_classes_i.item.config_class.does_override then
							l_classes_i.remove
						else
							l_classes_i.forth
						end
					end
					if l_classes_i.is_empty then
						create vd20
						vd20.set_class_name (a_class_name)
						Error_handler.insert_error (vd20)
						Error_handler.raise_error
					elseif l_classes_i.count > 1 then
						create vd29
						vd29.set_cluster (l_classes_i.first.group)
						vd29.set_second_cluster_name (l_classes_i.last.group.name)
						vd29.set_root_class_name (a_class_name)
						Error_handler.insert_error (vd29)
						Error_handler.raise_error
					else
						l_group := l_classes_i.first.group
					end
				else
					l_group := universe.target.groups.item (a_cluster_name)
					if l_group = Void then
						create vd19
						vd19.set_root_cluster_name (a_cluster_name)
						Error_handler.insert_error (vd19)
						Error_handler.raise_error
					else
							-- do a class_named because this checks for VSCN errors
						l_class := universe.class_named (l_type_as.class_name.name.as_upper, l_group)
						if l_class = Void or else l_group.classes.item (l_type_as.class_name.name.as_upper) /= l_class.config_class then
							create vd20
							vd20.set_class_name (a_class_name)
							Error_handler.insert_error (vd20)
							Error_handler.raise_error
						end
					end
				end

				l_class ?= l_group.classes.item (l_type_as.class_name.name.as_upper)
				if l_class = Void then
					create vd20
					vd20.set_class_name (a_class_name)
					Error_handler.insert_error (vd20)
					Error_handler.raise_error
				else
					create l_system_root.make_with_class (l_class, a_feature_name)
					l_system_root.set_class_type_as (l_type_as)
					if a_explicit then
						l_system_root.set_explicit
					end
					root_creators.force (l_system_root)
					if not l_class.is_compiled then
						Workbench.change_class (l_class)
					end
				end
			end
		end

	compute_root_type
			-- Computes the root type
		local
			l_root: SYSTEM_ROOT
			l_vsrt1: VSRT1
			l_vsrt2: VSRT2
			l_vsrt3: VSRT3
			l_vsrt4: VSRT4
			l_vd20: VD20
			cs: CURSOR
			l_error_level: NATURAL_32
		do
			from
				cs := root_creators.cursor
				root_creators.start
			until
				root_creators.after
			loop
				l_root := root_creators.item_for_iteration
				l_error_level := error_handler.error_level
				if not l_root.root_class.is_compiled then
						-- Class is not part of the system.
					create l_vd20
					l_vd20.set_class_name (l_root.root_class.name.as_upper)
					Error_handler.insert_error (l_vd20)
				else
					if not attached {CL_TYPE_A} type_a_generator.evaluate_type (l_root.class_type_as, l_root.root_class.compiled_class) as l_type then
							-- Throw an error: type is not valid.					
							-- Throw an error: type is not valid.
						create l_vsrt2
						l_vsrt2.set_root_type_as (l_root.class_type_as)
						l_vsrt2.set_group_name (l_root.root_class.group.name)
						Error_handler.insert_error (l_vsrt2)
					elseif l_type.is_loose then
						create l_vsrt1
						l_vsrt1.set_root_type (l_type)
						error_handler.insert_error (l_vsrt1)
					elseif l_type.base_class.is_deferred then
						create l_vsrt3
						l_vsrt3.set_root_type (l_type)
						error_handler.insert_error (l_vsrt3)
					elseif not l_type.good_generics then
						create l_vsrt4
						l_vsrt4.set_root_type (l_type)
						error_handler.insert_error (l_vsrt4)
					else
						if attached {GEN_TYPE_A} l_type as l_gen_type then
								-- Check constrained genericity validity rule
							l_gen_type.reset_constraint_error_list
								-- Check creation readiness because root type have to be creation ready.
								-- This is done in the context of ANY and not of `l_type.associated_class'
								-- as otherwise we could accept `TEST [G]' if done in the context of the
								-- generic class declared as `class TEST [G]'.
							l_gen_type.check_constraints (any_class.compiled_class, Void, True)
							if l_gen_type.constraint_error_list /= Void and then not l_gen_type.constraint_error_list.is_empty then
								create l_vsrt4
								l_vsrt4.set_root_type (l_gen_type)
								l_vsrt4.set_any_class (any_class.compiled_class)
								l_vsrt4.set_error_list (l_gen_type.constraint_error_list)
								error_handler.insert_error (l_vsrt4)
							else
									-- We need to check named tuple labels. This fixes eweasel test#tuple012.
								l_type.check_labels (l_type.base_class, Void)
							end
						end

						if error_handler.error_level = l_error_level then
							l_root.set_class_type (l_type)

							if not Compilation_modes.is_precompiling and not Lace.compile_all_classes then
									-- `root_class_c' cannot be used here as `root_type.associated_class' might be changed
								l_root.class_type.base_class.check_root_class_creators (l_root.procedure_name, l_root.class_type)
							end
						end
					end
				end
				root_creators.forth
			end
			root_creators.go_to (cs)
			Error_handler.checksum
		ensure
			root_type_computed: root_creators.for_all (agent {SYSTEM_ROOT}.is_class_type_set)
		end

feature -- Precompilation

	save_precompilation_info
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

	open_log_files
		do
			if in_final_mode then
					-- removed_log_file is used only in final mode
				create removed_log_file.make_with_path (project_location.final_path.extended (removed_log_file_name))
					-- Translat files
				create used_features_log_file.make_with_path (project_location.final_path.extended (translation_log_file_name))

					-- Files are open using the `write' mode
				removed_log_file.open_write
				used_features_log_file.open_write
			else
					-- Translat files
				create used_features_log_file.make_with_path (project_location.workbench_path.extended (translation_log_file_name))

					-- File is open using the `append' mode
					-- (refreezing)
				used_features_log_file.open_append
			end
		end

	close_log_files
		do
			used_features_log_file.close
			used_features_log_file := Void
			if in_final_mode then
				removed_log_file.close
				removed_log_file := Void
			end
		end

feature -- Debug purpose

	trace
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

feature -- Statistics

	statistics: TUPLE [
		total: INTEGER;
		conformance_violation: INTEGER;
		export_violation: INTEGER;
		covariant_violation: INTEGER;
		compiler_limitation: INTEGER;
		covariant_generic: INTEGER;
		is_equal_feat: INTEGER;
		any_features: INTEGER;
		like_current_feature: INTEGER;
		other: INTEGER]
			-- Statistics of catcalls in system
		once
			Result := [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		end

	update_statistics (a_cat_call: CAT_CALL_WARNING)
			-- Update statistics with catcall of current warning
		local
			l_feature_name: INTEGER
		do
			statistics.total := statistics.total + 1
			if a_cat_call.target_type /= Void and a_cat_call.source_type /= Void then
				statistics.conformance_violation := statistics.conformance_violation + 1
			elseif not a_cat_call.export_status_violations.is_empty then
				statistics.export_violation := statistics.export_violation + 1
			else
				check
					has_error: a_cat_call.compiler_limitation_type /= Void or
						not a_cat_call.covariant_argument_violations.is_empty or
						a_cat_call.has_covariant_generic
				end
				statistics.covariant_violation := statistics.covariant_violation + 1
				if a_cat_call.compiler_limitation_type /= Void then
					statistics.compiler_limitation := statistics.compiler_limitation + 1
				elseif a_cat_call.has_covariant_generic then
					statistics.covariant_generic := statistics.covariant_generic + 1
				else
					l_feature_name := a_cat_call.called_feature.name_id
					if a_cat_call.called_feature.rout_id_set.has (system.is_equal_rout_id) then
						statistics.is_equal_feat := statistics.is_equal_feat + 1
					elseif
						a_cat_call.called_feature.written_in = system.any_id and then
						(l_feature_name = names.equal_name_id or
						l_feature_name = names.standard_equal_name_id or
						l_feature_name = names.deep_equal_name_id or
						l_feature_name = names.standard_is_equal_name_id or
						l_feature_name = names.is_deep_equal_name_id or
						l_feature_name = names.copy_name_id or
						l_feature_name = names.standard_copy_name_id or
						l_feature_name = names.deep_copy_name_id)
					then
						statistics.any_features := statistics.any_features + 1

					elseif
						a_cat_call.called_feature.arguments /= Void and then
						a_cat_call.called_feature.arguments.there_exists (
							agent (a_type: TYPE_A): BOOLEAN
								do
									Result := a_type.is_like_current
								end)
					then
						statistics.like_current_feature := statistics.like_current_feature + 1
					else
						statistics.other := statistics.other + 1
					end
				end
			end
		end

	display_catcall_statistics
		local
			l_str: STRING
			l_cat_call_summary: CAT_CALL_SUMMARY_WARNING
		do
				-- To be used for global statistics on the project.
			debug ("catcall")
				if statistics.total > 0 then
					create l_str.make (1024)
					l_str.append ("Catcall statistics: " + statistics.total.out)
					l_str.append (" (export: " + statistics.export_violation.out)
					l_str.append ("; conformance: " + statistics.conformance_violation.out)
					l_str.append ("; covariant: " + statistics.covariant_violation.out + ")%N")
					l_str.append ("%Tcompiler-limitation: " + statistics.compiler_limitation.out + "%N")
					l_str.append ("%Tcovariant-generic: " + statistics.covariant_generic.out + "%N")
					l_str.append ("%Tis_equal: " + statistics.is_equal_feat.out + "%N")
					l_str.append ("%Tany-features: " + statistics.any_features.out + "%N")
					l_str.append ("%Tlike-current-features: " + statistics.like_current_feature.out + "%N")
					l_str.append ("%Tother: " + statistics.other.out)
					l_str.append ("%N")
					create l_cat_call_summary.make (l_str)
					error_handler.insert_warning (l_cat_call_summary, False)
				end
			end
		end

	conformance_checks: TUPLE [nb, like_target, same: INTEGER]
			--
		once
			Result := [{INTEGER} 0, {INTEGER} 0, {INTEGER} 0]
		end

	print_memory_statistics
			-- Print memory statistics on standard output.
		local
			l_mem: MEMORY
			l_mem_info: MEM_INFO
			l_full_gc_info, l_part_gc_info: GC_INFO
		do
			create l_mem
			l_mem_info := l_mem.memory_statistics ({MEM_CONST}.eiffel_memory)
			print ("Total memory is " + l_mem_info.total.out + "%N")
			print ("Used memory is " + (l_mem_info.used + l_mem_info.overhead).out + "%N")
			print ("Free memory is " + l_mem_info.free.out + "%N")

			l_full_gc_info := l_mem.gc_statistics ({MEM_CONST}.full_collector)
			print ("GC full cycle is " + l_full_gc_info.cycle_count.out + "%N")
			print ("GC full cycle is " + l_full_gc_info.cpu_time_average.out + "%N")

			l_part_gc_info := l_mem.gc_statistics ({MEM_CONST}.incremental_collector)
			print ("GC incremental cycle is " + l_part_gc_info.cycle_count.out + "%N")
			print ("GC incremental cycle is " + l_part_gc_info.cpu_time_average.out + "%N")
			print ("CPU time " + l_part_gc_info.cpu_total_time.out + "%N")
			print ("Kernel time " + l_part_gc_info.sys_total_time.out + "%N")
			print ("Full Collection period " + l_mem.collection_period.out + "%N")
			print ("GC percentage time " +
				(100 * (((l_full_gc_info.cycle_count * l_full_gc_info.cpu_time_average) +
				 (l_part_gc_info.cycle_count * l_part_gc_info.cpu_time_average)) /
				 l_part_gc_info.cpu_total_time)).out + "%N%N")
		end

feature {NONE} -- Implementation

	set_is_force_rebuild (b: BOOLEAN)
			-- Set `is_force_rebuild'.
		do
			is_force_rebuild := b
		ensure
			is_force_rebuild_set: is_force_rebuild = b
		end

	is_force_rebuild: BOOLEAN
			-- Is a rebuild of the configuration system forced?

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER)
		external
			"C"
		end

	current_time: INTEGER
			-- Elapsed time since the Epoch (00:00:00 UTC, January 1, 1970),
			-- measured in seconds.
		do
			Result := c_time (default_pointer)
		end

	c_time (p: POINTER): INTEGER
			-- Elapsed time since the Epoch (00:00:00 UTC, January 1, 1970),
			-- measured in seconds.
			-- If `p /= default_pointer' result will be stored in memory pointed
			-- by `p'.
		external
			"C signature (time_t *): EIF_INTEGER use <time.h>"
		alias
			"time"
		end

invariant
	attached remover implies dead_code /= {CONF_TARGET_OPTION}.dead_code_index_none
	attached remover implies in_final_mode

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
