class CLASS_TYPE 

inherit
	SHARED_COUNTER

	SHARED_GENERATOR

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
			!!skeleton.make
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
			body_id: BODY_ID
			feature_i: FEATURE_I
			file, extern_decl_file: INDENT_FILE
			inv_byte_code: INVARIANT_B
			final_mode: BOOLEAN
			generate_c_code: BOOLEAN
			once_count:INTEGER
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
	
					file := generation_file

					file.open_write_c
						-- Write header
					file.putstring ("/*%N * Code for class ")
					type.dump (file)
					file.putstring ("%N */%N%N")
					-- Includes wanted
					file.putstring ("#include %"eif_eiffel.h%"%N%N")
					if final_mode then
						file.putstring ("#include %"")
						file.putstring (base_file_name)
						file.putstring (".h%"%N%N")
	
						-- Generation of extern declarations
						Extern_declarations.generate_header (extern_declaration_filename)

					elseif Compilation_modes.is_precompiling then
						Class_counter.generate_extern_offsets (file)
						Static_type_id_counter.generate_extern_offsets (file)
						Real_body_id_counter.generate_extern_offsets (file)
					end

					if final_mode then
						!! extern_decl_file.make (extern_declaration_filename)
						extern_decl_file.open_append
					else
						extern_decl_file := file
					end

					byte_context.set_generated_file (file)
					byte_context.set_extern_declaration_file (extern_decl_file)

					if final_mode and then has_creation_routine then
							-- Generate the creation routine in final mode
						generate_creation_routine (file, extern_decl_file)
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
									file.putstring ("static int EIF_oidx_off = 0;%N")
								end
							end
							generate_feature (feature_i, file)
						end
						feature_table.forth
					end

						-- Create module initialization procedure
					file.generate_function_signature ("void", id.module_init_name, True, extern_decl_file, <<"">>, <<"void">>)
	
					if once_count > 0 then
						file.putstring ("%TEIF_oidx_off = EIF_once_count;%N%
									%%TEIF_once_count += ")
						file.putint (once_count)
						file.putstring (";%N}%N%N")
					else
						file.putstring ("%N}%N%N")
					end

					if current_class.has_invariant and then ((not final_mode) or else current_class.assertion_level.check_invariant) then
						inv_byte_code := Inv_byte_server.disk_item (current_class.id)
						inv_byte_code.generate_invariant_routine
						byte_context.clear_all
					end
	
					if final_mode then
						extern_decl_file.close
	
						Extern_declarations.generate (extern_declaration_filename)
						Extern_declarations.wipe_out
					end

					file.close_c

				else
						-- The file hasn't been generated
					System.makefile_generator.record_empty_class_type (id)
				end

					-- clean the list of shared include files
				shared_include_queue.wipe_out
			end
		end

	generate_feature (f: FEATURE_I; file: INDENT_FILE) is
			-- Generate feature `feat' in Current class type
		require
			good_argument: f /= Void
			to_generate_in: f.to_generate_in (associated_class)
		do
			f.generate (Current, file)
		end

	generation_file: INDENT_FILE is
			-- File for generating class code of the current class type
		local
			file_name: STRING
		do
			file_name := full_file_name (Class_suffix)
			if byte_context.final_mode then
				if class_has_cpp_externals then
					file_name.append (Dot_xpp)
				else
					file_name.append (Dot_x)
				end
			else
				if class_has_cpp_externals then
					file_name.append (Dot_cpp)
				else
					file_name.append (Dot_c)
				end
			end
			!! Result.make (file_name)
		end

	descriptor_file: INDENT_FILE is
			-- File for generating descriptor table
		require
			Workbench_mode: not byte_context.final_mode
		local
			file_name: STRING
		do
			file_name := full_file_name (Descriptor_suffix)
			file_name.append_character (Descriptor_file_suffix)
			file_name.append (Dot_c)
			!! Result.make (file_name)
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

	generate_creation_routine (file, h_file: INDENT_FILE) is
			-- Creation routine, if necessary (i.e. if the object is
			-- composite and has expanded we must initialize, as well
			-- as some special header flags).
		require
			has_creation_routine
		local
			sub_skel: SKELETON
			i, nb_ref: INTEGER
			exp_desc: EXPANDED_DESC
			class_type, sub_class_type: CLASS_TYPE
			old_cursor: CURSOR
			c_name, creat_name: STRING
			bits_desc: BITS_DESC
			creation_feature: FEATURE_I
			value: INTEGER
		do
			c_name := init_procedure_name
			nb_ref := skeleton.nb_reference
			skeleton.go_bits
				-- There are some expandeds here...
				-- Generate a procedure which will be in charge of all the
				-- initialisation bulk.

			file.generate_function_signature ("void", c_name, True, h_file,
				<<"Current", "parent">>, <<"EIF_REFERENCE", "EIF_REFERENCE">>)

			file.indent
			file.putstring ("RTLD;")
			file.new_line
			file.new_line
			file.putstring ("RTLI(2);%N")
			file.putstring ("l[0] = Current;")
			file.new_line
			file.putstring ("l[1] = parent;")
			file.new_line
			from
			until
				skeleton.after or else not skeleton.item.is_bits
			loop
					-- Initialize dynamic type of the bit attribute
				file.putstring ("HEADER(l[0]")

					--| In this instruction and in the followings, we put `False' as second
					--| arguments. This means we won't generate anything if there is nothing
					--| to generate. Remember that `True' is used in the generation of attributes
					--| table in Final mode.
				skeleton.generate(file, False)
				file.putstring(")->ov_flags = egc_bit_dtype;")
				file.new_line
				file.putstring ("*(uint32 *) (l[0]")
				bits_desc ?= skeleton.item; 	-- Cannot fail
				skeleton.generate(file, False)
				file.putstring(") = ")
				file.putint (bits_desc.value)
				file.putchar (';')
				file.new_line
				skeleton.forth
			end
				-- Current class type is composite
			file.putstring ("HEADER(l[0])->ov_flags |= EO_COMP;")
			file.new_line
			from
				i := 0
			until
				skeleton.after
			loop
				file.putstring ("*(char **) (l[0] ")
				value := nb_ref + i
				if value /= 0 then
					file.putstring (" + @REFACS(")
					file.putint (value)
					file.putstring (")) =")
				else
					file.putstring (") =")
				end
				file.new_line
				file.indent
				file.putstring("l[0]")
					-- There is a side effect with generation
				old_cursor := skeleton.cursor
				skeleton.generate(file, False)
				skeleton.go_to (old_cursor)
				file.putchar (';')
				file.new_line
				file.exdent

				exp_desc ?= skeleton.item;		-- Cannot fail
					-- Initialize dynaminc type of the expanded object
				file.putstring ("HEADER(l[0]")
				skeleton.generate(file, False)
				skeleton.go_to (old_cursor)
				file.putstring(")->ov_flags = ")
				file.putint(exp_desc.type_id - 1)
				file.putchar (';')
				file.new_line

					-- Mark expanded object
				file.putstring ("HEADER(l[0]")
				skeleton.generate(file, False)
				skeleton.go_to (old_cursor)
				file.putstring(")->ov_flags |= EO_EXP;")
				file.new_line
				file.putstring ("HEADER(l[0]")
				skeleton.generate(file, False)
				skeleton.go_to (old_cursor)
				file.putstring(")->ov_size = ")
				skeleton.generate(file, False)
				skeleton.go_to (old_cursor)
				file.putstring (" + (l[0] - l[1]);")
				file.new_line

					-- Call creation of expanded if there is one
				class_type := exp_desc.class_type
				creation_feature := 
						class_type.associated_class.creation_feature
				if creation_feature /= Void then
					creat_name := 
						creation_feature.body_id.feature_name (class_type.id)
					file.putstring (creat_name)
					file.putstring ("(l[0]")
					skeleton.generate(file, False)
					skeleton.go_to (old_cursor)
					file.putstring (");");	
					file.new_line
				end
					-- If the expanded object also has expandeds, we need
					-- to call the initialization routine too.
				sub_class_type := exp_desc.class_type
				sub_skel := sub_class_type.skeleton
				sub_skel.go_expanded
				if not sub_skel.after then
					file.putstring (sub_class_type.init_procedure_name)
					file.putstring("(l[0]")
					skeleton.generate(file, False)
					file.putstring(", l[1]);")
					file.new_line
				end
				skeleton.forth
				i := i + 1
			end
			file.putstring ("RTLE;%N}%N%N")
			file.exdent
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

	generate_parent_table (parents_file : INDENT_FILE; 
						   final_mode   : BOOLEAN) is
			-- Generate parent table
		require
			valid_file   : parents_file /= Void;
			is_open_write: parents_file.is_open_write
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

			Par_table.generate (parents_file, final_mode)
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

	generate_skeleton1 (skeleton_file: INDENT_FILE) is
			-- Generate skeleton names and types of Current class type
		require
			skeleton_exists: skeleton /= Void
			skeleton_file_is_open: Skeleton_file.is_open_write
		local
			parent_list: like parent_types
		do
			if not skeleton.empty then
					-- Generate attribute names sequence
				skeleton_file.putstring ("static char *names")
				skeleton_file.putint (type_id)
				skeleton_file.putstring (" [] =%N")
				skeleton.generate_name_array

					-- Generate attribute types sequence
				skeleton_file.putstring ("uint32 types")
				skeleton_file.putint (type_id)
				skeleton_file.putstring (" [] =%N")
				skeleton.generate_type_array

				if byte_context.final_mode then	
	
						-- Generate attribute offset table pointer array
					skeleton_file.putstring ("static long *offsets")
					skeleton_file.putint (type_id)
					skeleton_file.putstring (" [] =%N")
					skeleton.generate_offset_array
				else
						-- Generate attribute rout id array
					skeleton_file.putstring ("static int32 cn_attr")
					skeleton_file.putint (type_id)
					skeleton_file.putstring (" [] =%N")
					skeleton.generate_rout_id_array
				end
			end

				-- Generate parent dynamic type array
			parent_list := parent_types
			skeleton_file.putstring ("static int cn_parents")
			skeleton_file.putint (type_id)
			skeleton_file.putstring (" [] = {")
			from
				parent_list.start
			until
				parent_list.after
			loop
				skeleton_file.putint (parent_list.item.type_id - 1)
				skeleton_file.putstring (", ")
				parent_list.forth
			end
			skeleton_file.putstring ("-1};%N%N")

			if	byte_context.final_mode
				and
				associated_class.has_invariant
				and
				associated_class.assertion_level.check_invariant
			then
					-- Generate extern declaration for invariant
					-- routine of the current class type
				skeleton_file.putstring ("extern void ")
				skeleton_file.putstring (
					Invariant_body_id.feature_name (id))
				skeleton_file.putstring ("();%N%N")
			end
		end

	generate_skeleton2 (skeleton_file: INDENT_FILE) is
			-- Generate skeleton of Current class type
		require
			skeleton_file_is_open: Skeleton_file.is_open_write
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
			skeleton_file.putstring ("{%N(long) ")
			skeleton_file.putint (skeleton.count)
			skeleton_file.putstring (",%N%"")
			upper_class_name := a_class.name_in_upper
			skeleton_file.putstring (upper_class_name)
			skeleton_file.putstring ("%",%N")
			if not skeleton_empty then
				skeleton_file.putstring ("names")
				skeleton_file.putint (type_id)
				skeleton_file.putstring (",%N")
			else
				skeleton_file.putstring ("(char **) 0,%N")
			end
			skeleton_file.putstring ("cn_parents")
			skeleton_file.putint (type_id)
			skeleton_file.putstring (",%N")
			if not skeleton_empty then
				skeleton_file.putstring ("types")
				skeleton_file.putint (type_id)
				skeleton_file.putstring (",%N")
			else
				skeleton_file.putstring ("(uint32 *) 0,%N")
			end

			if byte_context.final_mode then
				if
					a_class.has_invariant
					and a_class.assertion_level.check_invariant
				then
					skeleton_file.putstring (
						Invariant_body_id.feature_name (id))
				else
					skeleton_file.putstring ("(void (*)()) 0")
				end
				skeleton_file.putstring (",%N")

				if not skeleton_empty then
					skeleton_file.putstring ("offsets")
					skeleton_file.putint (type_id)
					skeleton_file.new_line
				else
					skeleton_file.putstring
						("(long **) 0%N")
				end
			else
					-- Routine id array of attributes
				if not skeleton_empty then
					skeleton_file.putstring ("cn_attr")
					skeleton_file.putint (type_id)
				else
					skeleton_file.putstring ("(int32 *) 0")
				end
				skeleton_file.putstring (",%N")
						
					-- Skeleton size
				skeleton.generate_workbench_size (skeleton_file)
				skeleton_file.putstring (",%N")

					-- Skeleton number of references
				skeleton_file.putint
						(skeleton.nb_reference + skeleton.nb_expanded)
				skeleton_file.putstring ("L,%N")

					-- Deferred class type flag
				if a_class.is_deferred then
					skeleton_file.putstring ("'\01',%N")
				else
					skeleton_file.putstring ("'\0',%N")
				end

					-- Composite class type flag
				if has_creation_routine then
					skeleton_file.putstring ("'\01',%N")
				else
					skeleton_file.putstring ("'\0',%N")
				end

				if
					not Compilation_modes.is_precompiling and
					not associated_class.is_precompiled
				then
						-- Creation feature id if any.
					skeleton_file.putstring ("(int32) ")
					creation_feature := a_class.creation_feature
					if creation_feature /= Void then
						skeleton_file.putint (creation_feature.feature_id)
					else
						skeleton_file.putint (0)
					end

						-- Static type id 
					skeleton_file.putstring (",(int32) ")
					skeleton_file.putint (id.id - 1)
				else
					skeleton_file.putstring ("(int32) ")
					creation_feature := a_class.creation_feature
					if creation_feature /= Void then
						r_id := creation_feature.rout_id_set.first
						rout_info := System.rout_info_table.item (r_id)
						skeleton_file.putint (rout_info.origin.id)
						skeleton_file.putstring (",(int32) ")
						skeleton_file.putint (rout_info.offset)
					else
						skeleton_file.putstring ("0,(int32) 0")
					end
				end
				skeleton_file.putstring (",%N")
					
					-- Dispose routine id
				if System.memory_descendants.has (associated_class) then
					skeleton_file.putstring ("'\01',%N")
				else
					skeleton_file.putstring ("'\0',%N")
				end

				if
					not Compilation_modes.is_precompiling and
					not associated_class.is_precompiled
				then
						-- Generate reference on routine id array
					skeleton_file.putstring ("ra")
					skeleton_file.putint (associated_class.id.id)
				else
					skeleton_file.putstring ("(int32 *) 0")
				end
				skeleton_file.putstring (",%N")

					-- Generate cecil structure if any
				generate_cecil (skeleton_file)
			end

			skeleton_file.putchar ('}')
		end

feature -- Cecil generation

	generate_cecil (file: FILE) is
			-- Generation of the Cecil table
		local
			final_mode: BOOLEAN
		do
			final_mode := byte_context.final_mode
			if associated_class.has_visible then
				file.putchar ('{')
				file.putstring ("(int32) ")
				file.putint (associated_class.visible_table_size)
				if final_mode then
					file.putstring (", sizeof(char *(*)()), cl")
				else
					file.putstring (", sizeof(int32), cl")
				end
				file.putint (associated_class.id.id)
				file.putstring (", (char *) cr")
				if final_mode then
					file.putint (type_id)
				else
					file.putint (associated_class.id.id)
				end
				file.putchar ('}')
			else
				file.putstring
					("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
			end
		end

	class_has_cpp_externals: BOOLEAN is
			-- Are there any external C++ features in this class?
		local
			current_class: CLASS_C
			external_i: EXTERNAL_I
			feature_i: FEATURE_I
			feature_table: FEATURE_TABLE
		do
			current_class := associated_class
				--| The search on `types' is changing types' cursor position
				--| Keep this in Mind
				--| ES
			if current_class.types.search_item (type) = Current then
				feature_table := current_class.feature_table
				from
					feature_table.start
				until
					feature_table.after or else Result
				loop
					feature_i := feature_table.item_for_iteration
					if
						(byte_context.final_mode
						and then feature_i.to_generate_in (current_class))
						or else is_modifiable
					then
						external_i ?= feature_i
						if external_i /= Void then
							Result := external_i.is_cpp
						end
					end
					feature_table.forth
				end
			end
		end

feature -- Conformance table generation

	generate_conformance_table (conformance_file: INDENT_FILE) is
			-- Generate conformance table
		do
			Conf_table.init (type_id)
			Conf_table.mark (type_id)
			associated_class.make_conformance_table (Conf_table)
			Conf_table.generate (conformance_file)
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

				-- 4. attribute names and meta-types
			skeleton.make_names_byte_code (ba)
			skeleton.make_type_byte_code (ba)

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

	generate_separate_pattern (file: FILE) is
			-- Generation of the Cecil table
			-- Caller must guarantee it's called in Final mode
		require
			finalized_mode: byte_context.final_mode
		do
			if associated_class.has_visible then
				file.putstring ("{(int32) ")
				file.putint (associated_class.visible_table_size)
				file.putstring (", sizeof(EIF_INTEGER), cl")
				file.putint (associated_class.id.id)
				file.putstring (", (char *) cpatid")
				file.putint (type_id)
				file.putchar ('}')
			else
				file.putstring ("{(int32) 0, (int) 0, (char **) 0, (char *) 0}")
			end
		end

end
