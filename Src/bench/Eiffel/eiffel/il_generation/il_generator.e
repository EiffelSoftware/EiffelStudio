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

feature -- Generation

	generate is
			-- Generate a .NET assembly
		local
			file_name: STRING
			retried: BOOLEAN
			il_md_gen: IL_META_DATA_GENERATOR
			classes: ARRAY [CLASS_C]
		do
			if not retried then
				if System.java_generation then
					check
						False
					end
--					il_generator.set_java_generation
--					create {JVM_META_DATA_GENERATOR} il_md_gen.make
				else
					create {MSIL_META_DATA_GENERATOR} il_md_gen.make
					il_generator.set_msil_generation
				end
				il_generator.set_meta_data_generator (il_md_gen)

					-- Compute name of generated file if any.
				file_name := System.system_name + "." + System.msil_generation_type
				il_generator.start_assembly_generation (System.system_name, file_name)

					-- Set attributes of generated executable.
				if System.msil_generation_type.is_equal (dll_type) then
					il_generator.set_dll
				elseif System.is_console_application then
					il_generator.set_console_application
				else
					il_generator.set_window_application
				end

					-- Generate reference to assemblies on which Current system depends on.
				generate_reference_to_assemblies

					-- We currently have one module per assembly, in the future we might
					-- generate our code using as many modules as C directories if we
					-- were in our C code generation.
				il_generator.start_module_generation (file_name, System.line_generation)

				classes_count := System.classes.count
				classes := sorted_classes (System.classes)

					-- Generate types metadata description and IL code
				generate_types (il_md_gen, classes)

					-- Generate Eiffel Assembly Cache metadata (XML files)
				if System.generate_eac_metadata then
					il_md_gen.generate_metadata (classes)
				end

					-- Generate entry point, if any.
				generate_entry_point

					-- Finish code generation.
				il_generator.end_module_generation
				il_generator.end_assembly_generation
			else
				Error_handler.raise_error
			end
		rescue
			if not retried then
				Error_handler.insert_error (create {IL_ERROR}.make (il_generator.last_error))
				retried := True
				retry
			end
		end

feature {NONE} -- Assembly imports

	generate_reference_to_assemblies is
			-- Generate inclusion of assemblies specified in Ace file
		local
			assemblies: LIST [STRING]
		do
			assemblies := System.assembly_names
			if assemblies /= Void then
				from
					assemblies.start
				until
					assemblies.after
				loop
					il_generator.add_assembly_reference (assemblies.item)
					assemblies.forth
				end
			end
		end

feature {NONE} -- Type description

	generate_types (il_md_gen: IL_META_DATA_GENERATOR; classes: ARRAY [CLASS_C]) is
			-- Generate all classes in compiled system.
		require
			valid_system: System.classes /= Void
		do
				-- Generate set of types as they are known from Eiffel
				-- We simply define a basic correspondance between Eiffel
				-- and IDs used by the IL code generator in a topological
				-- order.
			generate_class_mappings (classes, il_md_gen)

				-- Generate only features description for each Eiffel class type
				-- with their IL code.
			generate_features_description (classes, il_md_gen)
			generate_features_implementation (classes, il_md_gen)

			il_generator.end_classes_descriptions
		end

	generate_class_mappings (classes: ARRAY [CLASS_C]; il_md_gen: IL_META_DATA_GENERATOR) is
			-- Generate mapping between Eiffel and IL generator with `classes' sorted in
			-- topological order.
		require
			classes_not_void: classes /= Void
			il_md_gen_not_void: il_md_gen /= Void
		local
			class_c: CLASS_C
			i, j, nb: INTEGER
			types: TYPE_LIST
			cl_type: CLASS_TYPE
			not_is_external: BOOLEAN
		do
			from
				i := classes.lower
				nb := classes.upper
				compiled_classes_count := 0
				il_generator.start_class_mappings (static_type_id_counter.count)
				j := classes_count
				degree_output.put_start_degree (1, j)
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void then
					degree_output.put_degree_1 (class_c, j)
					j := j - 1
					from
						not_is_external := not class_c.is_external
						if not_is_external then
							compiled_classes_count := compiled_classes_count + 1
						end
						types := class_c.types
						types.start
					until
						types.after
					loop
						cl_type := types.item
							-- Generate correspondance between Eiffel IDs and
							-- CIL information.
						il_md_gen.generate_class_mappings (cl_type)

							-- Generate precise description of classes: nature
							-- and inheritance hierarchy.
						il_md_gen.generate_il_class_description (class_c, cl_type)

							-- Generate custom attributes if defined on Eiffel classes
							-- to be generated.
						if not_is_external then
							ast_context.set_a_class (class_c)
							il_md_gen.generate_class_custom_attribute (cl_type)
						end
						types.forth
					end
				end
				i := i + 1
			end
			degree_output.put_end_degree
		end

	generate_features_description (classes: ARRAY [CLASS_C]; il_md_gen: IL_META_DATA_GENERATOR) is
			-- Generate mapping between Eiffel and IL generator with `classes'
			-- sorted in the topological order.
		require
			classes_not_void: classes /= Void
			il_md_gen_not_void: il_md_gen /= Void
		local
			class_c: CLASS_C
			i, j, nb: INTEGER
			types: TYPE_LIST
		do
			from
				i := classes.lower
				nb := classes.upper
				j := compiled_classes_count
				degree_output.put_start_degree (-1, j)
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void and then not class_c.is_external then
					degree_output.put_degree_minus_1 (class_c, j)
					j := j - 1
					from
						types := class_c.types
						types.start
					until
						types.after
					loop
						context.init (types.item)
							-- Generate entity to represent current Eiffel interface class
						il_md_gen.generate_il_features_description (class_c, types.item)

						if not class_c.is_frozen then
							il_generator.start_il_generation (types.item.static_type_id)
							il_generator.end_class
						end
						types.forth
					end
				end
				i := i + 1
			end
			degree_output.put_end_degree
		end

	generate_features_implementation (classes: ARRAY [CLASS_C]; il_md_gen: IL_META_DATA_GENERATOR) is
			-- Generate mapping between Eiffel and IL generator with `classes'
			-- sorted in the topological order.
		require
			classes_not_void: classes /= Void
			il_md_gen_not_void: il_md_gen /= Void
		local
			class_c: CLASS_C
			i, j, nb: INTEGER
			types: TYPE_LIST
		do
			from
				i := classes.lower
				nb := classes.upper
				j := compiled_classes_count
				degree_output.put_start_degree (-2, j)
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void and then not class_c.is_external then
					degree_output.put_degree_minus_2 (class_c, j)
					if j = 62 then
						print ("")
					end
					j := j - 1
					from
						types := class_c.types
						types.start
					until
						types.after
					loop
						context.init (types.item)
							-- Generate entity to represent current Eiffel implementation class
						il_generator.generate_il_implementation (class_c, types.item)
						il_generator.end_class

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
		do
			if
				System.msil_generation_type.is_equal ("exe") and then
				System.creation_name /= Void
			then
					-- Update the root class info
				a_class := System.root_class.compiled_class
				root_feat := a_class.feature_table.item (System.creation_name)
				il_generator.define_entry_point (a_class.types.first.implementation_id,
					root_feat.feature_id)
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
				nb := system_classes.count
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
