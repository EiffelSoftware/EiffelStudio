indexing
	description: "[
		Description of a generic derivation of a generic CLASS_C. It contains
		type of the current generic derivation. All generic derivations are stored
		in TYPE_LIST of CLASS_C
		]"
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

	SHARED_TYPE_I
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

create
	make

feature {NONE} -- Initialization

	make (t: CL_TYPE_I) is
			-- Create new generic derivation CLASS_TYPE based on
			-- `t', type of actual CLASS_C as used in Eiffel code.
		require
			good_argument: t /= Void
			not_formal: not t.has_formal
		do
			type := t
			is_changed := True
			type_id := System.type_id_counter.next
			static_type_id := Static_type_id_counter.next_id
			if System.il_generation then
				if
					associated_class.is_external or 
					associated_class.is_frozen or
					associated_class.is_single
				then
					implementation_id := static_type_id
				else
					implementation_id := Static_type_id_counter.next_id
				end
			end
			System.reset_melted_conformance_table
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

	type: CL_TYPE_I
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
			Result := not associated_class.is_external and not is_precompiled
		end

	is_changed: BOOLEAN
			-- Is the attribute list changed ? [has the skeleton of
			-- attributes to be re-generated ?]

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
			Result := il_casing.namespace_casing (is_dotnet_name, internal_namespace).twin
			if a_prefix /= Void then
				Result.append_character ('.')
				Result.append (a_prefix)
			end
			if not Result.is_empty then
				Result.append_character ('.')	
			end
			Result.append (il_casing.pascal_casing (is_dotnet_name, internal_type_name,
					feature {IL_CASING_CONVERSION}.upper_case))
		end

	conformance_table: PACKED_BOOLEANS
			-- Conformance table for current type.

feature -- Status report

	conform_to (other: CLASS_TYPE): BOOLEAN is
			-- Does `Current' type conform to `other'?
		require
			other_not_void: other /= Void
			conformance_table_not_void: conformance_table /= Void
			final_mode: byte_context.final_mode
		local
			l_other_type_id: INTEGER
			l_packed: PACKED_BOOLEANS
		do
			l_other_type_id := other.type_id
			Result := l_other_type_id = type_id
			if not Result then
				l_packed := conformance_table
				if l_other_type_id <= l_packed.upper then
					Result := l_packed.item (l_other_type_id)
				end
			end
		ensure
			conform_to_definition:
				Result implies associated_class.conform_to (other.associated_class)
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

	set_type (t: CL_TYPE_I) is
			-- Assign `t' to `type'.
		require
			t_not_void: t /= Void
		do
			type := t
		ensure
			type_set: type = t
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
			internal_namespace := associated_class.lace_class.actual_namespace.twin
			internal_type_name := type.il_type_name (Void)
			l_pos := internal_type_name.last_index_of ('.', internal_type_name.count)
			internal_type_name := internal_type_name.substring (l_pos + 1, internal_type_name.count)
			is_dotnet_name := System.dotnet_naming_convention
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
			-- Build recursively the conformance table of class `cl'.
		require
			cl_not_void: cl /= Void
			conformance_table_not_void: cl.conformance_table /= Void
		local
			a_parent: CLASS_TYPE
			a_table: like conformance_table
			l_area: SPECIAL [CL_TYPE_A]
			l_parent_type: CL_TYPE_I
			l_gen_type: GEN_TYPE_I
			i, nb: INTEGER
		do
			a_table := cl.conformance_table
			if type_id > a_table.upper or else a_table.item (type_id) = False then
					-- The parent has not been inserted yet. We use `force' as `type_id'
					-- might be greater than what `a_table' can hold.
				a_table.force (True, type_id)
				from
					l_area := associated_class.parents.area
					nb := associated_class.parents.count
					l_gen_type ?= type
				until
					i = nb
				loop
					l_parent_type := l_area.item (i).type_i
					if l_gen_type /= Void then
							-- Current class type is generic, we need to evaluate parent
							-- type in context of current class type.
						l_parent_type := l_parent_type.instantiation_in (l_gen_type)
					end
					a_parent := l_parent_type.associated_class_type
					a_parent.build_conformance_table_of (cl)
					i := i + 1
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
			Result := type.il_type_name (Void)
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
			Result := type.il_type_name ("Impl")
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
			Result := type.il_type_name ("Create")
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

	written_type (a_class: CLASS_C): CL_TYPE_I is
			-- Class type associated to class `a_class' in the context
			-- of Current
		require
			good_argument: a_class /= Void
			consistency: associated_class.conform_to (a_class)
		do
			Result := a_class.meta_type (type)
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
			parent_type: CL_TYPE_I
			already_in: BOOLEAN
			gen_type: GEN_TYPE_I
		do
			from
				create Result.make
				parents := associated_class.parents
				parents.start
			until
				parents.after
			loop
				parent_type := parents.item.type_i
				if parent_type.has_formal then
					gen_type ?= type
					parent_type := parent_type.instantiation_in (gen_type)
				end
				from
						-- Check if the parent type is not already in
						-- the list (repeated inheritance ...).
					already_in := False
					Result.start
				until
					Result.after or else already_in
				loop
					already_in := Result.item.type.same_as (parent_type)
					Result.forth
				end
				if not already_in then
					Result.extend (System.class_type_of_id (parent_type.type_id))
				end
			
				parents.forth
			end
		end

feature -- Generation

	pass4 is
			-- Generation of the C file
		local
			feature_table: FEATURE_TABLE
			current_class: CLASS_C
			feature_i: FEATURE_I
			file, extern_decl_file: INDENT_FILE
			inv_byte_code: INVARIANT_B
			final_mode: BOOLEAN
			generate_c_code: BOOLEAN
			once_count:INTEGER
			tmp, buffer, header_buffer, headers: GENERATION_BUFFER
		do
			final_mode := byte_context.final_mode

			current_class := associated_class

			if current_class.types.search_item (type) = Current then
					-- Do not generate twice the same type if it has
					-- been derived in two different merged precompiled
					-- libraries.

					-- Clear buffers for the new generation
				buffer := generation_buffer
				buffer.clear_all
				header_buffer := header_generation_buffer
				header_buffer.clear_all
				if final_mode then
					create headers.make (100)
				end

				feature_table := current_class.feature_table
				if final_mode then
						-- Check to see if there is really something to generate
	
					generate_c_code := has_creation_routine or else
							(current_class.has_invariant and then
							 current_class.assertion_level.check_invariant)
					from
						feature_table.start
					until
						generate_c_code or else feature_table.after
					loop
						feature_i := feature_table.item_for_iteration
						if feature_i.to_generate_in (current_class) then
							generate_c_code := feature_i.used
						end
						feature_table.forth
					end
				else
					generate_c_code := is_modifiable
				end

				if generate_c_code then
						-- First, we reset the `has_cpp_externals_calls' of `BYTE_CONTEXT'
						-- which will enable us to know wether or not a C++ call has been
						-- generated
					byte_context.set_has_cpp_externals_calls (False)

					if final_mode then
						tmp := headers
					else
						tmp := header_buffer
					end

							-- Write header
					tmp.putstring ("/*%N * Code for class ")
					type.dump (tmp)
					tmp.putstring ("%N */%N%N")
						-- Includes wanted
					tmp.putstring ("#include %"eif_eiffel.h%"%N%N")


					if final_mode then
						headers.putstring ("%N#include %"")
						headers.putstring (base_file_name)
						headers.putstring (".h%"%N%N")
	
							-- Generation of extern declarations
						header_buffer.putstring ("#ifndef ")
						header_buffer.putstring (already_included_header)
						header_buffer.putstring ("%N#define ")
						header_buffer.putstring (already_included_header)
						header_buffer.new_line
						Extern_declarations.generate_header (header_buffer)
					else
						header_buffer.start_c_specific_code
					end

					buffer.open_write_c

					byte_context.set_buffer (buffer)
					byte_context.set_header_buffer (header_buffer)

					if final_mode and then has_creation_routine then
							-- Generate the creation routine in final mode
						generate_creation_routine (buffer, header_buffer)
					end

					from
						feature_table.start
						byte_context.init (Current)
					until
						feature_table.after
					loop
						feature_i := feature_table.item_for_iteration
						if feature_i.to_generate_in (current_class) then
							if feature_i.is_once then
									-- If it's a once, give it a key.
								byte_context.set_once_index (once_count)
								once_count := once_count + 1
								if once_count = 1 then
										--| First declaration of EIF_oidx_off in the
										--| C code
									buffer.putstring ("static int EIF_oidx_off")
									buffer.putint (static_type_id)
									buffer.putstring (" = 0;%N")
								end
							end
							
								-- Generate the C code of `feature_i'
							generate_feature (feature_i, buffer)
						end
						feature_table.forth
					end

						-- Create module initialization procedure
					buffer.generate_function_signature ("void", Encoder.module_init_name
						(static_type_id), True, header_buffer, <<>>, <<>>)
	
					if once_count > 0 then
						buffer.putstring ("%TEIF_oidx_off")
						buffer.putint (static_type_id)
						buffer.putstring (" = EIF_once_count;%N%
									%%TEIF_once_count += ")
						buffer.putint (once_count)
						buffer.putstring (";%N}%N%N")
					else
						buffer.putstring ("%N}%N%N")
					end

					if
						current_class.has_invariant and then
						((not final_mode) or else
						current_class.assertion_level.check_invariant)
					then
						inv_byte_code := Inv_byte_server.disk_item (current_class.class_id)
						byte_context.set_byte_code (create {STD_BYTE_CODE})
						inv_byte_code.generate_invariant_routine
						byte_context.clear_all
					end
	
					if final_mode then
						Extern_declarations.generate (header_buffer)
						Extern_declarations.generate_header_files (headers)
						Extern_declarations.wipe_out

							-- End of header protection
						header_buffer.putstring ("%N#endif%N")

						create extern_decl_file.make_open_write (extern_declaration_filename)
						header_buffer.put_in_file (extern_decl_file)
						extern_decl_file.close
					else
						Extern_declarations.generate (header_buffer)
						Extern_declarations.generate_header_files (header_buffer)
						Extern_declarations.wipe_out
					end
					buffer.close_c

					if not final_mode then
							-- Give the information status in Workbench mode only on the
							-- C generate file type (either .c/.x or .cpp/.xpp)
							-- This information is used later to create the `file_to_compile'
							-- file in each sudirectories of the W_code.
						set_has_cpp_externals (byte_context.has_cpp_externals_calls)
						file := open_generation_file (has_cpp_externals)
					else
						file := open_generation_file (byte_context.has_cpp_externals_calls)
					end
					
					if not final_mode then
						Header_generation_buffer.put_in_file (file)
					else
						headers.put_in_file (file)
					end
					buffer.put_in_file (file)
					file.close

				else
						-- The file hasn't been generated
					System.makefile_generator.record_empty_class_type (static_type_id)
				end

					-- clean the list of shared include files
				shared_include_queue.wipe_out
			end
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
			file_name: STRING
			previous_file_name: STRING
			previous_file: PLAIN_TEXT_FILE
		do
			file_name := full_file_name (C_prefix)
			if byte_context.final_mode then
					-- In final mode we do not check about status changes
					-- since we delete the content of the F_code directory.
				if has_cpp_externals_calls then
					file_name.append (Dot_xpp)
				else
					file_name.append (Dot_x)
				end
			else
					-- If the status of the file has been changed we delete the
					-- previous version.
				if has_cpp_status_changed then
					previous_file_name := file_name.twin
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
				if has_cpp_externals_calls then
					file_name.append (Dot_cpp)
				else
					file_name.append (Dot_c)
				end
			end
			create Result.make_c_code_file (file_name)
		end

	open_descriptor_file: INDENT_FILE is
			-- Open in write mode a file for generating descriptor table
		require
			Workbench_mode: not byte_context.final_mode
		local
			file_name: STRING
		do
			file_name := full_file_name (C_prefix)
			file_name.append_character (Descriptor_file_suffix)
			file_name.append (Dot_c)
			create Result.make_c_code_file (file_name)
		end

	extern_declaration_filename: STRING is
			-- File name for external declarations in final mode
		do
			Result := full_file_name (C_prefix)
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
			s.append_character (C_prefix)
			s.append_integer (packet_number)
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
			Result.append_character (C_prefix)
			Result.append_integer (packet_number)
			Result.append_character ('_')
			Result.append (base_file_name)
			Result.append_character ('_')
		end

	full_file_name (sub_dir_prefix: CHARACTER): STRING is
			-- Generated file name prefix
			-- Side effect: Create the corresponding subdirectory if it
			-- doesnot exist yet.
		local
			subdirectory: STRING
			dir: DIRECTORY
			f_name: FILE_NAME
			dir_name: DIRECTORY_NAME
			finished_file: PLAIN_TEXT_FILE
			finished_file_name: FILE_NAME
		do
			if System.in_final_mode then
				Result := final_generation_path
			else
				Result := workbench_generation_path
			end
			create subdirectory.make (7)
			subdirectory.append_character (sub_dir_prefix)
			subdirectory.append_integer (packet_number)

			create dir_name.make_from_string (Result)
			dir_name.extend (subdirectory)
			create dir.make (dir_name)
			if not dir.exists then
				dir.create_dir
			end
			create f_name.make_from_string (dir_name)
			f_name.set_file_name (base_file_name)
			Result := f_name

			create finished_file_name.make_from_string (dir_name)
			finished_file_name.set_file_name (Finished_file_for_make)
			create finished_file.make (finished_file_name)
			if finished_file.exists and then finished_file.is_writable then
				finished_file.delete	
			end
		end

	base_file_name: STRING is
			-- Generated base file name prefix
		do
			create Result.make (10)
			Result.append (associated_class.base_file_name)
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
			create temp.make (10)
			temp.append_character (C_prefix)
			temp.append_integer (packet_number)

			create f_name.make_from_string (temp)

				-- File name
			temp := base_file_name
			if byte_context.final_mode then
				temp.append (Dot_x)
			else
				temp.append (Dot_c)
			end

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
			has_creation_routine
		local
			sub_skel: SKELETON
			i, nb_ref, position: INTEGER
			exp_desc: EXPANDED_DESC
			class_type, sub_class_type: CLASS_TYPE
			c_name, creat_name: STRING
			bits_desc: BITS_DESC
			creation_feature: FEATURE_I
			value: INTEGER
			gen_type: GEN_TYPE_I
			written_class: CLASS_C
			written_ctype: CLASS_TYPE
		do
			c_name := Encoder.feature_name (static_type_id, Initialization_body_index)
			nb_ref := skeleton.nb_reference
			skeleton.go_bits
				-- There are some expandeds here...
				-- Generate a procedure which will be in charge of all the
				-- initialisation bulk.

			buffer.generate_function_signature ("void", c_name, True, header_buffer,
				<<"Current", "parent">>, <<"EIF_REFERENCE", "EIF_REFERENCE">>)

			buffer.indent
			buffer.putstring ("uint32 offset_position = 0;")
			buffer.new_line
			buffer.putstring ("RTLD;")
			buffer.new_line
			buffer.new_line
			buffer.putstring ("RTLI(2);")
			buffer.new_line
			buffer.put_current_registration (0)
			buffer.new_line
			buffer.put_local_registration (1, "parent")
			buffer.new_line
			from
			until
				skeleton.after or else not skeleton.item.is_bits
			loop
					--| In this instruction and in the followings, we put `False' as second
					--| arguments. This means we won't generate anything if there is nothing
					--| to generate. Remember that `True' is used in the generation of attributes
					--| table in Final mode.
				buffer.putstring ("offset_position = ");
				skeleton.generate(buffer, False)
				buffer.putchar (';')
				buffer.new_line
					-- Initialize dynamic type of the bit attribute
				buffer.putstring ("HEADER(Current + offset_position")
				buffer.putstring(")->ov_flags = egc_bit_dtype | EO_EXP;")
				buffer.new_line
				bits_desc ?= skeleton.item; 	-- Cannot fail
				buffer.putstring ("*(uint32 *) (Current + offset_position")
				buffer.putstring(") = ")
				buffer.putint (bits_desc.value)
				buffer.putchar (';')
				buffer.new_line
				skeleton.forth
			end
				-- Current class type is composite
			buffer.putstring ("HEADER(Current)->ov_flags |= EO_COMP;")
			buffer.new_line
			from
				i := 0
			until
				skeleton.after
			loop
				buffer.putstring ("offset_position = ");
				position := skeleton.position
				skeleton.generate(buffer, False)
					-- There is a side effect with generation
				skeleton.go_to (position)
				buffer.putchar (';')
				buffer.new_line

				buffer.putstring ("*(EIF_REFERENCE *) (Current ")
				value := nb_ref + i
				if value /= 0 then
					buffer.putstring (" + @REFACS(")
					buffer.putint (value)
					buffer.putstring (")")
				end
				buffer.putstring(") = Current + offset_position;")
				buffer.new_line

				exp_desc ?= skeleton.item;		-- Cannot fail
					-- Initialize dynaminc type of the expanded object
				gen_type ?= exp_desc.type_i

				if gen_type = Void then
					-- Not an expanded generic
					buffer.putstring ("HEADER(Current + offset_position)->ov_flags = ")
					buffer.putint(exp_desc.type_id - 1)
					buffer.putchar (';')
					buffer.new_line
				else
					-- Expanded generic
					generate_ov_flags_start (buffer, gen_type)
					buffer.putstring ("HEADER(Current + offset_position)->ov_flags = typres")
					generate_ov_flags_finish (buffer)
					buffer.new_line
				end

					-- Mark expanded object
				buffer.putstring ("HEADER(Current + offset_position)->ov_flags |= EO_EXP;")
				buffer.new_line
				buffer.putstring ("HEADER(Current + offset_position)->ov_size = ")
				buffer.putstring ("offset_position + (Current - parent);")
				buffer.new_line

					-- Call creation of expanded if there is one
				class_type := exp_desc.class_type
				creation_feature := class_type.associated_class.creation_feature
				if creation_feature /= Void then
					written_class := System.class_of_id (creation_feature.written_in)
					if written_class.generics = Void then
						written_ctype := written_class.types.first
					else
						written_ctype := written_class.meta_type
							(class_type.type).associated_class_type
					end
					creat_name := Encoder.feature_name (written_ctype.static_type_id,
						creation_feature.body_index)
					buffer.putstring (creat_name)
					buffer.putstring ("(Current + offset_position);")
					buffer.new_line
						-- Generate in the header file, the declaration of the creation
						-- routine.
					Extern_declarations.add_routine_with_signature (Void_c_type,
						creat_name, <<"EIF_REFERENCE">>)
				end
					-- If the expanded object also has expandeds, we need
					-- to call the initialization routine too.
				sub_class_type := exp_desc.class_type
				sub_skel := sub_class_type.skeleton
				sub_skel.go_expanded
				if not sub_skel.after then
					creat_name := Encoder.feature_name (sub_class_type.static_type_id,
						Initialization_body_index)
					buffer.putstring (creat_name)
					buffer.putstring("(Current + offset_position, parent);")
					buffer.new_line
					Extern_declarations.add_routine_with_signature (Void_c_type,
						creat_name, <<"EIF_REFERENCE, EIF_REFERENCE">>)
				end
				skeleton.forth
				i := i + 1
			end
			buffer.putstring ("RTLE;%N}%N%N")
			buffer.exdent
		end

	generate_ov_flags_start (buffer: GENERATION_BUFFER; gen_type: GEN_TYPE_I) is
			-- Start creation of generic type for ov_flags.
		require
			buffer_exists: buffer /= Void
			type_exists: gen_type /= Void
		local
			use_init, final_mode: BOOLEAN
			idx_cnt : COUNTER
		do
			final_mode := byte_context.final_mode

			buffer.putchar ('{')
			buffer.new_line
			buffer.indent

			use_init := not gen_type.is_explicit
			
				-- Optimize: Use static array only when `typarr' is
				-- not modified by generated code in multithreaded mode only.
				-- It is safe in monothreaded code as we are guaranteed that
				-- only one thread of execution will use the modified `typarr'.
			if not System.has_multithreaded or else not use_init then
				buffer.putstring ("static ")
			end
			buffer.putstring ("int16 typarr [] = {")

			buffer.putint (type.generated_id (final_mode))
			buffer.putstring (", ")

			if use_init then
				create idx_cnt
				idx_cnt.set_value (1)
				gen_type.generate_cid_array (buffer, final_mode, False, idx_cnt)
			else
				gen_type.generate_cid (buffer, final_mode, False)
			end

			buffer.putstring ("-1};")
			buffer.new_line
			buffer.putstring ("int16 typres;")
			buffer.new_line
			if not use_init then
				buffer.putstring ("static int16 typcache = -1;")
				buffer.new_line
			end
			buffer.new_line
			if use_init then
				idx_cnt.set_value (1)
				gen_type.generate_cid_init (buffer, final_mode, False, idx_cnt)
			end

			if not use_init then
				buffer.putstring ("typres = RTCID2(&typcache, Dftype(Current),")
			else
				buffer.putstring ("typres = RTCID2(NULL, Dftype(Current),")
			end
			buffer.putint (gen_type.generated_id (final_mode))
			buffer.putstring (", typarr);")
			buffer.new_line
		end

	generate_ov_flags_finish (buffer: GENERATION_BUFFER) is
			-- Finish creation of generic type for ov_flags.
		require
			buffer_exists: buffer /= Void
		do
			buffer.putchar (';')
			buffer.new_line
			buffer.exdent
			buffer.putchar ('}')
			buffer.new_line
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
				--byte_context.set_class_type (Current)

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
						   final_mode   : BOOLEAN) is
			-- Generate parent table
		require
			valid_file   : buffer /= Void;
		local
			parents     : FIXED_LIST [CL_TYPE_A];
			parent_type : CL_TYPE_I
			gen_type    : GEN_TYPE_I;
			a_class     : CLASS_C
		do
			gen_type ?= type
			a_class  := associated_class

			if gen_type /= Void and then
					gen_type.meta_generic /= Void then
				Par_table.init (type.generated_id (final_mode), 
								gen_type.meta_generic.count,
								a_class.name_in_upper, a_class.is_expanded);
			else
				Par_table.init (type.generated_id (final_mode), 0,
								a_class.name_in_upper, a_class.is_expanded);
			end

			from
				parents := a_class.parents
				parents.start
			until
				parents.after
			loop
				parent_type := parents.item.type_i
				if gen_type /= Void then
					parent_type := parent_type.instantiation_in (gen_type)
				end
				Par_table.append_type (parent_type)
				parents.forth
			end

			Par_table.generate (buffer, final_mode)
		end;

	make_parent_table_byte_code (ba: BYTE_ARRAY) is
			-- Generate parent table
		local
			parents     : FIXED_LIST [CL_TYPE_A];
			parent_type : CL_TYPE_I
			gen_type    : GEN_TYPE_I;
			a_class     : CLASS_C
		do
			gen_type ?= type
			a_class  := associated_class

			if gen_type /= Void and then
					gen_type.meta_generic /= Void then
				Par_table.init (type.generated_id (False), 
								gen_type.meta_generic.count,
								a_class.name_in_upper, a_class.is_expanded);
			else
				Par_table.init (type.generated_id (False), 0,
								a_class.name_in_upper, a_class.is_expanded);
			end

			from
				parents := a_class.parents;
				parents.start;
			until
				parents.after
			loop
				parent_type := parents.item.type_i

				if gen_type /= Void then
					parent_type := parent_type.instantiation_in (gen_type)
				end

				Par_table.append_type (parent_type)
				parents.forth
			end

			Par_table.make_byte_code (ba);
		end;

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
				buffer.putstring ("static char *names")
				buffer.putint (type_id)
				buffer.putstring (" [] =%N")
				skeleton.generate_name_array

					-- Generate attribute types sequence
				buffer.putstring ("uint32 types")
				buffer.putint (type_id)
				buffer.putstring (" [] =%N")
				skeleton.generate_type_array

					-- Generate expanded generic type arrays
				Byte_context.set_class_type (Current)
				skeleton.generate_generic_type_arrays (type_id)

				if byte_context.final_mode then	
	
						-- Generate attribute offset table pointer array
					buffer.putstring ("static long offsets")
					buffer.putint (type_id)
					buffer.putstring (" [] =%N")
					skeleton.generate_offset_array
				else
						-- Generate attribute rout id array
					buffer.putstring ("static int32 cn_attr")
					buffer.putint (type_id)
					buffer.putstring (" [] =%N")
					skeleton.generate_rout_id_array
				end
			end

				-- Generate parent dynamic type array
			parent_list := parent_types
			buffer.putstring ("static int cn_parents")
			buffer.putint (type_id)
			buffer.putstring (" [] = {")
			from
				parent_list.start
			until
				parent_list.after
			loop
				buffer.putint (parent_list.item.type_id - 1)
				buffer.putstring (", ")
				parent_list.forth
			end
			buffer.putstring ("-1};%N%N")

			if
				byte_context.final_mode and
				associated_class.has_invariant and
				associated_class.assertion_level.check_invariant
			then
					-- Generate extern declaration for invariant
					-- routine of the current class type
				buffer.putstring ("extern void ")
				buffer.putstring (Encoder.feature_name (static_type_id, Invariant_body_index))
				buffer.putstring ("();%N%N")
			end
		end

	generate_skeleton2 (buffer: GENERATION_BUFFER) is
			-- Generate skeleton of Current class type
		local
			upper_class_name: STRING
			skeleton_empty: BOOLEAN
			a_class: CLASS_C
			creation_feature: FEATURE_I
			r_id: INTEGER
			rout_info: ROUT_INFO
		do
			a_class := associated_class
			skeleton_empty := skeleton.empty
			buffer.putstring ("{%N(long) ")
			buffer.putint (skeleton.count)
			buffer.putstring (",%N%"")
			upper_class_name := a_class.name_in_upper
			buffer.putstring (upper_class_name)
			buffer.putstring ("%",%N")
			if not skeleton_empty then
				buffer.putstring ("names")
				buffer.putint (type_id)
				buffer.putstring (",%N")
			else
				buffer.putstring ("(char **) 0,%N")
			end
			buffer.putstring ("cn_parents")
			buffer.putint (type_id)
			buffer.putstring (",%N")
			if not skeleton_empty then
				buffer.putstring ("types")
				buffer.putint (type_id)
				buffer.putstring (",%N")
				buffer.putstring ("gtypes")
				buffer.putint (type_id)
				buffer.putstring (",%N")
			else
				buffer.putstring ("(uint32 *) 0,%N")
				buffer.putstring ("(int16 **) 0,%N")
			end

			if byte_context.final_mode then
				if
					a_class.has_invariant and then
					a_class.assertion_level.check_invariant
				then
					buffer.putstring (Encoder.feature_name (static_type_id, Invariant_body_index))
				else
					buffer.putstring ("(void (*)()) 0")
				end
				buffer.putstring (",%N")

				if not skeleton_empty then
					buffer.putstring ("offsets")
					buffer.putint (type_id)
					buffer.new_line
				else
					buffer.putstring
						("(long *) 0%N")
				end
			else
					-- Routine id array of attributes
				if not skeleton_empty then
					buffer.putstring ("cn_attr")
					buffer.putint (type_id)
				else
					buffer.putstring ("(int32 *) 0")
				end
				buffer.putstring (",%N")
						
					-- Skeleton size
				skeleton.generate_workbench_size (buffer)
				buffer.putstring (",%N")

					-- Skeleton number of references
				buffer.putint
						(skeleton.nb_reference + skeleton.nb_expanded)
				buffer.putstring ("L,%N")

					-- Deferred class type flag
				if a_class.is_deferred then
					buffer.putstring ("'\01',%N")
				else
					buffer.putstring ("'\0',%N")
				end

					-- Composite class type flag
				if has_creation_routine then
					buffer.putstring ("'\01',%N")
				else
					buffer.putstring ("'\0',%N")
				end

				if
					not Compilation_modes.is_precompiling and
					not associated_class.is_precompiled
				then
						-- Creation feature id if any.
					buffer.putstring ("(int32) ")
					creation_feature := a_class.creation_feature
					if creation_feature /= Void then
						buffer.putint (creation_feature.feature_id)
					else
						buffer.putint (0)
					end

						-- Static type id 
					buffer.putstring (",(int32) ")
					buffer.putint (static_type_id - 1)
				else
					buffer.putstring ("(int32) ")
					creation_feature := a_class.creation_feature
					if creation_feature /= Void then
						r_id := creation_feature.rout_id_set.first
						rout_info := System.rout_info_table.item (r_id)
						buffer.putint (rout_info.origin)
						buffer.putstring (",(int32) ")
						buffer.putint (rout_info.offset)
					else
						buffer.putstring ("0,(int32) 0")
					end
				end
				buffer.putstring (",%N")
					
					-- Dispose routine id
				if System.disposable_descendants.has (associated_class) then
					buffer.putstring ("'\01',%N")
				else
					buffer.putstring ("'\0',%N")
				end

				if
					not Compilation_modes.is_precompiling and
					not associated_class.is_precompiled
				then
						-- Generate reference on routine id array
					buffer.putstring ("ra")
					buffer.putint (associated_class.class_id)
				else
					buffer.putstring ("(int32 *) 0")
				end
				buffer.putstring (",%N")

					-- Generate cecil structure if any
				generate_cecil (buffer)
			end

			buffer.putchar ('}')
		end

feature -- Cecil generation

	generate_cecil (buffer: GENERATION_BUFFER) is
			-- Generation of the Cecil table
		local
			final_mode: BOOLEAN
		do
			final_mode := byte_context.final_mode
			if associated_class.has_visible then
				buffer.putchar ('{')
				buffer.putstring ("(int32) ")
				buffer.putint (associated_class.visible_table_size)
				if final_mode then
					buffer.putstring (", sizeof(char *(*)()), cl")
				else
					buffer.putstring (", sizeof(int32), cl")
				end
				buffer.putint (associated_class.class_id)
				buffer.putstring (", (char *) cr")
				if final_mode then
					buffer.putint (type_id)
				else
					buffer.putint (associated_class.class_id)
				end
				buffer.putchar ('}')
			else
				buffer.putstring ("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
			end
		end

feature -- Byte code generation

	melted_feature_table: MELTED_FEATURE_TABLE is
		local
			parent_list: like parent_types
			ba: BYTE_ARRAY
			class_name: STRING
			creation_feature: FEATURE_I
			a_class: CLASS_C
		do
			ba := Byte_array
			ba.clear

				-- 1. dynamic type
			ba.append_short_integer (type_id - 1)

				-- 2. generator string
			class_name := associated_class.name_in_upper
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

				-- 6. Routine ids of attributes
			skeleton.make_rout_id_array (ba)

				-- 7. Reference number
			ba.append_integer (skeleton.nb_reference + skeleton.nb_expanded)
			
				-- 8. Skeleton size
			skeleton.make_size_byte_code (ba)

				-- Deferred class type flag
			a_class := associated_class
			if a_class.is_deferred then
				ba.append ('%/001/')
			else
				ba.append ('%U')
			end

				-- Composite class type flag
			if has_creation_routine then
				ba.append ('%/001/')
			else
				ba.append ('%U')
			end

				-- Creation feature id if any.
			creation_feature := a_class.creation_feature
			if creation_feature /= Void then
				ba.append_int32_integer (creation_feature.feature_id)
			else
				ba.append_int32_integer (0)
			end

				-- Static type id
			ba.append_int32_integer (static_type_id - 1)

				-- Dispose routine id of dispose
			if System.disposable_descendants.has (associated_class) then
				ba.append ('%/001/')
			else
				ba.append ('%U')
			end

			Result := ba.feature_table
		end

feature -- Debug

	trace is
		do
			skeleton.trace
			type.trace
		end

feature {NONE} -- Implementation

	internal_namespace: STRING
	internal_type_name: STRING
			-- Internal storage to help us reconstruct names of classes and features
			-- from a precompiled library.
		
invariant
	type_not_void: type /= Void
	valid_type_id: type_id > 0
	valid_static_type_id: static_type_id > 0
	valid_implementation_id: System.il_generation implies implementation_id > 0

end
