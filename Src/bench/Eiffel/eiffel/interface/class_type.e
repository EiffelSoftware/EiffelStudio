class CLASS_TYPE 

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

	SHARED_EXEC_TABLE

	SHARED_DECLARATIONS

	SHARED_TABLE

	SHARED_INCLUDE

	SYSTEM_CONSTANTS

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	COMPILER_EXPORTER

	SHARED_TYPE_I

creation
	make
	
feature 

	id: TYPE_ID
			-- Unique id for current class type
			--| Useful to set the name of the associated generated file
			--| which has to be dynamic type (`type_id') independant.
			--| Remeber that after during each freezing, dynamic types
			--| are reprocessed.

	type: CL_TYPE_I
			-- Type of the class: it includes meta-instantiation of
			-- possible generic parameters

	associated_eclass: CLASS_C is
			-- Associated class
		require
			type_exists: type /= Void
		do
			Result := System.class_of_id (type.base_id)
		end

feature 

	type_id: INTEGER
			-- Identification of the class type

	skeleton: SKELETON
			-- Skeleton of the class type

	is_modifiable: BOOLEAN is
			-- Is current type not part of a precompiled library?
		do
			Result := not is_precompiled
		end

	is_changed: BOOLEAN
			-- Is the attribute list changed ? [has the skeleton of
			-- attributes to be re-generated ?]

	set_is_changed (b: BOOLEAN) is
			-- Assign `b' to `is_changed' ?
		do
			is_changed := b
		end

	set_skeleton (s: like skeleton) is
			-- Assign `s' to `skeleton'.
		do
			skeleton := s
		end

	make (t: CL_TYPE_I) is
		require
			good_argument: t /= Void
			not t.has_formal
		do
			type := t
			is_changed := True
			type_id := System.type_id_counter.next
			id := Static_type_id_counter.next_id
			System.reset_melted_conformance_table
		end

feature -- Conveniences

	set_type (t: CL_TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	set_type_id (i: INTEGER) is
			-- Assign `i' to `type_id'.
		do
			type_id := i
		end

	associated_class: CLASS_C is
			-- Associated class
		require
			type_exists: type /= Void
		do
			Result := System.class_of_id (type.base_id)
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
				!! Result.make
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

	valid_body_ids: TWO_WAY_SORTED_SET [BODY_ID]

	update_valid_body_ids is
		local
			feature_table: FEATURE_TABLE
			current_class: CLASS_C
			feature_i: FEATURE_I
		do
			!! valid_body_ids.make
			valid_body_ids.compare_objects
			current_class := associated_class
			feature_table := current_class.feature_table

			from
				feature_table.start
			until
				feature_table.after
			loop
				feature_i := feature_table.item_for_iteration
				if feature_i.to_generate_in (current_class) then
					valid_body_ids.extend (feature_i.body_id)
				end
				feature_table.forth
			end
		end

	pass4 is
			-- Generation of the C file
		local
			feature_table: FEATURE_TABLE
			current_class: CLASS_C
			feature_i: FEATURE_I
			external_i: EXTERNAL_I
			file, extern_decl_file: INDENT_FILE
			inv_byte_code: INVARIANT_B
			final_mode: BOOLEAN
			generate_c_code: BOOLEAN
			once_count:INTEGER
			buffer, header_buffer: GENERATION_BUFFER
		do
			final_mode := byte_context.final_mode

			current_class := associated_class

				--| The search on `types' is changing types' cursor position
				--| Keep this in Mind
				--| ES
			if current_class.types.search_item (type) = Current then
					-- Do not generate twice the same type if it has
					-- been derived in two different merged precompiled
					-- libraries.

					-- Clear buffers for the new generation
				buffer := generation_buffer
				buffer.clear_all
				header_buffer := header_generation_buffer
				header_buffer.clear_all

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
							-- Write header
						buffer.putstring ("/*%N * Code for class ")
						type.dump (buffer)
						buffer.putstring ("%N */%N%N")
							-- Includes wanted
						buffer.putstring ("#include %"eif_eiffel.h%"%N%N")
					else
							-- Write header
						header_buffer.putstring ("/*%N * Code for class ")
						type.dump (header_buffer)
						header_buffer.putstring ("%N */%N%N")
							-- Includes wanted
						header_buffer.putstring ("#include %"eif_eiffel.h%"%N%N")
						header_buffer := buffer
					end

					if final_mode then
						buffer.putstring ("%N#include %"")
						buffer.putstring (base_file_name)
						buffer.putstring (".h%"%N%N")
	
							-- Generation of extern declarations
						Extern_declarations.generate_header (header_buffer)
					elseif Compilation_modes.is_precompiling then
						Class_counter.generate_extern_offsets (buffer)
						Static_type_id_counter.generate_extern_offsets (buffer)
						Real_body_id_counter.generate_extern_offsets (buffer)
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
									buffer.putint (id.id)
									buffer.putstring (" = 0;%N")
								end
							end
							
								-- Generate the C code of `feature_i'
							generate_feature (feature_i, buffer)
						end
						feature_table.forth
					end

						-- Create module initialization procedure
					buffer.generate_function_signature ("void", id.module_init_name, True, header_buffer, <<"">>, <<"void">>)
	
					if once_count > 0 then
						buffer.putstring ("%TEIF_oidx_off")
						buffer.putint (id.id)
						buffer.putstring (" = EIF_once_count;%N%
									%%TEIF_once_count += ")
						buffer.putint (once_count)
						buffer.putstring (";%N}%N%N")
					else
						buffer.putstring ("%N}%N%N")
					end

					if current_class.has_invariant and then ((not final_mode) or else current_class.assertion_level.check_invariant) then
						inv_byte_code := Inv_byte_server.disk_item (current_class.id)
						inv_byte_code.generate_invariant_routine
						byte_context.clear_all
					end
	
					if final_mode then
						Extern_declarations.generate (header_buffer)
						Extern_declarations.wipe_out

						!! extern_decl_file.make_open_write (extern_declaration_filename)
						extern_decl_file.put_string (header_buffer)
						extern_decl_file.close
					end
					buffer.close_c

					file := open_generation_file (byte_context.has_cpp_externals_calls)
					if not final_mode then
						file.put_string (header_generation_buffer)
					end
					file.put_string (buffer)
					file.close

				else
						-- The file hasn't been generated
					System.makefile_generator.record_empty_class_type (id)
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

	open_generation_file (has_cpp_externals: BOOLEAN): INDENT_FILE is
			-- Open in write mode a file for generating class code
			-- of the current class type
		local
			file_name: STRING
		do
			file_name := full_file_name (Class_suffix)
			if byte_context.final_mode then
				if has_cpp_externals then
					file_name.append (Dot_xpp)
				else
					file_name.append (Dot_x)
				end
			else
				if has_cpp_externals then
					file_name.append (Dot_cpp)
				else
					file_name.append (Dot_c)
				end
			end
			!! Result.make_open_write (file_name)
		end

	open_descriptor_file: INDENT_FILE is
			-- Open in write mode a file for generating descriptor table
		require
			Workbench_mode: not byte_context.final_mode
		local
			file_name: STRING
		do
			file_name := full_file_name (Descriptor_suffix)
			file_name.append_character (Descriptor_file_suffix)
			file_name.append (Dot_c)
			!! Result.make_open_write (file_name)
		end

	extern_declaration_filename: STRING is
			-- File name for external declarations in final mode
		do
			Result := full_file_name (Class_suffix)
			Result.append (Dot_h)
		end

	full_file_name (sub_dir_prefix: STRING): STRING is
			-- Generated file name prefix
			-- Side effect: Create the corresponding subdirectory if it
			-- doesnot exist yet.
		local
			subdirectory: STRING
			dir: DIRECTORY
			f_name: FILE_NAME
			dir_name: DIRECTORY_NAME
		do
			if System.in_final_mode then
				Result := final_generation_path
			else
				Result := workbench_generation_path
			end
			!!subdirectory.make (5)
			subdirectory.append (sub_dir_prefix)
			subdirectory.append_integer (packet_number)

			!!dir_name.make_from_string (Result)
			dir_name.extend (subdirectory)
			!!dir.make (dir_name)
			if not dir.exists then
				dir.create_dir
			end
			!!f_name.make_from_string (dir_name)
			f_name.set_file_name (base_file_name)
			Result := f_name
		end

	base_file_name: STRING is
			-- Generated base file name prefix
		do
			Result := associated_class.base_file_name
			Result.append_integer (id.id)
		end

	packet_number: INTEGER is
			-- Packet in which the file will be generated
		do
			Result := id.packet_number
		end

	relative_file_name: STRING is
			-- Relative path of the generation file
		local
			f_name: FILE_NAME
			temp: STRING
		do
				-- Subdirectory
			!! temp.make (10)
			temp.append (Class_suffix)
			temp.append_integer (packet_number)

			!! f_name.make_from_string (temp)

				-- File name
			temp := clone (base_file_name)
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

	dispose_feature: FEATURE_I is
		do
			Result := associated_class.dispose_feature
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
			old_cursor: CURSOR
			c_name, creat_name: STRING
			bits_desc: BITS_DESC
			creation_feature: FEATURE_I
			value: INTEGER
			gen_type: GEN_TYPE_I
		do
			c_name := init_procedure_name
			nb_ref := skeleton.nb_reference
			skeleton.go_bits
				-- There are some expandeds here...
				-- Generate a procedure which will be in charge of all the
				-- initialisation bulk.

			buffer.generate_function_signature ("void", c_name, True, header_buffer,
				<<"Current", "parent">>, <<"EIF_REFERENCE", "EIF_REFERENCE">>)

			buffer.indent
			buffer.putstring ("RTLD;")
			buffer.new_line
			buffer.new_line
			buffer.putstring ("RTLI(2);%N")
			buffer.putstring ("l[0] = Current;")
			buffer.new_line
			buffer.putstring ("l[1] = parent;")
			buffer.new_line
			from
			until
				skeleton.after or else not skeleton.item.is_bits
			loop
					-- Initialize dynamic type of the bit attribute
				buffer.putstring ("HEADER(l[0]")

					--| In this instruction and in the followings, we put `False' as second
					--| arguments. This means we won't generate anything if there is nothing
					--| to generate. Remember that `True' is used in the generation of attributes
					--| table in Final mode.
				skeleton.generate(buffer, False)
				buffer.putstring(")->ov_flags = egc_bit_dtype;")
				buffer.new_line
				buffer.putstring ("*(uint32 *) (l[0]")
				bits_desc ?= skeleton.item; 	-- Cannot fail
				skeleton.generate(buffer, False)
				buffer.putstring(") = ")
				buffer.putint (bits_desc.value)
				buffer.putchar (';')
				buffer.new_line
				skeleton.forth
			end
				-- Current class type is composite
			buffer.putstring ("HEADER(l[0])->ov_flags |= EO_COMP;")
			buffer.new_line
			from
				i := 0
			until
				skeleton.after
			loop
				buffer.putstring ("*(char **) (l[0] ")
				value := nb_ref + i
				if value /= 0 then
					buffer.putstring (" + @REFACS(")
					buffer.putint (value)
					buffer.putstring (")) =")
				else
					buffer.putstring (") =")
				end
				buffer.new_line
				buffer.indent
				buffer.putstring("l[0]")
					-- There is a side effect with generation
				position := skeleton.position
				skeleton.generate(buffer, False)
				skeleton.go_to (position)
				buffer.putchar (';')
				buffer.new_line
				buffer.exdent

				exp_desc ?= skeleton.item;		-- Cannot fail
					-- Initialize dynaminc type of the expanded object
				gen_type ?= exp_desc.type_i

				if gen_type = Void then
					-- Not an expanded generic
					buffer.putstring ("HEADER(l[0]")
					skeleton.generate(buffer, False)
					skeleton.go_to (position)
					buffer.putstring(")->ov_flags = ")
					buffer.putint(exp_desc.type_id - 1)
					buffer.putchar (';')
					buffer.new_line
				else
					-- Expanded generic
					generate_ov_flags_start (buffer, gen_type)
					buffer.putstring ("HEADER(l[0]")
					skeleton.generate(buffer, False)
					skeleton.go_to (position)
					buffer.putstring(")->ov_flags = typres")
					generate_ov_flags_finish (buffer)
					buffer.new_line
				end

					-- Mark expanded object
				buffer.putstring ("HEADER(l[0]")
				skeleton.generate(buffer, False)
				skeleton.go_to (position)
				buffer.putstring(")->ov_flags |= EO_EXP;")
				buffer.new_line
				buffer.putstring ("HEADER(l[0]")
				skeleton.generate(buffer, False)
				skeleton.go_to (position)
				buffer.putstring(")->ov_size = ")
				skeleton.generate(buffer, False)
				skeleton.go_to (position)
				buffer.putstring (" + (l[0] - l[1]);")
				buffer.new_line

					-- Call creation of expanded if there is one
				class_type := exp_desc.class_type
				creation_feature := class_type.associated_class.creation_feature
				if creation_feature /= Void then
					creat_name := creation_feature.body_id.feature_name (class_type.id)
					buffer.putstring (creat_name)
					buffer.putstring ("(l[0]")
					skeleton.generate(buffer, False)
					skeleton.go_to (position)
					buffer.putstring (");");	
					buffer.new_line
						-- Generate in the header file, the declaration of the creation
						-- routine.
					Extern_declarations.add_routine (Void_c_type, creat_name)
				end
					-- If the expanded object also has expandeds, we need
					-- to call the initialization routine too.
				sub_class_type := exp_desc.class_type
				sub_skel := sub_class_type.skeleton
				sub_skel.go_expanded
				if not sub_skel.after then
					buffer.putstring (sub_class_type.init_procedure_name)
					buffer.putstring("(l[0]")
					skeleton.generate(buffer, False)
					buffer.putstring(", l[1]);")
					buffer.new_line
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
			final_mode: BOOLEAN
		do
			final_mode := byte_context.final_mode

			buffer.indent
			buffer.putchar ('{')
			buffer.new_line
			buffer.indent

			if gen_type.is_explicit then
				-- Optimize: Use static array
				buffer.putstring ("static int16 typarr [] = {")
			else
				buffer.putstring ("int16 typarr [] = {")
			end

			buffer.putint (type.generated_id (final_mode))
			buffer.putstring (", ")
			gen_type.generate_cid (buffer, final_mode, False)
			buffer.putstring ("-1};")
			buffer.new_line
			buffer.putstring ("int16 typres;")
			buffer.new_line
			buffer.putstring ("static int16 typcache = -1;")
			buffer.new_line
			buffer.new_line
			buffer.putstring ("typres = RTCID(&typcache, l[0],")

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
			buffer.exdent
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

	init_procedure_name: STRING is
			-- C name of the procedure used to initialize the object
		do
			Result := Initialization_body_id.feature_name (id)
		end

feature -- Byte code generation

	update_dispatch_table is
			-- Update the dispatch table using melted features 
		require
			good_context: associated_class.has_features_to_melt
			Not_precompiled: not is_precompiled
		local
			melted_list: SORTED_TWO_WAY_LIST [MELTED_INFO]
			feat_tbl: FEATURE_TABLE
		do
			from
					-- Iteration on the melted list of the associated class
					-- processed during third pass of the compilation.
				melted_list := associated_class.melted_set
				melted_list.start

				feat_tbl := associated_class.feature_table
			until
				melted_list.after
			loop
					-- Generation of byte code
				melted_list.item.update_dispatch_unit (Current, feat_tbl)
				melted_list.forth
			end
		end

	melt is
			-- Generate byte code for changed features of Current class
			-- type
		require
			good_context: associated_class.has_features_to_melt
			Not_precompiled: not is_precompiled
		local
			melted_list: SORTED_TWO_WAY_LIST [MELTED_INFO]
			feat_tbl: FEATURE_TABLE
		do
			from
					-- Iteration on the melted list of the associated class
					-- processed during third pass of the compilation.
				melted_list := associated_class.melted_set
				melted_list.start

					-- Initialization of the byte code context
				byte_context.init (Current)
				--byte_context.set_class_type (Current)

				feat_tbl := associated_class.feature_table
				if valid_body_ids = Void then
					!!valid_body_ids.make
				end
			until
				melted_list.after
			loop
					-- Generation of byte code
				melted_list.item.melt (Current, feat_tbl)

				melted_list.forth
			end
		end

	melt_feature_table is
			-- Melt the feature table of the associated class
		local
			melted_feat_tbl: MELTED_FEATURE_TABLE
		do
			melted_feat_tbl := melted_feature_table
			melted_feat_tbl.set_type_id (id)
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
			!!Result.make
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

			if	byte_context.final_mode
				and
				associated_class.has_invariant
				and
				associated_class.assertion_level.check_invariant
			then
					-- Generate extern declaration for invariant
					-- routine of the current class type
				buffer.putstring ("extern void ")
				buffer.putstring (
					Invariant_body_id.feature_name (id))
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
			r_id: ROUTINE_ID
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
					a_class.has_invariant
					and a_class.assertion_level.check_invariant
				then
					buffer.putstring (
						Invariant_body_id.feature_name (id))
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
					buffer.putint (id.id - 1)
				else
					buffer.putstring ("(int32) ")
					creation_feature := a_class.creation_feature
					if creation_feature /= Void then
						r_id := creation_feature.rout_id_set.first
						rout_info := System.rout_info_table.item (r_id)
						buffer.putint (rout_info.origin.id)
						buffer.putstring (",(int32) ")
						buffer.putint (rout_info.offset)
					else
						buffer.putstring ("0,(int32) 0")
					end
				end
				buffer.putstring (",%N")
					
					-- Dispose routine id
				if System.memory_descendants.has (associated_class) then
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
					buffer.putint (associated_class.id.id)
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
				buffer.putint (associated_class.id.id)
				buffer.putstring (", (char *) cr")
				if final_mode then
					buffer.putint (type_id)
				else
					buffer.putint (associated_class.id.id)
				end
				buffer.putchar ('}')
			else
				buffer.putstring ("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
			end
		end

feature -- Conformance table generation

	generate_conformance_table (buffer: GENERATION_BUFFER) is
			-- Generate conformance table
		do
			Conf_table.init (type_id)
			Conf_table.mark (type_id)
			associated_class.make_conformance_table (Conf_table)
			Conf_table.generate (buffer)
		end

	make_conformance_table_byte_code (ba: BYTE_ARRAY) is
			-- Generate conformance table
		require
			good_argument: ba /= Void
		do
			Conf_table.init (type_id)
			Conf_table.mark (type_id)
			associated_class.make_conformance_table (Conf_table)
			Conf_table.make_byte_code (ba)
		end

	Conf_table: CONFORM_TABLE is
			-- Buffer for conformance table generation
		once
			!!Result.make (System.type_id_counter.value)
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
			ba.append_int32_integer (id.id - 1)

				-- Dispose routine id of dispose
			if System.memory_descendants.has (associated_class) then
				ba.append ('%/001/')
			else
				ba.append ('%U')
			end

			Result := ba.feature_table
		end

feature -- Precompilation

	is_precompiled: BOOLEAN is
		do
			Result := id.is_precompiled
		end

feature -- Debug

	trace is
		do
			skeleton.trace
			type.trace
		end

feature -- Cecil generation for Concurrent Eiffel

	generate_separate_pattern (buffer: GENERATION_BUFFER) is
			-- Generation of the Cecil table
			-- Caller must guarantee it's called in Final mode
		require
			finalized_mode: byte_context.final_mode
		do
			if associated_class.has_visible then
				buffer.putstring ("{(int32) ")
				buffer.putint (associated_class.visible_table_size)
				buffer.putstring (", sizeof(EIF_INTEGER), cl")
				buffer.putint (associated_class.id.id)
				buffer.putstring (", (char *) cpatid")
				buffer.putint (type_id)
				buffer.putchar ('}')
			else
				buffer.putstring ("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
			end
		end

end
