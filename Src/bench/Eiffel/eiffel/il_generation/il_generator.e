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
	
	SHARED_ERROR_HANDLER
	
	EXCEPTIONS
		export
			{NONE} all
		end

	COMPILER_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (deg_output: DEGREE_OUTPUT) is
			-- Generate a COM+ assembly.
		do
			degree_output := deg_output
		end

feature -- Generation

	generate is
			-- Generate a .NET assembly
		local
			file_name: STRING
			retried: BOOLEAN
			il_meta_data_generator: IL_META_DATA_GENERATOR
		do
			if not retried then
				if System.java_generation then
					il_generator.set_java_generation
				else
					il_generator.set_msil_generation
				end

				file_name := System.system_name + "." + System.msil_generation_type
				il_generator.start_assembly_generation (System.system_name, file_name)
				generate_reference_to_assemblies
				il_generator.start_module_generation (file_name, System.line_generation)
				generate_types
				if System.generate_eac_metadata then
					if System.java_generation then
						create {JVM_META_DATA_GENERATOR} il_meta_data_generator.make
					else
						create {MSIL_META_DATA_GENERATOR} il_meta_data_generator.make
					end
					il_meta_data_generator.generate_metadata (sorted_classes (System.classes))
				end
				generate_il_code
				generate_entry_point
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

feature -- Assembly imports

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

feature -- Type description

	generate_types is
			-- Generate all classes in compiled system.
		require
			valid_system: System.classes /= Void
		local
			classes: ARRAY [CLASS_C]
			class_c: CLASS_C
			i, nb: INTEGER
			il_meta_data_generator: IL_META_DATA_GENERATOR
			types: TYPE_LIST
		do
				-- Prepare generation by ordering classes following
				-- their topological order as done in degree 4.
			classes := sorted_classes (System.classes)

			if System.java_generation then
				create {JVM_META_DATA_GENERATOR} il_meta_data_generator.make
			else
				create {MSIL_META_DATA_GENERATOR} il_meta_data_generator.make
			end

				-- Generate set of types as they are known from Eiffel
			from
				i := classes.lower
				nb := classes.upper
				il_generator.start_class_mappings (max_type_id)
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void then
					from
						types := class_c.types
						types.start
					until
						types.after
					loop
						il_meta_data_generator.generate_class_mappings (types.item)
						types.forth
					end
				end
				i := i + 1
			end

				-- Generate only pure Eiffel type description.
				-- First only the non-array classes.
				-- Then the array classes.
				-- Reason: because we can have an ARRAY [B] and B has not yet
				-- been described yet. So we do first a description of B before
				-- doing the description of ARRAY [B]
			generate_classes_description (classes, il_meta_data_generator, False)
			generate_classes_description (classes, il_meta_data_generator, True)

				-- Generate only features description for each Eiffel class type
			from
				i := classes.lower
				nb := classes.upper
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void then
					from
						types := class_c.types
						types.start
					until
						types.after
					loop
						il_meta_data_generator.generate_il_features_description (class_c, types.item)
						types.forth
					end
				end
				i := i + 1
			end

				-- Generate custom attributes defined on `classes'.
			generate_custom_attributes (classes, il_meta_data_generator)

			il_generator.end_classes_descriptions
		end

feature -- Description

	generate_classes_description (classes: ARRAY [CLASS_C]; il_md_gen: IL_META_DATA_GENERATOR; only_arrays: BOOLEAN) is
			-- Generate only pure Eiffel type description
		require
			classes_not_void: classes /= Void
			il_md_gen_not_void: il_md_gen /= Void
		local
			class_c: CLASS_C
			i, nb: INTEGER
			types: TYPE_LIST
		do
			from
				i := classes.lower
				nb := classes.upper
				il_generator.start_classes_descriptions
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void and then class_c.is_special = only_arrays then
					from
						types := class_c.types
						types.start
					until
						types.after
					loop
						il_md_gen.generate_il_class_description (class_c, types.item)
						types.forth
					end
				end
				i := i + 1
			end
		end

feature -- Code generation

	generate_custom_attributes (classes: ARRAY [CLASS_C]; il_md_gen: IL_META_DATA_GENERATOR) is
			-- Generate custom attributes of `classes' if any.
		require
			classes_not_void: classes /= Void
			il_md_gen_not_void: il_md_gen /= Void
		local
			class_c: CLASS_C
			i, nb: INTEGER
			types: TYPE_LIST
		do
			from
				i := classes.lower
				nb := classes.upper
				il_generator.start_classes_descriptions
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void then
					from
						types := class_c.types
						types.start
					until
						types.after
					loop
						il_md_gen.generate_class_custom_attribute (types.item)
						types.forth
					end
				end
				i := i + 1
			end
		end
		
	generate_il_code is
			-- Generate IL code for all features in system.
		require
			valid_system: System.classes /= Void
		local
			classes: ARRAY [CLASS_C]
			class_c: CLASS_C
			i, j, nb: INTEGER
			types: TYPE_LIST
		do
			from
				classes := sorted_classes (System.classes)
				j := System.classes.count
				i := classes.lower
				nb := classes.upper
				il_generator.start_il_generations
				degree_output.put_start_degree (1, j)
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void then
					if not class_c.is_external then
						degree_output.put_degree_1 (class_c, j)
						from
							types := class_c.types
							types.start
						until
							types.after
						loop
							context.init (types.item)
							il_generator.generate_il (class_c, types.item)
							types.forth

								-- Generate entity to represent current Eiffel class
							il_generator.end_class
						end
					end
					j := j - 1
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
				il_generator.define_entry_point (a_class.types.first.static_type_id, root_feat.feature_id)
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
				i := system_classes.lower
				nb := system_classes.upper
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

	max_type_id: INTEGER is
			-- Maximum static type id number of classes in system.
		require
			system_classes_not_void: System.classes /= Void
		local
			i, nb: INTEGER
			system_classes: CLASS_C_SERVER
			types: TYPE_LIST
		do
			from
				system_classes := System.classes
				i := system_classes.lower
				nb := system_classes.upper
			variant
				nb - i + 1
			until
				i > nb
			loop
				if system_classes.item (i) /= Void then
					from
						types := system_classes.item (i).types
						types.start
					until
						types.after
					loop
						Result := Result.max (types.item.static_type_id)
						types.forth
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- Progression

	degree_output: DEGREE_OUTPUT
			-- Progression bar.

	degree_number: INTEGER is 1
			-- Degree in which compilation is performed.

invariant

	system_exists: System /= Void

end -- class IL_GENERATOR
