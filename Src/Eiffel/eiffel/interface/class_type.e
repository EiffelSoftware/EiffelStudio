indexing
	description: "[
		Description of a generic derivation of a generic CLASS_C. It contains
		type of the current generic derivation. All generic derivations are stored
		in TYPE_LIST of CLASS_C
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_TYPE

inherit
	SHARED_COUNTER

	SHARED_GENERATOR

	SHARED_GENERATION

	SHARED_SERVER

	SHARED_BODY_ID

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		export
			{ANY} byte_context
		end

	SHARED_ARRAY_BYTE

	SHARED_DECLARATIONS

	SHARED_TABLE

	SHARED_INCLUDE

	SYSTEM_CONSTANTS

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	COMPILER_EXPORTER

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_IL_CASING
		export
			{NONE} all
		end

	SHARED_CODE_FILES
		export
			{NONE} all
		end

	DEBUG_OUTPUT

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (t: like type) is
			-- Create new generic derivation CLASS_TYPE based on
			-- `t', type of actual CLASS_C as used in Eiffel code.
		require
			good_argument: t /= Void
			not_formal: not t.is_formal
		local
			l_system: like system
			l_static_type_id_counter: like static_type_id_counter
		do
			l_system := system
			l_static_type_id_counter := static_type_id_counter
			if t.is_basic then
				basic_type ?= t
			end
			type ?= t.generic_derivation
			check type_not_void: type /= Void end
				-- Set creation info as if the type is used as "like Current".
			if type = t then
					-- Duplicate type object to avoid modification of `t'.
				type := t.duplicate
			end
			is_changed := True
			type_id := l_system.type_id_counter.next
			static_type_id := l_static_type_id_counter.next_id
			if l_system.il_generation then
				if t.is_generated_as_single_type then
					implementation_id := static_type_id
				else
						-- Only Eiffel types that are generated with an interface
						-- and an implementation get a different `implementation_id'.
					implementation_id := l_static_type_id_counter.next_id
				end
					-- Set `external_id'.
				if basic_type /= Void and then associated_class.is_external and then not associated_class.is_typed_pointer then
						-- Basic types have a specific ID for external counterparts.
					external_id := l_static_type_id_counter.next_id
				else
					external_id := static_type_id
				end
			end
			l_system.reset_melted_conformance_table
		end

feature -- Access

	static_type_id: INTEGER
			-- Unique static_type_id for current class type
			--| Useful to set name of associated generated file
			--| which has to be dynamic type (`type_id') independant.
			--| Remeber that after during each freezing, dynamic types
			--| are reprocessed.

	implementation_id: INTEGER
			-- Same as `static_type_id' but used in IL mode only to
			-- give a different ID wether we are handling interface
			-- or implementation of current CLASS_TYPE.

	external_id: INTEGER
			-- Same as `static_type_id' but used in IL mode only to
			-- give a different ID wether we are handling external
			-- variant of current CLASS_TYPE (if any), otherwise
			-- it defaults to `static_type_id'.

	type: CL_TYPE_A
			-- Type of the class: it includes meta-instantiation of
			-- possible generic parameters

	type_id: INTEGER
			-- Identification of the class type

	last_type_token, last_implementation_type_token, last_create_type_token: INTEGER
			-- Last definition tokens computed for Current. They correspond respectively
			-- to the associated interface, the associated implementation and the
			-- factory class.
			--| Only meaningful in IL code generation.

	skeleton: SKELETON
			-- Skeleton of the class type

	is_valid: BOOLEAN is
			-- Is current type still valid for current system?
		do
			Result := associated_class /= Void and then system.class_type_of_id (type_id) /= Void
		end

	is_modifiable: BOOLEAN is
			-- Is current type not part of a precompiled library?
		do
			Result := not is_precompiled
		end

	is_generated: BOOLEAN is
			-- Is current type to be generated in IL code generation?
		require
			il_generation: System.il_generation
		do
			Result := not is_precompiled and not is_external
		end

	is_changed: BOOLEAN
			-- Is the attribute list changed ? [has the skeleton of
			-- attributes to be re-generated ?]

	is_reference: BOOLEAN
			-- Is `type' a reference type?
		do
			Result := type.is_reference
		end

	is_basic: BOOLEAN is
			-- Is current class type a basic type?
		do
			Result := basic_type /= Void
		end

	is_expanded: BOOLEAN is
			-- Is current class type expanded?
		require
			type_not_void: type /= Void
		do
			Result := type.is_expanded
		end

	is_true_expanded: BOOLEAN is
			-- Is current class type expanded but not basic?
		require
			type_not_void: type /= Void
		do
			Result := type.is_true_expanded and basic_type = Void
		end

	is_generic: BOOLEAN is
			-- Is current class a generic class?
		local
			l_gen_type: GEN_TYPE_A
		do
			l_gen_type ?= type
			Result := l_gen_type /= Void
		end

	is_external: BOOLEAN is
			-- Is current class type external?
		require
			type_not_void: type /= Void
		local
			l_class: like associated_class
		do
			l_class := associated_class
			Result := l_class.is_external and (not l_class.is_basic or l_class.is_typed_pointer or l_class.is_native_array)
		end

	is_generated_as_single_type: BOOLEAN is
			-- Is associated type generated as a single type or as an interface type and
			-- an implementation type.
		require
			il_generation: System.il_generation
		do
			Result := type.is_generated_as_single_type
		end

	has_cpp_externals: BOOLEAN
			-- Does current class_type contain C++ externals

	has_cpp_status_changed: BOOLEAN
			-- Has the class changed its `has_cpp_externals' flag
			-- after a recompilation.

	is_precompiled: BOOLEAN is
		do
			Result := Static_type_id_counter.is_precompiled (static_type_id)
		end

	class_interface: CLASS_INTERFACE
			-- Corresponding interface of current generic derivation.

	assembly_info: ASSEMBLY_INFO
			-- Information about assembly in which current class is being generated.

	is_dotnet_name: BOOLEAN
			-- Is current type being generated using dotnet name convention?

	il_type_name (a_prefix: STRING): STRING is
			-- Name of type in IL code generation.
		require
			is_precompiled: is_precompiled
		do
			Result := il_casing.type_name (internal_namespace, a_prefix, internal_type_name, is_dotnet_name)
		end

	conformance_table: PACKED_BOOLEANS
			-- Conformance table for current type.

	type_number: INTEGER is
			-- Gives the position on which this CLASS_TYPE occors in its associated class's TYPE_LIST
		local
			types: TYPE_LIST
		do
			if type_number_int = 0 then
				types := associated_class.types
				from
					types.start
				until
					types.after
				loop
					type_number_int := type_number_int + 1
					types.forth
				end
			end
			Result := type_number_int
		end

feature {NONE} -- Implementation: Access

	basic_type: BASIC_A
			-- If `type' is originally a basic type, we keep the BASIC_A instance
			-- as it is used for certain queries (e.g. tuple_code).

feature -- Status report

	dynamic_conform_to (a_type: TYPE_A; a_type_id: INTEGER; a_context_type: TYPE_A): BOOLEAN is
			-- Does Current conform to `a_type' in a dynamic binding sense?
			-- That is to say if you have Current be `B [G#1]' with a conformance
			-- type be `B [TUPLE]' and the ancestor `a_type' be `A [TUPLE [INTEGER]]'
			-- then it is conforming even though B [TUPLE] does not conform
			-- to A [TUPLE [INTEGER]].
		require
			a_type_not_void: a_type /= Void
			a_context_type_not_void: a_context_type /= Void
			a_context_type_valid: a_type.is_valid_context_type (a_context_type)
			a_type_has_class_type: a_type.has_associated_class_type (a_context_type)
			a_type_id_valid: a_type_id >= 0
			a_type_related_to_type_id: a_type.type_id (a_context_type) = a_type_id
			conformance_table_not_void: conformance_table /= Void
			final_mode: byte_context.final_mode
		local
			l_generics: ARRAY [TYPE_A]
			l_type_feat: TYPE_FEATURE_I
			l_ancestor_class, l_class: CLASS_C
			l_formal: FORMAL_A
			l_type, l_descendant_type: TYPE_A
			i, nb: INTEGER
			l_packed: PACKED_BOOLEANS
		do
			Result := type_id = a_type_id
			if not Result then
				l_packed := conformance_table
				if a_type_id <= l_packed.upper then
					Result := l_packed.item (a_type_id)
					if Result then
							-- CLASS_TYPE are conformant, so let's verify that `a_type' is a valid ancestor.
							-- For example `a_type' could be `A [STRING]' and current be `A [INTEGER]'
							-- and it is clear that `A [INTEGER]' does not conform to `A [STRING]'
							-- but class type `A [INTEGER]' does conform to `A [G#1]' the associated CLASS_TYPE
							-- of `A [STRING]'.
							-- Of course this is only needed when `a_type' is generics as if it is not
							-- then the above CLASS_TYPE conformance is giving us the proper result.
						l_generics := a_type.generics
						if l_generics /= Void then
							from
								l_ancestor_class := a_type.associated_class
								l_class := associated_class
								i := l_generics.lower
								nb := l_generics.upper
							until
								i > nb or not Result
							loop
									-- If actual generic parameter at position `i' in `a_type' is expanded
									-- then we rely on CLASS_TYPE conformance. We could change this in the
									-- future when we are handling generic expanded types.
								l_type := l_generics.item (i).actual_type
								if not l_type.is_expanded and not l_type.is_formal and not l_type.is_none then
									check l_type_has_class: l_type.has_associated_class end
									l_type_feat := l_class.generic_features.item (l_ancestor_class.formal_at_position (i).rout_id_set.first)
									check l_type_feat_not_void: l_type_feat /= Void end
									if l_type_feat.is_formal then
										l_formal ?= l_type_feat.type
										l_descendant_type := type.generics.item (l_formal.position)
										if l_descendant_type.is_expanded then
											Result := l_descendant_type.associated_class.simple_conform_to (l_type.associated_class)
										end
									else
											-- The formal generic parameter of `a_type' was instantiated via inheritance.
											-- Let's check that it is a conforming type to the actual generic parameter of `a_type'.
										Result := l_type_feat.type.associated_class.simple_conform_to (l_type.associated_class)
										if not Result then
											do_nothing
										end
									end
								end
								i := i + 1
							end
						end
					end
				end
			end
		end

feature -- Settings

	set_is_changed (b: BOOLEAN) is
			-- Assign `b' to `is_changed' ?
		do
			is_changed := b
		ensure
			is_changed_set: is_changed = b
		end

	set_skeleton (s: like skeleton) is
			-- Assign `s' to `skeleton'.
		do
			skeleton := s
		ensure
			skeleton_set: skeleton = s
		end

	set_last_type_token (v: like last_type_token) is
			-- Assign `v' to `last_type_token'.
		require
			v_not_zero: v /= 0
		do
			last_type_token := v
		ensure
			last_type_token_set: last_type_token = v
		end

	set_last_implementation_type_token (v: like last_implementation_type_token) is
			-- Assign `v' to `last_implementation_type_token'.
		require
			v_not_zero: v /= 0
		do
			last_implementation_type_token := v
		ensure
			last_implementation_type_token_set: last_implementation_type_token = v
		end

	set_last_create_type_token (v: like last_create_type_token) is
			-- Assign `v' to `last_create_type_token'.
		require
			v_not_zero: v /= 0
		do
			last_create_type_token := v
		ensure
			last_create_type_token_set: last_create_type_token = v
		end

	set_has_cpp_externals (b: BOOLEAN) is
			-- Assign `b' to `has_cpp_externals'.
		do
			has_cpp_status_changed := b /= has_cpp_externals
			has_cpp_externals := b
			if b then
				system.set_has_cpp_externals (b)
			end
		ensure
			has_cpp_externals_set: has_cpp_externals = b
		end

	set_type_id (i: INTEGER) is
			-- Assign `i' to `type_id'.
		require
			valid_i: i > 0
		do
			type_id := i
		ensure
			type_id_set: type_id = i
		end

	set_class_interface (cl: like class_interface) is
			-- Assign `cl' to `class_interface'.
		require
			cl_not_void: cl /= Void
		do
			class_interface := cl
		ensure
			class_interface_set: class_interface = cl
		end

	set_assembly_info (a: like assembly_info) is
			-- Set `assembly_info' with `a'.
		require
			a_not_void: a /= Void
		do
			assembly_info := a
		ensure
			assembly_info_set: assembly_info = a
		end

	set_il_type_name is
			-- Store basic information that will help us reconstruct
			-- a complete name.
		require
			not_is_precompiled: not is_precompiled
		local
			l_pos: INTEGER
		do
			internal_namespace := associated_class.original_class.actual_namespace.twin
			if basic_type /= Void then
				internal_type_name := basic_type.il_type_name (Void, Void)
			else
				internal_type_name := type.il_type_name (Void, Void)
			end
			l_pos := internal_type_name.last_index_of ('.', internal_type_name.count)
			internal_type_name := internal_type_name.substring (l_pos + 1, internal_type_name.count)
			is_dotnet_name := System.dotnet_naming_convention
		end

feature {SYSTEM_I} -- Setting

	set_implementation_id (i: like implementation_id) is
			-- Set `implementation_id' with `i'
		require
			il_generation: system.il_generation
			i_positive: i > 0
		do
			implementation_id := i
		ensure
			implementation_id_set: implementation_id = i
		end

feature -- Update

	reset_conformance_table is
			-- Reset conformance table for current type.
		do
			conformance_table := Void
		ensure
			conformance_table_reset: conformance_table = Void
		end

	build_conformance_table is
			-- Build conformance table for current type.
		do
			create conformance_table.make (type_id)
			build_conformance_table_of (Current)
		ensure
			conformance_table_not_void: conformance_table /= Void
		end

	build_conformance_table_of (cl: CLASS_TYPE) is
			-- Build recursively the conformance table of class `cl' knowing that
			-- `cl' conforms to Current.
		require
			cl_not_void: cl /= Void
			conformance_table_not_void: cl.conformance_table /= Void
		local
			a_parent: CLASS_TYPE
			a_table: like conformance_table
			l_area: SPECIAL [CL_TYPE_A]
			l_parent_type: CL_TYPE_A
			l_gen_type: GEN_TYPE_A
			i, nb: INTEGER
		do
			a_table := cl.conformance_table
			if type_id > a_table.upper or else a_table.item (type_id) = False then
					-- The parent has not been inserted yet. We use `force' as `type_id'
					-- might be greater than what `a_table' can hold.
				a_table.force (True, type_id)
					-- Since `cl' conforms to Current, it also conforms to the parent
					-- of Current.
				from
					l_area := associated_class.conforming_parents.area
					nb := associated_class.conforming_parents.count
				until
					i = nb
				loop
					l_parent_type := l_area.item (i)
					a_parent := l_parent_type.associated_class_type (type)
					a_parent.build_conformance_table_of (cl)
					i := i + 1
				end
				l_gen_type ?= type
				if l_gen_type /= Void and then not l_gen_type.is_tuple then
						-- Mark all generic derivations this one conforms to.
					l_gen_type.enumerate_interfaces (agent {CLASS_TYPE}.build_conformance_table_of (cl))
				end
			end
		end

feature -- Conveniences

	full_il_type_name: STRING is
			-- Full type name of Current as used in IL code generation with
			-- namespace specification.
		require
			il_generation: System.il_generation
		do
			if basic_type /= Void then
				Result := basic_type.il_type_name (Void, Void)
			else
				Result := type.il_type_name (Void, Void)
			end
		ensure
			full_il_create_type_name_not_void: Result /= Void
			full_il_create_type_name_not_empty: not Result.is_empty
		end

	full_il_implementation_type_name: STRING is
			-- Full type name of implementation of Current in IL code generation
			-- with namespace specification.
		require
			il_generation: System.il_generation
		do
			if basic_type /= Void then
				Result := basic_type.il_type_name ("Impl", Void)
			else
				Result := type.il_type_name ("Impl", Void)
			end
		ensure
			full_il_create_type_name_not_void: Result /= Void
			full_il_create_type_name_not_empty: not Result.is_empty
		end

	full_il_create_type_name: STRING is
			-- Full type name of implementation of Current in IL code generation
			-- with namespace specification.
		require
			il_generation: System.il_generation
		do
			if basic_type /= Void then
				Result := basic_type.il_type_name ("Create", Void)
			else
				Result := type.il_type_name ("Create", Void)
			end
		ensure
			full_il_create_type_name_not_void: Result /= Void
			full_il_create_type_name_not_empty: not Result.is_empty
		end

	associated_class: CLASS_C is
			-- Associated class
		require
			type_exists: type /= Void
		do
			Result := System.class_of_id (type.class_id)
		end

	written_type (a_class: CLASS_C): CLASS_TYPE is
			-- Class type associated to class `a_class' in the context
			-- of Current
		require
			good_argument: a_class /= Void
			consistency: associated_class.conform_to (a_class)
		do
			Result := a_class.meta_type (Current)
		ensure
			written_type_not_void: Result /= Void
		end

	written_type_id (a_class: CLASS_C): INTEGER is
			-- Type id of the type associated to class `a_class' in the
			-- context of Current
		require
			good_argument: a_class /= Void
			consistency: associated_class.conform_to (a_class)
		do
			Result := written_type (a_class).type_id
		end

	parent_types: LINKED_LIST [CLASS_TYPE] is
			-- List of parent types used for checking the invariant
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent_type: CL_TYPE_A
			already_in: BOOLEAN
		do
			from
				create Result.make
				parents := associated_class.parents
				parents.start
			until
				parents.after
			loop
				parent_type := parents.item
				from
						-- Check if the parent type is not already in
						-- the list (repeated inheritance ...).
					already_in := False
					Result.start
				until
					Result.after or else already_in
				loop
					already_in := parent_type.same_generic_derivation_as (type, Result.item.type)
					Result.forth
				end
				if not already_in then
					Result.extend (parent_type.associated_class_type (type))
				end

				parents.forth
			end
		end

feature -- Generation

	pass4 is
			-- Generation of the C file
		local
			l_feature_table: COMPUTED_FEATURE_TABLE
			l_feature_table_area: SPECIAL [FEATURE_I]
			current_class: CLASS_C
			current_eiffel_class: EIFFEL_CLASS_C
			l_feature_i: FEATURE_I
			file, extern_decl_file: INDENT_FILE
			inv_byte_code: INVARIANT_B
			final_mode: BOOLEAN
			generate_c_code: BOOLEAN
			tmp, buffer, ext_inline_buffer, header_buffer, headers: GENERATION_BUFFER
			l_inline_agent_table: HASH_TABLE [FEATURE_I, INTEGER]
			i, l_count: INTEGER
			l_byte_context: like byte_context
		do
			final_mode := byte_context.final_mode

			current_class := associated_class
			current_eiffel_class ?= current_class

			l_byte_context := byte_context

				-- Clear buffers for the new generation
			buffer := generation_buffer
			buffer.clear_all
			ext_inline_buffer := generation_ext_inline_buffer
			ext_inline_buffer.clear_all
			ext_inline_buffer.start_c_specific_code
			header_buffer := header_generation_buffer
			header_buffer.clear_all
			l_byte_context.generated_inlines.wipe_out

			if final_mode then
				create headers.make (100)
			end

			l_feature_table := current_class.feature_table.features
			l_feature_table_area := l_feature_table.area
			if final_mode then
					-- Check to see if there is really something to generate

				generate_c_code := has_creation_routine or else
						(current_class.has_invariant and then
						 system.keep_assertions)
				from
					i := 0
					l_count := l_feature_table.count
				until
					generate_c_code or else i = l_count
				loop
					l_feature_i := l_feature_table_area [i]
					if l_feature_i.to_generate_in (current_class) then
						generate_c_code := l_feature_i.used
					end
					i := i + 1
				end
			else
				generate_c_code := is_modifiable
			end

			if generate_c_code then
					-- First, we reset the `has_cpp_externals_calls' of `BYTE_CONTEXT'
					-- which will enable us to know wether or not a C++ call has been
					-- generated
				l_byte_context.set_has_cpp_externals_calls (False)
					-- Clear class type data.
				l_byte_context.clear_class_type_data

				if final_mode then
					tmp := headers
				else
					tmp := header_buffer
				end

						-- Write header
				tmp.put_string ("/*%N * Code for class ")
				tmp.put_string (type.dump)
				tmp.put_string ("%N */%N%N")
					-- Includes wanted
				tmp.put_string ("#include %"eif_eiffel.h%"%N")
				tmp.put_string ("#include %"../")
				tmp.put_string (packet_name (system_object_prefix, 1))
				tmp.put_character ('/')
				tmp.put_string (estructure)
				tmp.put_string (".h%"")
				tmp.put_new_line

				if final_mode then
					headers.put_string ("#include %"../")
					headers.put_string (packet_name (system_object_prefix, 1))
					headers.put_character ('/')
					headers.put_string (eoffsets)
					headers.put_string (".h%"")
					headers.put_new_line
					headers.put_string ("%N#include %"")
					headers.put_string (base_file_name)
					headers.put_string (".h%"")

						-- Generation of extern declarations
					header_buffer.put_string ("%N#ifndef ")
					header_buffer.put_string (already_included_header)
					header_buffer.put_string ("%N#define ")
					header_buffer.put_string (already_included_header)
				end
				header_buffer.start_c_specific_code

				buffer.start_c_specific_code

				l_byte_context.set_buffer (buffer)
				l_byte_context.set_header_buffer (header_buffer)
				l_byte_context.init (Current)

				if final_mode and then has_creation_routine then
						-- Generate the creation routine in final mode
					generate_creation_routine (buffer, header_buffer)
				end

				from
					i := 0
					l_count := l_feature_table.count
				until
					i = l_count
				loop
					l_feature_i := l_feature_table_area [i]
					if l_feature_i.to_generate_in (current_class) then
							-- Generate the C code of `feature_i'
						generate_feature (l_feature_i, buffer)
					end
					i := i + 1
				end

				if current_eiffel_class /= Void and then current_eiffel_class.has_inline_agents then
					from
						l_inline_agent_table := current_eiffel_class.inline_agent_table
						l_inline_agent_table.start
					until
						l_inline_agent_table.after
					loop
						l_feature_i := l_inline_agent_table.item_for_iteration
							-- Generate the C code of `feature_i'
						generate_feature (l_feature_i, buffer)
						l_inline_agent_table.forth
					end
				end

				if
					current_class.has_invariant and then
					((not final_mode) or else
					system.keep_assertions)
				then
					inv_byte_code := Inv_byte_server.disk_item (current_class.class_id)
					l_byte_context.set_byte_code (create {STD_BYTE_CODE})
					inv_byte_code.generate_invariant_routine
					l_byte_context.clear_feature_data
				end

					-- Create module initialization procedure
				buffer.generate_function_signature ("void", Encoder.module_init_name
					(static_type_id), True, header_buffer, <<>>, <<>>)
				buffer.generate_block_open
				buffer.put_gtcx

					-- Initialize once data
				l_byte_context.generate_module_once_data_initialization (type_id)
					-- Initialize once manifest strings
				l_byte_context.generate_once_manifest_string_initialization

				buffer.generate_block_close
				buffer.put_new_line

				if final_mode then
					Extern_declarations.generate (header_buffer)
					header_buffer.end_c_specific_code
					Extern_declarations.generate_header_files (headers)
					Extern_declarations.wipe_out

						-- End of header protection
					header_buffer.put_string ("%N#endif%N")

					create extern_decl_file.make_open_write (extern_declaration_filename)
					header_buffer.put_in_file (extern_decl_file)
					extern_decl_file.close
				else
					Extern_declarations.generate (header_buffer)
					header_buffer.end_c_specific_code
					Extern_declarations.generate_header_files (header_buffer)
					Extern_declarations.wipe_out
				end
				buffer.end_c_specific_code

				if not final_mode then
						-- Give the information status in Workbench mode only on the
						-- C generate file type (either .c/.x or .cpp/.xpp)
						-- This information is used later to create the `file_to_compile'
						-- file in each sudirectories of the W_code.
					set_has_cpp_externals (l_byte_context.has_cpp_externals_calls)
					file := open_generation_file (has_cpp_externals)
				else
					file := open_generation_file (l_byte_context.has_cpp_externals_calls)
				end

				if not final_mode then
					Header_generation_buffer.put_in_file (file)
				else
					headers.put_in_file (file)
				end
				ext_inline_buffer.end_c_specific_code
				ext_inline_buffer.put_in_file (file)
				buffer.put_in_file (file)
				file.close

			else
					-- The file hasn't been generated
				System.makefile_generator.record_empty_class_type (static_type_id)
			end

				-- clean the list of shared include files
			shared_include_queue.wipe_out
		end

	generate_feature (f: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generate feature `feat' in Current class type
		require
			good_argument: buffer /= Void
			to_generate_in: f.to_generate_in (associated_class)
		do
			f.generate (Current, buffer)
		end

	open_generation_file (has_cpp_externals_calls: BOOLEAN): INDENT_FILE is
			-- Open in write mode a file for generating class code
			-- of the current class type
		local
			l_file_name: STRING
			previous_file_name: STRING
			previous_file: PLAIN_TEXT_FILE
		do
			l_file_name := full_file_name (System.in_final_mode, packet_name (C_prefix, packet_number), base_file_name, Void)
			if byte_context.workbench_mode then
					-- If the status of the file has been changed we delete the
					-- previous version.
				if has_cpp_status_changed then
					previous_file_name := l_file_name.twin
					if has_cpp_externals_calls then
						previous_file_name.append (Dot_c)
					else
						previous_file_name.append (Dot_cpp)
					end
					create previous_file.make (previous_file_name)
					if previous_file.exists and then previous_file.is_writable then
						previous_file.delete
					end
				end
			end
			if has_cpp_externals_calls then
				l_file_name.append (Dot_cpp)
			else
				l_file_name.append (Dot_c)
			end
			create Result.make_c_code_file (l_file_name)
		end

	open_descriptor_file: INDENT_FILE is
			-- Open in write mode a file for generating descriptor table
		require
			Workbench_mode: not byte_context.final_mode
		local
			l_file_name: STRING
		do
			l_file_name := full_file_name (System.in_final_mode, packet_name (C_prefix, packet_number), base_file_name, Void)
			l_file_name.append_character (Descriptor_file_suffix)
			l_file_name.append (Dot_c)
			create Result.make_c_code_file (l_file_name)
		end

	extern_declaration_filename: STRING is
			-- File name for external declarations in final mode
		do
			Result := full_file_name (System.in_final_mode, packet_name (C_prefix, packet_number), base_file_name, Void)
			Result.append (Dot_h)
		end

	header_filename: INTEGER is
			-- File name for external declarations in final mode
			-- It is only a relativ path to F_code
		local
			s: STRING
		do
			create s.make (17)
			s.append_character ('%"')
			s.append_character ('.')
			s.append_character ('.')
			s.append_character ('/')
			s.append_string (packet_name (C_prefix, packet_number))
			s.append_character ('/')
			s.append (base_file_name)
			s.append (Dot_h)
			s.append_character ('%"')
			Names_heap.put (s)
			Result := Names_heap.found_item
		end

	already_included_header: STRING is
			-- #define statement used to protect generated header files for current
			-- generation.
		do
			create Result.make (14)
			Result.append_character ('_')
			Result.append_string (packet_name (C_prefix, packet_number))
			Result.append_character ('_')
			Result.append (base_file_name)
			Result.append_character ('_')
		end

	base_file_name: STRING is
			-- Generated base file name prefix
		do
			create Result.make (10)
			Result.append (associated_class.eiffel_class_c.base_file_name)
			Result.append_integer (static_type_id)
		ensure
			valid_result: Result /= Void
			pure_query: Result /= base_file_name and Result.is_equal (base_file_name)
		end

	packet_number: INTEGER is
			-- Packet in which the file will be generated
		do
			Result := static_type_id_counter.packet_number (static_type_id)
		end

	relative_file_name: STRING is
			-- Relative path of the generation file
		local
			f_name: FILE_NAME
			temp: STRING
		do
				-- Subdirectory
			create f_name.make_from_string (packet_name (C_prefix, packet_number))

				-- File name
			temp := base_file_name
			temp.append (Dot_c)

			f_name.set_file_name (temp)
			Result := f_name
		end

	has_creation_routine: BOOLEAN is
			-- Does the class type need an initialization routine ?
			--| i.e has the skeleton a bit or an expanded attribute at least ?
		do
			skeleton.go_bits
			Result := not skeleton.after
		end

	generate_creation_routine (buffer, header_buffer: GENERATION_BUFFER) is
			-- Creation routine, if necessary (i.e. if the object is
			-- composite and has expanded we must initialize, as well
			-- as some special header flags).
		require
			in_final_mode: byte_context.final_mode
			has_creation_routine: has_creation_routine
		local
			i, nb_ref, position: INTEGER
			exp_desc: EXPANDED_DESC
			c_name: STRING
			bits_desc: BITS_DESC
			value: INTEGER
			l_create_info: CREATE_INFO
		do
			c_name := Encoder.feature_name (type_id, Initialization_body_index)
			nb_ref := skeleton.nb_reference
			skeleton.go_bits
				-- There are some expandeds here...
				-- Generate a procedure which will be in charge of all the
				-- initialisation bulk.

			buffer.generate_function_signature ("void", c_name, True, header_buffer,
				<<"Current", "parent">>, <<EIF_REFERENCE_str, EIF_REFERENCE_str>>)

			buffer.generate_block_open
			buffer.put_gtcx
			buffer.put_new_line
			buffer.put_string ("uint32 offset_position = 0;")
			buffer.put_new_line
			buffer.put_string ("RTLD;")
			buffer.put_new_line
			buffer.put_string ("RTLI(2);")
			buffer.put_current_registration (0)
			buffer.put_local_registration (1, "parent")
				-- Separation for formatting
			buffer.put_new_line
			from
			until
				skeleton.after or else not skeleton.item.is_bits
			loop
					--| In this instruction and in the followings, we put `False' as second
					--| arguments. This means we won't generate anything if there is nothing
					--| to generate. Remember that `True' is used in the generation of attributes
					--| table in Final mode.
				buffer.put_new_line
				buffer.put_string ("offset_position = ");
				skeleton.generate (buffer, False, True)
				buffer.put_character (';')
					-- Initialize dynamic type of the bit attribute
				buffer.put_new_line
				buffer.put_string ("HEADER(Current + offset_position)->ov_flags = EO_EXP;")
				buffer.put_new_line
				buffer.put_string ("RT_DFS(HEADER(Current + offset_position), egc_bit_dtype);")
				buffer.put_new_line
				bits_desc ?= skeleton.item; 	-- Cannot fail
				buffer.put_string ("*(uint32 *) (Current + offset_position")
				buffer.put_string(") = ")
				buffer.put_integer (bits_desc.value)
				buffer.put_character (';')
				skeleton.forth
			end
				-- Current class type is composite
			buffer.put_new_line
			buffer.put_string ("HEADER(Current)->ov_flags |= EO_COMP;")
			from
				i := 0
			until
				skeleton.after
			loop
				buffer.put_new_line
				buffer.put_string ("offset_position = ");
				position := skeleton.position
				skeleton.generate(buffer, False, True)
					-- There is a side effect with generation
				skeleton.go_to (position)
				buffer.put_character (';')

				buffer.put_new_line
				buffer.put_string ("*(EIF_REFERENCE *) (Current")
				value := nb_ref + i
				skeleton.generate_i_th_reference_offset (buffer, value, True)
				buffer.put_string(") = Current + offset_position;")
				buffer.put_new_line

				exp_desc ?= skeleton.item;		-- Cannot fail
					-- Initialize dynaminc type of the expanded object
				l_create_info := exp_desc.type_i.create_info

					-- The dynamic type has to be set after setting the flags.
				buffer.put_string ("HEADER(Current + offset_position)->ov_flags = EO_EXP;")
				buffer.put_new_line
				l_create_info.generate_start (buffer)
				l_create_info.generate_gen_type_conversion (0)
				buffer.put_new_line
				buffer.put_string ("RT_DFS(HEADER(Current + offset_position), ")
				l_create_info.generate_type_id (buffer, True, 0)
				buffer.put_character (')')
				buffer.put_character (';')
				l_create_info.generate_end (buffer)

					-- Mark expanded object
				buffer.put_new_line
				buffer.put_string ("HEADER(Current + offset_position)->ov_size = ")
				buffer.put_string ("offset_position + (Current - parent);")

					-- Initializes expanded attribute if needed and then call creation procedure
					-- if needed.
				exp_desc.class_type.generate_expanded_initialization (buffer,
					"Current + offset_position", "parent", True)

				skeleton.forth
				i := i + 1
			end
			buffer.put_new_line
			buffer.put_string ("RTLE;")
			buffer.generate_block_close
				-- Separation for formatting
			buffer.put_new_line
		end

	mark_creation_routine (r: REMOVER) is
			-- Mark all the routines called in the creation routine
		local
			cl: CLASS_C
			creation_feature: FEATURE_I
		do
				-- Mark the creation procedure if the class
				-- is used as expanded
			cl := associated_class
			if cl.is_used_as_expanded then
				creation_feature := cl.creation_feature
				if creation_feature /= Void then
					r.record (creation_feature, cl)
				end
			end
		end

feature -- IL code generation

	generate_il_feature (f: FEATURE_I) is
			-- Generate feature `feat' in Current class type
		require
			feature_not_void: f /= Void
		do
			if not f.is_external then
				f.generate_il
			end
		end

feature -- Byte code generation

	update_execution_table is
			-- Update the execution table using melted features
		require
			good_context: associated_class.has_features_to_melt
			Not_precompiled: not is_precompiled
		local
			melted_set: SEARCH_TABLE [MELTED_INFO]
		do
			from
					-- Iteration on the melted list of the associated class
					-- processed during third pass of the compilation.
				melted_set := associated_class.melted_set
				melted_set.start
			until
				melted_set.after
			loop
					-- Generation of byte code
				melted_set.item_for_iteration.update_execution_unit (Current)
				melted_set.forth
			end
		end

	melt is
			-- Generate byte code for changed features of Current class
			-- type
		require
			good_context: associated_class.has_features_to_melt
			Not_precompiled: not is_precompiled
		local
			melted_set: SEARCH_TABLE [MELTED_INFO]
			feat_tbl: FEATURE_TABLE
		do
			from
					-- Iteration on the melted list of the associated class
					-- processed during third pass of the compilation.
				melted_set := associated_class.melted_set
				melted_set.start

					-- Initialization of the byte code context
				byte_context.init (Current)

				feat_tbl := associated_class.feature_table
			until
				melted_set.after
			loop
					-- Generation of byte code
				melted_set.item_for_iteration.melt (Current, feat_tbl)
				melted_set.forth
			end
		end

	melt_feature_table is
			-- Melt the feature table of the associated class
		local
			melted_feat_tbl: MELTED_FEATURE_TABLE
		do
			melted_feat_tbl := melted_feature_table
			melted_feat_tbl.set_type_id (static_type_id)
			Tmp_m_feat_tbl_server.put (melted_feat_tbl)
		end

feature -- Parent table generation

	generate_parent_table (buffer: GENERATION_BUFFER;
						   final_mode: BOOLEAN) is
			-- Generate parent table.
		require
			valid_file   : buffer /= Void
		do
			compute_parent_table (final_mode)
			Par_table.generate (buffer, final_mode, Current)
		end

	make_parent_table_byte_code (ba: BYTE_ARRAY) is
			-- Generate parent table.
		do
			compute_parent_table (False)
			Par_table.make_byte_code (ba, Current)
		end

feature {NONE} -- Implementation

	compute_parent_table (final_mode: BOOLEAN) is
			-- Compute parent table and make it available in `Par_table'.
		local
			parents     : FIXED_LIST [CL_TYPE_A];
			parent_type : CL_TYPE_A
			gen_type    : GEN_TYPE_A;
			a_class     : CLASS_C
		do
			gen_type ?= type
			a_class  := associated_class

			if gen_type /= Void and then gen_type.generics /= Void then
				Par_table.init (type.generated_id (final_mode, Void),
								gen_type.generics.count,
								a_class.name, a_class.is_expanded);
			else
				Par_table.init (type.generated_id (final_mode, Void), 0,
								a_class.name, a_class.is_expanded);
			end

			if is_expanded then
					-- Use a reference counterpart as a parent to ensure
					-- that reattachment of expanded to reference works
					-- as expected.
				parent_type := type.reference_type
				if parent_type.has_associated_class_type (type) then
					par_table.append_type (parent_type)
				else
					parent_type := Void
				end
			end
			if parent_type = Void then
				from
					parents := a_class.conforming_parents
					parents.start
				until
					parents.after
				loop
					parent_type := parents.item
					if gen_type /= Void then
						parent_type := parent_type.adapted_in (Current)
					end
					Par_table.append_type (parent_type)
					parents.forth
				end
			end
		end

	Par_table: PARENT_TABLE is
			-- Buffer for parent table generation
		once
			create Result.make
		end;

feature -- Skeleton generation

	generate_skeleton1 (buffer: GENERATION_BUFFER) is
			-- Generate skeleton names and types of Current class type
		require
			skeleton_exists: skeleton /= Void
		local
			parent_list: like parent_types
		do
			if not skeleton.empty then
					-- Generate attribute names sequence
				buffer.put_string ("static char *names")
				buffer.put_integer (type_id)
				buffer.put_string (" [] =%N")
				skeleton.generate_name_array

					-- Generate attribute types sequence
				buffer.put_string ("uint32 types")
				buffer.put_integer (type_id)
				buffer.put_string (" [] =%N")
				skeleton.generate_type_array

					-- Generate expanded generic type arrays
				Byte_context.init (Current)
				skeleton.generate_generic_type_arrays

				if byte_context.final_mode then

						-- Generate attribute offset table pointer array
					buffer.put_string ("static long offsets")
					buffer.put_integer (type_id)
					buffer.put_string (" [] =%N")
					skeleton.generate_offset_array
				else
						-- Generate attribute rout id array
					buffer.put_string ("static int32 cn_attr")
					buffer.put_integer (type_id)
					buffer.put_string (" [] =%N")
					skeleton.generate_rout_id_array
				end
			end

				-- Generate parent dynamic type array
			parent_list := parent_types
			buffer.put_string ("static EIF_TYPE_INDEX cn_parents")
			buffer.put_integer (type_id)
			buffer.put_string (" [] = {")
			from
				parent_list.start
			until
				parent_list.after
			loop
				buffer.put_type_id (parent_list.item.type_id)
				buffer.put_character (',')
				buffer.put_character (' ')
				parent_list.forth
			end
			buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
			buffer.put_string ("};%N%N")

			if
				byte_context.final_mode and
				associated_class.has_invariant and
				system.keep_assertions
			then
					-- Generate extern declaration for invariant
					-- routine of the current class type
				buffer.put_string ("extern void ")
				buffer.put_string (Encoder.feature_name (type_id, Invariant_body_index))
				buffer.put_string ("();%N%N")
			end
		end

	generate_skeleton2 (buffer: GENERATION_BUFFER) is
			-- Generate skeleton of Current class type
		local
			skeleton_empty: BOOLEAN
			a_class: CLASS_C
			creation_feature: FEATURE_I
			r_id: INTEGER
			rout_info: ROUT_INFO
		do
			a_class := associated_class
			skeleton_empty := skeleton.empty
			buffer.generate_block_open
			buffer.put_new_line
			buffer.put_string ("(long) ")
			buffer.put_integer (skeleton.count)
			buffer.put_character (',')
			buffer.put_new_line
			buffer.put_string_literal (a_class.name)
			buffer.put_character (',')
			buffer.put_new_line
			if not skeleton_empty then
				buffer.put_string ("names")
				buffer.put_integer (type_id)
			else
				buffer.put_string ("NULL")
			end
			buffer.put_character (',')
			buffer.put_new_line
			buffer.put_string ("cn_parents")
			buffer.put_integer (type_id)
			buffer.put_character (',')
			buffer.put_new_line
			if not skeleton_empty then
				buffer.put_string ("types")
				buffer.put_integer (type_id)
				buffer.put_character (',')
				buffer.put_new_line
				buffer.put_string ("gtypes")
				buffer.put_integer (type_id)
			else
				buffer.put_string ("NULL")
				buffer.put_character (',')
				buffer.put_new_line
				buffer.put_string ("NULL")
			end

				-- Store Skeleton flag associated to Current type
			buffer.put_character (',')
			buffer.put_new_line
			buffer.put_string ("(uint16) ")
			buffer.put_natural_16 (skeleton_flags)
			buffer.put_character (',')
			buffer.put_new_line

			if byte_context.final_mode then
				if
					a_class.has_invariant and then system.keep_assertions
				then
					buffer.put_string (Encoder.feature_name (type_id, Invariant_body_index))
				else
					buffer.put_string ("(void (*)()) 0")
				end
				buffer.put_character (',')
				buffer.put_new_line

				if not skeleton_empty then
					buffer.put_string ("offsets")
					buffer.put_integer (type_id)
					buffer.put_new_line
				else
					buffer.put_string
						("(long *) 0%N")
				end
			else
					-- Routine id array of attributes
				if not skeleton_empty then
					buffer.put_string ("cn_attr")
					buffer.put_integer (type_id)
				else
					buffer.put_string ("(int32 *) 0")
				end
				buffer.put_character (',')
				buffer.put_new_line

					-- Skeleton size
				skeleton.generate_workbench_size (buffer)
				buffer.put_character (',')
				buffer.put_new_line

					-- Skeleton number of references
				buffer.put_integer
						(skeleton.nb_reference + skeleton.nb_expanded)
				buffer.put_two_character ('L', ',')
				buffer.put_new_line

				if
					not Compilation_modes.is_precompiling and
					not associated_class.is_precompiled
				then
						-- Creation feature id if any.
					buffer.put_string ("(int32) ")
					creation_feature := a_class.creation_feature
					if creation_feature /= Void then
						buffer.put_integer (creation_feature.feature_id)
					else
						buffer.put_integer (0)
					end

						-- Static type id
					buffer.put_string (",(int32) ")
					buffer.put_static_type_id (static_type_id)
				else
					buffer.put_string ("(int32) ")
					creation_feature := a_class.creation_feature
					if creation_feature /= Void then
						r_id := creation_feature.rout_id_set.first
						rout_info := System.rout_info_table.item (r_id)
						buffer.put_integer (rout_info.origin)
						buffer.put_string (",(int32) ")
						buffer.put_integer (rout_info.offset)
					else
						buffer.put_string ("0,(int32) 0")
					end
				end
				buffer.put_character (',')
				buffer.put_new_line

				if
					not Compilation_modes.is_precompiling and
					not associated_class.is_precompiled
				then
						-- Generate reference on routine id array
					buffer.put_string ("ra")
					buffer.put_integer (associated_class.class_id)
				else
					buffer.put_string ("(int32 *) 0")
				end
				buffer.put_character (',')

				if a_class.has_visible then
						-- Generate cecil structure if any
					generate_cecil (buffer)
				end
			end
			buffer.generate_block_close
		end

feature -- Structure generation

	generate_expanded_structure_declaration (buffer: GENERATION_BUFFER; a_name: STRING) is
			-- Declaration of variable `a_name' for current expanded type in `buffer'.
		require
			is_expanded: is_expanded
			buffer_not_void: buffer /= Void
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			buffer.put_new_line
			buffer.put_string (expanded_structure_name)
			buffer.put_character (' ')
			buffer.put_string (a_name)
			buffer.put_string (";")
		end

	generate_expanded_structure_definition (buffer: GENERATION_BUFFER) is
			-- Define associated expanded structure if current is expanded.
		require
			buffer_not_void: buffer /= Void
		do
			if is_expanded then
				buffer.put_new_line
				buffer.put_string (expanded_structure_name)
				buffer.put_string (" {")
				buffer.put_string ("char data [")
				if byte_context.final_mode then
					skeleton.generate_size (buffer, False)
				else
					buffer.put_integer (skeleton.workbench_size)
				end
				generate_expanded_overhead_size (buffer)
				buffer.put_string ("]; };")
			end
		end

	generate_expanded_overhead_size (buffer: GENERATION_BUFFER) is
			-- Generate size of overhead if any.
		require
			is_expanded: is_expanded
			buffer_not_void: buffer /= Void
		do
--			if byte_context.workbench_mode or else skeleton.has_references then
				buffer.put_string (" + OVERHEAD")
--			end
		end

	generate_expanded_type_initialization (buffer: GENERATION_BUFFER; a_name: STRING; a_type: TYPE_A; a_context_type: CLASS_TYPE) is
			-- Generate initialization of expanded local variable `a_name' and `type `a_type'
			-- declared in the context of `a_context_type' into `buffer'.
		require
			is_expanded: is_expanded
			buffer_not_void: buffer /= Void
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			a_type_not_void: a_type /= Void
			compatible_type: a_type.adapted_in (a_context_type).generic_derivation.same_as (type)
		local
--			l_gen_type: GEN_TYPE_A
			l_create_info: CREATE_INFO
			l_workbench_mode: BOOLEAN
		do
			l_create_info := a_type.create_info
			l_workbench_mode := byte_context.workbench_mode
--			l_gen_type ?= a_type.adapted_in (type)
--			if l_workbench_mode or else (skeleton.has_references or l_gen_type /= Void) then
					-- The dynamic type has to be set after setting the flags.
					-- Also note that we use EO_C as those expanded cannot move.
				buffer.put_new_line
				buffer.put_string ("((union overhead *) ")
				buffer.put_string (a_name)
				buffer.put_string (".data)->ov_flags = EO_EXP | EO_C;")

				l_create_info.generate_start (buffer)
				l_create_info.generate_gen_type_conversion (0)

				buffer.put_new_line
				buffer.put_string ("RT_DFS((union overhead *) ")
				buffer.put_string (a_name)
				buffer.put_string (".data, ")
				l_create_info.generate_type_id (buffer, not l_workbench_mode, 0)
				buffer.put_character (')')
				buffer.put_character (';')
				l_create_info.generate_end (buffer)
--			end
		end

	generate_expanded_creation (buffer: GENERATION_BUFFER; a_target_name: STRING; a_type: TYPE_A; a_context_type: CLASS_TYPE) is
			-- Allocate memory and call to `default_create' if needed on `a_target_name' of type `a_type'
			-- declared in context `a_context_type'.
		require
			is_expanded: is_expanded
			buffer_not_void: buffer /= Void
			a_target_name_not_void: a_target_name /= Void
			a_target_name_not_empty: not a_target_name.is_empty
			a_type_not_void: a_type /= Void
			compatible_type: a_type.adapted_in (a_context_type).generic_derivation.same_as (type)
		local
			l_create_info: CREATE_INFO
		do
			l_create_info := a_type.create_info
			l_create_info.generate_start (buffer)
			l_create_info.generate_gen_type_conversion (0)
			buffer.put_new_line
			buffer.put_string (a_target_name)
			buffer.put_string ("= RTLN(")
			l_create_info.generate_type_id (buffer, not byte_context.workbench_mode, 0)
			buffer.put_two_character (')', ';')
			l_create_info.generate_end (buffer)
		end

	generate_expanded_initialization (buffer: GENERATION_BUFFER; a_target_name, a_parent_name: STRING; needs_initialization: BOOLEAN) is
			-- If `needs_initialization', initialize expanded attributes of `a_target_name'
			-- which is located in `a_parent_name' object.
			-- Then generate call to `default_create' if needed on `a_target_name'.
		require
			is_expanded: is_expanded
			buffer_not_void: buffer /= Void
			a_target_name_not_void: a_target_name /= Void
			a_target_name_not_empty: not a_target_name.is_empty
			a_parent_name_not_void: needs_initialization implies a_parent_name /= Void
			a_parent_name_not_empty: needs_initialization implies not a_parent_name.is_empty
		local
			creation_feature: FEATURE_I
			c_name: STRING
			l_written_class: CLASS_C
			l_written_type: CLASS_TYPE
		do
			if needs_initialization then
				if byte_context.workbench_mode then
					buffer.put_new_line
					buffer.put_string ("wstdinit(")
					buffer.put_string (a_target_name)
					buffer.put_character (',')
					buffer.put_string (a_parent_name)
					buffer.put_string (");")
				else
					if has_creation_routine then
						c_name := encoder.feature_name (type_id, initialization_body_index)
						Extern_declarations.add_routine_with_signature (Void_type.c_type.c_string,
							c_name, <<"EIF_REFERENCE, EIF_REFERENCE">>)
						buffer.put_new_line
						buffer.put_string (c_name)
						buffer.put_character ('(')
						buffer.put_string (a_target_name)
						buffer.put_character (',')
						buffer.put_string (a_parent_name)
						buffer.put_string (");")
					end
				end
			end
			if byte_context.workbench_mode then
					-- RTLEI is a macro used to initialize expanded types
				buffer.put_new_line
				buffer.put_string ("RTLXI(")
				buffer.put_string (a_target_name)
				buffer.put_string (");")
			else
					-- Manually call creation procedure on `a_target_name' only if
					-- it is not the version of ANY or if it is not empty.
				creation_feature := associated_class.creation_feature
				if
					creation_feature /= Void and then
					(creation_feature.is_external or not creation_feature.is_empty)
				then
					l_written_class := System.class_of_id (creation_feature.written_in)
					l_written_type := l_written_class.meta_type (Current)
					c_name := Encoder.feature_name (l_written_type.type_id,
						creation_feature.body_index)
					buffer.put_new_line
					buffer.put_string (c_name)
					buffer.put_character ('(')
					buffer.put_string (a_target_name)
					Extern_declarations.add_routine_with_signature (Void_type.c_type.c_string,
						c_name, <<EIF_REFERENCE_str>>)
					buffer.put_string (");")
				end
			end
		end

	expanded_structure_name: STRING is
			-- Name of associated structure.
		require
			is_expanded: is_expanded
		do
			create Result.make (20)
			Result.append (once "struct eif_ex_")
			Result.append_integer (static_type_id - 1)
		ensure
			expanded_structure_name_not_void: Result /= Void
		end

feature -- Cecil generation

	generate_cecil (buffer: GENERATION_BUFFER) is
			-- Generation of the Cecil table
		require
			has_visible: associated_class.has_visible
		local
			final_mode: BOOLEAN
		do
			final_mode := byte_context.final_mode
			buffer.put_new_line
			buffer.put_character ('{')
			buffer.put_string (once "(int32) ")
			buffer.put_integer (associated_class.visible_table_size)
			buffer.put_string (once ", sizeof(char *(*)()), cl")
			buffer.put_integer (associated_class.class_id)
			buffer.put_string (once ", (char *) cr")
			buffer.put_integer (type_id)
			buffer.put_character ('}')
		end

feature -- Byte code generation

	melted_feature_table: MELTED_FEATURE_TABLE is
		local
			parent_list: like parent_types
			ba: BYTE_ARRAY
			creation_feature: FEATURE_I
			class_name: STRING
		do
			ba := Byte_array
			ba.clear

				-- 1. dynamic type
			ba.append_short_integer (type_id - 1)

				-- 2. generator string
			class_name := associated_class.name
			check
				class_name_not_too_long: class_name.count <= ba.max_string_count
			end
			ba.append_string (class_name)

				-- 3. number of attributes
			ba.append_integer (skeleton.count)

				-- 4. attribute names, meta-types and full types
			skeleton.make_names_byte_code (ba)
			skeleton.make_type_byte_code (ba)
			skeleton.make_gen_type_byte_code (ba)

				-- 5. Parent list
			from
				parent_list := parent_types
					-- 5.1: parent count
				ba.append_short_integer (parent_list.count)
				parent_list.start
			until
				parent_list.after
			loop
					-- 5.2: parent dynamic type
				ba.append_short_integer (parent_list.item.type_id - 1)
				parent_list.forth
			end

				-- 6. Store skeleton flags
			ba.append_natural_16 (skeleton_flags)

				-- 7. Routine ids of attributes
			skeleton.make_rout_id_array (ba)

				-- 8. Reference number
			ba.append_integer (skeleton.nb_reference + skeleton.nb_expanded)

				-- 9. Skeleton size
			skeleton.make_size_byte_code (ba)

				-- Creation feature id if any.
			creation_feature := associated_class.creation_feature
			if creation_feature /= Void then
				ba.append_integer_32 (creation_feature.feature_id)
			else
				ba.append_integer_32 (0)
			end

				-- Static type id
			ba.append_integer_32 (static_type_id - 1)

			Result := ba.feature_table
		end

feature -- Cleaning

	remove_c_generated_files is
			-- Remove the C generated files when we remove `Current' from system.
		local
			retried, file_exists: BOOLEAN
			object_name: STRING
			generation_dir: DIRECTORY_NAME
			c_file_name, cpp_file_name: FILE_NAME
			packet_nb: INTEGER
			file: PLAIN_TEXT_FILE
			finished_file_name: FILE_NAME
			finished_file: PLAIN_TEXT_FILE
		do
			if not retried and not is_precompiled and System.makefile_generator /= Void then
				create generation_dir.make_from_string (project_location.workbench_path)

				packet_nb := packet_number

					-- Descriptor file removal
				create object_name.make (5)
				object_name.append_character (C_prefix)
				object_name.append_integer (packet_nb)
				create c_file_name.make_from_string (generation_dir)
				c_file_name.extend (object_name)

				create object_name.make (12)
				object_name.append (base_file_name)
				object_name.append_character (Descriptor_file_suffix)
				object_name.append (Dot_c)
				finished_file_name := c_file_name.twin
				c_file_name.set_file_name (object_name)
				create file.make (c_file_name)
				file_exists := file.exists
				if file_exists and then file.is_writable then
					file.delete
				end
				if file_exists then
						-- We delete `finished' only if there was a file to delete
						-- If there was no file, maybe it was simply a melted class.
					finished_file_name.set_file_name (Finished_file_for_make)
					create finished_file.make (finished_file_name)
					if finished_file.exists and then finished_file.is_writable then
						finished_file.delete
					end
				end

					-- C Code file removal
				create c_file_name.make_from_string (generation_dir)
				create object_name.make (5)
				object_name.append_character (C_prefix)
				object_name.append_integer (packet_nb)
				c_file_name.extend (object_name)
				finished_file_name := c_file_name.twin
				cpp_file_name := c_file_name.twin
				create object_name.make (12)
				object_name.append (base_file_name)
				object_name.append (Dot_c)
				c_file_name.set_file_name (object_name)
				create file.make (c_file_name)
				file_exists := file.exists
				if file_exists and then file.is_writable then
					file.delete
				else
					create object_name.make (12)
					object_name.append (base_file_name)
					object_name.append (Dot_cpp)
					cpp_file_name.set_file_name (object_name)
					create file.make (cpp_file_name)
					file_exists := file.exists
					if file_exists and then file.is_writable then
						file.delete
					end
				end
				if file_exists then
						-- We delete `finished' only if there was a file to delete
						-- If there was no file, maybe it was simply a melted class.
					finished_file_name.set_file_name (Finished_file_for_make)
					create finished_file.make (finished_file_name)
					if finished_file.exists and then finished_file.is_writable then
						finished_file.delete
					end
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Convenience

	skeleton_flags: NATURAL_16 is
			-- Corresponding flags to insert in skeleton structure
		local
			l_class: like associated_class
		do
			l_class := associated_class

				-- From bit 0 to bit 3: we store `tuple_code'.
			if basic_type /= Void then
					-- For basic types, we use `basic_type' as `type' only
					-- contains the true expanded forms of basic types (i.e CL_TYPE_A).
				Result := basic_type.c_type.tuple_code
			else
				Result := type.c_type.tuple_code
			end

				-- Bit 8: Store `is_declared_as_expanded'
			if l_class.is_expanded then
				Result := Result | 0x0100
			end

				-- Bit 9: Store `is_expanded'
			if is_expanded then
				Result := Result | 0x0200
			end

				-- Bit 10: Store `has_dispose'
			if System.disposable_descendants.has (l_class) then
				Result := Result | 0x0400
			end

				-- Bit 11: Store `is_composite'
			if has_creation_routine then
				Result := Result | 0x0800
			end

				-- Bit 12: Store `is_deferred'
			if l_class.is_deferred then
				Result := Result | 0x1000
			end
		end

feature {NONE} -- Debug output

	debug_output: STRING is
			-- Output displayed in debugger.
		local
			l_name: STRING
		do
			if type /= Void then
				l_name := type.dump
				create Result.make (l_name.count + 15 )
			else
				create Result.make (13)
			end
			Result.append_character ('s')
			Result.append_character (':')
			Result.append_integer (static_type_id)
			Result.append_character (',')
			Result.append_integer (type_id)
			if l_name /= Void then
				Result.append_character (':')
				Result.append_character (' ')
				Result.append (l_name)
			end
		end

feature {NONE} -- Implementation

	EIF_REFERENCE_str: STRING = "EIF_REFERENCE"

	internal_namespace: STRING
	internal_type_name: STRING
			-- Internal storage to help us reconstruct names of classes and features
			-- from a precompiled library.

	create_current: CREATE_CURRENT is
			-- Byte code information for "like Current" type creation.
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	type_number_int: INTEGER
		-- used to chache the type number

invariant
	type_not_void: type /= Void
	type_is_generic_derivation: type.generic_derivation.same_as (type)
	valid_type_id: type_id > 0
	valid_static_type_id: static_type_id > 0
	valid_implementation_id: System.il_generation implies implementation_id > 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end
