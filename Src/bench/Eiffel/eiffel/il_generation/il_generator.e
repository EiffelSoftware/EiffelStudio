indexing
	description: "Special object responsible for generating IL byte code"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_GENERATOR

inherit
	SHARED_WORKBENCH

	SHARED_IL_CODE_GENERATOR

	SHARED_BYTE_CONTEXT

	SHARED_AST_CONTEXT
		rename
			context as ast_context
		end
	
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

create
	make

feature {NONE} -- Initialization

	make (deg_output: DEGREE_OUTPUT) is
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

feature -- Generation

	generate is
			-- Generate a .NET assembly
		local
			file_name, location: STRING
			output_file_name: FILE_NAME
			retried, is_assembly_loaded, is_error_available: BOOLEAN
			deletion_successful: BOOLEAN
			output_file: RAW_FILE
			l_last_error_msg: STRING
			l_key_file_name: STRING
			l_public_key: MD_PUBLIC_KEY
			l_signing: MD_STRONG_NAME
		do
			if not retried then
					-- At this point the COM component should be properly instantiated.
				is_assembly_loaded := True

					-- Let's check that we can retrieve an error if any, we do not care
					-- about the value, we just want to make sure that the call does not
					-- raise any exception, if it does `is_error_available' will be 
					-- False which will cause not to be used in case of an exception
					-- (See rescue clause below).
				l_last_error_msg := il_generator.last_error
				is_error_available := True

					-- Compute name of generated file if any.
				file_name := System.name + "." + System.msil_generation_type
				
				if is_finalizing then
					location := Final_generation_path
				else
					location := Workbench_generation_path
				end
				
					-- Set information about current assembly.
				create assembly_info.make (System.name)
				if System.msil_version /= Void and then not System.msil_version.is_empty then
					assembly_info.set_version (System.msil_version)
				end

				create l_signing.make
				if not l_signing.exists then
						-- We cannot continue as incremental recompilation needs access
						-- to `MD_STRONG_NAME'.
					Error_handler.insert_error (create {VIAC})
					Error_handler.checksum
				end
				
				check
					l_signing_exists: l_signing.exists
				end
				
					-- Sign assembly only if we are allowed to.
				if feature {EIFFEL_ENV}.has_signable_generation then
					l_key_file_name := System.msil_key_file_name
					if l_key_file_name /= Void then
						l_key_file_name := (create {ENV_INTERP}).interpreted_string (
							l_key_file_name)
					end
				end

				if l_key_file_name /= Void then
					create l_public_key.make_from_file (l_key_file_name)
					if not l_public_key.is_valid then
						l_public_key := Void
							-- Introduce error saying that public key cannot be read.
						Error_handler.insert_warning (create {VIIK})
					end
				else
					l_public_key := Void
				end

				if l_public_key /= Void then
					assembly_info.set_public_key_token (l_public_key.public_key_token_string)
				end

				create output_file_name.make_from_string (location)
				output_file_name.set_file_name (file_name)
				create output_file.make (output_file_name)
				if output_file.exists then
					output_file.delete
				end
				deletion_successful := True

					-- Set attributes of generated executable.
				if System.msil_generation_type.is_equal (dll_type) then
					il_generator.set_dll
				elseif System.is_console_application then
					il_generator.set_console_application
				else
					il_generator.set_window_application
				end
				
				il_generator.set_verifiability (System.il_verifiable)
				il_generator.set_cls_compliant (System.cls_compliant)

					-- We add `9' because they are 9 types from ISE.Runtime
					-- we want to reuse.
				il_generator.initialize_class_mappings (static_type_id_counter.count + 9)

					-- Identify all runtime types.
				il_generator.set_runtime_type_id (static_type_id_counter.count + 1)
				il_generator.set_class_type_id (static_type_id_counter.count + 2)
				il_generator.set_generic_type_id (static_type_id_counter.count + 3)
				il_generator.set_formal_type_id (static_type_id_counter.count + 4)
				il_generator.set_none_type_id (static_type_id_counter.count + 5)
				il_generator.set_basic_type_id (static_type_id_counter.count + 6)
				il_generator.set_eiffel_type_info_type_id (static_type_id_counter.count + 7)
				il_generator.set_generic_conformance_type_id (static_type_id_counter.count + 8)
				il_generator.set_assertion_level_enum_type_id (static_type_id_counter.count + 9)

				il_generator.start_assembly_generation (System.name, file_name,
					l_public_key, location, assembly_info,
					System.line_generation or not is_finalizing)

					-- Split classes into modules
				prepare_classes (System.classes)

					-- Generate types metadata description and IL code
				generate_all_types (sorted_classes (System.classes))

				if not is_single_module then
						-- Generate run-time helper.
					il_generator.generate_runtime_helper
				end

					-- Generate entry point if necessary
				generate_entry_point

					-- Generate resources if any
				if System.dotnet_resources_names /= Void then
					il_generator.generate_resources (System.dotnet_resources_names)				
				end
					-- Finish code generation.
				il_generator.end_assembly_generation
				
					-- Perform cleanup of underlying external objects
				il_generator.cleanup
			else
					-- Perform cleanup of underlying external objects
				il_generator.cleanup
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
						l_last_error_msg := il_generator.last_error
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

	deploy is
			-- Copy local assemblies if needed to `Generation_directory/Assemblies' and
			-- copy configuration file to load local assemblies.
		local
			l_assembly: ASSEMBLY_I
			l_source, l_target: RAW_FILE
			l_source_name, l_target_name: FILE_NAME
			l_file_name: STRING
			l_has_local, retried: BOOLEAN
			l_precomp: REMOTE_PROJECT_DIRECTORY
			l_viop: VIOP
			l_use_optimized_precomp: BOOLEAN
		do
			if not retried then
					-- Copy referenced local assemblies
				from
					Universe.clusters.start
				until
					Universe.clusters.after
				loop
					l_assembly ?= Universe.clusters.item
					if l_assembly /= Void and then not l_assembly.is_in_gac then
						l_has_local := True
						copy_to_local (l_assembly.assembly_path)
					end
					Universe.clusters.forth
				end

					-- Copy precompiled assemblies.
				if
					Workbench.Precompilation_directories /= Void and then
					not Workbench.Precompilation_directories.is_empty
				then
					from
						Workbench.Precompilation_directories.start
						create_local_assemblies_directory
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
							error_handler.insert_warning (l_viop)
						end
						
						copy_to_local (l_precomp.assembly_driver (l_use_optimized_precomp))
						copy_to_local (l_precomp.assembly_helper_driver (l_use_optimized_precomp))
						if not l_use_optimized_precomp or l_precomp.line_generation then
							copy_to_local (l_precomp.assembly_debug_info (l_use_optimized_precomp))
						end

						Workbench.Precompilation_directories.forth
					end
				end	
				
					-- Copy configuration file to be able to load up local assembly.
				if l_has_local then
						-- Compute name of configuration file: It is `system_name.xxx.config'
						-- where `xxx' is either `exe' or `dll'.
					l_file_name := System.name + "." + System.msil_generation_type + ".config"
					
					l_source_name := (create {EIFFEL_ENV}).Generation_templates_path.twin
					l_source_name.set_file_name ("assembly_config.xml")
		
					if is_finalizing then
						create l_target_name.make_from_string (Final_generation_path)
					else
						create l_target_name.make_from_string (workbench_generation_path)
					end
					l_target_name.set_file_name (l_file_name)
		
					create l_source.make_open_read (l_source_name)
					create l_target.make_open_write (l_target_name)
					l_source.copy_to (l_target)
					l_target.close
					l_source.close
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

	generate_all_types (classes: ARRAY [CLASS_C]) is
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
				Il_generator.start_module_generation (ordered_classes.key_for_iteration)
				generate_types (ordered_classes.item_for_iteration)
				Il_generator.end_module_generation (has_root_class)
				ordered_classes.forth
			end
			if not is_single_module then
				degree_output.put_end_degree
			end
		end

	compute_root_class is
			-- Initialize `root_class_routine' with CLASS_C instance that defines
			-- creation routine of current system.
			--| In most cases `System.root_class.compiled_class' is equal to
			--| `root_class_routine', but when creation routine is inherited, this
			--| is not true.
			--| `root_class_routine' is used to find out which module needs to be
			--| marked in a special way so that debug information is properly generated.
		local
			l_feat: FEATURE_I
			l_root_class: CLASS_C
		do
			if System.root_class /= Void and then System.creation_name /= Void then
				l_root_class := System.root_class.compiled_class
				l_feat := l_root_class.feature_table.item (System.creation_name)
				root_class_routine := l_feat.written_class
			end
		end

	generate_types (classes: ARRAY [CLASS_C]) is
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
				il_generator.generate_runtime_helper
			end

				-- Generate only features description for each Eiffel class type
				-- with their IL code.
			generate_features_description (classes)
			generate_features_implementation (classes)
			generate_creation_classes (classes)
		end

	generate_class_interfaces (classes: ARRAY [CLASS_C]) is
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
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void then
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
							il_generator.generate_class_interfaces (cl_type, class_c)
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
					else
							-- Step is needed as namespace of a precompiled class should be set.
							-- At the moment it is set withing `generate_class_mappings', but
							-- when a class does not have a generic derivation, `types' is empty
							-- and `generate_class_mappings' is not called.
						class_c.lace_class.set_actual_namespace
					end
				end
				i := i + 1
			end
		end

	generate_class_mappings (classes: ARRAY [CLASS_C]; for_interface: BOOLEAN) is
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
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if is_class_generated (class_c) then
					has_root_class := has_root_class or else (root_class_routine /= Void and then
						class_c.lace_class = root_class_routine.lace_class)
					types := class_c.types
					if not types.is_empty then
						from
							types.start
						until
							types.after
						loop
							cl_type := types.item
								-- Generate correspondance between Eiffel IDs and
								-- CIL information.
							if cl_type.is_generated then
								Il_generator.set_current_module_with (cl_type)
								Il_generator.generate_class_mappings (cl_type, for_interface)
							end

							types.forth
						end
					end
				end
				i := i + 1
			end
		end

	generate_class_attributes (classes: ARRAY [CLASS_C]) is
			-- Generate mapping between Eiffel and IL generator with `classes' sorted in
			-- topological order.
		require
			classes_not_void: classes /= Void
		local
			class_c: CLASS_C
			i, j, nb: INTEGER
			types: TYPE_LIST
			l_class_processed: BOOLEAN
		do
			from
				i := classes.lower
				nb := classes.upper
				j := compiled_classes_count				
			variant
				nb - i + 1
			until
				i > nb or j = 0
			loop
				class_c := classes.item (i)
				if is_class_generated (class_c) then
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
						if types.item.is_generated then
							Il_generator.set_current_module_with (types.item)
							Il_generator.generate_class_attributes (types.item)
							if not l_class_processed then
								j := j - 1
								l_class_processed := True
							end
						end

						types.forth
					end
				end
				i := i + 1
			end
		end

	generate_features_description (classes: ARRAY [CLASS_C]) is
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
			variant
				nb - i + 1
			until
				i > nb or j = 0
			loop
				class_c := classes.item (i)
				if is_class_generated (class_c) then
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
							Il_generator.set_current_module_with (cl_type)

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
							il_generator.generate_il_features_description (class_c, cl_type)
						end

						types.forth
					end
				end
				i := i + 1
			end
			if is_single_module then
				degree_output.put_end_degree
			end
		end

	generate_features_implementation (classes: ARRAY [CLASS_C]) is
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
		do
			from
				i := classes.lower
				nb := classes.upper
				j := compiled_classes_count
				if is_single_module then
					if is_finalizing then
						degree_output.put_start_degree (-3, j)
					else
						degree_output.put_start_degree (-1, j)
					end
				end
			variant
				nb - i + 1
			until
				i > nb or j = 0
			loop
				class_c := classes.item (i)
				if is_class_generated (class_c) then
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
							Il_generator.set_current_module_with (cl_type)

							if not l_class_processed then
								if is_single_module then
									if is_finalizing then
										degree_output.put_degree_minus_3 (class_c, j)
									else
										degree_output.put_degree_minus_1 (class_c, j)
									end
								else
									degree_output.put_degree_1 (class_c, j)
								end
								System.set_current_class (class_c)
								l_class_processed := True
								j := j - 1
								compiled_classes_count := compiled_classes_count - 1
							end

							cl_type.set_assembly_info (assembly_info)

								-- Generate entity to represent current Eiffel implementation class
							il_generator.generate_il_implementation (class_c, cl_type)
						end

						types.forth
					end
				end
				i := i + 1
			end
			if is_single_module then
				degree_output.put_end_degree
			end
		end

	generate_creation_classes (classes: ARRAY [CLASS_C]) is
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
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if is_class_generated (class_c) then
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
							Il_generator.set_current_module_with (cl_type)

								-- Generate entity to represent current Eiffel implementation class
							il_generator.generate_creation_procedures (class_c, cl_type)
						end

						types.forth
					end
				end
				i := i + 1
			end
			if is_single_module then
				degree_output.put_end_degree
			end
		end

	generate_entry_point is
			-- Generate call to creation routine from ROOT_CLASS
		local
			a_class: CLASS_C
			root_feat: FEATURE_I
			l_decl_type: CL_TYPE_I
		do
			if
				System.msil_generation_type.is_equal ("exe") and then
				System.creation_name /= Void
			then
					-- Update the root class info
				a_class := System.root_class.compiled_class
				root_feat := a_class.feature_table.item (System.creation_name)
				l_decl_type := il_generator.implemented_type (root_feat.origin_class_id,
					a_class.types.first.type)
				il_generator.define_entry_point (
					a_class.types.first.implementation_id,
					l_decl_type.associated_class_type,
					root_feat.origin_feature_id, root_feat.has_arguments)
			end
		end
		
feature {NONE} -- Sort

	ordered_classes: HASH_TABLE [ARRAY [CLASS_C], INTEGER]
			-- Classes sorted by their module appartenance.

	prepare_classes (system_classes: CLASS_C_SERVER) is
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
			variant
				nb - i + 1
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

	force_recompilation is
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
						if
							l_class_c /= Void and not is_class_generated (l_class_c)
						then
							System.degree_minus_1.insert_class (l_class_c)
						end
						i := i + 1
					end
					l_changed_classes.forth
				end
			end
		end
		
	sorted_array_from_list (a_list: ARRAYED_LIST [CLASS_C]): SORTABLE_ARRAY [CLASS_C] is
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

	sorted_classes (system_classes: CLASS_C_SERVER): ARRAY [CLASS_C] is
			-- `system_classes' sorted following their topological
			-- order.
		require
			system_classes_not_void: system_classes /= Void
		local
			i, nb: INTEGER
			class_c: CLASS_C
		do
			from
				i := 1
				nb := system_classes.capacity
				create Result.make (i, nb)
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := system_classes.item (i)
				if class_c /= Void then
					Result.force (class_c, class_c.topological_id)
				end
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
			-- classes_sorted: Result.is_topologically_sorted
		end

feature {NONE} -- File copying

	copy_to_local (a_source: STRING) is
			-- Copy `a_source' into `Assemblies' directory.
		require
			a_source_not_void: a_source /= Void
			a_source_not_empty: not a_source.is_empty
		local
			l_path: STRING
			l_source, l_target: RAW_FILE
			l_target_name: FILE_NAME
			l_pos: INTEGER
			l_vicf: VICF
			l_retried: BOOLEAN
		do
			if not l_retried then
				create_local_assemblies_directory
				l_path := a_source
		
				l_pos := l_path.last_index_of (
					Platform_constants.Directory_separator, l_path.count)
					
				create l_source.make (l_path)
				if is_finalizing then
					create l_target_name.make_from_string (Final_bin_generation_path)
				else
					create l_target_name.make_from_string (Workbench_bin_generation_path)
				end
		
				if l_pos > 0 then
					l_target_name.set_file_name (l_path.substring (l_pos + 1,
						l_path.count))
				else
					l_target_name.set_file_name (l_path)
				end
			
				create l_target.make (l_target_name)
				
					-- Only copy the file if it is not already there or if the original
					-- file is more recent.
				if not l_target.exists or else l_target.date < l_source.date then
					l_source.open_read
					l_target.open_write
					l_source.copy_to (l_target)
					l_source.close
					l_target.close
					l_target.set_date (l_source.date)
				end
			else
				if l_target_name /= Void then
					create l_vicf.make (a_source, l_target_name)
				else
					create l_vicf.make (a_source, "Unknown target")
				end
				error_handler.insert_warning (l_vicf)	
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Progression

	degree_output: DEGREE_OUTPUT
			-- Progression bar.

	degree_number: INTEGER is 1
			-- Degree in which compilation is performed.

	dll_type: STRING is "dll"
			-- Type of generation

	is_class_generated (a_class: CLASS_C): BOOLEAN is
			-- Is `a_class' to be generated?
		do
				-- We force generation of basic classes even if only the reference version
				-- will be generated.
			Result := (a_class /= Void and then (a_class.is_basic or not a_class.is_external))
				and then (is_finalizing or else a_class.degree_minus_1_needed)
		end
		
invariant
	system_exists: System /= Void

end -- class IL_GENERATOR
