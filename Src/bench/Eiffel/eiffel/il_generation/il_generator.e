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

create
	make

feature {NONE} -- Initialization

	make (deg_output: DEGREE_OUTPUT) is
			-- Generate a COM+ assembly.
		do
			degree_output := deg_output
		end

feature -- Access

	classes_count: INTEGER
			-- Number of classes in Universe.

	compiled_classes_count: INTEGER
			-- Number of classes generated in IL.

	assembly_info: ASSEMBLY_INFO
			-- Info about currently generated assembly.

feature -- Generation

	generate is
			-- Generate a .NET assembly
		local
			file_name, location: STRING
			output_file_name: FILE_NAME
			retried, is_assembly_loaded, is_error_available: BOOLEAN
			deletion_successful: BOOLEAN
			classes: ARRAY [CLASS_C]
			output_file: RAW_FILE
			l_last_error_msg: STRING
			l_key_file_name: STRING
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
				
				if System.in_final_mode then
					location := (create {PROJECT_CONTEXT}).Final_generation_path
				else
					location := (create {PROJECT_CONTEXT}).Workbench_generation_path
				end
				
				l_key_file_name := System.msil_key_file_name
				if l_key_file_name /= Void then
					l_key_file_name := (create {ENV_INTERP}).interpreted_string (l_key_file_name)
				end
				il_generator.start_assembly_generation (System.name, file_name,
					l_key_file_name, location)
				
					-- Create data of current assembly
				create assembly_info.make (System.name)
				
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

					-- We currently have one module per assembly, in the future we might
					-- generate our code using as many modules as C directories if we
					-- were in our C code generation.
				il_generator.start_module_generation (file_name, System.line_generation)

				classes_count := System.classes.count
				classes := sorted_classes (System.classes)

					-- Generate types metadata description and IL code
				generate_types (classes)

					-- Generate entry point, if any.
				generate_entry_point

					-- Finish code generation.
				il_generator.end_module_generation
				il_generator.end_assembly_generation
			else
					-- An error occurred, let's raise an Eiffel compilation
					-- error that will be caught by WORBENCH_I.recompile.
				Error_handler.raise_error
			end
		rescue
			if not retried then
				if not is_assembly_loaded or not is_error_available then
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

feature {NONE} -- Type description

	generate_types (classes: ARRAY [CLASS_C]) is
			-- Generate all classes in compiled system.
		require
			valid_system: System.classes /= Void
		do
				-- Generate set of types as they are known from Eiffel
				-- We simply define a basic correspondance between Eiffel
				-- and IDs used by the IL code generator in a topological
				-- order.
			generate_class_mappings (classes)
			generate_class_attributes (classes)

				-- Generate only features description for each Eiffel class type
				-- with their IL code.
			generate_features_description (classes)
			generate_features_implementation (classes)
		end

	generate_class_mappings (classes: ARRAY [CLASS_C]) is
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

					-- We add `8' because they are 8 types from ISE.Runtime
					-- we want to reuse.
				il_generator.start_class_mappings (static_type_id_counter.count + 8)

					-- Identify all runtime types.
				il_generator.set_runtime_type_id (static_type_id_counter.count + 1)
				il_generator.set_class_type_id (static_type_id_counter.count + 2)
				il_generator.set_generic_type_id (static_type_id_counter.count + 3)
				il_generator.set_formal_type_id (static_type_id_counter.count + 4)
				il_generator.set_none_type_id (static_type_id_counter.count + 5)
				il_generator.set_basic_type_id (static_type_id_counter.count + 6)
				il_generator.set_eiffel_type_info_type_id (static_type_id_counter.count + 7)
				il_generator.set_generic_conformance_type_id (static_type_id_counter.count + 8)
				il_generator.generate_type_class_mappings
				il_generator.set_any_type_id (System.any_class.compiled_class.types.first.static_type_id)
				il_generator.set_object_type_id (System.system_object_class.compiled_class.types.first.implementation_id)
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void then
-- 					if (j \\ 500) = 0 then
-- 						feature {MEMORY}.full_collect
-- 						feature {MEMORY}.full_coalesce
-- 					end
-- 
					from
						types := class_c.types
						types.start
						l_class_counted := False
					until
						types.after
					loop
						cl_type := types.item
							-- Generate correspondance between Eiffel IDs and
							-- CIL information.
						Il_generator.generate_class_mappings (cl_type)
						if cl_type.is_generated and not l_class_counted then
							compiled_classes_count := compiled_classes_count + 1
							l_class_counted := True
						end

						types.forth
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
				if class_c /= Void and not class_c.is_external then
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
				degree_output.put_start_degree (1, j)
			variant
				nb - i + 1
			until
				i > nb or j = 0
			loop
				class_c := classes.item (i)
				if class_c /= Void and not class_c.is_external then
					if (j \\ 500) = 0 then
						feature {MEMORY}.full_collect
						feature {MEMORY}.full_coalesce
					end

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

							if not l_class_processed then
								degree_output.put_degree_1 (class_c, j)
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
			degree_output.put_end_degree
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
				degree_output.put_start_degree ((-1).to_integer_8, j)
			variant
				nb - i + 1
			until
				i > nb or j = 0
			loop
				class_c := classes.item (i)
				if class_c /= Void and not class_c.is_external then
					if (j \\ 500) = 0 then
						feature {MEMORY}.full_collect
						feature {MEMORY}.full_coalesce
					end

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

							if not l_class_processed then
								degree_output.put_degree_minus_1 (class_c, j)
								System.set_current_class (class_c)
								class_c.set_assembly_info (assembly_info)
								l_class_processed := True
								j := j - 1
							end

								-- Generate entity to represent current Eiffel implementation class
							il_generator.generate_il_implementation (class_c, cl_type)
						end

						types.forth
					end
				end
				i := i + 1
			end
			degree_output.put_end_degree
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
				il_generator.define_entry_point (a_class.types.first.implementation_id, l_decl_type.associated_class_type.implementation_id,
					root_feat.origin_feature_id)
			end
		end
		
feature {NONE} -- Sort

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

feature {NONE} -- Progression

	degree_output: DEGREE_OUTPUT
			-- Progression bar.

	degree_number: INTEGER is 1
			-- Degree in which compilation is performed.

	dll_type: STRING is "dll"
			-- Type of generation

invariant
	system_exists: System /= Void

end -- class IL_GENERATOR
