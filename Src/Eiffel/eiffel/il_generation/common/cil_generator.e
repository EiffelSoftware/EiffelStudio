note
	description: "Special object responsible for generating IL byte code"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_GENERATOR

inherit
	IL_GENERATOR

	SHARED_WORKBENCH

	SHARED_IL_CODE_GENERATOR

	SHARED_BYTE_CONTEXT

	SHARED_ERROR_HANDLER

	EXCEPTIONS
		export
			{NONE} all
		end

	COMPILER_EXPORTER

	SHARED_COUNTER
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	CLI_EMITTER_SERVICE
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (deg_output: DEGREE_OUTPUT)
			-- Generate a COM+ assembly.
		do
			degree_output := deg_output
			is_finalizing := System.in_final_mode
			is_single_module := is_finalizing or else Compilation_modes.is_precompiling
		end

feature -- Access

	compiled_classes_count: INTEGER
			-- Number of classes generated in IL.

	assembly_info: ASSEMBLY_INFO
			-- Info about currently generated assembly.

	is_finalizing: BOOLEAN
			-- Are we finalizing?

	is_single_module: BOOLEAN
			-- Are we only generate one module?

feature {NONE} -- Implementation: Access

	root_class_routine: CLASS_C
			-- Class which defines body of creation routine.

	has_root_class: BOOLEAN
			-- Does current module has a root class specification?

	signing: detachable MD_STRONG_NAME
			-- Object used for signing assemblies.
			-- This is optional since NetCORE.

feature -- Generation

	generate
			-- Generate a .NET assembly
		local
			file_name: STRING_32
			location: like {PROJECT_DIRECTORY}.path
			retried, is_assembly_loaded, is_error_available: BOOLEAN
			deletion_successful: BOOLEAN
			output_file: RAW_FILE
			l_last_error_msg: STRING
			l_public_key: MD_PUBLIC_KEY
			l_res: ARRAYED_LIST [CONF_EXTERNAL_RESOURCE]
		do
			if not retried then
					-- At this point the COM component should be properly instantiated.
				is_assembly_loaded := True

					-- Let's check that we can retrieve an error if any, we do not care
					-- about the value, we just want to make sure that the call does not
					-- raise any exception, if it does `is_error_available' will be
					-- False which will cause not to be used in case of an exception
					-- (See rescue clause below).
				l_last_error_msg := cil_generator.last_error
				is_error_available := True

					-- Compute name of generated file if any.
				create file_name.make (System.name.count + 1 + system.msil_generation_type.count)
				file_name.append_string_general (System.name)
				file_name.append_character ('.')
				file_name.append (system.msil_generation_type)

				if is_finalizing then
					location := project_location.final_path
				else
					location := project_location.workbench_path
				end

					-- Set information about current assembly.
				create assembly_info.make (System.name)
				if
					attached System.msil_version as l_msil_version and then
					not l_msil_version.is_empty
				then
					assembly_info.set_version (l_msil_version)
				end

					-- By default no signing
				signing := Void

					-- Sign assembly if a key was provided, and signing supported.
				if
					attached System.msil_key_file_name as l_key_file_name and then
					l_key_file_name /= Void
				then
						-- FIXME: maybe add a new setting "signing_enabled" [2023-03-28]
					signing := md_factory.strong_name (System.clr_runtime_version)
					if attached signing as sn and then sn.exists then
						create l_public_key.make_from_file (l_key_file_name, sn)
						if not l_public_key.is_valid then
							l_public_key := Void
								-- Introduce error saying that public key cannot be read.
							Error_handler.insert_warning (create {VIIK}, universe.target.options.is_warning_as_error)
						end
					else
						l_public_key := Void

							-- No support for assembly key signature.
							-- This is optional with NetCORE.
						Error_handler.insert_warning (create {VIAC}, False)
						Error_handler.checksum
						signing := Void
					end
				else
					l_public_key := Void
				end

				if l_public_key /= Void then
					assembly_info.set_public_key_token (l_public_key.public_key_token_string)
				end

				create output_file.make_with_path (location.extended (file_name))
				if output_file.exists then
					output_file.delete
				end
				deletion_successful := True

					-- Set attributes of generated executable.
				if System.msil_generation_type.is_equal (dll_type) then
					cil_generator.set_dll
				elseif System.is_console_application then
					cil_generator.set_console_application
				else
					cil_generator.set_window_application
				end

				if not {PLATFORM}.is_64_bits or System.force_32bits then
					cil_generator.set_32bits
				end

				cil_generator.set_verifiability (System.il_verifiable)
				cil_generator.set_cls_compliant (System.cls_compliant)

					-- We add `9' because they are 9 types from ISE.Runtime
					-- we want to reuse.
				cil_generator.initialize_class_mappings (static_type_id_counter.count + 9)

					-- Identify all runtime types.
				cil_generator.set_runtime_type_id (static_type_id_counter.count + 1)
				cil_generator.set_class_type_id (static_type_id_counter.count + 2)
				cil_generator.set_generic_type_id (static_type_id_counter.count + 3)
				cil_generator.set_formal_type_id (static_type_id_counter.count + 4)
				cil_generator.set_none_type_id (static_type_id_counter.count + 5)
				cil_generator.set_basic_type_id (static_type_id_counter.count + 6)
				cil_generator.set_eiffel_type_info_type_id (static_type_id_counter.count + 7)
				cil_generator.set_generic_conformance_type_id (static_type_id_counter.count + 8)
				cil_generator.set_assertion_level_enum_type_id (static_type_id_counter.count + 9)
				cil_generator.set_tuple_type_id (static_type_id_counter.count + 10)

				cil_generator.start_assembly_generation (System.name, file_name,
					l_public_key, location, assembly_info,
					System.line_generation or not is_finalizing)

					-- Split classes into modules
				prepare_classes (System.classes)

					-- Generate types metadata description and IL code
				generate_all_types (sorted_classes (System.classes))

				if not is_single_module then
						-- Generate run-time helper.
					cil_generator.generate_runtime_helper
				end

					-- Generate entry point if necessary
				generate_entry_point

					-- Generate resources if any
				l_res := universe.conf_system.all_external_resource
				if not l_res.is_empty then
					cil_generator.generate_resources (l_res)
				end
					-- Finish code generation.
				cil_generator.end_assembly_generation (signing)

					-- Perform cleanup of underlying external objects
				cil_generator.cleanup
			else
					-- Perform cleanup of underlying external objects
				cil_generator.cleanup
					-- An error occurred, let's raise an Eiffel compilation
					-- error that will be caught by WORBENCH_I.recompile.
				Error_handler.raise_error
			end
		rescue
			if not retried then
				if Error_handler.has_error then
				elseif not is_assembly_loaded or not is_error_available then
					Error_handler.insert_error (create {VIGE}.make_com_error)
				else
					if deletion_successful then
						l_last_error_msg := cil_generator.last_error
						if l_last_error_msg = Void or else l_last_error_msg.is_empty then
							Error_handler.insert_error (create {VIGE}.make (Error_handler.exception_trace))
						else
							Error_handler.insert_error (create {VIGE}.make (l_last_error_msg))
						end
					else
						check
							file_name_not_void: file_name /= Void
						end
						Error_handler.insert_error (create {VIGE}.make_output_in_use (file_name))
					end
				end
				retried := True
				retry
			end
		end

	deploy
			-- Copy local assemblies if needed to `Generation_directory/Assemblies' and
			-- copy configuration file to load local assemblies.
		local
			l_source_name: PATH
			l_target_name: like {PROJECT_DIRECTORY}.path
			l_has_local, retried: BOOLEAN
			l_precomp: REMOTE_PROJECT_DIRECTORY
			l_viop: VIOP
			l_use_optimized_precomp: BOOLEAN
			l_assemblies: STRING_TABLE [CONF_PHYSICAL_ASSEMBLY_INTERFACE]
			l_state: CONF_STATE
		do
			if not retried then
					-- Create the Assemblies directory if it does not already exist
				project_location.create_local_assemblies_directory (is_finalizing)

					-- Copy referenced local assemblies
				l_state := universe.conf_state
				from
					l_assemblies := universe.conf_system.all_assemblies
					l_assemblies.start
				until
					l_assemblies.after
				loop
					if attached {CONF_PHYSICAL_ASSEMBLY} l_assemblies.item_for_iteration as l_as then
						if l_as.is_enabled (l_state) and then not l_as.is_in_gac then
							copy_to_local (l_as.location.build_path ({STRING_32} "", l_as.location.original_file), assembly_location (is_finalizing), Void)
							l_has_local := True
						end
					else
						check is_physical_assembly: False end
					end
					l_assemblies.forth
				end

					-- Copy precompiled assemblies.
				if
					Workbench.Precompilation_directories /= Void and then
					not Workbench.Precompilation_directories.is_empty
				then
					from
						Workbench.Precompilation_directories.start
						project_location.create_local_assemblies_directory (is_finalizing)
						l_has_local := True
					until
						Workbench.Precompilation_directories.after
					loop
						l_precomp := Workbench.Precompilation_directories.item_for_iteration
							-- Copy assembly file
							-- Copy associated libXXX.dll file if any.
						l_use_optimized_precomp := l_precomp.is_precompile_finalized and system.msil_use_optimized_precompile
						if system.msil_use_optimized_precompile and not l_precomp.is_precompile_finalized then
								-- generate warning informing them they is no ompitzed precompiled library
							create l_viop.make (l_precomp.name)
							error_handler.insert_warning (l_viop, universe.target.options.is_warning_as_error)
						end

						copy_to_local (l_precomp.assembly_driver (l_use_optimized_precomp), assembly_location (is_finalizing), Void)
						copy_to_local (l_precomp.assembly_helper_driver (l_use_optimized_precomp), assembly_location (is_finalizing), Void)
						if not l_use_optimized_precomp or l_precomp.line_generation then
							copy_to_local (l_precomp.assembly_debug_info (l_use_optimized_precomp), assembly_location (is_finalizing), Void)
						end

						Workbench.Precompilation_directories.forth
					end
				end

					-- Copy configuration file to be able to load up local assembly.
				if l_has_local then
					l_source_name := eiffel_layout.generation_templates_path.extended ("assembly_config.xml")

					if is_finalizing then
						l_target_name := project_location.final_path
					else
						l_target_name := project_location.workbench_path
					end
						-- Compute name of configuration file: It is `system_name.xxx.config'
						-- where `xxx' is either `exe' or `dll'.
					copy_to_local (l_source_name, l_target_name, {STRING_32} "" + System.name + "." + System.msil_generation_type + ".config")
				end
			else
					-- An error occurred, let's raise an Eiffel compilation
					-- error that will be caught by WORBENCH_I.recompile.
				Error_handler.raise_error
			end
		rescue
			if not retried then
				retried := True
				Error_handler.insert_error (create {VIGE}.make ("Could not copy local assemblies."))
				retry
			end
		end

feature {NONE} -- Type description

	generate_all_types (classes: ARRAY [CLASS_C])
			-- Generate all classes in compiled system.
		require
			valid_system: System.classes /= Void
		do
			compute_root_class

			generate_class_interfaces (classes)

			if not is_single_module then
				degree_output.put_start_degree (1, compiled_classes_count)
			end

			from
				ordered_classes.start
			until
				ordered_classes.after
			loop
				cil_generator.start_module_generation (ordered_classes.key_for_iteration)
				generate_types (ordered_classes.item_for_iteration)
				cil_generator.end_module_generation (has_root_class, signing)
				ordered_classes.forth
			end
			if not is_single_module then
				degree_output.put_end_degree
			end
		end

	compute_root_class
			-- Initialize `root_class_routine' with CLASS_C instance that defines
			-- creation routine of current system.
			--| In most cases `System.root_type.associated_class' is equal to
			--| `root_class_routine', but when creation routine is inherited, this
			--| is not true.
			--| `root_class_routine' is used to find out which module needs to be
			--| marked in a special way so that debug information is properly generated.
		local
			l_feat: FEATURE_I
			l_root_class: CLASS_C
		do
			if System.root_type /= Void and then not System.root_creation_name.is_empty then
				l_root_class := System.root_type.base_class
				l_feat := l_root_class.feature_table.item (System.root_creation_name)
				root_class_routine := l_feat.written_class
			end
		end

	generate_types (classes: ARRAY [CLASS_C])
			-- Generate all classes in compiled system.
		require
			valid_system: System.classes /= Void
		do
			has_root_class := False
				-- Generate set of types as they are known from Eiffel
				-- We simply define a basic correspondance between Eiffel
				-- and IDs used by the IL code generator in a topological
				-- order. But we first defines all interfaces and then
				-- the implementation if any.
			generate_class_mappings (classes, True)
			generate_class_mappings (classes, False)
			generate_class_attributes (classes)

			if is_single_module then
					-- Generate run-time helper.
				cil_generator.generate_runtime_helper
			end

				-- Generate only features description for each Eiffel class type
				-- with their IL code.
			generate_features_description (classes)
			generate_features_implementation (classes)
			generate_creation_classes (classes)
		end

	generate_class_interfaces (classes: ARRAY [CLASS_C])
			-- Generate mapping between Eiffel and IL generator with `classes' sorted in
			-- topological order.
		require
			classes_not_void: classes /= Void
		local
			class_c: CLASS_C
			i, nb: INTEGER
			types: TYPE_LIST
			cl_type: CLASS_TYPE
			l_class_counted: BOOLEAN
		do
			from
				i := classes.lower
				nb := classes.upper
				compiled_classes_count := 0
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void then
					if not class_c.is_precompiled then
						class_c.set_il_name
					end
					types := class_c.types
					if not types.is_empty then
						from
							types.start
							l_class_counted := False
						until
							types.after
						loop
							cl_type := types.item
								-- Generate correspondance between Eiffel IDs and
								-- CIL information.
							cil_generator.generate_class_interfaces (cl_type, class_c)
							if cl_type.is_generated then
								cl_type.set_il_type_name
								if not l_class_counted and is_class_generated (class_c) then
										-- We only count what is needed to be counted, i.e. classes
										-- that are compiled or recompiled.
									compiled_classes_count := compiled_classes_count + 1
									l_class_counted := True
								end
							end

							types.forth
						end
						if class_c.is_generic and then not class_c.is_external then
								-- Add all possible generic derivations of the same class
								-- where expanded parameters are replaced with reference ones
								-- to the list of interfaces a type conforms to.
							from
								types.start
							until
								types.after
							loop
								cl_type := types.item
								if attached {GEN_TYPE_A} cl_type.type as gen_type then
									gen_type.enumerate_interfaces (
										agent (c: CLASS_TYPE; p: ARRAYED_LIST [CLASS_INTERFACE])
											local
												ci: CLASS_INTERFACE
											do
												ci := c.class_interface
												if not p.has (ci) then
													p.extend (ci)
												end
											end
										(?, cl_type.class_interface.parents)
									)
								else
									check is_gen_type_a: False end
								end
								types.forth
							end
						end
					else
							-- Step is needed as namespace of a precompiled class should be set.
							-- At the moment it is set withing `generate_class_mappings', but
							-- when a class does not have a generic derivation, `types' is empty
							-- and `generate_class_mappings' is not called.
						class_c.lace_class.set_actual_namespace
					end
				end
				i := i + 1
			variant
				nb - i + 1
			end
		end

	generate_class_mappings (classes: ARRAY [CLASS_C]; for_interface: BOOLEAN)
			-- Generate mapping between Eiffel and IL generator with `classes' sorted in
			-- topological order.
		require
			classes_not_void: classes /= Void
		local
			class_c: CLASS_C
			i, nb: INTEGER
			types: TYPE_LIST
			cl_type: CLASS_TYPE
		do
			from
				i := classes.lower
				nb := classes.upper
			until
				i > nb
			loop
				class_c := classes.item (i)
				if is_class_generated (class_c) and then class_c.has_types then
					has_root_class := has_root_class or else (root_class_routine /= Void and then
						class_c.lace_class = root_class_routine.lace_class)
					types := class_c.types
						-- Generate reference classes first, because their interface class
						-- may be required to generate expanded classes.
					from
						types.start
					until
						types.after
					loop
						cl_type := types.item
							-- Generate correspondance between Eiffel IDs and
							-- CIL information.
						if cl_type.is_generated and then not cl_type.is_expanded then
							cil_generator.set_current_module_with (cl_type)
							cil_generator.generate_class_mappings (cl_type, for_interface)
						end

						types.forth
					end
					from
						types.start
					until
						types.after
					loop
						cl_type := types.item
							-- Generate correspondance between Eiffel IDs and
							-- CIL information.
						if cl_type.is_generated and then cl_type.is_expanded then
							cil_generator.set_current_module_with (cl_type)
							cil_generator.generate_class_mappings (cl_type, for_interface)
						end

						types.forth
					end
				end
				i := i + 1
			variant
				nb - i + 1
			end
		end

	generate_class_attributes (classes: ARRAY [CLASS_C])
			-- Generate mapping between Eiffel and IL generator with `classes' sorted in
			-- topological order.
		require
			classes_not_void: classes /= Void
		local
			class_c: CLASS_C
			i, j, nb: INTEGER
			types: TYPE_LIST
			cl_type: CLASS_TYPE
			l_class_processed: BOOLEAN
		do
			from
				i := classes.lower
				nb := classes.upper
				j := compiled_classes_count
			until
				i > nb or j = 0
			loop
				class_c := classes.item (i)
				if is_class_generated (class_c) and then class_c.has_types then
					System.set_current_class (class_c)
					from
						types := class_c.types
						types.start
						l_class_processed := False
					until
						types.after
					loop
							-- Generate correspondance between Eiffel IDs and
							-- CIL information.
						cl_type := types.item
						if cl_type.is_generated then
							context.init (cl_type)
							cil_generator.set_current_module_with (cl_type)
							cil_generator.generate_class_attributes (cl_type)
							if not l_class_processed then
								j := j - 1
								l_class_processed := True
							end
						end

						types.forth
					end
				end
				i := i + 1
			variant
				nb - i + 1
			end
		end

	generate_features_description (classes: ARRAY [CLASS_C])
			-- Generate mapping between Eiffel and IL generator with `classes'
			-- sorted in the topological order.
		require
			classes_not_void: classes /= Void
		local
			class_c: CLASS_C
			i, j, nb: INTEGER
			types: TYPE_LIST
			cl_type: CLASS_TYPE
			l_class_processed: BOOLEAN
		do
			from
				i := classes.lower
				nb := classes.upper
				j := compiled_classes_count
				if is_single_module then
					if is_finalizing then
						degree_output.put_start_degree (-2, j)
					else
						degree_output.put_start_degree (1, j)
					end
				end
			until
				i > nb or j = 0
			loop
				class_c := classes.item (i)
				if is_class_generated (class_c) and then class_c.has_types then
					from
						types := class_c.types
						types.start
						l_class_processed := False
					until
						types.after
					loop
						cl_type := types.item

						if cl_type.is_generated then
							context.init (cl_type)
							cil_generator.set_current_module_with (cl_type)

							if not l_class_processed then
								if is_single_module then
									if is_finalizing then
										degree_output.put_degree_minus_2 (class_c, j)
									else
										degree_output.put_degree_1 (class_c, j)
									end
								end
								System.set_current_class (class_c)
								l_class_processed := True
								j := j - 1
							end

								-- Generate entity to represent current Eiffel interface class
							cil_generator.generate_il_features_description (class_c, cl_type)
						end

						types.forth
					end
				end
				i := i + 1
			variant
				nb - i + 1
			end
			if is_single_module then
				degree_output.put_end_degree
			end
		end

	generate_features_implementation (classes: ARRAY [CLASS_C])
			-- Generate mapping between Eiffel and IL generator with `classes'
			-- sorted in the topological order.
		require
			classes_not_void: classes /= Void
		local
			class_c: CLASS_C
			i, j, nb: INTEGER
			types: TYPE_LIST
			l_class_processed: BOOLEAN
			cl_type: CLASS_TYPE
			put_degree: PROCEDURE [CLASS_C, INTEGER]
		do
			from
				i := classes.lower
				nb := classes.upper
				j := compiled_classes_count
				if not is_single_module then
					put_degree := agent degree_output.put_degree_1
				elseif is_finalizing then
					put_degree := agent degree_output.put_degree_minus_3
					degree_output.put_start_degree (-3, j)
				else
					put_degree := agent degree_output.put_degree_minus_1
					degree_output.put_start_degree (-1, j)
				end
			until
				i > nb or j = 0
			loop
				class_c := classes.item (i)
				if is_class_generated (class_c) and then class_c.has_types then
					from
						types := class_c.types
						types.start
						l_class_processed := False
					until
						types.after
					loop
						cl_type := types.item
						if cl_type.is_generated then
							context.init (cl_type)
							cil_generator.set_current_module_with (cl_type)

							if not l_class_processed then
								put_degree (class_c, j)
								System.set_current_class (class_c)
								l_class_processed := True
								j := j - 1
								compiled_classes_count := compiled_classes_count - 1
							end

							cl_type.set_assembly_info (assembly_info)

								-- Generate entity to represent current Eiffel implementation class
							cil_generator.generate_il_implementation (class_c, cl_type)
						end

						types.forth
					end
					if not class_c.is_precompiled and then not class_c.is_external then
							-- Because we need a context type to resolve the signatures
							-- of the once routines, we simply use one of the generic
							-- derivation for that. It is safe to do so, because we know
							-- that a once cannot rely on anchor or formals.
						check
							cl_type_not_void: cl_type /= Void
							same_class: class_c = cl_type.associated_class
						end
						cil_generator.generate_once_data (class_c, cl_type)
						class_c.set_assembly_info (assembly_info)
					end
				end
				i := i + 1
			variant
				nb - i + 1
			end
			if is_single_module then
				degree_output.put_end_degree
			end
		end

	generate_creation_classes (classes: ARRAY [CLASS_C])
			-- Generate mapping between Eiffel and IL generator with `classes'
			-- sorted in the topological order.
		require
			classes_not_void: classes /= Void
		local
			class_c: CLASS_C
			i, nb: INTEGER
			types: TYPE_LIST
			l_class_processed: BOOLEAN
			cl_type: CLASS_TYPE
		do
			from
				i := classes.lower
				nb := classes.upper
			until
				i > nb
			loop
				class_c := classes.item (i)
				if is_class_generated (class_c) and then class_c.has_types then
					System.set_current_class (class_c)
					from
						types := class_c.types
						types.start
						l_class_processed := False
					until
						types.after
					loop
						cl_type := types.item
						if cl_type.is_generated then
							context.init (cl_type)
							cil_generator.set_current_module_with (cl_type)

								-- Generate entity to represent current Eiffel implementation class
							cil_generator.generate_creation_procedures (class_c, cl_type)
						end

						types.forth
					end
				end
				i := i + 1
			variant
				nb - i + 1
			end
		end

	generate_entry_point
			-- Generate call to creation routine from ROOT_CLASS
		local
			a_class: CLASS_C
			root_class_type: CLASS_TYPE
			root_feat: FEATURE_I
			l_decl_type: CL_TYPE_A
		do
			if
				System.msil_generation_type.same_string_general ("exe") and then
				not System.root_creation_name.is_empty
			then
					-- Update the root class info
				root_class_type := system.root_class_type (system.root_type)
				a_class := root_class_type.associated_class
				root_feat := a_class.feature_table.item (System.root_creation_name)
				l_decl_type := root_class_type.type.implemented_type (root_feat.written_in)
				context.init (root_class_type)
				cil_generator.define_entry_point (
					root_class_type,
					l_decl_type.associated_class_type (root_class_type.type),
					root_feat.written_feature_id, root_feat.has_arguments)
			end
		end

feature {NONE} -- Sort

	ordered_classes: HASH_TABLE [ARRAY [CLASS_C], INTEGER]
			-- Classes sorted by their module appartenance.

	prepare_classes (system_classes: CLASS_C_SERVER)
			-- Initialize `ordered_classes' so that it is organized by modules
			-- and for each modules classes are sorted following their topological order.
		require
			system_classes_not_void: system_classes /= Void
		local
			l_classes: HASH_TABLE [ARRAYED_LIST [CLASS_C], INTEGER]
			l_list: ARRAYED_LIST [CLASS_C]
			i, nb, l_packet, l_max_packet: INTEGER
			l_class: CLASS_C
			l_is_one_module: BOOLEAN
		do
			create l_classes.make (10)
			from
				i := 1
				nb := system_classes.capacity
				l_is_one_module := is_single_module
			until
				i > nb
			loop
				l_class := system_classes.item (i)
				if l_class /= Void then
					if l_is_one_module then
						l_packet := 1
					else
						l_packet := l_class.class_id // System.msil_classes_per_module + 1
					end
					l_classes.search (l_packet)
					if l_classes.found then
						l_list := l_classes.found_item
					else
						create l_list.make (10)
						l_classes.put (l_list, l_packet)
					end
					l_list.extend (l_class)
					if l_packet > l_max_packet then
						l_max_packet := l_packet
					end
				end
				i := i + 1
			variant
				nb - i + 1
			end

			create ordered_classes.make (l_max_packet)
			from
				l_classes.start
			until
				l_classes.after
			loop
				l_list := l_classes.item_for_iteration
				l_packet := l_classes.key_for_iteration

				ordered_classes.put (sorted_array_from_list (l_list), l_packet)
				l_classes.forth
			end

			force_recompilation
		ensure
			ordered_classes_not_void: ordered_classes /= Void
		end

	force_recompilation
			-- Traverse `ordered_classes' and if a class has to be generated
			-- then for all classes belonging to the same entry in `ordered_classes'
			-- should be recompiled.
		local
			l_class_c: CLASS_C
			i, nb: INTEGER
			types: TYPE_LIST
			l_added: BOOLEAN
			l_classes: ARRAY [CLASS_C]
			l_changed_classes: ARRAYED_LIST [ARRAY [CLASS_C]]
		do
			if not is_single_module then
					-- First pass, we collect all modules in which a class needs
					-- to be recompiled.
				from
					create l_changed_classes.make (ordered_classes.count)
					ordered_classes.start
				until
					ordered_classes.after
				loop
					l_classes := ordered_classes.item_for_iteration
					l_added := False
					from
						i := l_classes.lower
						nb := l_classes.upper
					until
						i > nb or l_added
					loop
						l_class_c := l_classes.item (i)
						if l_class_c /= Void then
							types := l_class_c.types
							if not types.is_empty then
								from
									types.start
								until
									types.after or l_added
								loop
									if
										types.item.is_generated and
										is_class_generated (l_class_c) and not l_added
									then
										l_changed_classes.extend (l_classes)
										l_added := True
									end
									types.forth
								end
							end
						end
						i := i + 1
					end
					ordered_classes.forth
				end

					-- Second pass. For each module containing a modified class, we mark
					-- the other classes of this module for a compilation.
				from
					l_changed_classes.start
				until
					l_changed_classes.after
				loop
					l_classes := l_changed_classes.item
					from
						i := l_classes.lower
						nb := l_classes.upper
					until
						i > nb
					loop
						l_class_c := l_classes.item (i)
							-- If `l_class_c' is not marked to be generated, we force its addition
							-- so that it gets compiled.
						if l_class_c /= Void and then not is_class_generated (l_class_c) then
							System.degree_minus_1.insert_class (l_class_c)
						end
						i := i + 1
					end
					l_changed_classes.forth
				end
			end
		end

	sorted_array_from_list (a_list: ARRAYED_LIST [CLASS_C]): SORTABLE_ARRAY [CLASS_C]
			-- Initialize a sorted array of CLASS_C from `a_list'.
		require
			a_list_not_void: a_list /= Void
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := a_list.count
				create Result.make (i, nb)
				a_list.start
			until
				i > nb
			loop
				Result.put (a_list.item, i)
				a_list.forth
				i := i + 1
			end
			Result.sort
		ensure
			sorted_array_from_list_not_void: Result /= Void
		end

	sorted_classes (system_classes: CLASS_C_SERVER): ARRAY [CLASS_C]
			-- `system_classes' sorted following their topological
			-- order.
		require
			system_classes_not_void: system_classes /= Void
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := system_classes.capacity
				create Result.make (i, nb)
			until
				i > nb
			loop
				if attached system_classes.item (i) as class_c then
					Result.force (class_c, class_c.topological_id)
				end
				i := i + 1
			variant
				nb - i + 1
			end
		ensure
			Result_not_void: Result /= Void
			-- classes_sorted: Result.is_topologically_sorted
		end

feature {NONE} -- File copying

	assembly_location (a_is_finalizing: BOOLEAN): PATH
			-- Location of `Assemblies' directory in W_code or F_code depending
			-- on compilation type `a_is_finalizing'.
		do
			if a_is_finalizing then
				Result := project_location.final_assemblies_path
			else
				Result := project_location.workbench_assemblies_path
			end
		end

	copy_to_local (a_source: PATH; a_target_directory: PATH; a_destination_name: detachable READABLE_STRING_GENERAL)
			-- Copy `a_source' into `a_target_directory' directory under `a_destination_name' if specified,
			-- or under the same name as `a_source'.
		require
			a_source_not_void: a_source /= Void
			a_source_not_empty: not a_source.is_empty
			a_target_directory_not_void: a_target_directory /= Void
			a_target_directory_not_empty: not a_target_directory.is_empty
			a_destination_name_valid: a_destination_name /= Void implies not a_destination_name.is_empty
		local
			l_source, l_target: RAW_FILE
			l_vicf: VICF
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_source.make_with_path (a_source)
				if a_destination_name /= Void then
					create l_target.make_with_path (a_target_directory.extended (a_destination_name))
				else
					create l_target.make_with_path (a_target_directory.extended_path (a_source.entry))
				end

					-- Only copy the file if it is not already there or if the original
					-- file is more recent.
				if not l_target.exists or else l_target.date < l_source.date then
					if l_source.exists then
						l_source.open_read
						l_target.open_write
						l_source.copy_to (l_target)
						l_source.close
						l_target.close
						l_target.set_date (l_source.date)
					else
							-- Source does not exist, report the error.
						create l_vicf.make (a_source.name, l_target.path.name)
						error_handler.insert_warning (l_vicf, universe.target.options.is_warning_as_error)
					end
				end
			else
					-- An exception occurred, report the error.
				if l_source /= Void and then not l_source.is_closed then
					l_source.close
				end
				if l_target /= Void and then not l_target.is_closed then
					l_target.close
				end
				if l_target /= Void then
					create l_vicf.make (a_source.name, l_target.path.name)
				else
					create l_vicf.make (a_source.name, "Target not yet computed")
				end
				error_handler.insert_warning (l_vicf, universe.target.options.is_warning_as_error)
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Progression

	degree_output: DEGREE_OUTPUT
			-- Progression bar.

	degree_number: INTEGER = 1
			-- Degree in which compilation is performed.

	dll_type: STRING = "dll"
			-- Type of generation

	is_class_generated (a_class: CLASS_C): BOOLEAN
			-- Is `a_class' to be generated?
		do
				-- We force generation of basic classes even if only the reference version
				-- will be generated.
			Result := (a_class /= Void and then (a_class.is_basic and then not a_class.is_typed_pointer or not a_class.is_external))
				and then (is_finalizing or else a_class.degree_minus_1_needed)
		ensure
			definition: Result implies a_class /= Void
		end

invariant
	system_exists: System /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
