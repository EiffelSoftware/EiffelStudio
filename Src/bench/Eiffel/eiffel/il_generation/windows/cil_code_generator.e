indexing
	description: "Generation of IL code using a bridge pattern."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IL_CODE_GENERATOR

inherit
	IL_CONST

	IL_PREDEFINED_STRINGS
		export
			{NONE} all
		end

	SHARED_IL_CONSTANTS

	SHARED_WORKBENCH
		export
			{NONE} all 
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	ASSERT_TYPE
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
		rename
			context as ast_context
		export
			{NONE} all
		end

	SHARED_IL_CASING
		export
			{NONE} all
		end

	SHARED_GENERATION
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end
		
	SHARED_TYPE_I
		export
			{NONE} all
		end
	
feature {NONE} -- Initialization

	make is
			-- Initialize generator.
		do
			standard_twin_rout_id := System.any_class.compiled_class.feature_table.
				item_id (feature {PREDEFINED_NAMES}.Standard_twin_name_id).rout_id_set.first
			internal_finalize_rout_id := System.system_object_class.compiled_class.feature_table.
				item_id (feature {PREDEFINED_NAMES}.finalize_name_id).rout_id_set.first
		end

feature -- Access

	current_class_type: CLASS_TYPE
			-- Currently class type being handled.

feature -- Status report

	is_debug_info_enabled: BOOLEAN
			-- Are we generating debug information?

feature {IL_MODULE} -- Access

	is_single_inheritance_implementation: BOOLEAN is
			-- Is current generation of type SINGLE_IL_CODE_GENERATOR?
		deferred
		end

	method_body: MD_METHOD_BODY
			-- Body for currently generated routine.

	local_start_offset, local_end_offset, local_count: INTEGER
			-- Number of locals for current feature.

feature {NONE} -- Access

	main_module: IL_MODULE
			-- Module containing assembly manifest.

	current_module: IL_MODULE
			-- Module being used for code generation.

	current_type_id: INTEGER
			-- Type_id of class being analyzed.

	current_class: CLASS_C
			-- Current class being treated.

	is_single_class: BOOLEAN
			-- Can current class only be single inherited?

	standard_twin_rout_id, internal_finalize_rout_id: INTEGER
			-- Routine ID of `standard_twin' and `finalize' from ANY.

	output_file_name: FILE_NAME
			-- File where assembly is stored.

	md_dispenser: MD_DISPENSER
			-- Access to MetaData generator.

	md_emit: MD_EMIT is
			-- Metadata emitter.
		do
			Result := current_module.md_emit
		ensure
			md_emit_not_void: Result /= Void
		end

	method_writer: MD_METHOD_WRITER is
			-- To store method bodys.
		do
			Result := current_module.method_writer
		ensure
			method_writer_not_void: Result /= Void
		end

	type_count: INTEGER is
			-- Number of generated types in Current system.
		do
			Result := (create {SHARED_COUNTER}).static_type_id_counter.count + 8
		ensure
			type_count_positive: type_count >= 0
		end

	done_sig: MD_FIELD_SIGNATURE
			-- Precomputed signature of `done_token' so that we do not have
			-- to compute it too often.

	default_sig: MD_METHOD_SIGNATURE
			-- Precomputed signature of a feature with no arguments and no return type.
			-- Used to define default constructors and other features with same signature.

	method_sig: MD_METHOD_SIGNATURE
			-- Permanent signature for features.

	field_sig: MD_FIELD_SIGNATURE
			-- Permanent signature for attributes.

	local_sig: MD_LOCAL_SIGNATURE
			-- Permanent signature for locals.

	local_types: ARRAYED_LIST [PAIR [TYPE_I, STRING]]
			-- To store types of local variables.

	uni_string: UNI_STRING
			-- Buffer for all unicode string conversion.

	is_console_application: BOOLEAN
			-- Is current a console application?

	is_dll: BOOLEAN
			-- Is current generated as a DLL?

	is_verifiable: BOOLEAN
			-- Does code generation has to be verifiable?

	is_cls_compliant: BOOLEAN
			-- Does code generation generate CLS compliant code?

	object_type_id, any_type_id: INTEGER
			-- Type id of SYSTEM_OBJECT and ANY class.

	assembly_name: STRING
			-- Name of current assembly.

	c_module_name: STRING
			-- Name of C generated module containing all C externals.

	location_path: STRING
			-- Path where assemblies are being generated.

	current_feature_token: INTEGER
			-- Token of feature being generated in `generate_feature_code'.

	once_generation: BOOLEAN
			-- Are we currently generating a once feature?

feature {NONE} -- Debug info

	dbg_writer: DBG_WRITER is
			-- PDB writer.
		do
			Result := current_module.dbg_writer
		end

	dbg_offsets,
	dbg_start_lines,
	dbg_start_columns,
	dbg_end_lines,
	dbg_end_columns: ARRAY [INTEGER]
			-- Data holding debug information for current feature.

	dbg_offsets_count: INTEGER
			-- Number of meaningful elements in above arrays.

feature -- Access

	runtime_type_id: INTEGER
			-- Identifier for class ISE.Runtime.TYPE.

	class_type_id: INTEGER
			-- Identifier for class ISE.Runtime.CLASS_TYPE.

	basic_type_id: INTEGER
			-- Identifier for class ISE.Runtime.BASIC_TYPE.

	generic_type_id: INTEGER
			-- Identifier for class ISE.Runtime.GENERIC_TYPE.

	formal_type_id: INTEGER
			-- Identifier for class ISE.Runtime.FORMAL_TYPE.

	none_type_id: INTEGER
			-- Identifier for class ISE.Runtime.NONE_TYPE.

	eiffel_type_info_type_id: INTEGER
			-- Identifier for class ISE.Runtime.EIFFEL_TYPE_INFO.

	generic_conformance_type_id: INTEGER
			-- Identifier for class ISE.Runtime.GENERIC_CONFORMANCE.

	public_key: MD_PUBLIC_KEY
			-- Public key if used of current assembly.

feature -- Settings

	set_runtime_type_id (an_id: like runtime_type_id) is
			-- Set `an_id' to `runtime_type_id'.
		require
			valid_id: an_id > 0
		do
			runtime_type_id := an_id
		ensure
			runtime_type_id_set: runtime_type_id = an_id
		end

	set_class_type_id (an_id: like class_type_id) is
			-- Set `an_id' to `class_type_id'.
		require
			valid_id: an_id > 0
		do
			class_type_id := an_id
		ensure
			class_type_id_set: class_type_id = an_id
		end

	set_generic_type_id (an_id: like generic_type_id) is
			-- Set `an_id' to `generic_type_id'.
		require
			valid_id: an_id > 0
		do
			generic_type_id := an_id
		ensure
			generic_type_id_set: generic_type_id = an_id
		end

	set_formal_type_id (an_id: like formal_type_id) is
			-- Set `an_id' to `formal_type_id'.
		require
			valid_id: an_id > 0
		do
			formal_type_id := an_id
		ensure
			formal_type_id_set: formal_type_id = an_id
		end

	set_none_type_id (an_id: like none_type_id) is
			-- Set `an_id' to `none_type_id'.
		require
			valid_id: an_id > 0
		do
			none_type_id := an_id
		ensure
			none_type_id_set: none_type_id = an_id
		end

	set_eiffel_type_info_type_id (an_id: like eiffel_type_info_type_id) is
			-- Set `an_id' to `eiffel_type_info_type_id'.
		require
			valid_id: an_id > 0
		do
			eiffel_type_info_type_id := an_id
		ensure
			eiffel_type_info_type_id_set: eiffel_type_info_type_id = an_id
		end

	set_basic_type_id (an_id: like basic_type_id) is
			-- Set `an_id' to `basic_type_id'.
		require
			valid_id: an_id > 0
		do
			basic_type_id := an_id
		ensure
			basic_type_id_set: basic_type_id = an_id
		end

	set_generic_conformance_type_id (an_id: like generic_conformance_type_id) is
			-- Set `an_id' to `generic_conformance_type_id'.
		require
			valid_id: an_id > 0
		do
			generic_conformance_type_id := an_id
		ensure
			generic_conformance_type_id_set: generic_conformance_type_id = an_id
		end

	set_once_generation (v: BOOLEAN) is
			-- Set `once_generation' to `v'.
		do
			once_generation := v
		ensure
			once_generation_set: once_generation = v
		end

	set_object_type_id (an_id: INTEGER) is
			-- Set `object_type_id' to `an_id'.
		require
			valid_id: an_id > 0
		do
			object_type_id := an_id
		ensure
			object_type_id_set: object_type_id = an_id
		end

	set_any_type_id (an_id: INTEGER) is
			-- Set `any_type_id' to `an_id'.
		require
			valid_id: an_id > 0
		do
			any_type_id := an_id
		ensure
			any_type_id_set: any_type_id = an_id
		end

	set_current_module_with (a_class_type: CLASS_TYPE) is
			-- Update `current_module' so that it refers to module in which
			-- `a_class_type' is generated.
		require
			a_class_type_not_void: a_class_type /= Void
		do
			current_module := il_modules (a_class_type)
				-- Refine so that only classes being generated in current compilation
				-- unit needs the module to be generated as well.
			if a_class_type.is_generated and then not current_module.is_generated then
				current_module.prepare (md_dispenser, type_count)
			end
		ensure
			current_module_set: current_module /= Void
			associated_current_module: current_module = il_modules (a_class_type)
		end

feature {NONE} -- Settings

	set_current_class_type (cl_type: like current_class_type) is
			-- Set `current_class_type' to `cl_type'.
		require
			cl_type_not_void: cl_type /= Void
		do
			current_class_type := cl_type
		ensure
			current_class_type_set: current_class_type = cl_type
		end

	set_current_class (cl: like current_class) is
			-- Set `current_class' to `cl'.
		require
			cl_not_void: cl /= Void
		do
			current_class := cl
		ensure
			current_class_set: current_class = cl
		end

	set_current_type_id (an_id: like current_type_id) is
			-- Set `current_type_id' to `an_id'.
		require
			valid_id: an_id > 0
		do
			current_type_id := an_id
		ensure
			current_type_id_set: current_type_id = an_id
		end

feature -- Generation Structure

	start_assembly_generation (
			a_assembly_name, a_file_name: STRING;
			a_public_key: like public_key;
			location: STRING;
			assembly_info: ASSEMBLY_INFO;
			debug_mode: BOOLEAN)
		is
			-- Create Assembly with `name'.
		require
			a_assembly_name_not_void: a_assembly_name /= Void
			a_assembly_name_not_empty: not a_assembly_name.is_empty
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			location_not_void: location /= Void
			location_not_empty: not location.is_empty
		local
			l_assembly_flags: INTEGER
		do
			location_path := location
			assembly_name := a_assembly_name

				-- Create unicode string buffer.
			create uni_string.make_empty (1024)

				-- Name of `dll' containing all C externals.
			create c_module_name.make_from_string ("lib" + a_assembly_name + ".dll")

			create md_dispenser.make


				-- Create signature for `done' in once computation.
			create done_sig.make
			done_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

				-- Create default signature.
			create default_sig.make
			default_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			default_sig.set_parameter_count (0)
			default_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				-- Create permanent signature for feature.
			create method_sig.make
			create field_sig.make
			create local_sig.make
			create local_types.make (5)

			last_non_recorded_feature_token := 0
			create override_counter

			public_key := a_public_key
			if public_key /= Void then
				l_assembly_flags := feature {MD_ASSEMBLY_FLAGS}.public_key
			end

			is_debug_info_enabled := debug_mode

			create output_file_name.make_from_string (location)
			output_file_name.set_file_name (a_file_name)

			create main_module.make (
				a_assembly_name,
				output_file_name,
				c_module_name,
				a_public_key,
				Current,
				assembly_info,
				1,
				debug_mode,
				True -- Main assembly
				)
			current_module := main_module
			if is_console_application then
				main_module.set_console_application
			else
				main_module.set_window_application
			end

			if is_dll then
				main_module.set_dll
			end
			
			main_module.prepare (md_dispenser, type_count)

			if System.in_final_mode then
				internal_il_modules.put (main_module, 1)
			end
		ensure
			assembly_name_set: assembly_name = a_assembly_name
		end

	start_module_generation (a_module_id: INTEGER) is
			-- Create Module `name' within current assembly.
			-- In debug mode if `debug_mode' is true.
		do
			current_module := internal_il_modules.item (a_module_id)
		end

	define_entry_point
			(creation_type_id: INTEGER; a_class_type: CLASS_TYPE; a_feature_id: INTEGER)
		is
			-- Define entry point for IL component from `a_feature_id' in
			-- class `a_type_id'.
		require
			positive_creation_type_id: creation_type_id > 0
			a_class_type_not_void: a_class_type /= Void
			positive_feature_id: a_feature_id > 0
		local
			l_cur_mod: like current_module
		do
			l_cur_mod := current_module
			current_module := main_module
			current_class_type := a_class_type
			main_module.define_entry_point (creation_type_id, a_class_type, a_feature_id)
			current_module := l_cur_mod
		end

	end_assembly_generation is
			-- Finish creation of current assembly.
		local
			l_types: like class_types
			l_type: CLASS_TYPE
			l_class: CLASS_C
			i, nb: INTEGER
			l_uni_string: UNI_STRING
			l_module: IL_MODULE
			l_token, l_file_token: INTEGER
			l_hash, l_hash_res: MANAGED_POINTER
			l_result: INTEGER
			l_size: INTEGER
			l_alg_id: INTEGER
		do
			-- Do nothing
			current_module := main_module

			if not System.in_final_mode then
				from
					l_types := System.class_types
					i := l_types.lower
					nb := l_types.upper
					create l_uni_string.make_empty (0)
				until
					i > nb
				loop
					l_type := l_types.item (i)
					if l_type /= Void and then l_type.is_generated then
						l_module := il_modules (l_type)
						
						if file_token.has (l_module) then
							l_file_token := file_token.item (l_module)
						else
							create l_hash.make (1024)
							l_uni_string.set_string (l_module.module_file_name)
							l_result := feature {MD_STRONG_NAME}.get_hash_from_file (
								l_uni_string.item, $l_alg_id, l_hash.item, l_hash.count, $l_size)
								
							check
								l_result_ok: l_result = 0
							end
							
							create l_hash_res.make_from_pointer (l_hash.item, l_size)

							l_uni_string.set_string (l_module.module_name)
							l_file_token := md_emit.define_file (l_uni_string, l_hash_res)
							file_token.put (l_file_token, l_module)
						end
						
						l_uni_string.set_string (l_type.full_il_type_name)
						l_token := md_emit.define_exported_type (l_uni_string, l_file_token,
							l_type.last_type_token, feature {MD_TYPE_ATTRIBUTES}.Public)
						
						if l_type.implementation_id /= l_type.static_type_id then
							l_uni_string.set_string (l_type.full_il_implementation_type_name)
							l_token := md_emit.define_exported_type (l_uni_string, l_file_token,
								l_type.last_implementation_type_token,
								feature {MD_TYPE_ATTRIBUTES}.Public)
						end

						l_class := l_type.associated_class	
						if
							not l_class.is_deferred and
							(l_class.creators = Void or else not l_class.creators.is_empty)
						then
							l_uni_string.set_string (l_type.full_il_create_type_name)
							l_token := md_emit.define_exported_type (l_uni_string, l_file_token,
								l_type.last_create_type_token, feature {MD_TYPE_ATTRIBUTES}.Public)
						end
					end
					i := i + 1
				end
			end
			
			main_module.save_to_disk
		end

	end_module_generation (has_root_class: BOOLEAN) is
			-- Finish creation of current module.
		local
			a_class: CLASS_C
			root_feat: FEATURE_I
			l_decl_type: CL_TYPE_I
		do
			if
				not System.in_final_mode and then
				(current_module /= Void and then current_module.is_generated)
			then
					-- Mark now entry point for debug information
				if has_root_class and is_debug_info_enabled then
					a_class := system.root_class.compiled_class
					root_feat := a_class.feature_table.item (system.creation_name)
					l_decl_type := implemented_type (root_feat.origin_class_id,
						a_class.types.first.type)

					current_module.dbg_writer.set_user_entry_point (
						current_module.implementation_feature_token (
							l_decl_type.associated_class_type.static_type_id,
							root_feat.origin_feature_id))
				end
					-- Save module.
				current_module.save_to_disk
			end
		end

feature -- Generation type

	set_console_application is
			-- Current generated application is a CONSOLE application.
		do
			is_console_application := True
		end

	set_window_application is
			-- Current generated application is a WINDOW application.
		do
			is_console_application := False
		end

	set_dll is
			-- Current generated application is a DLL.
		do
			is_dll := True
		end

feature -- Generation Info

	set_version (build, major, minor, revision: INTEGER) is
			-- Assign current generated assembly with given version details.
		require
			valid_build: build >= 0
			valid_major: major >= 0
			valid_minor: minor >= 0
			valid_revision: revision >= 0
		do
			check
				not_yet_implemented: False
			end
		end

	set_verifiability (verifiable: BOOLEAN) is
			-- Mark current generation to generate verifiable code.
		do
			is_verifiable := verifiable
		ensure then
			is_verifiable_set: is_verifiable = verifiable
		end

	set_cls_compliant (cls_compliant: BOOLEAN) is
			-- Mark current generation to generate cls_compliant code.
		do
			is_cls_compliant := cls_compliant
		ensure then
			is_cls_compliant_set: is_cls_compliant = cls_compliant
		end

feature -- Class info

	initialize_class_mappings (class_count: INTEGER) is
			-- Following calls to current will only be `generate_class_mappings'.
		do
			create internal_il_modules.make (0, class_count)
			create file_token.make (10)
			create external_class_mapping.make (class_count)

			create signatures_table.make (0, class_count)
			create implementation_signatures_table.make (0, class_count)

				-- Debug data structure.
			internal_class_types := Void
		end

	generate_type_class_mappings is
			-- Create correspondance between `runtime_type_id' and ISE.Runtime.TYPE.
		do
		end

	generate_class_mappings (class_type: CLASS_TYPE) is
			-- Define all types, both external and eiffel one.
		require
			class_type_not_void: class_type /= Void
		do
			current_module.generate_class_mappings (class_type)
		end

	generate_class_interfaces (class_type: CLASS_TYPE; class_c: CLASS_C) is
			-- Initialize `class_interface' from `class_type' with info from `class_c'.
		require
			class_type_not_void: class_type /= Void
			class_c_not_void: class_c /= Void
		local
			pars: SEARCH_TABLE [CLASS_INTERFACE]
			class_interface: CLASS_INTERFACE
			parent_type: CL_TYPE_I
			parents: FIXED_LIST [CL_TYPE_A]
			l_class_type: CLASS_TYPE
			l_native_array: NATIVE_ARRAY_CLASS_TYPE
			l_type: CL_TYPE_I
		do
			l_class_type := byte_context.class_type

			l_native_array ?= class_type
			if l_native_array /= Void then
				external_class_mapping.put (class_type.type, l_native_array.il_type_name)
			elseif class_c.is_external then
				l_type := class_type.type
				if l_type.base_class.is_basic then
					l_type := l_type.base_class.actual_type.type_i
				elseif l_type.base_class.is_expanded then
					l_type := clone (l_type)
					l_type.set_is_true_expanded (True)
				end
				external_class_mapping.put (l_type, class_type.full_il_type_name)
			end

			parents := class_c.parents
			create class_interface.make_from_context (class_c.class_interface, class_type)
			create pars.make (parents.count)

			from
				parents.start
			until
				parents.after
			loop
				byte_context.set_class_type (class_type)
				parent_type ?= byte_context.real_type (parents.item.type_i)
				pars.force (parent_type.associated_class_type.class_interface)
				parents.forth
			end

			class_interface.set_parents (pars)
			class_type.set_class_interface (class_interface)

				-- Restore byte context if any.
			if l_class_type /= Void then
				byte_context.set_class_type (l_class_type)
			end
		end

	generate_class_attributes (class_type: CLASS_TYPE) is
			-- Define custom attributes of `class_type'.
		require
			class_type_not_void: class_type /= Void
		local
			l_ca_factory: CUSTOM_ATTRIBUTE_FACTORY
			l_class: CLASS_C
			l_attributes: BYTE_LIST [BYTE_NODE]
		do
			current_class_type := class_type
			l_class := class_type.associated_class
			create l_ca_factory

				-- First we generate attributes common to both generated class and interface.
			l_attributes := l_class.custom_attributes
			if l_attributes /= Void then
				l_ca_factory.generate_custom_attributes (
					class_type_token (class_type.implementation_id), class_type, l_attributes)
					-- Generate custome attribute on interface if it is generated.
				if class_type.static_type_id /= class_type.implementation_id then
					l_ca_factory.generate_custom_attributes (
						class_type_token (class_type.static_type_id), class_type, l_attributes)
				end
			end
	
				-- Then we generate only class or interface specific attribute if we indeed
				-- generate a class and an interface associated to an Eiffel class.
			if class_type.static_type_id /= class_type.implementation_id then
				l_attributes := l_class.class_custom_attributes
				if l_attributes /= Void then
					l_ca_factory.generate_custom_attributes (
						class_type_token (class_type.implementation_id), class_type, l_attributes)
				end
				l_attributes := l_class.interface_custom_attributes
				if l_attributes /= Void then
					l_ca_factory.generate_custom_attributes (
						class_type_token (class_type.static_type_id), class_type, l_attributes)
				end
			end
		end

	define_runtime_features (class_type: CLASS_TYPE) is
			-- Define all features needed by ISE .NET runtime. It generates
			-- `____class_name', `$$____type', `____set_type' and `____type'.
		require
			class_type_not_void: class_type /= Void
		local
			l_meth_token: INTEGER
			l_sig: like method_sig
			l_field_sig: like field_sig
			l_type_field_token: INTEGER
			l_class_token: INTEGER
			l_name_ca: MD_CUSTOM_ATTRIBUTE
			l_class_name: STRING
			l_meth_attr: INTEGER
		do
			l_class_token := class_type_token (class_type.implementation_id)
			l_class_name := class_type.associated_class.name_in_upper

			create l_name_ca.make
			l_name_ca.put_string (l_class_name)
			l_name_ca.put_integer_16 (0)
			define_custom_attribute (l_class_token,
				current_module.ise_eiffel_class_name_attr_ctor_token, l_name_ca)

			if is_single_inheritance_implementation then
				l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Public |
					feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					feature {MD_METHOD_ATTRIBUTES}.Virtual
			else
				l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Public |
					feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					feature {MD_METHOD_ATTRIBUTES}.Virtual |
					feature {MD_METHOD_ATTRIBUTES}.Final
			end

				-- Define `____class_name'.
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

			uni_string.set_string ("____class_name")
			l_meth_token := md_emit.define_method (uni_string,
				l_class_token, l_meth_attr, l_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

			if is_cls_compliant then
				define_custom_attribute (l_meth_token, current_module.cls_compliant_ctor_token,
					not_cls_compliant_ca)
			end

			start_new_body (l_meth_token)
			put_system_string (l_class_name)
			generate_return
			method_writer.write_current_body

			if
				not is_single_inheritance_implementation or else
				(class_type.static_type_id = any_type_id or else not
				class_type.associated_class.main_parent.simple_conform_to (System.any_class.compiled_class))
			then
				l_meth_attr := l_meth_attr | feature {MD_METHOD_ATTRIBUTES}.Final

					-- Define `$$____type'.
				l_field_sig := field_sig
				l_field_sig.reset
				l_field_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
					current_module.ise_eiffel_derivation_type_token)
				uni_string.set_string ("$$____type")
				l_type_field_token := md_emit.define_field (uni_string, l_class_token,
					feature {MD_FIELD_ATTRIBUTES}.Family, l_field_sig)

				if is_cls_compliant then
					define_custom_attribute (l_type_field_token,
						current_module.cls_compliant_ctor_token, not_cls_compliant_ca)
				end

					-- Define `____set_type'.
				l_sig.reset
				l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
				l_sig.set_parameter_count (1)
				l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
					current_module.ise_eiffel_derivation_type_token)

				uni_string.set_string ("____set_type")
				l_meth_token := md_emit.define_method (uni_string,
					l_class_token, l_meth_attr, l_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

				if is_cls_compliant then
					define_custom_attribute (l_meth_token, current_module.cls_compliant_ctor_token,
						not_cls_compliant_ca)
				end

				start_new_body (l_meth_token)
				generate_current
				generate_argument (1)
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stfld, l_type_field_token)
				generate_return
				method_writer.write_current_body

					-- Define `____type'.
				l_sig.reset
				l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
				l_sig.set_parameter_count (0)
				l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
					current_module.ise_eiffel_derivation_type_token)

				uni_string.set_string ("____type")
				l_meth_token := md_emit.define_method (uni_string,
					l_class_token, l_meth_attr, l_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

				if is_cls_compliant then
					define_custom_attribute (l_meth_token, current_module.cls_compliant_ctor_token,
						not_cls_compliant_ca)
				end

				start_new_body (l_meth_token)
				generate_current
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldfld, l_type_field_token)
				generate_return
				method_writer.write_current_body
			end
		end

feature {NONE} -- Class info

	clean_implementation_class_data is
			-- Clean current class implementation data.
		require
			current_type_id_set: current_type_id > 0
		do
			current_module.clean_implementation_class_data (current_type_id)
		end

feature -- Features info

	generate_il_features_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features description of `class_type'.
		require
			class_c_not_void: class_c /= Void
			not_external_class: not class_c.is_external
			class_type_not_void: class_type /= Void
		do
			set_current_class_type (class_type)
			set_current_class (class_c)
			set_current_type_id (class_type.static_type_id)
			current_class_token := class_type_token (current_type_id)

				-- Generate interface features on Eiffel classes
			inst_context.set_cluster (class_c.cluster)
			if not (class_c.is_frozen or class_c.is_single) then
				generate_interface_features (class_c, class_type)
			else
				generate_implementation_features (class_c, class_type)
			end
		end

	generate_interface_features (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features written in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			select_tbl: SELECT_TABLE
			features: SEARCH_TABLE [INTEGER]
			feat: FEATURE_I
		do
			is_single_class := False
			from
				select_tbl := class_c.feature_table.origin_table
				features := class_type.class_interface.features
				features.start
			until
				features.after
			loop
				feat := select_tbl.item (features.item_for_iteration)
				generate_feature (feat, True, False, False)
				features.forth
			end

				-- Generate type features for formal generic parameters.
			if class_c.generic_features /= Void then
				generate_type_features (class_c.generic_features, class_c.class_id)
			end

				-- Generate type features for feature used as anchor.
			if class_c.anchored_features /= Void then
				generate_type_features (class_c.anchored_features, class_c.class_id)
			end
		end

	generate_implementation_features (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features written in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			class_c_is_single: class_c.is_frozen or class_c.is_single
		local
			select_tbl: SELECT_TABLE
			features: SEARCH_TABLE [INTEGER]
			feat: FEATURE_I
		do
			is_single_class := True
			from
				select_tbl := class_c.feature_table.origin_table
				features := class_type.class_interface.features
				features.start
			until
				features.after
			loop
				feat := select_tbl.item (features.item_for_iteration)
				generate_feature (feat, False, False, False)
				features.forth
			end
			is_single_class := False
		end

	define_feature_reference (a_type_id, a_feature_id: INTEGER;
			in_interface, is_static, is_override: BOOLEAN)
		is
			-- Define reference to feature `a_feature_id' defined in `a_type_id'.
		require
			type_id_valid: a_type_id > 0
			feature_id_valid: a_feature_id > 0
		local
			l_feat: FEATURE_I
			l_class_type: CLASS_TYPE
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_name: STRING
			l_feat_arg: FEAT_ARG
			l_type_i: TYPE_I
			l_meth_token, l_setter_token: INTEGER
			l_parameter_count: INTEGER
			l_is_attribute: BOOLEAN
			l_return_type: TYPE_I
			i: INTEGER
			l_signature: ARRAY [INTEGER]
			l_is_c_external: BOOLEAN
			l_class_token: like current_class_token
			l_ext: IL_EXTENSION_I
			l_naming_convention: BOOLEAN
			l_is_single_class: BOOLEAN
		do
			l_class_type := class_types.item (a_type_id)
			l_class_token := class_type_token (a_type_id)
			l_feat := l_class_type.associated_class.feature_of_feature_id (a_feature_id)
			l_is_single_class := l_class_type.associated_class.is_frozen or
				l_class_type.associated_class.is_single or
				l_class_type.associated_class.is_external

			byte_context.set_class_type (l_class_type)

--			if l_feat.is_il_external then
--				define_external_feature_reference (l_feat, a_type_id)
--			elseif l_feat.feature_name_id /= Names_heap.void_name_id then
			if l_feat.feature_name_id /= Names_heap.void_name_id then
				l_is_attribute := l_feat.is_attribute
				l_is_c_external := l_feat.is_c_external
				l_parameter_count := l_feat.argument_count

				create l_signature.make (0, l_parameter_count)
				l_signature.compare_references

				l_return_type := argument_actual_type (l_feat.type.actual_type.type_i)
				if (l_is_single_class or (not in_interface and is_static)) and l_is_attribute then
					l_field_sig := field_sig
					l_field_sig.reset
					set_signature_type (l_field_sig, l_return_type)
					l_signature.put (l_return_type.static_type_id, 0)
				else
					l_meth_sig := method_sig
					l_meth_sig.reset
					if is_static and not in_interface then
						l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
					else
						l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
					end

					if is_static and not l_is_c_external then
						l_meth_sig.set_parameter_count (l_parameter_count + 1)
					else
						l_meth_sig.set_parameter_count (l_parameter_count)
					end

					if l_feat.is_function or l_is_attribute or l_feat.is_constant then
						set_method_return_type (l_meth_sig, l_return_type)
						l_signature.put (l_return_type.static_type_id, 0)
					elseif l_feat.is_type_feature then
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
							current_module.ise_type_token)
					else
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
					end

					if is_static and not l_is_c_external then
						set_signature_type (l_meth_sig, l_class_type.type)
					end

					if l_feat.has_arguments then
						from
							l_feat_arg := l_feat.arguments
							l_feat_arg.start
							i := 0
						until
							l_feat_arg.after
						loop
							l_type_i := argument_actual_type (l_feat_arg.item.actual_type.type_i)
							set_signature_type (l_meth_sig, l_type_i)
							l_signature.put (l_type_i.static_type_id, i + 1)
							i := i + 1
							l_feat_arg.forth
						end
					end
				end

				if not l_feat.is_type_feature then
						-- Only for not automatically generated feature do we use the 
						-- naming convention chosen by user.
					l_naming_convention := l_class_type.is_dotnet_name
				end

					-- When we are handling with an external feature, we have to extract its
					-- real name, not the Eiffel one.
				l_ext ?= l_feat.extension
				if l_ext /= Void then
					l_name := l_ext.alias_name
				else
					if l_feat.is_type_feature then
						l_name := l_feat.feature_name
					else
						if is_static then
							if l_is_c_external then
								l_name := encoder.feature_name (l_class_type.static_type_id,
									l_feat.body_index)
							else
								if l_is_attribute then
									l_name := "$$" + il_casing.camel_casing (
										l_naming_convention, l_feat.feature_name)
								else
									l_name := "$$" + il_casing.pascal_casing (
										l_naming_convention, l_feat.feature_name,
										feature {IL_CASING_CONVERSION}.lower_case)
								end
							end
						else
							l_name := il_casing.pascal_casing (
								l_naming_convention, l_feat.feature_name, 
								feature {IL_CASING_CONVERSION}.lower_case)
						end
					end
				end

				uni_string.set_string (l_name)

				if (l_is_single_class or (not in_interface and is_static)) and l_is_attribute then
					l_meth_token := md_emit.define_member_ref (uni_string, l_class_token,
						l_field_sig)

					insert_attribute (l_meth_token, a_type_id, l_feat.feature_id)
				else
						-- Normal method
					l_meth_token := md_emit.define_member_ref (uni_string, l_class_token,
						l_meth_sig)

					if not is_static and l_is_attribute and not is_override then
							-- Let's define attribute setter.
						l_meth_sig.reset
						l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
						l_meth_sig.set_parameter_count (1)
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
						set_signature_type (l_meth_sig, l_return_type)
						uni_string.set_string (setter_prefix + l_name)
						l_setter_token := md_emit.define_member_ref (uni_string,
							l_class_token, l_meth_sig)

						insert_setter (l_setter_token, a_type_id, l_feat.feature_id)
					end

					if not is_override then
						if l_is_single_class then
							insert_implementation_feature (l_meth_token, a_type_id,
								l_feat.feature_id)
							insert_implementation_signature (l_signature, a_type_id,
								l_feat.feature_id)
							insert_feature (l_meth_token, a_type_id, l_feat.feature_id)
							insert_signature (l_signature, a_type_id, l_feat.feature_id)
						else
							if is_static then
								insert_implementation_feature (l_meth_token, a_type_id,
									l_feat.feature_id)
								insert_implementation_signature (l_signature, a_type_id,
									l_feat.feature_id)
							else
								insert_feature (l_meth_token, a_type_id, l_feat.feature_id)
								insert_signature (l_signature, a_type_id, l_feat.feature_id)
							end
						end
					else
						last_non_recorded_feature_token := l_meth_token
					end
				end
			end

				-- Restore context.
			byte_context.set_class_type (current_class_type)
		end

	define_external_feature_reference (a_feat: FEATURE_I; a_type_id: INTEGER) is
			-- Define reference to external feature `a_feat' defined in `a_type_id'.
		require
			a_feat_not_void: a_feat /= Void
			a_feat_is_il_external: a_feat.is_il_external
		local
			l_ext: IL_EXTENSION_I
			l_signature: like last_external_signature
			l_token: INTEGER
		do
			l_ext ?= a_feat.extension
			check
				l_ext_not_void: l_ext /= Void
			end
			l_token := l_ext.token
			l_signature := last_external_signature

			insert_implementation_feature (l_token, a_type_id, a_feat.feature_id)
			insert_implementation_signature (l_signature, a_type_id, a_feat.feature_id)
			insert_feature (l_token, a_type_id, a_feat.feature_id)
			insert_signature (l_signature, a_type_id, a_feat.feature_id)
		end
	
	generate_feature (feat: FEATURE_I; in_interface, is_static, is_override_or_c_external: BOOLEAN) is
			-- Generate interface `feat' description.
		require
			feat_not_void: feat /= Void
		do
			implementation_generate_feature (feat, in_interface, is_static, is_override_or_c_external, False)
		end

	implementation_generate_feature (
			feat: FEATURE_I; in_interface, is_static, is_override_or_c_external, is_empty: BOOLEAN)
		is
			-- Generate interface `feat' description.
		require
			feat_not_void: feat /= Void
		local
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_name: STRING
			l_feat_arg: FEAT_ARG
			l_type_i: TYPE_I
			l_meth_token, l_setter_token: INTEGER
			l_param_token: INTEGER
			l_meth_attr: INTEGER
			l_field_attr: INTEGER
			l_parameter_count: INTEGER
			l_is_attribute: BOOLEAN
			l_return_type: TYPE_I
			l_has_arguments: BOOLEAN
			i, j: INTEGER
			l_signature: ARRAY [INTEGER]
			l_is_c_external: BOOLEAN
			l_ca_factory: CUSTOM_ATTRIBUTE_FACTORY
			l_naming_convention: BOOLEAN
		do
			if feat.feature_name_id /= Names_heap.void_name_id then
				l_is_attribute := feat.is_attribute
				l_is_c_external := feat.is_c_external
				l_parameter_count := feat.argument_count

				create l_signature.make (0, l_parameter_count)
				l_signature.compare_references

				l_return_type := argument_actual_type (feat.type.actual_type.type_i)
				if (is_single_class or (not in_interface and is_static)) and l_is_attribute then
					l_field_sig := field_sig
					l_field_sig.reset
					set_signature_type (l_field_sig, l_return_type)
					l_signature.put (l_return_type.static_type_id, 0)
				else
					l_meth_sig := method_sig
					l_meth_sig.reset
					if is_static and not in_interface then
						l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
					else
						l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
					end

					if is_static and not l_is_c_external then
						l_meth_sig.set_parameter_count (l_parameter_count + 1)
					else
						l_meth_sig.set_parameter_count (l_parameter_count)
					end

					if feat.is_function or l_is_attribute or feat.is_constant then
						set_method_return_type (l_meth_sig, l_return_type)
						l_signature.put (l_return_type.static_type_id, 0)
					elseif feat.is_type_feature then
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
							current_module.ise_type_token)
					else
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
					end

					if is_static and not l_is_c_external then
						set_signature_type (l_meth_sig, current_class_type.type)
					end

					if feat.has_arguments then
						l_has_arguments := True
						from
							l_feat_arg := feat.arguments
							l_feat_arg.start
							i := 0
						until
							l_feat_arg.after
						loop
							l_type_i := argument_actual_type (l_feat_arg.item.actual_type.type_i)
							set_signature_type (l_meth_sig, l_type_i)
							l_signature.put (l_type_i.static_type_id, i + 1)
							i := i + 1
							l_feat_arg.forth
						end
					end
				end

				if not feat.is_type_feature then
						-- Only for not automatically generated feature do we use the 
						-- naming convention chosen by user.
					l_naming_convention := System.dotnet_naming_convention
				end
				if is_static then
					if l_is_c_external then
						l_name := encoder.feature_name (current_class_type.static_type_id,
							feat.body_index)
					else
						if l_is_attribute then
							l_name := "$$" + il_casing.camel_casing (
								l_naming_convention, feat.feature_name)
						else
							l_name := "$$" + il_casing.pascal_casing (
								l_naming_convention, feat.feature_name,
								feature {IL_CASING_CONVERSION}.lower_case)
						end
					end
				else
					l_name := il_casing.pascal_casing (
						l_naming_convention, feat.feature_name, 
						feature {IL_CASING_CONVERSION}.lower_case)
				end

				uni_string.set_string (l_name)

				if (is_single_class or (not in_interface and is_static)) and l_is_attribute then
					l_field_attr := feature {MD_FIELD_ATTRIBUTES}.Public

					l_meth_token := md_emit.define_field (uni_string, current_class_token,
						l_field_attr, l_field_sig)

					insert_attribute (l_meth_token, current_type_id, feat.feature_id)
				else
					l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Public |
						feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature

					if in_interface then
						l_meth_attr := l_meth_attr | feature {MD_METHOD_ATTRIBUTES}.Virtual |
							feature {MD_METHOD_ATTRIBUTES}.Abstract |
							feature {MD_METHOD_ATTRIBUTES}.New_slot
					else
						if is_static then
							l_meth_attr := l_meth_attr | feature {MD_METHOD_ATTRIBUTES}.Static
						else
							l_meth_attr := l_meth_attr | feature {MD_METHOD_ATTRIBUTES}.Virtual
							if feat.is_origin then
								l_meth_attr := l_meth_attr | feature {MD_METHOD_ATTRIBUTES}.New_slot
							end
							if feat.is_deferred and not is_empty and not is_override_or_c_external then
								l_meth_attr := l_meth_attr |
									feature {MD_METHOD_ATTRIBUTES}.Abstract
							end
						end
					end

					if is_static and l_is_c_external then
							-- Let's define Pinvoke here.
						l_meth_token := md_emit.define_method (uni_string, current_class_token,
							l_meth_attr, l_meth_sig, feature {MD_METHOD_ATTRIBUTES}.Managed |
							feature {MD_METHOD_ATTRIBUTES}.Preserve_sig)
						md_emit.define_pinvoke_map (l_meth_token,
							feature {MD_PINVOKE_CONSTANTS}.Charset_ansi |
							feature {MD_PINVOKE_CONSTANTS}.Stdcall, uni_string,
							current_module.c_module_token)
					else
							-- Normal method
						l_meth_token := md_emit.define_method (uni_string, current_class_token,
							l_meth_attr, l_meth_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)
					end

					if is_cls_compliant and (is_static or feat.is_type_feature) then
						define_custom_attribute (l_meth_token,
							current_module.cls_compliant_ctor_token, not_cls_compliant_ca)
					end

					if not is_static and l_is_attribute and not is_override_or_c_external then
							-- Let's define attribute setter.
						if in_interface then
							l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Public |
								feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature |
								feature {MD_METHOD_ATTRIBUTES}.Virtual |
								feature {MD_METHOD_ATTRIBUTES}.Abstract
						else
							l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Public |
								feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature |
								feature {MD_METHOD_ATTRIBUTES}.Virtual
						end

						l_meth_sig.reset
						l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
						l_meth_sig.set_parameter_count (1)
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
						set_signature_type (l_meth_sig, l_return_type)
						uni_string.set_string (setter_prefix + l_name)
						l_setter_token := md_emit.define_method (uni_string, current_class_token,
							l_meth_attr, l_meth_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

						insert_setter (l_setter_token, current_type_id, feat.feature_id)

						if is_cls_compliant then
							define_custom_attribute (l_setter_token,
								current_module.cls_compliant_ctor_token, not_cls_compliant_ca)
						end
					end

						-- Let's generate argument names now.
					if is_static and not l_is_c_external then
							-- Offset for static features as we generate one more argument.
						j := 1
							-- Current needs to be generated only for static wrapper of Eiffel
							-- feature so that metadata consumer can pick the name (e.g. debugger)
							-- but it is not needed when it is defined as an instance method.
						uni_string.set_string ("Current")
						l_param_token := md_emit.define_parameter (l_meth_token, uni_string, j,
							feature {MD_PARAM_ATTRIBUTES}.In)
					end

					if l_has_arguments then
						from
							l_feat_arg := feat.arguments
							i := 1
						until
							i > l_parameter_count
						loop
							uni_string.set_string (l_feat_arg.item_name (i))
							l_param_token := md_emit.define_parameter (l_meth_token, uni_string,
								i + j, feature {MD_PARAM_ATTRIBUTES}.In)
							i := i + 1
						end
					end

					if not is_override_or_c_external then
						if is_single_class then
							insert_implementation_feature (l_meth_token, current_type_id,
								feat.feature_id)
							insert_implementation_signature (l_signature, current_type_id,
								feat.feature_id)
							insert_feature (l_meth_token, current_type_id, feat.feature_id)
							insert_signature (l_signature, current_type_id, feat.feature_id)
						else
							if is_static then
								insert_implementation_feature (l_meth_token, current_type_id,
									feat.feature_id)
								insert_implementation_signature (l_signature, current_type_id,
									feat.feature_id)
							else
								insert_feature (l_meth_token, current_type_id, feat.feature_id)
								insert_signature (l_signature, current_type_id, feat.feature_id)
							end
						end
					else
						last_non_recorded_feature_token := l_meth_token
					end
				end
				if not is_override_or_c_external and (not is_static or else l_is_attribute) then
					create l_ca_factory
					l_ca_factory.set_feature_custom_attributes (feat, l_meth_token)
				end
			end
		end

	argument_actual_type (a_type: TYPE_I): TYPE_I is
			-- Compute real type of Current in current generated class.
		require
			a_type_not_void: a_type /= Void
		do
			if not a_type.has_formal then
				if not a_type.is_none then
					Result := a_type
				end
			else
				Result := byte_context.real_type (a_type)
			end
		ensure
			valid_result: Result /= Void
		end

	set_method_return_type (a_sig: MD_METHOD_SIGNATURE; a_type: TYPE_I) is
			-- Set `a_type' to return type of `a_sig'.
		require
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		do
			current_module.set_method_return_type (a_sig, a_type)
		end

	set_signature_type (a_sig: MD_SIGNATURE; a_type: TYPE_I) is
			-- Set `a_type' to return type of `a_sig'.
		require
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		do
			current_module.set_signature_type (a_sig, a_type)
		end

	generate_type_features (feats: HASH_TABLE [TYPE_FEATURE_I, INTEGER]; class_id: INTEGER) is
			-- Generate all TYPE_FEATURE_I that must be generated in
			-- interface corresponding to class ID `class_id'.
		require
			feats_not_void: feats /= Void
		local
			l_type_feature: TYPE_FEATURE_I
		do
			from
				feats.start
			until
				feats.after
			loop
				l_type_feature := feats.item_for_iteration
				if l_type_feature.origin_class_id = class_id then
					generate_feature (l_type_feature, True, False, False)
				end
				feats.forth
			end
		end

feature -- IL Generation

	generate_creation_procedures (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for creation procedures in `class_c'.
		require
			class_c_not_void: class_c /= Void
			not_external_class: not class_c.is_external
			class_type_not_void: class_type /= Void
		local
			create_name: STRING
			l_attributes: INTEGER
			l_creators: HASH_TABLE [EXPORT_I, STRING]
			l_feat_tbl: FEATURE_TABLE
			l_feat: FEATURE_I
			l_type_token: INTEGER
			l_is_generic: BOOLEAN
		do
			l_creators := class_c.creators

				-- Let's define factory class if needed, i.e.:
				-- 1 - class is not deferred
				-- 2 - class has exported creation procedure
				-- 3 - class has automatic `default_create' procedure
			if not class_c.is_deferred and (l_creators = Void or else not l_creators.is_empty) then
				l_is_generic := class_c.is_generic
				create_name := class_type.full_il_create_type_name
				l_attributes := feature {MD_TYPE_ATTRIBUTES}.Public |
					feature {MD_TYPE_ATTRIBUTES}.Auto_layout |
					feature {MD_TYPE_ATTRIBUTES}.Ansi_class |
					feature {MD_TYPE_ATTRIBUTES}.Is_class
				uni_string.set_string (create_name)
				l_type_token := md_emit.define_type (uni_string, l_attributes,
					current_module.object_type_token, Void)

				class_type.set_last_create_type_token (l_type_token)

				current_class_token := l_type_token
				current_class_type := class_type

				if l_creators = Void then
					l_feat := class_c.default_create_feature
						-- It is not guaranteed that a class defines `default_create', e.g.
						-- a class that does not inherit from ANY.
					if l_feat /= Void then
						generate_creation_procedure (class_c, class_type, l_feat, l_is_generic)
					end
				else
					from
						l_creators.start
						l_feat_tbl := class_c.feature_table
					until
						l_creators.after
					loop
						l_feat := l_feat_tbl.item (l_creators.key_for_iteration)
						generate_creation_procedure (class_c, class_type, l_feat, l_is_generic)
						l_creators.forth
					end
				end
			end
		end

	generate_creation_procedure (class_c: CLASS_C; class_type: CLASS_TYPE; feat: FEATURE_I; is_generic: BOOLEAN) is
			-- Generate IL code for creation procedures in `class_c'.
		require
			class_c_not_void: class_c /= Void
			not_external_class: not class_c.is_external
			class_type_not_void: class_type /= Void
			feat_not_void: feat /= Void
			feat_not_attribute: not feat.is_attribute
			feat_not_function: not feat.is_function
			feat_not_deferred: not feat.is_deferred
			feat_not_constant: not feat.is_constant
			feat_not_type_feature: not feat.is_type_feature
		local
			l_meth_sig: like method_sig
			l_name: STRING
			l_feat_arg: FEAT_ARG
			l_type_i: TYPE_I
			l_meth_token, l_eiffel_meth_token, l_meth_attr: INTEGER
			i, nb: INTEGER
		do
			if feat.feature_name_id /= Names_heap.void_name_id then
				nb := feat.argument_count
				l_meth_sig := method_sig
				l_meth_sig.reset
				l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
				if is_generic then
					l_meth_sig.set_parameter_count (nb + 1)
				else
					l_meth_sig.set_parameter_count (nb)
				end
				set_method_return_type (l_meth_sig, current_class_type.type)

				if nb > 0 then
					from
						l_feat_arg := feat.arguments
						l_feat_arg.start
					until
						l_feat_arg.after
					loop
						l_type_i := argument_actual_type (l_feat_arg.item.actual_type.type_i)
						set_signature_type (l_meth_sig, l_type_i)
						l_feat_arg.forth
					end
				end
				if is_generic then
					l_meth_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
						current_module.ise_eiffel_derivation_type_token)
				end

				l_name := il_casing.pascal_casing (System.dotnet_naming_convention,
					feat.feature_name, feature {IL_CASING_CONVERSION}.lower_case)

				uni_string.set_string (l_name)

				l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Public |
					feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					feature {MD_METHOD_ATTRIBUTES}.Static

					-- Normal method
				l_meth_token := md_emit.define_method (uni_string, current_class_token,
					l_meth_attr, l_meth_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

				l_eiffel_meth_token := feature_token (
					implemented_type (feat.origin_class_id, current_class_type.type).static_type_id,
					feat.origin_feature_id)

				start_new_body (l_meth_token)
				create_object (current_class_type.implementation_id)
				if is_generic then
					duplicate_top
					generate_argument (nb)
					method_body.put_call (feature {MD_OPCODES}.callvirt,
						current_module.ise_set_type_token, 1, False)
				end
				duplicate_top
				if nb > 0 then
					from
					until
						i >= nb
					loop
						generate_argument (i)
						i := i + 1
					end
				end
				method_body.put_call (feature {MD_OPCODES}.callvirt, l_eiffel_meth_token, nb, False)
				method_body.put_opcode (feature {MD_OPCODES}.ret)
				method_writer.write_current_body					
			end
		end

	generate_il_implementation (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for feature in `class_c'.
		require
			class_c_not_void: class_c /= Void
			not_external_class: not class_c.is_external
			class_type_not_void: class_type /= Void
		deferred
		end

	generate_empty_body (a_feat: FEATURE_I) is
			-- Generate a valid empty body for `a_feat' in `current_type_id'.
		require
			feature_not_void: a_feat /= Void
		local
			l_meth_token: INTEGER
			l_type: TYPE_I
		do
			l_meth_token := feature_token (current_type_id, a_feat.feature_id)
			start_new_body (l_meth_token)
			l_type := argument_actual_type (a_feat.type.actual_type.type_i)
			if not l_type.is_void then
				put_default_value (l_type)
			end
			method_body.put_opcode (feature {MD_OPCODES}.Ret)
			method_writer.write_current_body
		end

	generate_feature_il (feat: FEATURE_I; a_type_id, code_feature_id: INTEGER) is
			-- Specifies for which feature `feat' of `feat.feature_id' written in class of
			-- `a_type_id' IL code will be generated. If `a_type_id' is different from current
			-- type id, it means that `a_feature_id' is simply a delegation to a call on
			-- `code_feature_id' defined in `a_type_id': call to static version of feature if
			-- not `imp_inherited'.
		require
			feature_not_void: feat /= Void
			positive_type_id: a_type_id > 0
			positive_code_feature_id: code_feature_id > 0
		local
			l_token: INTEGER
			l_meth_token: INTEGER
			l_cur_sig: ARRAY [INTEGER]
			l_impl_sig: ARRAY [INTEGER]
			i, nb: INTEGER
			l_is_external: BOOLEAN
			l_sequence_point: like sequence_point
			l_sequence_point_list: LIST [like sequence_point]
			l_class_type: CLASS_TYPE
		do
			l_meth_token := feature_token (current_type_id, feat.feature_id)

			if feat.is_attribute then
				l_token := attribute_token (a_type_id, code_feature_id)
				start_new_body (l_meth_token)
				generate_current
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldfld, l_token)
				method_body.put_opcode (feature {MD_OPCODES}.Ret)
				method_writer.write_current_body

				l_meth_token := setter_token (current_type_id, feat.feature_id)
				start_new_body (l_meth_token)
				generate_current
				generate_argument (1)
				generate_check_cast (Void, argument_actual_type (feat.type.actual_type.type_i))
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stfld, l_token)
				method_body.put_opcode (feature {MD_OPCODES}.Ret)
				method_writer.write_current_body
			else
				l_token := implementation_feature_token (a_type_id, code_feature_id)
				l_cur_sig := signatures (current_type_id, feat.feature_id)
				l_impl_sig := implementation_signatures (a_type_id, code_feature_id)

				l_is_external := feat.is_external or feat.is_il_external

				l_class_type := class_types.item (a_type_id)

				if
					not l_is_external and then not l_class_type.is_precompiled and then
					il_modules (current_class_type) = il_modules (l_class_type) and then
					(l_cur_sig = Void or else l_cur_sig.is_equal (l_impl_sig))
				then
					if is_debug_info_enabled then
						dbg_writer.open_method (l_meth_token)
						l_sequence_point_list :=
							current_module.method_sequence_points.item (l_token)
						from
							l_sequence_point_list.start
						until
							l_sequence_point_list.after
						loop
							l_sequence_point := l_sequence_point_list.item
							dbg_offsets_count := l_sequence_point.integer_item (1)
							dbg_offsets ?= l_sequence_point.item (2)
							dbg_start_lines ?= l_sequence_point.item (3)
							dbg_start_columns ?= l_sequence_point.item (4)
							dbg_end_lines ?= l_sequence_point.item (5)
							dbg_end_columns ?= l_sequence_point.item (6)
							dbg_writer.define_sequence_points (
								dbg_documents (l_sequence_point.integer_item (7)),
								dbg_offsets_count, dbg_offsets, dbg_start_lines, dbg_start_columns,
								dbg_end_lines, dbg_end_columns)
							l_sequence_point_list.forth
						end
						generate_local_debug_info (l_token)
						dbg_writer.close_method
					end
					method_writer.write_duplicate_body (l_token, l_meth_token)
				else
					if is_debug_info_enabled then
							-- Enable debugger to go through stub definition.
						define_custom_attribute (l_meth_token,
							current_module.debugger_step_through_ctor_token,
							debugger_step_through_ca)
						define_custom_attribute (l_meth_token,
							current_module.debugger_hidden_ctor_token, debugger_hidden_ca)
					end

					start_new_body (l_meth_token)
					if not feat.is_c_external then
						generate_current
					end
					from
						i := 1
						nb := feat.argument_count
					until
						i > nb
					loop
						generate_argument (i)
						if is_verifiable and l_cur_sig.item (i) /= l_impl_sig.item (i) then
							method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Castclass,
								class_type_token (l_impl_sig.item (i)))
						end
						i := i + 1
					end
					method_body.put_call (feature {MD_OPCODES}.Call, l_token,
						nb, feat.has_return_value)
					if feat.has_return_value then
						if is_verifiable and l_cur_sig.item (0) /= l_impl_sig.item (0) then
							method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Castclass,
								class_type_token (l_cur_sig.item (0)))
						end
					end
					generate_return
					method_writer.write_current_body
				end
			end
		end

	generate_external_il (feat: FEATURE_I) is
			-- Generate call to external feature `feat'. Its token is `last_non_recorded_feature_token'.
		require
			feature_not_void: feat /= Void
			feature_is_c_external: feat.is_c_external
		local
			l_token: INTEGER
			l_meth_token: INTEGER
			i, nb: INTEGER
		do
			l_token := last_non_recorded_feature_token
			l_meth_token := feature_token (current_type_id, feat.feature_id)

			if is_debug_info_enabled then
					-- Enable debugger to go through stub definition.
				define_custom_attribute (l_meth_token,
					current_module.debugger_step_through_ctor_token, debugger_step_through_ca)
				define_custom_attribute (l_meth_token, current_module.debugger_hidden_ctor_token,
					debugger_hidden_ca)
			end

			start_new_body (l_meth_token)
			from
				i := 1
				nb := feat.argument_count
			until
				i > nb
			loop
				generate_argument (i)
				i := i + 1
			end
			method_body.put_call (feature {MD_OPCODES}.Call, l_token, nb, feat.has_return_value)
			generate_return
			method_writer.write_current_body
		end

	generate_feature_code (feat: FEATURE_I) is
			-- Generate IL code for feature `feat'.
		require
			feat_not_void: feat /= Void
		local
			l_meth_token: INTEGER
			l_sequence_point_list: LINKED_LIST [like sequence_point]
		do
			if not feat.is_attribute and not feat.is_c_external and not feat.is_deferred then
				l_meth_token := implementation_feature_token (current_type_id, feat.feature_id)
				current_feature_token := l_meth_token
				start_new_body (l_meth_token)


				if is_debug_info_enabled then
					dbg_writer.open_method (l_meth_token)
					local_start_offset := method_body.count
					create dbg_offsets.make (0, 5)
					create dbg_start_lines.make (0, 5)
					create dbg_start_columns.make (0, 5)
					create dbg_end_lines.make (0, 5)
					create dbg_end_columns.make (0, 5)
					dbg_offsets_count := 0
				end

				current_class_type.generate_il_feature (feat)
				local_end_offset := method_body.count
				store_locals (l_meth_token)
				method_writer.write_current_body

				if is_debug_info_enabled then
					generate_local_debug_info (l_meth_token)
					dbg_writer.define_sequence_points (
						dbg_documents (current_class.class_id),
						dbg_offsets_count, dbg_offsets, dbg_start_lines, dbg_start_columns,
						dbg_end_lines, dbg_end_columns)
					dbg_writer.close_method
					l_sequence_point_list :=
						current_module.method_sequence_points.item (l_meth_token)
					if l_sequence_point_list = Void then
						create l_sequence_point_list.make
						current_module.method_sequence_points.put (l_sequence_point_list,
							l_meth_token)
					end
					l_sequence_point_list.extend ([dbg_offsets_count, dbg_offsets, dbg_start_lines,
						dbg_start_columns, dbg_end_lines, dbg_end_columns, feat.written_in])
				end
			end
		end

	generate_feature_standard_twin (feat: FEATURE_I) is
			-- Generate IL code for feature `standard_twin' from ANY.
		require
			feat_not_void: feat /= Void
		local
			l_meth_token: INTEGER
		do
			l_meth_token := feature_token (current_type_id, feat.feature_id)
			start_new_body (l_meth_token)
			generate_current
			method_body.put_call (feature {MD_OPCODES}.Call, current_module.memberwise_clone_token,
				0, True)
			generate_check_cast (Void, current_class_type.type)
			generate_return
			method_writer.write_current_body
		end

	generate_object_equality_test is
			-- Generate comparison of two objects.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name,
				"standard_equal", Static_type, <<type_info_class_name, type_info_class_name>>,
				"System.Boolean", False)
		end

	start_new_body (method_token: INTEGER) is
			-- Start a new body definition for method `method_token'.
		require
			valid_method_token: method_token /= 0
		do
			method_body := method_writer.new_method_body (method_token)
			result_position := -1
		ensure
			method_body_set: method_body /= Void
		end

	last_external_signature: ARRAY [INTEGER]
			-- Signature of last external processed through `external_token'.

	last_non_recorded_feature_token: INTEGER
			-- Token of last defined feature that we did not record or last override.

	override_counter: COUNTER
			-- Number of generated override methods.

	is_method_impl_needed (feat, inh_feat: FEATURE_I; class_type: CLASS_TYPE): BOOLEAN is
			-- Is a MethodImpl needed between `inh_feat' and `feat'?
		require
			feat_not_void: feat /= Void
			inh_feat_not_void: inh_feat /= Void
			class_type_not_void: class_type /= Void
		local
			l_ext: IL_EXTENSION_I
			l_naming_convention: BOOLEAN
		do
			l_naming_convention := System.dotnet_naming_convention
			if l_naming_convention /= class_type.is_dotnet_name then
				l_ext ?= inh_feat.extension
				if l_ext /= Void then
 					Result := not il_casing.pascal_casing (l_naming_convention,
						feat.feature_name,
 						feature {IL_CASING_CONVERSION}.lower_case).is_equal (l_ext.alias_name)
				else
					Result := not il_casing.pascal_casing (l_naming_convention,
							feat.feature_name, feature {IL_CASING_CONVERSION}.lower_case).is_equal (
						il_casing.pascal_casing (class_type.is_dotnet_name,
							inh_feat.feature_name, feature {IL_CASING_CONVERSION}.lower_case))
				end
			else
				Result := feat.feature_name_id /= inh_feat.feature_name_id
	 			if not Result then
	 				l_ext ?= inh_feat.extension
	 				if l_ext /= Void then
	 					Result := not il_casing.pascal_casing (System.dotnet_naming_convention,
							feat.feature_name,
	 						feature {IL_CASING_CONVERSION}.lower_case).is_equal (l_ext.alias_name)
	 				end
	 			end
			end
		end

	generate_method_impl (cur_feat: FEATURE_I; parent_type: CLASS_TYPE; inh_feat: FEATURE_I) is
			-- Generate a MethodImpl from `parent_type' and `inh_feat'
			-- to `current_class_type' and `cur_feat'.
		require
			cur_feat_not_void: cur_feat /= Void
			cur_feat_not_il_external: not cur_feat.is_il_external
			parent_type_not_void: parent_type /= Void
			inh_feat_not_void: inh_feat /= Void
		local
			l_cur_sig: ARRAY [INTEGER]
			l_inh_sig: ARRAY [INTEGER]
			l_same_signature: BOOLEAN
			l_setter_token: INTEGER
			i, nb: INTEGER
			l_name_id: INTEGER
			l_meth_attr: INTEGER
			l_meth_sig: MD_METHOD_SIGNATURE
			l_parent_type_id: INTEGER
			l_name: STRING
			l_return_type: TYPE_I
			l_token: like last_non_recorded_feature_token
		do
			l_parent_type_id := parent_type.static_type_id
			l_cur_sig := signatures (current_type_id, cur_feat.feature_id)
			l_inh_sig := signatures (l_parent_type_id, inh_feat.feature_id)

			l_same_signature := l_cur_sig.is_equal (l_inh_sig)

			if l_same_signature then
				md_emit.define_method_impl (current_class_token, feature_token (current_type_id,
					cur_feat.feature_id), feature_token (l_parent_type_id, inh_feat.feature_id))

				if cur_feat.is_attribute and then inh_feat.is_attribute then
					md_emit.define_method_impl (current_class_token, setter_token (current_type_id,
						cur_feat.feature_id), setter_token (l_parent_type_id, inh_feat.feature_id))
				end
			else
				l_name_id := inh_feat.feature_name_id
				l_name := inh_feat.feature_name
				inh_feat.set_feature_name (Override_prefix + l_name + override_counter.next.out)

					-- We have to generate body of `inh_feat' in context of
					-- `parent_type' in order to correctly evaluate its
					-- signature in current context.
				Byte_context.set_class_type (parent_type)
				generate_feature (inh_feat, False, False, True)
				l_return_type := argument_actual_type (inh_feat.type.actual_type.type_i)
				Byte_context.set_class_type (current_class_type)

					-- We need to restore the name right away.
				inh_feat.set_feature_name_id (l_name_id)

				l_token := last_non_recorded_feature_token
				start_new_body (l_token)
				generate_current
				from
					i := 1
					nb := cur_feat.argument_count
				until
					i > nb
				loop
					generate_argument (i)
					if is_verifiable and l_cur_sig.item (i) /= l_inh_sig.item (i) then
						method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Castclass,
							class_type_token (l_cur_sig.item (i)))
					end
					i := i + 1
				end
				method_body.put_call (feature {MD_OPCODES}.Callvirt, feature_token (current_type_id,
					cur_feat.feature_id), nb, cur_feat.has_return_value)

				if cur_feat.has_return_value then
					if is_verifiable and l_cur_sig.item (0) /= l_inh_sig.item (0) then
						method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Castclass,
							class_type_token (l_inh_sig.item (0)))
					end
				end
				generate_return
				method_writer.write_current_body

				md_emit.define_method_impl (current_class_token, l_token,
					feature_token (l_parent_type_id, inh_feat.feature_id))

				if cur_feat.is_attribute and then inh_feat.is_attribute then
					l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Virtual |
						feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature |
						feature {MD_METHOD_ATTRIBUTES}.Private

					l_meth_sig := method_sig
					l_meth_sig.reset
					l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
					l_meth_sig.set_parameter_count (1)
					l_meth_sig.set_return_type (
						feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

					set_signature_type (l_meth_sig, l_return_type)

					uni_string.set_string (Override_prefix + setter_prefix + l_name +
						override_counter.next.out)

					l_setter_token := md_emit.define_method (uni_string, current_class_token,
						l_meth_attr, l_meth_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

					start_new_body (l_setter_token)
					generate_current
					generate_argument (1)
					if is_verifiable and l_cur_sig.item (0) /= l_inh_sig.item (0) then
						method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Castclass,
							class_type_token (l_cur_sig.item (0)))
					end
					method_body.put_call (feature {MD_OPCODES}.Callvirt,
						setter_token (current_type_id, cur_feat.feature_id),
						nb, cur_feat.has_return_value)

					generate_return
					method_writer.write_current_body

					md_emit.define_method_impl (current_class_token, l_setter_token,
						setter_token (l_parent_type_id, inh_feat.feature_id))
				end
			end
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER;
			is_virtual: BOOLEAN)
		is
			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		require
			base_name_not_void: base_name /= Void
			base_name_not_empty: not base_name.is_empty
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			valid_external_type: valid_type (ext_kind)
		local
			l_type_token: INTEGER
		do
			l_type_token := current_module.external_token_mapping (base_name)
			internal_generate_external_call (0, l_type_token, Void, name, ext_kind,
					Names_heap.convert_to_string_array (parameters_type),
					Names_heap.item (return_type), is_virtual)
		end

	external_token (base_name: STRING; member_name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER) : INTEGER
		is
			-- Get token for feature specified by `base_name' and `member_name'
		require
			base_name_not_void: base_name /= Void
			base_name_empty: not base_name.is_empty
			member_name_not_void: member_name /= Void
			member_name_not_empty: not member_name.is_empty
			valid_external_type: valid_type (ext_kind)
		local
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_class_token: INTEGER
			i, nb: INTEGER
			l_has_return_type: BOOLEAN
			l_type: TYPE_I
			l_real_type: STRING
			l_is_array: BOOLEAN
			l_parameters_string: ARRAY [STRING]
			l_return_type: STRING
			l_signature: ARRAY [INTEGER]
		do
			l_class_token := current_module.external_token_mapping (base_name)
			l_parameters_string := Names_heap.convert_to_string_array (parameters_type)
			l_return_type := Names_heap.item (return_type)

			l_has_return_type := l_return_type /= Void
			if l_has_return_type then
				if l_return_type.item (l_return_type.count) = ']' then
					l_real_type := l_return_type.substring (1, l_return_type.count - 2)
					l_is_array := True
				else
					l_real_type := l_return_type
				end
				l_type := external_class_mapping.item (l_real_type)
			end

			if parameters_type = Void then
				create l_signature.make (0, 0)
			else
				create l_signature.make (0, parameters_type.count)
			end
			l_signature.compare_references

			inspect ext_kind
			when Field_type, Static_field_type, Set_field_type, Set_static_field_type then
				l_field_sig := field_sig
				l_field_sig.reset
				if l_is_array then
					l_field_sig.set_type (
						feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
				end
				if l_type /= Void then
					set_signature_type (l_field_sig, l_type)
					l_signature.put (l_type.static_type_id, 0)
				else
					l_field_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
						current_module.external_token_mapping (l_return_type))
				end

				uni_string.set_string (member_name)
				Result := md_emit.define_member_ref (uni_string, l_class_token, l_field_sig)
			else
				l_meth_sig := method_sig
				l_meth_sig.reset
				if ext_kind = Static_type or ext_kind = Operator_type then
					l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
				else
					l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
				end

				if l_parameters_string /= Void then
					nb := l_parameters_string.count
				end

				l_meth_sig.set_parameter_count (nb)

				if l_has_return_type then
					if l_is_array then
						l_meth_sig.set_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					end
					if l_type /= Void then
						set_method_return_type (l_meth_sig, l_type)
						l_signature.put (l_type.static_type_id, 0)
					else
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
							current_module.external_token_mapping (l_return_type))
					end
				else
					l_meth_sig.set_return_type (
						feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				end

				from
					i := 1
				until
					i > nb
				loop
					l_real_type := l_parameters_string.item (i)
					if l_real_type.item (l_real_type.count) = ']' then
						l_is_array := True
						l_real_type := l_real_type.substring (1, l_real_type.count - 2)
					else
						l_is_array := False
					end
					l_type := external_class_mapping.item (l_real_type)
					if l_is_array then
						l_meth_sig.set_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					end
					if l_type /= Void then
						set_signature_type (l_meth_sig, l_type)
						l_signature.put (l_type.static_type_id, i)
					else
						l_meth_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
							current_module.external_token_mapping (l_real_type))
					end
					i := i + 1
				end

				if member_name = Void then
					uni_string.set_string (".ctor")
				else
					uni_string.set_string (member_name)
				end

				Result := md_emit.define_member_ref (uni_string, l_class_token, l_meth_sig)
			end
			last_external_signature := l_signature
		end

	internal_generate_external_call (an_assembly_token, a_type_token: INTEGER; base_name: STRING;
			member_name: STRING; ext_kind: INTEGER;
			parameters_string: ARRAY [STRING]; return_type: STRING;
			is_virtual: BOOLEAN)
		is
			-- Generate call to `member_name' with signature `parameters_type' + `return_type'.
		require
			valid_external_type: valid_type (ext_kind)
		local
			l_token: INTEGER
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_class_token: INTEGER
			i, nb: INTEGER
			l_has_return_type: BOOLEAN
			l_type: TYPE_I
			l_real_type: STRING
			l_is_array: BOOLEAN
		do
 			if base_name /= Void then
 				uni_string.set_string (base_name)
 				l_class_token := md_emit.define_type_ref (uni_string, an_assembly_token)
 			else
				l_class_token := a_type_token
			end

			l_has_return_type := return_type /= Void
			if l_has_return_type then
				if return_type.item (return_type.count) = ']' then
					l_real_type := return_type.substring (1, return_type.count - 2)
					l_is_array := True
				else
					l_real_type := return_type
				end
				l_type := external_class_mapping.item (l_real_type)
			end

			inspect ext_kind
			when Field_type, Static_field_type, Set_field_type, Set_static_field_type then
				l_field_sig := field_sig
				l_field_sig.reset
				if l_is_array then
					l_field_sig.set_type (
						feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
				end
				if l_type /= Void then
					set_signature_type (l_field_sig, l_type)
				else
					l_field_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
						current_module.external_token_mapping (return_type))
				end

				uni_string.set_string (member_name)
				l_token := md_emit.define_member_ref (uni_string, l_class_token, l_field_sig)
				inspect ext_kind
				when Field_type then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldfld, l_token)
				when Static_field_type then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld, l_token)
				when Set_field_type then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stfld, l_token)
				when Set_static_field_type then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, l_token)
				end
			else
				l_meth_sig := method_sig
				l_meth_sig.reset
				if ext_kind = Static_type or ext_kind = Operator_type then
					l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
				else
					l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
				end

				if parameters_string /= Void then
					nb := parameters_string.count
				end

				l_meth_sig.set_parameter_count (nb)

				if l_has_return_type then
					if l_is_array then
						l_meth_sig.set_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					end
					if l_type /= Void then
						set_method_return_type (l_meth_sig, l_type)
					else
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
							current_module.external_token_mapping (return_type))
					end
				else
					l_meth_sig.set_return_type (
						feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				end

				from
					i := 1
				until
					i > nb
				loop
					l_real_type := parameters_string.item (i)
					if l_real_type.item (l_real_type.count) = ']' then
						l_is_array := True
						l_real_type := l_real_type.substring (1, l_real_type.count - 2)
					else
						l_is_array := False
					end
					l_type := external_class_mapping.item (l_real_type)
					if l_is_array then
						l_meth_sig.set_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					end
					if l_type /= Void then
						set_signature_type (l_meth_sig, l_type)
					else
						l_meth_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
							current_module.external_token_mapping (l_real_type))
					end
					i := i + 1
				end

				if member_name = Void then
					uni_string.set_string (".ctor")
				else
					uni_string.set_string (member_name)
				end

				l_token := md_emit.define_member_ref (uni_string, l_class_token, l_meth_sig)

				inspect ext_kind
				when Creator_call_type, Static_type, Operator_type then
					method_body.put_call (feature {MD_OPCODES}.Call, l_token, nb, l_has_return_type)
				when Normal_type, Deferred_type then
					if is_virtual then
						method_body.put_call (
							feature {MD_OPCODES}.Callvirt, l_token, nb, l_has_return_type)
					else
						method_body.put_call (
							feature {MD_OPCODES}.Call, l_token, nb, l_has_return_type)
					end
				when Creator_type then
					method_body.put_call (
						feature {MD_OPCODES}.Newobj, l_token, nb, True)
				end
			end
		end

feature -- Local variable info generation

	set_local_count (a_count: INTEGER) is
			-- Set `local_count' to `a_count'.
		require
			valid_count: a_count >= 0
		do
			local_count := a_count
		ensure
			local_count_set: local_count = a_count
		end

	put_result_info (type_i: TYPE_I) is
			-- Specifies `type_i' of type of result.
		require
			type_i_not_void: type_i /= Void
		do
			if not once_generation then
				result_position := 0
				local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i, "Result"))
			end
		end

	put_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		do
			local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i,
				Names_heap.item (name_id)))
		end

	put_nameless_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		do
			local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i, "_" + name_id.out))
		end

	put_dummy_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		do
			local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i,
				"_dummy_" + name_id.out))
		end

feature -- Local saving

	reset_local_types is
			-- Reset `local_types'.
		do
			create local_types.make (5)
		end

	store_locals (a_meth_token: INTEGER) is
			-- Store `local_types' into `method_body' for routine `a_meth_token'.
		require
			method_token_valid: a_meth_token & feature {MD_TOKEN_TYPES}.Md_mask =
				feature {MD_TOKEN_TYPES}.Md_method_def
		do
			current_module.store_locals (local_types, a_meth_token)
		end

	generate_local_debug_info (a_method_token: INTEGER) is
			-- Generate local information about routine `method_token'.
		require
			debug_info_requested: is_debug_info_enabled
			method_token_valid: a_method_token & feature {MD_TOKEN_TYPES}.Md_mask =
				feature {MD_TOKEN_TYPES}.Md_method_def
		do
			current_module.generate_local_debug_info (a_method_token)
		end

feature -- Object creation

	create_object (a_type_id: INTEGER) is
			-- Create object of `a_type_id'.
		require
			valid_type_id: a_type_id > 0
		do
			method_body.put_call (feature {MD_OPCODES}.Newobj,
				constructor_token (a_type_id), 0, True)
		end

	create_like_object is
			-- Create object of same type as object on top of stack.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"create_like_object", Static_type, <<type_info_class_name>>,
				type_info_class_name,
				False)
		end

	load_type is
			-- Load on stack type of object on top of stack.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"load_type_of_object", Static_type, <<type_info_class_name>>,
				type_class_name,
				False)
		end

	create_type is
			-- Given info on stack, it will create a new instance of a generic formal
			-- parameter.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"create_type", Static_type, <<type_class_name,
				type_info_class_name>>, type_info_class_name,
				False)
		end

feature -- IL stack managment

	duplicate_top is
			-- Duplicate top element of IL stack.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Dup)
		end

	pop is
			-- Remove top element of IL stack.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Pop)
		end

feature -- Variables access

	generate_current is
			-- Generate access to `Current'.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldarg_0)
		end

	generate_result is
			-- Generate access to `Result'.
		do
			if once_generation then
				generate_once_result
			else
				generate_local (result_position)
			end
		end

	generate_attribute (need_target: BOOLEAN; type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate access to attribute of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		local
			cl_type: CL_TYPE_I
			l_class: CLASS_C
		do
			cl_type ?= type_i
			if cl_type /= Void then
				l_class := cl_type.base_class
			end
			if
				l_class /= Void and then
				l_class.is_frozen or l_class.is_single or l_class.is_external
			then
				if need_target then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldfld,
						attribute_token (cl_type.implementation_id, a_feature_id))
				else
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld,
						attribute_token (cl_type.implementation_id, a_feature_id))
				end
			else
					-- Attribute are accessed through their feature encapsulation.
				internal_generate_feature_access (type_i.static_type_id, a_feature_id,
					0, True, True)
			end
		end

	generate_feature_access (type_i: TYPE_I; a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
			internal_generate_feature_access (type_i.static_type_id, a_feature_id, nb,
				is_function, True)
		end

	generate_precompiled_feature_access (type_i: TYPE_I; a_feature: FEATURE_I) is
			-- Generate a call to a precompiled library.
		require
			type_i_not_void: type_i /= Void
			a_feature_not_void: a_feature /= Void
		do
		end

	internal_generate_feature_access (a_type_id, a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `a_type_id'.
		require
			positive_type_id: a_type_id > 0
			positive_feature_id: a_feature_id > 0
		local
			l_opcode: INTEGER_16
		do
			if is_virtual then
				l_opcode := feature {MD_OPCODES}.Callvirt
			else
				l_opcode := feature {MD_OPCODES}.Call
			end

			method_body.put_call (l_opcode, feature_token (a_type_id, a_feature_id), nb,
				is_function)
		end

	generate_precursor_feature_access (type_i: TYPE_I; a_feature_id: INTEGER;
			nb: INTEGER; is_function: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `type_i' with `nb' arguments.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
			method_body.put_call (feature {MD_OPCODES}.Call,
				implementation_feature_token (type_i.implementation_id, a_feature_id),
				nb, is_function)
		end

	put_type_token (a_type_id: INTEGER) is
			-- Put token associated to `a_type_id' on stack.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldtoken,
				class_type_token (a_type_id))
		end

	put_method_token (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate access to feature of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldtoken,
				feature_token (type_i.static_type_id, a_feature_id))
		end

	generate_argument (n: INTEGER) is
			-- Generate access to `n'-th variable arguments of current feature.
		require
			valid_n: n >= 0
		do
			inspect
				n
			when 0 then method_body.put_opcode (feature {MD_OPCODES}.Ldarg_0)
			when 1 then method_body.put_opcode (feature {MD_OPCODES}.Ldarg_1)
			when 2 then method_body.put_opcode (feature {MD_OPCODES}.Ldarg_2)
			when 3 then method_body.put_opcode (feature {MD_OPCODES}.Ldarg_3)
			else
				if n <= 255 then
					method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldarg_s, n.to_integer_8)
				else
					method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Ldarg, n.to_integer_16)
				end
			end
		end

	generate_local (n: INTEGER) is
			-- Generate access to `n'-th local variable of current feature.
		require
			valid_n: n >= 0
		local
			l_pos: INTEGER
		do
			l_pos := n + result_position
			inspect
				l_pos
			when 0 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_0)
			when 1 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_1)
			when 2 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_2)
			when 3 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_3)
			else
				if l_pos <= 255 then
					method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldloc_s,
						l_pos.to_integer_8)
				else
					method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Ldloc,
						l_pos.to_integer_16)
				end
			end
		end

	generate_metamorphose (type_i: TYPE_I) is
			-- Generate `metamorphose', ie boxing a basic type of `type_i' into its
			-- corresponding reference type.
		require
			type_i_not_void: type_i /= Void
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Box,
				class_type_token (type_i.static_type_id))
		end


	generate_unmetamorphose (type_i: TYPE_I) is
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		require
			type_i_not_void: type_i /= Void
		local
			l_type_id: INTEGER
		do
			l_type_id := type_i.static_type_id
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Unbox,
				class_type_token (l_type_id))
			generate_load_from_address (type_i)
		end

feature -- Addresses

	generate_local_address (n: INTEGER) is
			-- Generate address of `n'-th local variable.
		require
			valid_n: n >= 0
		local
			l_pos: INTEGER
		do
			l_pos := n + result_position
			if l_pos <= 255 then
				method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldloca_s, l_pos.to_integer_8)
			else
				method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Ldloca, l_pos.to_integer_16)
			end
		end

	generate_argument_address (n: INTEGER) is
			-- Generate address of `n'-th argument variable.
		require
			valid_n: n >= 0
		do
			if n <= 255 then
				method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldarga_s, n.to_integer_8)
			else
				method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Ldarga, n.to_integer_16)
			end
		end

	generate_current_address is
			-- Generate address of `Current'.
		do
			method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldarga_s, 0)
		end

	generate_result_address is
			-- Generate address of `Result'.
		do
			if once_generation then
				generate_once_result_address
			else
				generate_local_address (result_position)
			end
		end

	generate_attribute_address (type_i: TYPE_I; attr_type: TYPE_I; a_feature_id: INTEGER) is
			-- Generate address to attribute of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			attr_type_not_void: attr_type /= Void
			positive_feature_id: a_feature_id > 0
		local
			cl_type: CL_TYPE_I
			local_number: INTEGER
		do
			cl_type ?= type_i
			if
				cl_type /= Void and then
				(cl_type.base_class.is_frozen or cl_type.base_class.is_single)
			then
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldflda,
					attribute_token (cl_type.implementation_id, a_feature_id))
			else
					-- Attribute are accessed through their feature encapsulation.
				duplicate_top
				internal_generate_feature_access (type_i.static_type_id, a_feature_id,
					0, True, True)
				duplicate_top
				Byte_context.add_local (attr_type)
				local_number := Byte_context.local_list.count
				put_dummy_local_info (attr_type, local_number)
				generate_local_assignment (local_number)
				generate_local_address (local_number)
			end
		end

	generate_routine_address (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate address of routine of `a_feature_id' in class `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
			method_body.put_opcode (feature {MD_OPCODES}.Dup)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldvirtftn,
				feature_token (type_i.static_type_id, a_feature_id))
		end

	generate_load_from_address (a_type: TYPE_I) is
			-- Load value of `a_type' type from address pushed on stack.
		require
			type_not_void: a_type /= Void
		do
			inspect a_type.element_type
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i1 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i1)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_u1 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_u1)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i2 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i2)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_u2 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_u2)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i4 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i4)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_u4 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_u4)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i8 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i8)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_u8 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_u8)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i1)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_char then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i2)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r4 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_r4)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r8 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_r8)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i)
			else
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldobj, class_type_token (a_type.static_type_id))
			end
		end

feature -- Assignments

	generate_is_instance_of (type_i: TYPE_I) is
			-- Generate `Isinst' byte code instruction.
		require
			type_i_not_void: type_i /= Void
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Isinst,
				class_type_token (type_i.static_type_id))
		end

	generate_check_cast (source_type, target_type: TYPE_I) is
			-- Generate `checkcast' byte code instruction.
		require
			target_type_not_void: target_type /= Void
		local
			l_source, l_target: CL_TYPE_I
		do
			if is_verifiable and not target_type.is_expanded then
				l_source ?= source_type
				l_target ?= target_type
				if
					source_type = Void or else
					l_source = Void or else l_target = Void or else
					not l_source.base_class.simple_conform_to (l_target.base_class)
				then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Castclass,
						class_type_token (target_type.static_type_id))
				end
			end
		end

	generate_cast_to_implementation (target_type: TYPE_I) is
			-- Generate `cast' to implementation of `target_type'.
		require
			target_type_not_void: target_type /= Void
		do
			if is_verifiable and not target_type.is_expanded then
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Castclass,
					class_type_token (target_type.implementation_id))
			end
		end

	generate_attribute_assignment (need_target: BOOLEAN; type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate assignment to attribute of `a_feature_id' in current class.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		local
			cl_type: CL_TYPE_I
			l_class: CLASS_C
		do
			cl_type ?= type_i
			if cl_type /= Void then
				l_class := cl_type.base_class
			end
			if
				l_class /= Void and then
				l_class.is_frozen or l_class.is_single or l_class.is_external
			then
				if need_target then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stfld,
						attribute_token (type_i.static_type_id, a_feature_id))
				else
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld,
						attribute_token (type_i.static_type_id, a_feature_id))
				end
			else
				method_body.put_call (feature {MD_OPCODES}.Callvirt,
					setter_token (type_i.static_type_id, a_feature_id), 1, False)
			end
		end

	generate_expanded_attribute_assignment (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate assignment to attribute of `a_feature_id' in current class
			-- when direct access to attribute is not possible.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= type_i
			if
				cl_type = Void or else
				not (cl_type.base_class.is_frozen or cl_type.base_class.is_single)
			then
				method_body.put_call (feature {MD_OPCODES}.Callvirt,
					setter_token (type_i.static_type_id, a_feature_id), 1, False)
			end
		end

	generate_local_assignment (n: INTEGER) is
			-- Generate assignment to `n'-th local variable of current feature.
		require
			valid_n: n >= 0
		local
			l_pos: INTEGER
		do
			l_pos := n + result_position
			inspect
				l_pos
			when 0 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_0)
			when 1 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_1)
			when 2 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_2)
			when 3 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_3)
			else
				if l_pos <= 255 then
					method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Stloc_s,
						l_pos.to_integer_8)
				else
					method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Stloc, 
						l_pos.to_integer_16)
				end
			end
		end

	generate_result_assignment is
			-- Generate assignment to Result variable of current feature.
		do
			if once_generation then
				generate_once_store_result
			else
				generate_local_assignment (result_position)
			end
		end

feature -- Conversion

	convert_to (type: TYPE_I) is
			-- Convert top of stack into `type'.
		require
			type_not_void: type /= Void
			type_is_basic: type.is_basic
		do
			inspect
				type.element_type
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean then convert_to_boolean
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_char then convert_to_character
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r4 then convert_to_real
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r8 then convert_to_double
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i then convert_to_native_int
			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i1,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u1
			then
				convert_to_integer_8

			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i2,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u2
			then
				convert_to_integer_16

			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i4,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u4
			then
				convert_to_integer_32

			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i8,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u8
			then
				convert_to_integer_64

			else
				check
					False
				end
			end
		end

	convert_to_native_int is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i)
		end

	convert_to_integer_8, convert_to_boolean is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i1)
		end

	convert_to_integer_16, convert_to_character is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i2)
		end

	convert_to_integer_32 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i4)
		end

	convert_to_integer_64 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i8)
		end

	convert_to_double is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_r8)
		end

	convert_to_real is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_r4)
		end

feature -- Return statements

	generate_return is
			-- Generate simple end of routine
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ret)
		end

	generate_return_value is
			-- Generate end of routine which returns `Result'.
		do
				-- Push result on stack.
			generate_result
			generate_return
		end

feature -- Once management

	done_token, result_token: INTEGER
			-- Token for static fields holding value if once has been computed,
			-- and its value if computed.
			-- Ok to use token in a non-module specific code here, because they
			-- are only local to current feature generation.

	generate_once_done_info (name: STRING) is
			-- Generate declaration of static `done' variable corresponding
			-- to once feature `name'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		do
			uni_string.set_string (name + "_done")
			done_token := md_emit.define_field (uni_string,
				current_class_token,
				feature {MD_FIELD_ATTRIBUTES}.Public | feature {MD_FIELD_ATTRIBUTES}.Static,
				done_sig)
		end

	generate_once_result_info (name: STRING; type_i: TYPE_I) is
			-- Generate declaration of static `result' variable corresponding
			-- to once function `name' that has a return type `type_i'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			type_i: type_i /= Void
		local
			l_sig: like field_sig
		do
			l_sig := field_sig
			l_sig.reset
			set_signature_type (l_sig, type_i)

			uni_string.set_string (name + "_result")
			result_token := md_emit.define_field (uni_string,
				current_class_token,
				feature {MD_FIELD_ATTRIBUTES}.Public | feature {MD_FIELD_ATTRIBUTES}.Static, l_sig)
		end

	generate_once_computed is
			-- Mark current once as being computed.
		do
			put_boolean_constant (True)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, done_token)
		end

	generate_once_result_address is
			-- Generate test on `done' of once feature `name'.
		do
			put_boolean_constant (True)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsflda, result_token)
		end

	generate_once_test is
			-- Generate test on `done' of once feature `name'.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld, done_token)
		end

	generate_once_result is
			-- Generate access to static `result' variable to load last
			-- computed value of current processed once function
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld, result_token)
		end

	generate_once_store_result is
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, result_token)
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER) is
			-- Generate call to `item' of NATIVE_ARRAY.
		local
			l_opcode: INTEGER_16
		do
			inspect kind
			when Il_i1 then l_opcode := feature {MD_OPCODES}.Ldelem_i1
			when Il_i2 then l_opcode := feature {MD_OPCODES}.Ldelem_i2
			when Il_i4 then l_opcode := feature {MD_OPCODES}.Ldelem_i4
			when Il_i8, Il_u8 then l_opcode := feature {MD_OPCODES}.Ldelem_i8
			when Il_r4 then l_opcode := feature {MD_OPCODES}.Ldelem_r4
			when Il_r8 then l_opcode := feature {MD_OPCODES}.Ldelem_r8
			when Il_ref then l_opcode := feature {MD_OPCODES}.Ldelem_ref
			when Il_i then l_opcode := feature {MD_OPCODES}.Ldelem_i
			when Il_u1 then l_opcode := feature {MD_OPCODES}.Ldelem_u1
			when Il_u2 then l_opcode := feature {MD_OPCODES}.Ldelem_u2
			when Il_u4 then l_opcode := feature {MD_OPCODES}.Ldelem_u4
			else
				check
					not_reached: False
				end
				l_opcode := feature {MD_OPCODES}.Nop
			end
			method_body.put_opcode (l_opcode)
		end

	generate_array_write (kind: INTEGER) is
			-- Generate call to `put' of NATIVE_ARRAY.
		local
			l_opcode: INTEGER_16
		do
			inspect kind
			when Il_i1, Il_u1 then l_opcode := feature {MD_OPCODES}.Stelem_i1
			when Il_i2, Il_u2 then l_opcode := feature {MD_OPCODES}.Stelem_i2
			when Il_i4, Il_u4 then l_opcode := feature {MD_OPCODES}.Stelem_i4
			when Il_i8, Il_u8 then l_opcode := feature {MD_OPCODES}.Stelem_i8
			when Il_r4 then l_opcode := feature {MD_OPCODES}.Stelem_r4
			when Il_r8 then l_opcode := feature {MD_OPCODES}.Stelem_r8
			when Il_ref then l_opcode := feature {MD_OPCODES}.Stelem_ref
			when Il_i then l_opcode := feature {MD_OPCODES}.Stelem_i
			else
				check
					not_reached: False
				end
				l_opcode := feature {MD_OPCODES}.Nop
			end
			method_body.put_opcode (l_opcode)
		end

	generate_array_creation (a_type_id: INTEGER) is
			-- Create a new NATIVE_ARRAY [A] where `a_type_id' corresponds
			-- to type id of `A'.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Newarr,
				class_type_token (a_type_id))
		end

	generate_array_count is
			-- Get length of current NATIVE_ARRAY on stack.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldlen)
			convert_to_integer_32
		end

	generate_array_upper is
			-- Generate call to `count - 1'.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldlen)
			method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_1)
			method_body.put_opcode (feature {MD_OPCODES}.Sub)
		end

	generate_array_lower is
			-- Always `0' for native arrays as they are zero-based one
			-- dimensional array.
		do
				-- First we pop pushed array as it is not needed and
				-- then we push `0'.
			method_body.put_opcode (feature {MD_OPCODES}.Pop)
			method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
		end

feature -- Exception handling

	rescue_label: INTEGER
			-- Label used for rescue clauses to mark end of `try-catch'.

	generate_start_exception_block is
			-- Mark starting point for a routine that has
			-- a rescue clause.
		do
			rescue_label := method_body.define_label
			method_body.exception_block.set_start_position (method_body.count)
		end

	generate_start_rescue is
			-- Mark beginning of rescue clause.
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Leave, rescue_label)
			method_body.exception_block.set_catch_position (method_body.count)
			method_body.exception_block.set_type_token (current_module.system_exception_token)
				-- We need to increment stack depth of 1 because CLI runtime automatically
				-- puts the exception object on top of stack and there is no automatic
				-- way to add it.
			method_body.increment_stack_depth (1)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld,
				current_module.ise_last_exception_token)
		end

	generate_leave_to (a_label: IL_LABEL) is
			-- Instead of using `branch_to' which is forbidden in a `try-catch' clause,
			-- we generate a `leave' opcode that has the same semantic except that it
			-- should branch outside the `try-catch' clause.
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Leave, a_label.id)
		end

	generate_end_exception_block is
			-- Mark end of rescue clause.
		do
			method_body.put_opcode (feature {MD_OPCODES}.rethrow)
			method_body.exception_block.set_end_position (method_body.count)
			method_body.mark_label (rescue_label)
		end

feature -- Assertions

	generate_in_assertion_status is
			-- Generate value of `in_assertion' on stack.
		do
			method_body.put_call (feature {MD_OPCODES}.Call, current_module.ise_in_assertion_token,
				0, True)
		end

	generate_set_assertion_status is
			-- Set `in_assertion' flag with top of stack.
		do
			method_body.put_call (feature {MD_OPCODES}.Call,
				current_module.ise_set_in_assertion_token, 1, False)
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING) is
			-- Generate test after an assertion is being generated.
			-- If result of test is False, we raise an exception.
		local
			type_assert: STRING
			l_label: INTEGER
			l_str_token: INTEGER
		do
			inspect
				assert_type
			when In_postcondition then
				type_assert := "Postcondition violation: "
			when In_check then
				type_assert := "Check violation: "
			when In_loop_invariant then
				type_assert := "Loop invariant violation: "
			when In_loop_variant then
				type_assert := "Loop variant violation: "
			when In_invariant then
				type_assert := "Invariant violation: "
			end

			uni_string.set_string (type_assert + tag)
			l_str_token := md_emit.define_string (uni_string)

			l_label := method_body.define_label
			method_body.put_opcode_label (feature {MD_OPCODES}.Brtrue, l_label)
			put_boolean_constant (False)
			generate_set_assertion_status
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldstr, l_str_token)
			method_body.put_call (feature {MD_OPCODES}.Newobj, current_module.exception_ctor_token,
				1, True)
			method_body.put_opcode (feature {MD_OPCODES}.Throw)
			method_body.mark_label (l_label)
		end

	generate_precondition_check (tag: STRING; failure_block: IL_LABEL) is
			-- Generate test after a precondition is generated
			-- If result of test is False we put `tag' in an
			-- exception object and go check next block of inherited
			-- preconditions and check them. If no more block, we raise
			-- an exception with exception object.
		local
			l_str_token: INTEGER
		do
			uni_string.set_string ("Precondition violation: " + tag)
			l_str_token := md_emit.define_string (uni_string)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldstr, l_str_token)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld,
				current_module.ise_assertion_tag_token)
			method_body.put_opcode_label (feature {MD_OPCODES}.Brfalse, failure_block.id)
		end

	generate_precondition_violation is
			-- Generate a precondition violation.
			-- Has to be a specific one because preconditions can be weaken.
		do
			put_boolean_constant (False)
			generate_set_assertion_status
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld,
				current_module.ise_assertion_tag_token)
			method_body.put_call (feature {MD_OPCODES}.Newobj, current_module.exception_ctor_token,
				1, True)
			method_body.put_opcode (feature {MD_OPCODES}.Throw)
		end

	generate_invariant_feature (feat: INVARIANT_FEAT_I) is
			-- Generate `_invariant' that checks `current_class_type' invariants.
		local
			l_invariant_token: INTEGER
			l_dotnet_invariant_token: INTEGER
			l_sig: like method_sig
		do
				-- First we generate the `$$_invariant' feature which only contains invariant for
				-- Current class.
			if feat /= Void then
				generate_feature (feat, False, True, False)
				generate_feature_code (feat)

				l_invariant_token := implementation_feature_token (current_type_id, feat.feature_id)
			else
					-- Generate empty invariant feature that does nothing. Will be
					-- used in descendant.
				l_sig := method_sig
				l_sig.reset
				l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
				l_sig.set_parameter_count (1)
				l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				set_signature_type (l_sig, current_class_type.type)

				uni_string.set_string ("$$_invariant")
				l_invariant_token := md_emit.define_method (uni_string, current_class_token,
					feature {MD_METHOD_ATTRIBUTES}.Public |
					feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					feature {MD_METHOD_ATTRIBUTES}.Static, l_sig,
					feature {MD_METHOD_ATTRIBUTES}.Managed)

				start_new_body (l_invariant_token)
				method_body.put_opcode (feature {MD_OPCODES}.Ret)
				method_writer.write_current_body
			end

			current_module.internal_invariant_token.
				put (l_invariant_token, current_class_type.implementation_id)

				-- Generate invariant feature that calls above static version.
			uni_string.set_string ("_invariant")
			l_dotnet_invariant_token := md_emit.define_method (uni_string, current_class_token,
				feature {MD_METHOD_ATTRIBUTES}.Public |
				feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature |
				feature {MD_METHOD_ATTRIBUTES}.Virtual,
				default_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

			start_new_body (l_dotnet_invariant_token)
			generate_current
			method_body.put_call (feature {MD_OPCODES}.Call, l_invariant_token, 0, False)
			generate_return
			method_writer.write_current_body
		end
		
	generate_inherited_invariants is
			-- Generate call to all directly inherited invariant features.
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent_type: CL_TYPE_I
			cl_type: CLASS_TYPE
			i, id: INTEGER
			l_list: SEARCH_TABLE [INTEGER]
		do
			from
				parents := current_class_type.associated_class.parents
				create l_list.make (parents.count)
				parents.start
			until
				parents.after
			loop
				parent_type ?= byte_context.real_type (parents.item.type_i)
				cl_type := parent_type.associated_class_type
				id := cl_type.implementation_id
				if not l_list.has (id) then
					l_list.force (id)
					if not cl_type.associated_class.is_external then
						generate_current
						method_body.put_call (feature {MD_OPCODES}.Call,
							invariant_token (id), 0, False)
					end
					i := i + 1
				end
				parents.forth
			end
		end

	generate_invariant_checked_for (a_label: IL_LABEL) is
			-- Generate check to find out if we should check invariant or not.
		require
			a_label_not_void: a_label /= Void
		do
			put_type_token (current_class_type.type.static_type_id)
			method_body.put_call (feature {MD_OPCODES}.Call,
				current_module.ise_is_invariant_checked_for_token, 1, True)
			branch_on_true (a_label)
		end

	generate_invariant_checking (type_i: TYPE_I) is
			-- Generate an invariant check after routine call, it assumes that
			-- target has already been pushed onto evaluation stack.
		require
			type_i_not_void: type_i /= Void
		do
			method_body.put_call (feature {MD_OPCODES}.Call,
				current_module.ise_check_invariant_token, 1, False)
		end

feature -- Constants generation

	put_default_value (type: TYPE_I) is
			-- Put default value of `type' on IL stack.
		require
			type_not_void: type /= Void
		do
			inspect
				type.element_type
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean then
				put_boolean_constant (False)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_char then
				put_character_constant ('%U')
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r8 then
				put_double_constant (0.0)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i then
				put_integer_32_constant (0)
				convert_to_native_int

			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r4 then
				put_double_constant (0.0)
				convert_to_real

			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i1,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u1
			then
				put_integer_8_constant (0)

			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i2,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u2
			then
				put_integer_16_constant (0)

			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i4,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u4
			then
				put_integer_32_constant (0)

			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i8,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u8
			then
				put_integer_64_constant (0)

			else
				put_void
			end
		end

	put_void is
			-- Add a Void element on stack.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldnull)
		end

	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		require
			valid_s: s /= Void
		do
			create_object (String_implementation_id)
			duplicate_top
			put_system_string (s)
			internal_generate_feature_access (String_type_id, String_make_feat_id, 1, False, True)
		end

	put_system_string (s: STRING) is
			-- Put `System.String' object corresponding to `s' on IL stack.
		require
			valid_s: s /= Void
		local
			l_string_token: INTEGER
		do
			uni_string.set_string (s)
			l_string_token := md_emit.define_string (uni_string)
			method_body.put_string (l_string_token)
		end

	put_integer_constant (type: TYPE_I; i: INTEGER) is
			-- Put `i' as integer constant of type `type'.
		require
			type_not_void: type /= Void 
			type_is_long: type.is_long
		local
			long: LONG_I
		do
			long ?= type
			inspect
				long.size
			when 8 then put_integer_8_constant (i)
			when 16 then put_integer_16_constant (i)
			when 32 then put_integer_32_constant (i)
			when 64 then put_integer_64_constant (i)
			end
		end

	put_integer_8_constant,
	put_integer_16_constant,
	put_integer_32_constant (i: INTEGER) is
			-- Put `i' as INTEGER_8, INTEGER_16, INTEGER on IL stack
		do
			inspect
				i
			when 0 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
			when 1 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_1)
			when 2 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_2)
			when 3 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_3)
			when 4 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_4)
			when 5 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_5)
			when 6 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_6)
			when 7 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_7)
			when 8 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_8)
			else
				method_body.put_opcode_integer (feature {MD_OPCODES}.Ldc_i4, i)
			end
		end

	put_integer_64_constant (i: INTEGER_64) is
			-- Put `i' as INTEGER_64 on IL stack
		do
			method_body.put_opcode_integer_64 (feature {MD_OPCODES}.Ldc_i8, i)
		end

	put_double_constant (d: DOUBLE) is
			-- Put `d' on IL stack.
		do
			method_body.put_opcode_double (feature {MD_OPCODES}.Ldc_r8, d)
		end

	put_character_constant (c: CHARACTER) is
			-- Put `c' on IL stack.
		do
			method_body.put_opcode_integer (feature {MD_OPCODES}.Ldc_i4, c.code)
		end

	put_boolean_constant (b: BOOLEAN) is
			-- Put `b' on IL stack.
		do
			if b then
				method_body.put_opcode (feature {MD_OPCODES}.ldc_i4_1)
			else
				method_body.put_opcode (feature {MD_OPCODES}.ldc_i4_0)
			end
		end

feature -- Labels and branching

	branch_on_true (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		require
			label_not_void: label /= Void
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Brtrue, label.id)
		end

	branch_on_false (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		require
			label_not_void: label /= Void
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Brfalse, label.id)
		end

	branch_to (label: IL_LABEL) is
			-- Generate a branch instruction to `label'.
		require
			label_not_void: label /= Void
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Br, label.id)
		end

	mark_label (label: IL_LABEL) is
			-- Mark a portion of code with `label'.
		require
			label_not_void: label /= Void
		do
			method_body.mark_label (label.id)
		end

	create_label: IL_LABEL is
			-- Create a new label
		do
			create Result.make (method_body.define_label)
		end

feature -- Binary operator generation

	generate_binary_operator (code: INTEGER) is
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		do
			inspect
				code
			when il_le then
				method_body.put_opcode (feature {MD_OPCODES}.Cgt)
				method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			when il_lt then method_body.put_opcode (feature {MD_OPCODES}.Clt)
			when il_ge then
				method_body.put_opcode (feature {MD_OPCODES}.Clt)
				method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			when il_gt then method_body.put_opcode (feature {MD_OPCODES}.Cgt)
			when il_star then method_body.put_opcode (feature {MD_OPCODES}.Mul)
			when il_power then
				method_body.put_call (
					feature {MD_OPCODES}.Call, current_module.power_method_token, 2, True)
			when il_plus then method_body.put_opcode (feature {MD_OPCODES}.Add)
			when il_mod then method_body.put_opcode (feature {MD_OPCODES}.Rem)
			when il_minus then method_body.put_opcode (feature {MD_OPCODES}.Sub)
			when il_div, il_slash then method_body.put_opcode (feature {MD_OPCODES}.Div)
			when il_xor then method_body.put_opcode (feature {MD_OPCODES}.Xor_opcode)
			when il_or then method_body.put_opcode (feature {MD_OPCODES}.Or_opcode)
			when il_and then method_body.put_opcode (feature {MD_OPCODES}.And_opcode)
			when il_eq then method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			when il_ne then
				method_body.put_opcode (feature {MD_OPCODES}.Ceq)
				method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			when il_shl then method_body.put_opcode (feature {MD_OPCODES}.Shl)
			when il_shr then method_body.put_opcode (feature {MD_OPCODES}.Shr)
			end
		end

feature -- Unary operator generation

	generate_unary_operator (code: INTEGER) is
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		do
			inspect
				code
			when il_uplus then -- Nothing to be done here.
			when il_uminus then method_body.put_opcode (feature {MD_OPCODES}.Neg)
			when il_not then
				method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			when il_bitwise_not then method_body.put_opcode (feature {MD_OPCODES}.Not_opcode)
			end
		end

feature -- Basic feature

	generate_is_digit is
			-- Generate `is_digit' on CHARACTER.
		local
			l_min_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			set_method_return_type (l_sig, Boolean_c_type)
			set_signature_type (l_sig, Char_c_type)

			uni_string.set_string ("IsDigit")
			l_min_token := md_emit.define_member_ref (uni_string, current_module.char_type_token,
				l_sig)

			method_body.put_call (feature {MD_OPCODES}.Call, l_min_token, 1, True)
		end

	generate_min (type: TYPE_I) is
			-- Generate `min' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		local
			l_min_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			set_method_return_type (l_sig, type)
			set_signature_type (l_sig, type)
			set_signature_type (l_sig, type)

			uni_string.set_string ("Min")
			l_min_token := md_emit.define_member_ref (uni_string, current_module.math_type_token,
				l_sig)

			method_body.put_call (feature {MD_OPCODES}.Call, l_min_token, 2, True)
		end

	generate_max (type: TYPE_I) is
			-- Generate `max' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		local
			l_max_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			set_method_return_type (l_sig, type)
			set_signature_type (l_sig, type)
			set_signature_type (l_sig, type)

			uni_string.set_string ("Max")
			l_max_token := md_emit.define_member_ref (uni_string, current_module.math_type_token,
				l_sig)

			method_body.put_call (feature {MD_OPCODES}.Call, l_max_token, 2, True)
		end

	generate_abs (type: TYPE_I) is
			-- Generate `abs' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		local
			l_abs_token: INTEGER
			l_type_token: INTEGER
			l_sig: like method_sig
			l_type_id: INTEGER
		do
			l_type_id := type.static_type_id
			l_type_token := class_type_token (l_type_id)
			create l_sig.make
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			set_method_return_type (l_sig, type)
			set_signature_type (l_sig, type)
			uni_string.set_string ("Abs")
			l_abs_token := md_emit.define_member_ref (uni_string, current_module.math_type_token,
				l_sig)

			method_body.put_call (feature {MD_OPCODES}.Call, l_abs_token, 1, True)
		end

	generate_to_string is
			-- Generate call on `ToString'.
		do
			method_body.put_call (feature {MD_OPCODES}.Callvirt,
				current_module.to_string_method_token, 0, True)
		end

	generate_hash_code is
			-- Given an INTEGER on top of stack, put on stack
			-- a positive INTEGER.
		do
			convert_to_integer_32
			put_integer_32_constant (0x7FFFFFFF)
			method_body.put_opcode (feature {MD_OPCODES}.And_opcode)
		end

	generate_out (type: TYPE_I) is
			-- Generate `out' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		local
			local_number: INTEGER
		do
				-- Generate `out' representation in IL format
			generate_metamorphose (type)
			generate_to_string

				-- Store value
			byte_context.add_local (System_string_type)
			local_number := byte_context.local_list.count
			put_dummy_local_info (System_string_type, local_number)
			generate_local_assignment (local_number)

			create_object (string_implementation_id)
			duplicate_top
			generate_local (local_number)
			internal_generate_feature_access (string_type_id, string_make_feat_id, 0, False, True)
		end

feature -- Line info

	put_line_info (n: INTEGER) is
			-- Generate debug information at line `n'.
		require
			valid_n: n > 0
		local
			l_pos: INTEGER
		do
			if is_debug_info_enabled then
				l_pos := dbg_offsets_count
				dbg_offsets.force (method_body.count, l_pos)
				dbg_start_lines.force (n, l_pos)
				dbg_start_columns.force (0, l_pos)
				dbg_end_lines.force (n, l_pos)
				dbg_end_columns.force (1000, l_pos)
				dbg_offsets_count := l_pos + 1
				method_body.put_nop
			end
		end

	put_debug_info (location: TOKEN_LOCATION) is
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
		require
			location_not_void: location /= Void
		local
			l_pos: INTEGER
		do
			if is_debug_info_enabled then
				l_pos := dbg_offsets_count
				dbg_offsets.force (method_body.count, l_pos)
				dbg_start_lines.force (location.line_number, l_pos)
				dbg_start_columns.force (location.start_column_position, l_pos)
				dbg_end_lines.force (location.line_number, l_pos)
				dbg_end_columns.force (location.end_column_position, l_pos)
				dbg_offsets_count := l_pos + 1
				method_body.put_nop
			end
		end

	flush_sequence_points (a_class_type: CLASS_TYPE) is
			-- Flush all sequence points.
		require
			a_class_type_not_void: a_class_type /= Void
		local
			l_sequence_point_list: LINKED_LIST [like sequence_point]
		do
			if is_debug_info_enabled then
				dbg_writer.define_sequence_points (
					dbg_documents (a_class_type.associated_class.class_id),
					dbg_offsets_count, dbg_offsets, dbg_start_lines, dbg_start_columns,
					dbg_end_lines, dbg_end_columns)

				l_sequence_point_list :=
					current_module.method_sequence_points.item (current_feature_token)
				if l_sequence_point_list = Void then
					create l_sequence_point_list.make
					current_module.method_sequence_points.put (l_sequence_point_list,
						current_feature_token)
				end
				l_sequence_point_list.extend ([dbg_offsets_count, dbg_offsets, dbg_start_lines,
					dbg_start_columns, dbg_end_lines, dbg_end_columns,
					a_class_type.associated_class.class_id])

					-- Reset offsets.
				create dbg_offsets.make (0, 5)
				create dbg_start_lines.make (0, 5)
				create dbg_start_columns.make (0, 5)
				create dbg_end_lines.make (0, 5)
				create dbg_end_columns.make (0, 5)
				dbg_offsets_count := 0
			end
		end

feature -- Compilation error handling

	last_error: STRING
			-- Last exception which occurred during IL generation

feature -- Convenience

	implemented_type (implemented_in: INTEGER; current_type: CL_TYPE_I): CL_TYPE_I is
			-- Return static_type_id of class that defined `feat'.
		require
			valid_implemented_in: implemented_in > 0
			current_type_not_void: current_type /= Void
		local
			cl_type_a: CL_TYPE_A
			written_class: CLASS_C
			class_id: INTEGER
		do
			class_id := current_type.class_id

				-- If `feat' is defined in current class, that's easy and we
				-- return `current_type_id'. Otherwise we have to find the
				-- correct CLASS_TYPE object where `feat' is written.
			if class_id = implemented_in then
				Result := current_type
			else
				written_class := System.class_of_id (implemented_in) 
					-- We go through the hierarchy only when `written_class'
					-- is generic, otherwise for the most general case where
					-- `written_class' is not generic it will take a long
					-- time to go through the inheritance hierarchy.
				if written_class.types.count > 1 then
					cl_type_a := current_type.type_a
					Result := cl_type_a.find_class_type (written_class).type_i
				else
					Result := written_class.types.first.type
				end
			end
		end

feature -- Generic conformance

	generate_class_type_instance (cl_type: CL_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		require
			cl_type_not_void: cl_type /= Void
		local
			l_type_id: INTEGER
		do
			if cl_type.is_basic then
				l_type_id := basic_type_id
			else
				l_type_id := class_type_id
			end
			create_object (l_type_id)
			duplicate_top
			put_type_token (cl_type.implementation_id)
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				class_type_class_name,
				"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
		end

	generate_generic_type_instance (n: INTEGER) is
			-- Generate a GENERIC_TYPE instance corresponding that will hold `n' items.
		require
			valid_n: n >= 0
		do
			create_object (generic_type_id)
			duplicate_top
			put_integer_32_constant (n)
			generate_array_creation (runtime_type_id)
		end

	generate_generic_type_settings (gen_type: GEN_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		require
			gen_type_not_void: gen_type /= Void
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_type_class_name,
				"set_type_array", Normal_type, <<type_array_class_name>>, Void, True);

			duplicate_top
			put_type_token (gen_type.implementation_id)
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_type_class_name,
				"set_type", Normal_type, <<type_handle_class_name>>, Void, True)

			duplicate_top
			put_integer_32_constant (gen_type.meta_generic.count)
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_type_class_name,
				"set_nb_generics", Normal_type, <<integer_32_class_name>>, Void, True)
		end

	generate_none_type_instance is
			-- Generate a NONE_TYPE instance.
		do
			create_object (none_type_id)
		end

	assign_computed_type is
			-- Given elements on stack, compute associated type and set it to
			-- newly created object.
		do
				-- First object on stack is newly created object on which we 
				-- want to assign the computed type.
				-- Second object is the array containing the type array.
				-- Last, we push current object to the stack.
			generate_current
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"compute_type", Static_type, <<type_info_class_name, type_class_name,
				type_info_class_name>>, Void, False)
		end

feature {NONE} -- Implementation: generation

	generate_type_feature (a_type_feature: TYPE_FEATURE_I) is
			-- Generate type description for `a_type_feature'.
		require
			a_type_feature_not_void: a_type_feature /= Void
		local
			l_cl_type: CL_TYPE_I
			l_gen_type: GEN_TYPE_I
			l_formal_type: FORMAL_I
			l_type_i: TYPE_I
			l_type_id, i, up: INTEGER
			l_sig: like local_sig
			l_token: INTEGER
		do
			l_type_i := a_type_feature.type.actual_type.type_i

				-- We are now evaluation `l_type_i' in the context of current CLASS_TYPE
				-- generation. So if it is a formal, we have to make sure that call to
				-- `byte_context.real_type (l_type_i)' keeps its formal status, by default
				-- it translates a FORMAL_I into a REFERENCE_I.
			if l_type_i.has_formal then
				if l_type_i.is_formal then
					l_formal_type ?= l_type_i
					l_type_i := byte_context.real_type (l_type_i)
					if not l_type_i.is_expanded then
						l_type_i := l_formal_type
					end
				else
					l_type_i := byte_context.real_type (l_type_i)
				end
			end

			if l_type_i.is_formal then
				l_type_id := formal_type_id
			else
				l_cl_type ?= l_type_i
				if l_cl_type.is_basic then
					l_type_id := basic_type_id
				else
					l_gen_type ?= l_cl_type
					if l_gen_type /= Void then
						l_type_id := generic_type_id
					else
						l_type_id := class_type_id
					end
				end
			end

			start_new_body (feature_token (current_type_id, a_type_feature.feature_id))

				-- Set position of `result' local variable. Does not make sense to 
				-- call `put_result_info' as we don't know its associated CL_TYPE_I.
			result_position := 0

			l_sig := local_sig
			l_sig.reset

			l_sig.set_local_count (1)
			l_sig.add_local_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
				class_type_token (l_type_id))
			l_token := md_emit.define_signature (l_sig)
			method_body.set_local_token (l_token)

			create_object (l_type_id)
			generate_result_assignment

			generate_result

			if l_type_id = formal_type_id then
				put_integer_32_constant (l_formal_type.position)
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					formal_type_class_name,
					"set_position",
					Normal_type, <<integer_32_class_name>>, Void, True)
			elseif l_type_id = class_type_id then
					-- Non-generic class.
				put_type_token (l_cl_type.implementation_id)
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					class_type_class_name,
					"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
			elseif l_type_id = basic_type_id then
				put_type_token (l_cl_type.implementation_id)
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					basic_type_class_name,
					"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
			else
				duplicate_top

				put_integer_32_constant (l_gen_type.meta_generic.count)
				generate_array_creation (runtime_type_id)

				from
					i := l_gen_type.true_generics.lower
					check
						i_start_at_one: i = 1
					end
					up := l_gen_type.true_generics.upper
				until
					i > up
				loop
					duplicate_top
					put_integer_32_constant (i - 1)
					l_gen_type.true_generics.item (i).generate_gen_type_il (Current, True)
					generate_array_write (feature {IL_CONST}.il_ref)
					i := i + 1
				end

				internal_generate_external_call (current_module.ise_runtime_token, 0,
					generic_type_class_name,
					"set_type_array", normal_type, <<type_array_class_name>>, Void, True)
				duplicate_top
				put_type_token (l_gen_type.implementation_id)
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					generic_type_class_name,
					"set_type", normal_type, <<type_handle_class_name>>, Void, True)
				duplicate_top
				put_integer_32_constant (l_gen_type.meta_generic.count)
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					generic_type_class_name,
					"set_nb_generics", normal_type, <<integer_32_class_name>>, Void, True)

				pop
			end
			generate_return_value

			method_writer.write_current_body
		end

feature {IL_CODE_GENERATOR} -- Implementation: convenience

	System_string_type: TYPE_I is
			-- Type of string object
		once
			Result := System.system_string_class.compiled_class.types.first.type
		end

	String_type: TYPE_I is
			-- Type of string object
		once
			Result := System.string_class.compiled_class.types.first.type
		end

	String_implementation_id: INTEGER is
			-- Type ID of string implementation.
		once
			Result := String_type.implementation_id
		end

	String_type_id: INTEGER is
			-- Type of string interface.
		once
			Result := String_type.static_type_id
		end

	String_make_feat_id: INTEGER is
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.string_class.compiled_class.
				feature_table.item_id (feature {PREDEFINED_NAMES}.make_from_cil_name_id).feature_id
		end

feature {IL_CODE_GENERATOR, IL_MODULE, CUSTOM_ATTRIBUTE_FACTORY} -- Custom attribute definition

	define_custom_attribute (token: INTEGER; ctor_token: INTEGER; data: MD_CUSTOM_ATTRIBUTE) is
			-- Define a custom attribute on `token' using constructor `ctor_token' with
			-- arguments `data'.
			-- Same as `md_emit.define_custom_attribuyte' but we do not care about return type.
		local
			l_ca_token: INTEGER
		do
			l_ca_token := md_emit.define_custom_attribute (token, ctor_token, data)
		end

feature {NONE} -- Predefined custom attributes

	not_cls_compliant_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for not CLS compliant attribute
		once
			create Result.make
			Result.put_boolean (False)
			Result.put_integer_16 (0)
		end

	not_com_visible_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for not COM Visible attribute.
		once
			create Result.make
			Result.put_boolean (False)
			Result.put_integer_16 (0)
		end

	debugger_step_through_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blobl for `System.Diagnostics.DebuggerStepThroughAttribute' attribute.
		once
			create Result.make
			Result.put_integer_16 (0)
		end

	debugger_hidden_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blobl for `System.Diagnostics.DebuggerHiddenAttribute' attribute.
		once
			create Result.make
			Result.put_integer_16 (0)
		end

feature {NONE} -- Onces

	language_guid: COM_GUID is
			-- Language guid used to identify our language when debugging.
		once
			create Result.make (0x6805C61E, 0x8195, 0x490C,
				<<0x87, 0xEE, 0xA7, 0x13, 0x30, 0x1A, 0x67, 0x0C>>)
		end

	vendor_guid: COM_GUID is
			-- Vendor guid used to identify us when debugging.
		once
			create Result.make (0xB68AF30E, 0x9424, 0x485F,
				<<0x82, 0x64, 0xD4, 0xA7, 0x26, 0xC1, 0x62, 0xE7>>)
		end

	document_type_guid: COM_GUID is
			-- Document type guid.
		once
			create Result.make_empty
		end

feature {NONE} -- Once per type definition

	current_class_token: INTEGER
			-- Token of current class being generated.

feature -- Once per feature definition

	result_position: INTEGER
			-- Position of `Result' local variable.

feature -- Mapping between Eiffel compiler and generated tokens

	il_modules (a_class_type: CLASS_TYPE): IL_MODULE is
			-- Perform lookup for module associated with `a_class_type'. If not
			-- found then create a module used for reference only.
		require
			a_class_type_not_void: a_class_type /= Void
		local
			l_type_id: INTEGER
			l_output: FILE_NAME
			l_module_name: STRING
		do
			if System.in_final_mode then
				l_type_id := 1
			else
				l_type_id := a_class_type.associated_class.class_id
			end
			Result := internal_il_modules.item (l_type_id)
			if Result = Void then
				create l_output.make_from_string (location_path)
				l_module_name := assembly_name + "_module_" + l_type_id.out + ".dll"
				l_output.set_file_name (l_module_name)
				create Result.make (
					l_module_name,
					l_output,
					c_module_name,
					Void,
					Current,
					Void,
					l_type_id,
					is_debug_info_enabled,
					False)
				internal_il_modules.put (Result, l_type_id)
			end
		end

	internal_il_modules: ARRAY [IL_MODULE]
			-- Array of IL_MODULE indexed by CLASS_TYPE.packet_number

	external_class_mapping: HASH_TABLE [CL_TYPE_I, STRING]
			-- Quickly find a type given its external name.

	class_mapping: ARRAY [INTEGER]
			-- Array of type token indexed by their `type_id'.

	constructor_token (a_type_id: INTEGER): INTEGER is
			-- Token identifier for default constructor of `a_type_id'.
		require
			valid_type_id: a_type_id > 0
		do
			Result := current_module.constructor_token (a_type_id)
		ensure
			constructor_token_valid: Result /= Void
		end

	class_type_token (a_type_id: INTEGER): INTEGER is
			-- Given `a_type_id' returns its associated metadata token.
		require
			valid_type_id: a_type_id > 0
		do
			Result := current_module.class_type_token (a_type_id)
		ensure
			class_token_valid: Result /= 0
		end

	invariant_token (a_type_id: INTEGER): INTEGER is
			-- Metadata token of invariant feature in class type `a_type_id'.
		require
			type_id_valid: a_type_id > 0
		do
			Result := current_module.invariant_token (a_type_id)
		ensure
			invariant_token_valid: Result /= 0
		end

	class_types: ARRAY [CLASS_TYPE] is
			-- List all class types in system indexed using both `implementation_id' and
			-- `static_type_id'.
		local
			i, nb: INTEGER
			l_class_type: CLASS_TYPE
		do
			if internal_class_types = Void then
					-- Collect all class types in system and initialize `internal_class_types'.
				from
					i := System.class_types.lower
					nb := System.class_types.upper
					create Result.make (0, System.Static_type_id_counter.count)
				until
					i > nb
				loop
					l_class_type := System.class_types.item (i)
					if l_class_type /= Void then
						Result.put (l_class_type, l_class_type.static_type_id)
						Result.put (l_class_type, l_class_type.implementation_id)
					end
					i := i + 1
				end
				internal_class_types := Result
			end
			Result := internal_class_types
		ensure
			class_types_not_void: class_types /= Void
			class_types_not_empty: class_types.count > 0
		end

	feature_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := current_module.feature_token (a_type_id, a_feature_id)
		ensure
			feature_token_valid: Result /= 0
		end

	setter_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given an attribute `a_feature_id' in `a_type_id' return associated
			-- token that sets it.
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := current_module.setter_token (a_type_id, a_feature_id)
		ensure
			setter_token_valid: Result /= 0
		end

	signatures (a_type_id, a_feature_id: INTEGER): ARRAY [INTEGER] is
			-- Given a `a_feature_id' in `a_type_id' retrieves its associated
			-- signature.
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_feats: HASH_TABLE [ARRAY [INTEGER], INTEGER]
		do
			l_feats := signatures_table.item (a_type_id)
			if l_feats /= Void then
				Result := l_feats.item (a_feature_id)
			end
			if Result = Void then
				define_feature_reference (a_type_id, a_feature_id, False, False, False)
				Result := signatures (a_type_id, a_feature_id)
			end
		ensure
			result_not_void: Result /= Void
		end

	implementation_signatures (a_type_id, a_feature_id: INTEGER): ARRAY [INTEGER] is
			-- Given a `a_feature_id' in `a_type_id' retrieves its associated
			-- signature.
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_feats: HASH_TABLE [ARRAY [INTEGER], INTEGER]
		do
			l_feats := implementation_signatures_table.item (a_type_id)
			if l_feats /= Void then
				Result := l_feats.item (a_feature_id)
				if Result = Void then
					define_feature_reference (a_type_id, a_feature_id, False, False, False)
					Result := implementation_signatures (a_type_id, a_feature_id)
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	implementation_feature_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := current_module.implementation_feature_token (a_type_id, a_feature_id)
		ensure
			valid_result: Result /= 0
		end

	attribute_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := current_module.attribute_token (a_type_id, a_feature_id)
		ensure
			valid_result: Result /= 0
		end

	file_token: HASH_TABLE [INTEGER, IL_MODULE]
			-- File token associated to `a_module' in `main_module'.

	table_token (a_table: ARRAY [HASH_TABLE [INTEGER, INTEGER]];
			a_type_id, a_feature_id: INTEGER): INTEGER
		is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			a_table_not_void: a_table /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_feats: HASH_TABLE [INTEGER, INTEGER]
		do
			l_feats := a_table.item (a_type_id)
			if l_feats /= Void then
				Result := l_feats.item (a_feature_id)
			end
		end

	sequence_point: TUPLE [
			INTEGER,			-- Offset count
			ARRAY [INTEGER],	-- Offsets
			ARRAY [INTEGER],	-- Start lines
			ARRAY [INTEGER],	-- Start columns
			ARRAY [INTEGER],	-- End lines
			ARRAY [INTEGER],	-- End columns
			INTEGER]			-- Written in class ID
		is
			-- For type definition purpose.
		do
		end

	local_debug_info: TUPLE [INTEGER, INTEGER, INTEGER, like local_types] is
			-- For type definition purpose.
		do
		end

	dbg_documents (a_class_id: INTEGER): DBG_DOCUMENT_WRITER is
			-- Associated document to `a_class_id'.
		require
			in_debug_mode: is_debug_info_enabled
		do
			Result := current_module.dbg_documents (a_class_id)
		ensure
			dbg_documents_not_void: Result /= Void
		end

	internal_class_types: ARRAY [CLASS_TYPE]
			-- Array of CLASS_TYPE in system indexed by `implementation_id' and
			-- `static_type_id' of CLASS_TYPE.

	implementation_signatures_table, signatures_table: ARRAY [HASH_TABLE [ARRAY [INTEGER], INTEGER]]
			-- Array of signatures indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are an array of type id representation signature of
			-- feature `feature_id' in `type_id'.

	insert_feature (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			current_module.insert_feature (a_token, a_type_id, a_feature_id)
		ensure
			inserted: feature_token (a_type_id, a_feature_id) = a_token
		end

	insert_setter (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			current_module.insert_setter (a_token, a_type_id, a_feature_id)
		ensure
			inserted: setter_token (a_type_id, a_feature_id) = a_token
		end

	insert_implementation_feature (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			current_module.insert_implementation_feature (a_token, a_type_id, a_feature_id)
		ensure
			inserted: implementation_feature_token (a_type_id, a_feature_id) = a_token
		end

	insert_attribute (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			current_module.insert_attribute (a_token, a_type_id, a_feature_id)
		ensure
			inserted: attribute_token (a_type_id, a_feature_id) = a_token
		end

	insert_in_table (a_table: ARRAY [HASH_TABLE [INTEGER, INTEGER]];
			a_token, a_type_id, a_feature_id: INTEGER)
		is
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			a_table_not_void: a_table /= Void
			token_valid: a_token /= 0
			type_id_valid: a_type_id > 0
			feature_id_valid: a_feature_id > 0
			not_inserted: a_table.item (a_type_id) /= Void implies
				not a_table.item (a_type_id).has (a_feature_id)
		local
			l_hash: HASH_TABLE [INTEGER, INTEGER]
		do
			l_hash := a_table.item (a_type_id)
			if l_hash = Void then
				create l_hash.make (10)
				a_table.put (l_hash, a_type_id)
			end

			l_hash.put (a_token, a_feature_id)
		ensure
			inserted: a_table.item (a_type_id).item (a_feature_id) = a_token
		end

	insert_implementation_signature (a_signature: ARRAY [INTEGER];
			a_type_id, a_feature_id: INTEGER)
		is
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in
			-- `implementation_signatures_table'.
		require
			implementation_signatures_table_not_void: implementation_signatures_table /= Void
			a_signature_not_void: a_signature /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_hash: HASH_TABLE [ARRAY [INTEGER], INTEGER]
		do
			l_hash := implementation_signatures_table.item (a_type_id)
			if l_hash = Void then
				create l_hash.make (10)
				implementation_signatures_table.put (l_hash, a_type_id)
			end

			l_hash.put (a_signature, a_feature_id)
		ensure
			inserted: implementation_signatures_table.item (a_type_id).item (a_feature_id).is_equal (a_signature)
		end

	insert_signature (a_signature: ARRAY [INTEGER]; a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `signatures_table'.
		require
			signatures_table_not_void: signatures_table /= Void
			a_signature_not_void: a_signature /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_hash: HASH_TABLE [ARRAY [INTEGER], INTEGER]
		do
			l_hash := signatures_table.item (a_type_id)
			if l_hash = Void then
				create l_hash.make (10)
				signatures_table.put (l_hash, a_type_id)
			end

			l_hash.put (a_signature, a_feature_id)
		ensure
			inserted: signatures_table.item (a_type_id).item (a_feature_id).is_equal (a_signature)
		end

feature {NONE} -- Implementation

	buffer: GENERATION_BUFFER is
			-- Inherited feature from ASSERT_TYPE which is not used therefore hidden.
		do
			check
				not_callable: False
			end
		end

end -- class IL_CODE_GENERATOR
