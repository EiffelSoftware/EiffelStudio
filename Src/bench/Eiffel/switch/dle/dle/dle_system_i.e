-- Internal representation of a DLE dynamic system.

class DLE_SYSTEM_I 

inherit
	SYSTEM_I
		redefine
			sorter, is_dynamic, make_update, check_static_calls,
			change_classes, reset_type_id, remove_dynamic_class_id,
			generate_pattern_table, generate_skeletons,
			generate_conformance_table, generate_dispatch_table,
			generate_main_file, generate_dle_file, generate_init_file, 
			generate_rout_info_table, generate_option_file,
			generate_cecil, generate_exec_table, shake_tables,
			generate_reference_table, degree_minus_4, degree_minus_5,
			generate_size_table, clear_dle_finalization_data,
			dle_type_set, generate_plug, mark_dynamic_descendant_used,
			dle_finalized_nobid_table, generate_dle_make_table,
			mark_dynamic_classes, make_update_descriptors,
			check_dle_finalize, dle_system_name, dle_max_topo_id,
			dynamic_class_ids, min_type_id
		end

feature -- Initialization

	extending (static: SYSTEM_I) is
			-- Create a dynamic system as an extension of the
			-- static system `static'.
		require
			static_exists: static /= Void
			extendible: static.extendible
		do
				-- Copy the static system's data structures.
				-- This is a raw copy of all the attributes of `static'.
				-- We could be smarter by copying only what's relevant.

				-- Attributes from `BASIC_SYSTEM_I'.
			any_class := static.any_class
			array_class := static.array_class
			bit_class := static.bit_class
			boolean_class := static.boolean_class
			boolean_ref_class := static.boolean_ref_class
			character_class := static.character_class
			character_ref_class := static.character_ref_class
			double_class := static.double_class
			double_ref_class := static.double_ref_class
			general_class := static.general_class
			integer_class := static.integer_class
			integer_ref_class := static.integer_ref_class
			memory_class_i := static.memory_class_i
			plug_file := static.plug_file
			pointer_class := static.pointer_class
			pointer_ref_class := static.pointer_ref_class
			real_class := static.real_class
			real_ref_class := static.real_ref_class
			special_class := static.special_class
			string_class := static.string_class
			to_special_class := static.to_special_class
			dynamic_class := static.dynamic_class

				-- Attributes from `SYSTEM_I'.
			rout_info_table := static.rout_info_table
			class_counter := static.class_counter
			body_id_counter := static.body_id_counter
			body_index_counter := static.body_index_counter
			type_id_counter := static.type_id_counter
			static_type_id_counter := static.static_type_id_counter
			feature_as_counter := static.feature_as_counter
			feat_tbl_server := static.feat_tbl_server
			body_server := static.body_server
			ast_server := static.ast_server
			byte_server := static.byte_server
			rep_server := static.rep_server
			rep_feat_server := static.rep_feat_server
			class_info_server := static.class_info_server
			inv_ast_server := static.inv_ast_server
			inv_byte_server := static.inv_byte_server
			depend_server := static.depend_server
			rep_depend_server := static.rep_depend_server
			m_feat_tbl_server := static.m_feat_tbl_server
			m_feature_server := static.m_feature_server
			m_rout_id_server := static.m_rout_id_server
			m_desc_server := static.m_desc_server
			class_comments_server := static.class_comments_server
			classes := static.classes
			class_types := static.class_types
			type_set := static.type_set
			pattern_table := static.pattern_table
			successful := static.successful
			private_freeze := static.private_freeze
			freezing_occurred := static.freezing_occurred
			history_control := static.history_control
			instantiator := static.instantiator
			externals := static.externals
			system_name := static.system_name
			root_cluster := static.root_cluster
			root_class_name := static.root_class_name
			creation_name := static.creation_name
			c_file_names := static.c_file_names
			object_file_names := static.object_file_names
			makefile_names := static.makefile_names
			executable_directory := static.executable_directory
			c_directory := static.c_directory
			object_directory := static.object_directory
			first_compilation := static.first_compilation
			poofter_finalization := static.poofter_finalization
			new_class := static.new_class
			new_classes := static.new_classes
			moved := static.moved
			update_sort := static.update_sort
			max_class_id := static.max_class_id
			freeze_set1 := static.freeze_set1
			freeze_set2 := static.freeze_set2
			is_conformance_table_melted := static.is_conformance_table_melted
			melted_conformance_table := static.melted_conformance_table
			melted_set := static.melted_set
			frozen_level := static.frozen_level
			body_index_table := static.body_index_table
			original_body_index_table := static.original_body_index_table
			onbidt := static.onbidt
			dispatch_table := static.dispatch_table
			execution_table := static.execution_table
			server_controler := static.server_controler
			remover := static.remover
			remover_off := static.remover_off
			code_replication_off := static.code_replication_off
			exception_stack_managed := static.exception_stack_managed
			has_expanded := static.has_expanded
			current_pass := static.current_pass
			current_class := static.current_class
			makefile_generator := static.makefile_generator
			cecil_file := static.cecil_file
			skeleton_file := static.skeleton_file
			conformance_file := static.conformance_file
			make_file := static.make_file
			array_make_name := static.array_make_name
			optimization_tables := static.optimization_tables
			array_optimization_on := static.array_optimization_on
			inlining_on := static.inlining_on
			inlining_size := static.inlining_size
			keep_assertions := static.keep_assertions
			do_not_check_vape := static.do_not_check_vape
			address_expression_allowed := static.address_expression_allowed
			removed_log_file := static.removed_log_file
			used_features_log_file := static.used_features_log_file
			dle_poly_server := static.dle_poly_server
			dle_eiffel_table := static.dle_eiffel_table
			dle_remover := static.dle_remover
			dle_frozen_nobid_table := static.dle_frozen_nobid_table
			dle_static_calls := static.dle_static_calls
			dle_system_name := static.system_name
			address_table := static.address_table
			routine_id_counter := static.routine_id_counter
			uses_precompiled := static.uses_precompiled

			!! sorter.make
			!! dynamic_class_ids.make (50)

				-- Save information concerning the static base system.
			dle_array_optimization_on :=
					array_optimization_on and not remover_off
			!! dle_finalized_nobid_table.make (50)
			dle_finalized_nobid_table.set_threshold (body_id_counter.total_count)
			dle_type_set := clone (type_set)
			min_type_id := type_id_counter.value + 1
			dle_max_topo_id := max_class_id
				-- Keep track of the melted descriptors of 
				-- the static system.
			m_static_desc_server := m_desc_server

				-- Get rid of the melted data structures of
				-- the base static system.
			freeze_set1.wipe_out
			freeze_set2.wipe_out
			melted_set.wipe_out
			m_feat_tbl_server.clear
			m_feature_server.clear
			m_rout_id_server.clear
			!! m_desc_server.make
			execution_table.init_dle
			dispatch_table.init_dle
			pattern_table.init_dle
		end

feature -- Access

	sorter: DLE_CLASS_SORTER
			-- Topological sorter on classes

	dynamic_class_ids: SEARCH_TABLE [CLASS_ID]
			-- Set of ids of dynamic classes

	dle_max_topo_id: INTEGER
			-- Greatest topological class id of the static system

	min_type_id: INTEGER
			-- Value from which to start the dynamic type_id numbering
			-- for newly created DC-set class types
			-- (Correspond to the greatest class_type type_id of the
			-- static system + 1)

	m_static_desc_server: M_DESC_SERVER
			-- Server for melted class type descriptors of the static
			-- system

	dle_type_set: ROUT_ID_SET
			-- Set of the routine ids for which a type table should
			-- have been generated in the extendible system

	dle_finalized_nobid_table: NEW_OLD_TABLE [BODY_ID]
			-- Finalized New/Old body id table; Keep track of body_id
			-- modifications between finalization of the static system
			-- and finalization of the dynamic system

	dle_array_optimization_on: BOOLEAN
			-- Was the array optimization on in the static system?

	dle_make_min_used: INTEGER
			-- Minimum used type id in the `dle_make' routine table
			-- (Table of the `make' creation routines of the
			-- descendands of DYNAMIC in the DC-set)

	dle_system_name: STRING
			-- Name of the static system

feature -- Status report

	is_dynamic: BOOLEAN is true
			-- Is the current system a Dynamic Class Set?

	has_been_frozen: BOOLEAN
			-- Has the Dynamic Class Set already been frozen?

feature -- Recompilation 

	change_classes is
				-- Mark classes to be recompiled.
		do
				-- Need to compile all the new dynamic classes.
			Workbench.change_all_new_dynamic_classes
		end

	reset_type_id (class_type: CLASS_TYPE) is
			-- Assign a new dynamic type id to `class_type' if dynamic,
			-- keeping the static system type ids unchanged.
		do
			if class_type.is_dynamic then
				{SYSTEM_I} precursor (class_type)
			end
		end

	mark_dynamic_classes (marked_classes: SEARCH_TABLE [CLASS_ID]) is
			-- Mark the descendants of DYNAMIC in the DC-set.
		local
			class_id: CLASS_ID
			a_class: CLASS_C
		do
			from
				dynamic_class_ids.start
			until
				dynamic_class_ids.after
			loop
				class_id := dynamic_class_ids.item_for_iteration
				a_class := class_of_id (class_id)
				if a_class /= Void then
					if a_class.syntactical_inherits_from_dynamic then
						a_class.mark_class (marked_classes)
					end
				end
				dynamic_class_ids.forth
			end
		end

	remove_dynamic_class_id (id: CLASS_ID) is
			-- Remove `id' from the set of dynamic class id.
		do
			dynamic_class_ids.remove (id)
		end

feature -- Melting

	make_update (empty: BOOLEAN) is
			-- Produce the file containing melted information of the
			-- Dynamic Class Set.
		local
			a_class: CLASS_C
			file_pointer: POINTER
			melted_file: RAW_FILE
		do
debug ("ACTIVITY")
	io.error.putstring ("Creating melted.dle%N")
end
			melted_file := Update_dle_file
			melted_file.open_write
			file_pointer := melted_file.file_pointer

			if empty then
				has_been_frozen := true
			end

			if has_been_frozen then
					-- The system has been frozen.
				melted_file.putchar ('%/001/')
			else
				melted_file.putchar ('%U')
			end

				-- The DC-set is melted.
			if empty then
				melted_file.putchar ('%U')
			else
				melted_file.putchar ('%/001/')
			end

				-- Write first the number of class types now available
			write_int (file_pointer, type_id_counter.value)

				-- Write the number of classes now available
			write_int (file_pointer, class_counter.total_count)

				-- Write DYNAMIC dtype
			write_int (file_pointer, dynamic_dtype - 1)

				-- Write first the new size of the dispatch table
			dispatch_table.write_dispatch_count (melted_file)

			if not empty then
				make_update_feature_tables (melted_file)
				make_update_rout_id_arrays (melted_file)

					-- Update the dispatch table
				Dispatch_table.make_update (melted_file)

					-- Open the file for reading byte code for melted features
					-- Update the execution table
				execution_table.make_melted_dle (melted_file)
				make_conformance_table_byte_code (melted_file)
				make_option_table (melted_file)
				make_rout_info_table (melted_file)
				make_update_descriptors (melted_file)
			else
				make_update_static_descriptors (melted_file)
			end

				-- End mark
			write_int (file_pointer, -1)
			melted_file.close
		end

	make_update_descriptors (file: RAW_FILE) is
			-- Write melted descriptors into `file'.
		local
			class_id: CLASS_ID
		do
				-- Write melted descriptors from the DR-system.
			make_update_static_descriptors (file)
				-- Write melted descriptors from the DC-set.
			{SYSTEM_I} precursor (file)
		end

	make_update_static_descriptors (file: RAW_FILE) is
			-- Write melted descriptors from the DR-system.
		require
			file_not_void: file /= Void
			file_is_open_write: file.is_open_write
		local
			class_id: CLASS_ID
		do
			from
				M_static_desc_server.start
			until
				M_static_desc_server.after
			loop
				class_id := M_static_desc_server.key_for_iteration
				M_static_desc_server.item (class_id).store (file)
				M_static_desc_server.forth
			end
		end

feature -- Freeezing

	shake_tables is
			-- Compress dispatch and execution tables.
		do
			execution_table.shake_dle
			dispatch_table.shake_dle
		end

feature -- Final mode 

	degree_minus_4 is
			-- Process Degree -4.
		local
			a_class: CLASS_C
			class_id: CLASS_ID
			deg_output: DEGREE_OUTPUT
			id_list: like dynamic_class_ids
			i: INTEGER
		do
			deg_output := Degree_output
				-- Retrieve data stored during the last finalization
				-- of the dynamically extendible system.
			tmp_poly_server.copy (dle_poly_server)
			Eiffel_table.init_dle (Old_eiffel_table)

			from 
				id_list := dynamic_class_ids
				i := id_list.count
				deg_output.put_start_degree (-4, i)
				id_list.start 
			until 
				id_list.after 
			loop
				class_id := id_list.item_for_iteration
				a_class := class_of_id (class_id)
				if a_class /= Void then
					deg_output.put_degree_minus_4 (a_class, i)

					a_class.process_polymorphism
					History_control.check_overload
				end
				i := i - 1
				id_list.forth
			end
			deg_output.put_end_degree
			History_control.transfer
			tmp_poly_server.flush
		end

	degree_minus_5 is
			-- Process Degree -5.
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			deg_output: DEGREE_OUTPUT
			j: INTEGER
		do
			deg_output := Degree_output
			!FINAL_DLE_MAKER! makefile_generator.make
			open_log_files
				-- Generation of C files associated to the classes of
				-- the system.
			j := classes.count
			deg_output.put_start_degree (-5, j)
			from classes.start until classes.after loop
				class_array := classes.item_for_iteration
				nb := class_counter.item (classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						current_class := a_class
						if a_class.dle_generate_final_code then
							deg_output.put_degree_minus_5 (a_class, j)
						end
						j := j - 1
					end
					i := i + 1
				end
				classes.forth
			end
			close_log_files
		end

	check_dle_finalize is
			-- If the user asked for a finalization then check whether
			-- the static system has been finalized as well.
		local
			v9fm: V9FM
		do
			if Compilation_modes.is_finalizing then
				if dle_poly_server = Void then
						-- The static system has not been finalized.
					!! v9fm
					Error_handler.insert_error (v9fm)
					Error_handler.checksum
				end
			end
		end

	check_static_calls is
			-- Check whether the statically bound calls in the static system
			-- need not to be dynamically bound now.
		local
			table: POLY_TABLE [ENTRY]
			type_id: INTEGER
			rout_id: ROUTINE_ID
			server_id: INTEGER_ID
			rout_ids: DLE_STATIC_CALLS
			feature_table: FEATURE_TABLE
			class_c: CLASS_C
			feat: FEATURE_I
			v9sc: V9SC
		do
			from
				dle_static_calls.start
			until
				dle_static_calls.after
			loop
				server_id := dle_static_calls.key_for_iteration
				rout_ids := dle_static_calls.item (server_id)
				type_id := server_id.id
				from
					rout_ids.start
				until
					rout_ids.after
				loop
					class_c := class_types.item (type_id).associated_class
					feature_table := class_c.feature_table
					rout_id := rout_ids.item
					table := Eiffel_table.poly_table (rout_id)
					if table.is_polymorphic (type_id) then
							-- The call is not statically bound anymore.
						feat := feature_table.feature_of_rout_id (rout_id)
						if feat /= Void then
							!! v9sc
							v9sc.set_class (class_c)
							v9sc.set_feature (feat)
							Error_handler.insert_error (v9sc)
						end
					end
					rout_ids.forth
				end
				dle_static_calls.forth
			end
			Error_handler.checksum
		end

	clear_dle_finalization_data is
			-- Get rid of the data stored during the last
			-- final mode compilation normally used when finalizing
			-- the Dynamic Class Set.
		do
			-- Do nothing here since we do want to keep these data
			-- for the finalization of the dynamic system.
		end

feature -- Generation

	generate_main_file is
			-- Main file generation.
		do
		end

	generate_pattern_table is
			-- Generate pattern table.
		do
			pattern_table.generate_dle
		end

	generate_skeletons is
			-- Generate skeletons of class types of the DC-set.
		local
			class_array: ARRAY [CLASS_C]
			j, i, nb, nb_class: INTEGER
			cl_type: CLASS_TYPE
			a_class: CLASS_C
			has_attribute, final_mode: BOOLEAN
			types: TYPE_LIST
			Skeleton_file: INDENT_FILE
		do
			nb := Type_id_counter.value
			final_mode := in_final_mode

				-- Open skeleton file
			Skeleton_file := Skeleton_f (final_mode)
			Skeleton_file.open_write

			Skeleton_file.putstring ("#include %"eif_struct.h%"%N")
			Skeleton_file.putstring ("#include %"eif_macros.h%"%N")
			if final_mode then
				Skeleton_file.putstring ("#include %"")
				Skeleton_file.putstring (Eskelet)
				Skeleton_file.putstring (Dot_h)
				Skeleton_file.putstring ("%"%N%N")
				from
						-- Start the iteration from the maximum `type_id' 
						-- value of the static system.
					i := min_type_id
				until
					i > nb
				loop
					cl_type := class_types.item (i)
					if cl_type /= Void then
						cl_type.skeleton.make_extern_declarations
					end
					i := i + 1
				end
				Extern_declarations.generate_header (final_file_name (Eskelet, Dot_h))
				Extern_declarations.generate (final_file_name (Eskelet, Dot_h))
				Extern_declarations.wipe_out
			else
				Skeleton_file.new_line
				from classes.start until classes.after loop
					class_array := classes.item_for_iteration
					nb := class_counter.item (classes.key_for_iteration).count
					from i := 1 until i > nb loop
						a_class := class_array.item (i)
						if a_class /= Void then
							j := a_class.id.id
							if a_class.has_dynamic then
								if not a_class.is_precompiled then
									Skeleton_file.putstring ("extern int32 ra")
									Skeleton_file.putint (j)
									Skeleton_file.putstring ("[];%N")
								end
								if a_class.has_visible then
									Skeleton_file.putstring ("extern char *cl")
									Skeleton_file.putint (j)
									Skeleton_file.putstring ("[];%N")
									Skeleton_file.putstring ("extern uint32 cr")
									Skeleton_file.putint (j)
									Skeleton_file.putstring ("[];%N")
								end
								if not a_class.skeleton.empty then
									from
										types := a_class.types
										types.start
									until
										types.after
									loop
										if types.item.is_dynamic then
											Skeleton_file.putstring 
													("extern uint32 types")
											Skeleton_file.putint (types.item.type_id)
											Skeleton_file.putstring ("[];%N")
										end
										types.forth
									end
								end
							end
						end
						i := i + 1
					end
					classes.forth
				end
				Skeleton_file.new_line
			end

			from 
					-- Start the iteration from the maximum `type_id' 
					-- value of the static system.
				nb := Type_id_counter.value
				i := min_type_id
			until
				i > nb
			loop
				cl_type := class_types.item (i)
					-- Classes could be removed
				if cl_type /= Void then
					cl_type.generate_skeleton1
				end
				i := i + 1
			end

			Skeleton_file.putstring ("void dle_eskelet(void)")
			Skeleton_file.new_line
			Skeleton_file.putchar ('{')
			Skeleton_file.new_line
			Skeleton_file.indent
			Skeleton_file.putstring ("struct cnode *node;")
			Skeleton_file.new_line
			if final_mode then
				Skeleton_file.new_line
				Skeleton_file.putstring ("esystem = (struct cnode *)cmalloc(")
				Skeleton_file.putint (Type_id_counter.value)
				Skeleton_file.putstring (" * sizeof(struct cnode));")
				Skeleton_file.new_line
				Skeleton_file.putstring ("if (esystem == (struct cnode *) 0)")
				Skeleton_file.new_line
				Skeleton_file.indent
				Skeleton_file.putstring ("enomem();")
				Skeleton_file.new_line
				Skeleton_file.exdent
				Skeleton_file.putstring ("bcopy(egc_fsystem, esystem, ")
				Skeleton_file.putint (min_type_id - 1)
				Skeleton_file.putstring (" * sizeof(struct cnode));")
				Skeleton_file.new_line
			else
				Skeleton_file.putstring ("struct ctable *cecil_tab;")
				Skeleton_file.new_line
			end
			from
					-- Start the iteration from the maximum `type_id' 
					-- value of the static system.
				i := min_type_id
			until
				i > nb
			loop
				cl_type := class_types.item (i)
				if cl_type /= Void and then cl_type.is_dynamic then
					Skeleton_file.new_line
					cl_type.generate_dle_skeleton (skeleton_file)
				end
				i := i + 1
			end

			if not final_mode then
					-- Generate the array of routine id arrays
				Skeleton_file.new_line
				from
						-- Start the iteration from the maximum `type_id' 
						-- value of the static system.
					i := min_type_id
				until
					i > nb
				loop
					cl_type := class_types.item (i)
					Skeleton_file.putstring ("Routids(")
					Skeleton_file.putint (cl_type.id.id - 1)
					Skeleton_file.putstring (") = ")
					if
						cl_type /= Void and then
						not cl_type.associated_class.is_precompiled
					then
						Skeleton_file.putstring ("ra")
						Skeleton_file.putint (cl_type.associated_class.id.id)
					else
						Skeleton_file.putstring ("(int32 *) 0")
					end
					Skeleton_file.putchar (';')
					Skeleton_file.new_line
					i := i + 1
				end
			else
				Skeleton_file.exdent
				Skeleton_file.putchar ('}')
				Skeleton_file.new_line
				Skeleton_file.new_line
				Skeleton_file.putstring ("void free_eskelet(void)")
				Skeleton_file.new_line
				Skeleton_file.putchar ('{')
				Skeleton_file.new_line
				Skeleton_file.indent
				Skeleton_file.putstring ("xfree(esystem);")
				Skeleton_file.new_line
				Skeleton_file.putstring ("esystem = egc_fsystem;")
				Skeleton_file.new_line
			end
			Skeleton_file.exdent
			Skeleton_file.putchar ('}')
			Skeleton_file.new_line
			Skeleton_file.new_line

				-- Close skeleton file
			Skeleton_file.close
		end

	generate_cecil is
			-- Generate Cecil structures.
		local
			class_array: ARRAY [CLASS_C]
			i, nb, generic, no_generic: INTEGER
			cl_type: CLASS_TYPE
			a_class: CLASS_C
			final_mode: BOOLEAN
			temp: STRING
			subdir: DIRECTORY
			f_name: FILE_NAME
			dir_name: DIRECTORY_NAME
		do
			final_mode := byte_context.final_mode
			Cecil_file := cecil_f (final_mode)
			Cecil_file.open_write
			Cecil_file.putstring ("#include %"eif_project.h%"%N%
								  %#include %"eif_cecil.h%"%N")
			if final_mode then
				Cecil_file.putstring ("#include %"eif_ececil.h%"%N")
			end
			Cecil_file.putstring ("#include %"eif_struct.h%"%N%N")
			Cecil_file.putstring ("extern struct ctable egc_ce_type_init;%N")
			Cecil_file.putstring ("extern struct ctable egc_ce_gtype_init;%N%N")
			from classes.start until classes.after loop
				class_array := classes.item_for_iteration
				nb := class_counter.item (classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						if a_class.has_visible then
							a_class.dle_generate_cecil
						end
					end
					i := i + 1
				end
				classes.forth
			end
			make_cecil_tables
			Cecil2.generate
			Cecil3.generate
			Cecil_file.putstring ("void dle_evisib(void)")
			Cecil_file.new_line
			Cecil_file.putchar ('{')
			Cecil_file.new_line
			Cecil_file.indent
			if final_mode then
					-- Extern declarations for previous file
				temp := clone (System_object_prefix)
				temp.append_integer (1)
				!!dir_name.make_from_string (Final_generation_path)
				dir_name.extend (temp)
				!! subdir.make (dir_name)
				if not subdir.exists then
					subdir.create
				end
				!!f_name.make_from_string (dir_name)
				f_name.set_file_name ("ececil.h")
				Extern_declarations.generate_header (f_name)
				Extern_declarations.generate (f_name)
				Extern_declarations.wipe_out
				Cecil_file.putstring ("struct ctable *cecil_tab;")
				Cecil_file.new_line
				Cecil_file.new_line
				Cecil_file.putstring ("egc_ce_rname = (struct ctable *)cmalloc(")
				Cecil_file.putint (Type_id_counter.value)
				Cecil_file.putstring (" * sizeof(struct ctable));")
				Cecil_file.new_line
				Cecil_file.putstring ("if (egc_ce_rname == (struct ctable *) 0)")
				Cecil_file.new_line
				Cecil_file.indent
				Cecil_file.putstring ("enomem();")
				Cecil_file.new_line
				Cecil_file.exdent
				Cecil_file.putstring ("bcopy(fce_rname, egc_ce_rname, ")
				Cecil_file.putint (min_type_id - 1)
				Cecil_file.putstring (" * sizeof(struct ctable));")
				Cecil_file.new_line
				Cecil_file.new_line
				from
						-- Start the iteration from the maximum `type_id' 
						-- value of the static system.
					i := min_type_id
					nb := Type_id_counter.value
				until
					i > nb
				loop
if class_types.item (i) /= Void then
					Cecil_file.putstring ("cecil_tab = &Cecil(")
					Cecil_file.putint (i - 1)
					Cecil_file.putstring (");")
					Cecil_file.new_line
					class_types.item (i).dle_generate_cecil (Cecil_file)
					Cecil_file.new_line
end
					i := i + 1
				end
			end
			Cecil_file.putstring ("egc_ce_type_init = Dce_type;")
			Cecil_file.new_line
			Cecil_file.putstring ("egc_ce_gtype_init = Dce_gtype;")
			Cecil_file.new_line
			if final_mode then
				Cecil_file.exdent
				Cecil_file.putstring ("}%N%N")
				Cecil_file.putstring ("void free_evisib(void)")
				Cecil_file.new_line
				Cecil_file.putchar ('{')
				Cecil_file.new_line
				Cecil_file.indent
				Cecil_file.putstring ("xfree(egc_ce_rname);")
				Cecil_file.new_line
				Cecil_file.putstring ("egc_ce_rname = fce_rname;")
				Cecil_file.new_line
			end
			Cecil_file.exdent
			Cecil_file.putstring ("}%N")

			Cecil_file.close
			Cecil_file := Void
		end

	generate_conformance_table is
			-- Generates conformance tables.
		local
			i, nb: INTEGER
			cl_type: CLASS_TYPE
		do
			Conformance_file := conformance_f (byte_context.final_mode)
			Conformance_file.open_write

			Conformance_file.putstring ("#include %"eif_struct.h%"%N%N")

			from
				i := 1
				nb := Type_id_counter.value
			until
				i > nb
			loop
				cl_type := class_types.item (i)
if cl_type /= Void then
		-- FIXME
				cl_type.generate_conformance_table
end
				i := i + 1
			end

			Conformance_file.putstring
					("static struct conform *Dco_table[] = {%N")
			from
				i := 1
			until
				i > nb
			loop
				cl_type := class_types.item (i)
if cl_type /= Void then
				Conformance_file.putstring ("&conf")
				Conformance_file.putint (cl_type.type_id)
else
		-- FIXME
	Conformance_file.putstring ("(struct conform *)0")
end
				Conformance_file.putstring (",%N")
				i := i + 1
			end

			Conformance_file.putstring ("};%N")

			Conformance_file.new_line
			Conformance_file.putstring ("void dle_econform(void)")
			Conformance_file.new_line
			Conformance_file.putchar ('{')
			Conformance_file.new_line
			Conformance_file.indent
			Conformance_file.putstring ("co_table = Dco_table;")
			Conformance_file.new_line
			Conformance_file.exdent
			Conformance_file.putchar ('}')
			Conformance_file.new_line
			if in_final_mode then
				Conformance_file.new_line
				Conformance_file.putstring ("void free_econform(void)")
				Conformance_file.new_line
				Conformance_file.putchar ('{')
				Conformance_file.new_line
				Conformance_file.indent
				Conformance_file.putstring ("co_table = egc_fco_table;")
				Conformance_file.new_line
				Conformance_file.exdent
				Conformance_file.putchar ('}')
				Conformance_file.new_line
			end

			Conformance_file.close
			Conformance_file := Void
		end

	generate_dispatch_table is
			-- Generate `dispatch_table'.
		do
			Dispatch_file.open_write
			dispatch_table.generate_dle (Dispatch_file)
			dispatch_table.freeze
			Dispatch_file.close
				-- The melted list of the dispatch table
				-- is now empty
		end

	generate_exec_table is
			-- Generate `execution_table'.
		do
			Frozen_file.open_write
			execution_table.generate_dle (Frozen_file)
			execution_table.freeze
			Frozen_file.close
				-- The melted list of the execution table
				-- is now empty
		end

	generate_init_file is
			-- Generation of the init file of the DC-set.
		local
			Initialization_file: INDENT_FILE
			i, nb: INTEGER
			cl_type: CLASS_TYPE
		do
			if not in_final_mode then
				Initialization_file := Init_f (false)
				Initialization_file.open_write
				Initialization_file.putstring ("void dle_einit(void)")
				Initialization_file.new_line
				Initialization_file.putchar ('{')
				Initialization_file.new_line
				Initialization_file.indent
				from
						-- Start the iteration from the maximum `type_id' 
						-- value of the static system.
					i := min_type_id
					nb := type_id_counter.value
				until
					i > nb
				loop
					cl_type := class_types.item (i)
-- FIXME ???
-- cl_type cannot be Void if process_dynamic_types has been done in
-- freeze_system.
					if cl_type /= Void then
						Initialization_file.putchar ('%T')
						Initialization_file.putstring (cl_type.id.init_name)
						Initialization_file.putstring ("();")
						Initialization_file.new_line
					end
					i := i + 1
				end
				Initialization_file.exdent
				Initialization_file.putstring ("}")
				Initialization_file.new_line
				Initialization_file.close
			end
		end

	generate_rout_info_table is
		local
			f: INDENT_FILE
		do
			if not byte_context.final_mode then
				f := Rout_info_file
				f.open_write
				Rout_info_table.generate_dle (f)
				f.close
			end
		end

	generate_option_file is
			-- Generate compilation option file.
		local
			class_array: ARRAY [CLASS_C]
			i, nb: INTEGER
			a_class: CLASS_C
			partial_debug: DEBUG_TAG_I
			class_type: CLASS_TYPE
		do
			Option_file.open_write

			Option_file.putstring ("#include %"eif_struct.h%"%N%N")

				-- First debug keys
			from classes.start until classes.after loop
				class_array := classes.item_for_iteration
				nb := class_counter.item (classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						if a_class.has_dynamic then
							partial_debug ?= a_class.debug_level
							if partial_debug /= Void then
								partial_debug.generate_keys (Option_file, a_class.id)
							end
						end
					end
					i := i + 1
				end
				classes.forth
			end

			Option_file.putstring ("void dle_eoption(void)")
			Option_file.new_line
			Option_file.putchar ('{')
			Option_file.new_line
			Option_file.indent
			Option_file.putstring ("struct eif_opt *dle_opt;")
			Option_file.new_line
			Option_file.putstring ("struct dbg_opt *dle_dbg;")
			Option_file.new_line
			from
					-- Start the iteration from the maximum `type_id' 
					-- value of the static system.
				i := min_type_id
				nb := Type_id_counter.value
			until
				i > nb
			loop
				Option_file.new_line

				Option_file.putstring("dle_opt = &eoption[")
				Option_file.putint(i - 1)
				Option_file.putstring("];")
				Option_file.new_line

				class_type := class_types.item (i)
				if class_type /= Void then
						-- Classes could be removed

					a_class := class_type.associated_class
					Option_file.putstring("dle_opt->assert_level = ")
					a_class.assertion_level.generate (Option_file)
					Option_file.putchar (';')
					Option_file.new_line

					Option_file.putstring("dle_opt->profile_level = ")
					a_class.profile_level.generate (Option_file)
					Option_file.putchar (';')
					Option_file.new_line

					Option_file.putstring("dle_opt->trace_level = ")
					a_class.trace_level.generate (Option_file)
					Option_file.putchar (';')
					Option_file.new_line

					Option_file.putstring("dle_dbg = &dle_opt->debug_level;")
					Option_file.new_line
					a_class.debug_level.generate_dle (Option_file, a_class.id)
				else
					Option_file.putstring("dle_opt->assert_level = (int16) 0;")
					Option_file.new_line
					Option_file.putstring("dle_opt->trace_level = (int16) 0;")
					Option_file.new_line
					Option_file.putstring("dle_opt->profile_level = (int16) 0;")
					Option_file.new_line
					Option_file.putstring("dle_dbg = &dle_opt->debug_level;")
					Option_file.new_line
					Option_file.putstring("dle_dbg->debug_level = (int16) 0;")
					Option_file.new_line
					Option_file.putstring("dle_dbg->nb_keys = (int16) 0;")
					Option_file.new_line
					Option_file.putstring("dle_dbg->keys = (char **) 0);")
					Option_file.new_line
				end
				i := i + 1
			end
	
			Option_file.exdent
			Option_file.putchar ('}')
			Option_file.new_line

			Option_file.close
		end

	generate_size_table is
			-- Generate the size table.
		local
			i, nb: INTEGER
			class_type: CLASS_TYPE
			file: INDENT_FILE
		do
			file := Size_file (true)
			from
				i := min_type_id
				nb := type_id_counter.value
				file.open_write
				file.putstring ("#include %"eif_macros.h%"%N%N")
				file.putstring ("void dle_esize(void)%N{%N")
				file.indent
				file.putstring ("esize = (long *)cmalloc(")
				file.putint (Type_id_counter.value)
				file.putstring (" * sizeof(long));%N")
				file.putstring ("if (esize == (long *) 0)%N")
				file.indent
				file.putstring ("enomem();%N")
				file.exdent
				file.putstring ("bcopy(egc_fsize, esize, ")
				file.putint (min_type_id - 1)
				file.putstring (" * sizeof(long));%N")
			until
				i > nb
			loop
				class_type := class_types.item (i)
if class_type /= Void then
				file.putstring ("esize[")
				file.putint (i - 1)
				file.putstring ("] = ")
				class_type.skeleton.generate_size (file)
				file.putchar (';')
				file.new_line
end
				i := i + 1
			end
			file.exdent
			file.putchar ('}')
			file.new_line
			file.new_line

			file.putstring ("void free_esize(void)")
			file.new_line
			file.putchar ('{')
			file.new_line
			file.indent
			file.putstring ("xfree(esize);")
			file.new_line
			file.putstring ("esize = egc_fsize;")
			file.new_line
			file.exdent
			file.putchar ('}')
			file.new_line

			file.close
		end

	generate_reference_table is
			-- Generate the table of reference numer per type.
		local
			i, nb, nb_ref, nb_exp: INTEGER
			class_type: CLASS_TYPE
			skeleton: SKELETON
		do
			from
				i := min_type_id
				nb := type_id_counter.value
				Reference_file.open_write
				Reference_file.putstring ("#include %"eif_plug.h%"")
				Reference_file.new_line
				Reference_file.new_line
				Reference_file.putstring ("void dle_eref(void)")
				Reference_file.new_line
				Reference_file.putchar ('{')
				Reference_file.new_line
				Reference_file.indent
				Reference_file.putstring ("nbref = (long *)cmalloc(")
				Reference_file.putint (Type_id_counter.value)
				Reference_file.putstring (" * sizeof(long));")
				Reference_file.new_line
				Reference_file.putstring ("if (nbref == (long *) 0)")
				Reference_file.new_line
				Reference_file.indent
				Reference_file.putstring ("enomem();")
				Reference_file.new_line
				Reference_file.exdent
				Reference_file.putstring ("bcopy(egc_fnbref, nbref, ")
				Reference_file.putint (min_type_id - 1)
				Reference_file.putstring (" * sizeof(long));")
				Reference_file.new_line
				Reference_file.new_line
			until
				i > nb
			loop
				class_type := class_types.item (i)
if class_type /= Void then
				Reference_file.putstring ("nbref[")
				Reference_file.putint (i - 1)
				Reference_file.putstring ("] = ")
				skeleton := class_type.skeleton
				nb_ref := skeleton.nb_reference
				nb_exp := skeleton.nb_expanded
				Reference_file.putint (nb_ref + nb_exp)
				Reference_file.putchar (';')
				Reference_file.new_line
end
				i := i + 1
			end
			Reference_file.exdent
			Reference_file.putchar ('}')
			Reference_file.new_line
			Reference_file.new_line

			Reference_file.putstring ("void free_eref(void)")
			Reference_file.new_line
			Reference_file.putchar ('{')
			Reference_file.new_line
			Reference_file.indent
			Reference_file.putstring ("xfree(nbref);")
			Reference_file.new_line
			Reference_file.putstring ("nbref = egc_fnbref;")
			Reference_file.new_line
			Reference_file.exdent
			Reference_file.putchar ('}')
			Reference_file.new_line

			Reference_file.close
		end

	generate_plug is
			-- Generate plug with run-time.
		local
			final_mode: BOOLEAN
			init_name, dispose_name: STRING
			dle_make_name: STRING
		do
			final_mode := in_final_mode
			Plug_file := plug_f (final_mode)
			Plug_file.open_write
			Plug_file.putstring ("#include %"eif_plug.h%"%N")
			Plug_file.putstring ("#include %"eif_struct.h%"%N%N")
			if final_mode then
					-- Extern declarations
				init_name := Initialization_rout_id.table_name
				dispose_name := Dispose_rout_id.table_name
				dle_make_name := Dle_make_rout_id.table_name
				Plug_file.putstring ("extern char *(**")
				Plug_file.putstring (init_name)
				Plug_file.putstring (")();%N")
				Plug_file.putstring ("extern char *(**")
				Plug_file.putstring (dispose_name)
				Plug_file.putstring (")();%N")
				Plug_file.putstring ("extern char *(**")
				Plug_file.putstring (dle_make_name)
				Plug_file.putstring (")();%N")
				if array_optimization_on or dle_array_optimization_on then
					remover.array_optimizer.generate_dle_plug_extern (Plug_file)
				end
				Plug_file.new_line
				Plug_file.putstring ("void dle_eplug(void)")
				Plug_file.new_line
				Plug_file.putchar ('{')
				Plug_file.new_line
				Plug_file.indent
					-- Initialization routines
				Plug_file.putstring ("egc_ecreate = ")
				Plug_file.putstring (init_name)
				Plug_file.putchar (';')
				Plug_file.new_line
					-- Dispose routines
				Plug_file.putstring ("egc_edispose = (void (**)()) ")
				Plug_file.putstring (dispose_name)
				Plug_file.putchar (';')
				Plug_file.new_line
					-- `make' creation procedures of descendands
					-- of DYNAMIC in the DC-set.
				Plug_file.putstring ("dle_make = ")
				Plug_file.putstring (dle_make_name)
				Plug_file.putstring (" - ")
				Plug_file.putint (dle_make_min_used - 1)
				Plug_file.putchar (';')
				Plug_file.new_line
				if array_optimization_on or dle_array_optimization_on then
					remover.array_optimizer.generate_dle_plug (Plug_file)
				end
					-- New scount
				Plug_file.putstring ("scount = ")
				Plug_file.putint (Type_id_counter.value)
				Plug_file.putchar (';')
				Plug_file.new_line
					-- DYNAMIC dtype
				Plug_file.putstring ("dynamic_dtype = ")
				Plug_file.putint (dynamic_dtype - 1)
				Plug_file.putchar (';')
			else
				Plug_file.putstring ("extern fnptr **egc_address_table_init;%N%N")
				Plug_file.putstring ("extern fnptr *Deif_address_table[];%N%N")
				Plug_file.putstring ("void dle_eplug(void)")
				Plug_file.new_line
				Plug_file.putchar ('{')
				Plug_file.new_line
				Plug_file.indent
				Plug_file.putstring ("egc_address_table_init = Deif_address_table;")
			end
			Plug_file.new_line
			Plug_file.exdent
			Plug_file.putchar ('}')
			Plug_file.new_line

			Plug_file.close
		end

	generate_dle_file is
			-- Generate DLE related data to be loaded at run-time.
		local
			DLE_file: INDENT_FILE
			DLE_file_h: INDENT_FILE
			i, nb: INTEGER
		do
				-- Open DLE file
			DLE_file := DLE_f (in_final_mode)
			DLE_file.open_write

			if not in_final_mode then
				DLE_file.putstring ("extern void dle_eskelet(void);")
				DLE_file.new_line
				DLE_file.putstring ("extern void dle_efrozen(void);")
				DLE_file.new_line
				DLE_file.putstring ("extern void dle_disptch(void);")
				DLE_file.new_line
				DLE_file.putstring ("extern void dle_econform(void);")
				DLE_file.new_line
				DLE_file.putstring ("extern void dle_ecall(void);")
				DLE_file.new_line
				DLE_file.putstring ("extern void dle_eoption(void);")
				DLE_file.new_line
				DLE_file.putstring ("extern void dle_epattern(void);")
				DLE_file.new_line
				DLE_file.putstring ("extern void free_epattern(void);")
				DLE_file.new_line
				DLE_file.putstring ("extern void dle_einit(void);")
				DLE_file.new_line
				DLE_file.putstring ("extern void dle_evisib(void);")
				DLE_file.new_line
				DLE_file.putstring ("extern void dle_eplug(void);")
				DLE_file.new_line
				DLE_file.new_line
				DLE_file.putstring ("void dle_load(void)")
				DLE_file.new_line
				DLE_file.putchar ('{')
				DLE_file.new_line
				DLE_file.indent
				DLE_file.putstring ("dle_eskelet();")
				DLE_file.new_line
				DLE_file.putstring ("dle_efrozen();")
				DLE_file.new_line
				DLE_file.putstring ("dle_edisptch();")
				DLE_file.new_line
				DLE_file.putstring ("dle_econform();")
				DLE_file.new_line
				DLE_file.putstring ("dle_ecall();")
				DLE_file.new_line
				DLE_file.putstring ("dle_eoption();")
				DLE_file.new_line
				DLE_file.putstring ("dle_epattern();")
				DLE_file.new_line
				DLE_file.putstring ("dle_einit();")
				DLE_file.new_line
				DLE_file.putstring ("dle_evisib();")
				DLE_file.new_line
				DLE_file.putstring ("dle_eplug();")
				DLE_file.new_line
				DLE_file.exdent
				DLE_file.putchar ('}')
				DLE_file.new_line
				DLE_file.new_line

				DLE_file.putstring ("void dle_free(void)")
				DLE_file.new_line
				DLE_file.putchar ('{')
				DLE_file.new_line
				DLE_file.indent
				DLE_file.putstring ("free_epattern();")
				DLE_file.new_line
				DLE_file.exdent
				DLE_file.putchar ('}')
				DLE_file.new_line
			else
				!! DLE_file_h.make (final_file_name (Edle, Dot_h))
				DLE_file_h.open_write
				DLE_file.putstring ("#include %"")
				DLE_file.putstring (Edle)
				DLE_file.putstring (Dot_h)
				DLE_file.putchar ('"')
				DLE_file.new_line
				DLE_file.new_line
				DLE_file.putstring ("void dle_load(void)")
				DLE_file.new_line
				DLE_file.putchar ('{')
				DLE_file.new_line
				DLE_file.indent

				DLE_file_h.putstring ("extern void dle_econform(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("dle_econform();")
				DLE_file.new_line

				DLE_file_h.putstring ("extern void dle_eref(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("dle_eref();")
				DLE_file.new_line

				DLE_file_h.putstring ("extern void dle_esize(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("dle_esize();")
				DLE_file.new_line

				DLE_file_h.putstring ("extern void dle_eskelet(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("dle_eskelet();")
				DLE_file.new_line

				DLE_file_h.putstring ("extern void dle_evisib(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("dle_evisib();")
				DLE_file.new_line

				from
					i := 1
					nb := Rout_generator.file_counter
				until
					i > nb
				loop
					DLE_file_h.putstring ("extern void dle_erout")
					DLE_file_h.putint (i)
					DLE_file_h.putstring ("(void);")
					DLE_file_h.new_line

					DLE_file.putstring ("dle_erout")
					DLE_file.putint (i)
					DLE_file.putstring ("(void);")
					DLE_file.new_line
					i := i + 1
				end
				from
					i := 1
					nb := Attr_generator.file_counter
				until
					i > nb
				loop
					DLE_file_h.putstring ("extern void dle_eattr")
					DLE_file_h.putint (i)
					DLE_file_h.putstring ("(void);")
					DLE_file_h.new_line

					DLE_file.putstring ("dle_eattr")
					DLE_file.putint (i)
					DLE_file.putstring ("(void);")
					DLE_file.new_line
					i := i + 1
				end

					-- The code in `plug' has to be called after the routine
					-- and attribute tables have been initialized.
				DLE_file_h.putstring ("extern void dle_eplug(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("dle_eplug();")
				DLE_file.new_line

				DLE_file.exdent
				DLE_file.putchar ('}')
				DLE_file.new_line
				DLE_file.new_line

				DLE_file.putstring ("void dle_free(void)")
				DLE_file.new_line
				DLE_file.putchar ('{')
				DLE_file.new_line
				DLE_file.indent

				DLE_file_h.putstring ("extern void free_econform(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("free_econform();")
				DLE_file.new_line

				DLE_file_h.putstring ("extern void free_eref(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("free_eref();")
				DLE_file.new_line

				DLE_file_h.putstring ("extern void free_esize(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("free_esize();")
				DLE_file.new_line

				DLE_file_h.putstring ("extern void free_eskelet(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("free_eskelet();")
				DLE_file.new_line

				DLE_file_h.putstring ("extern void free_evisib(void);")
				DLE_file_h.new_line
				DLE_file.putstring ("free_evisib();")
				DLE_file.new_line

				DLE_file.exdent
				DLE_file.putchar ('}')
				DLE_file.new_line

				DLE_file_h.close
			end

				-- Close DLE file
			DLE_file.close
		end

	generate_dle_make_table is
			-- Generate the table of `make' creation procedures of
			-- the descendants of DYNAMIC in the DC-set.
		local
			rout_table: DYN_ROUT_TABLE
			rout_entry: ROUT_ENTRY
			class_c: CLASS_C
			feat: FEATURE_I
			cl_type: CLASS_TYPE
			void_type: VOID_I
		do
			from
				!! void_type
				!! rout_table.make
				rout_table.set_rout_id (Dle_make_rout_id)
				dynamic_class_ids.start
			until
				dynamic_class_ids.after
			loop
				class_c := class_of_id (dynamic_class_ids.item_for_iteration)
				if
					class_c /= Void and then
					class_c.inherits_from_dynamic
				then
					!! rout_entry
						-- Classes of the DC-set inheriting from DYNAMIC
						-- are not generic nor deferred. They hence have
						-- only one type.
					cl_type := class_c.types.first
					feat := class_c.creation_feature
					rout_entry.set_type_id (cl_type.type_id)
					rout_entry.set_written_type_id
					 	(feat.written_type_id (cl_type.type))
					rout_entry.set_body_index (feat.body_index)
					rout_entry.set_type (void_type)
					rout_table.extend (rout_entry)
				end
				dynamic_class_ids.forth
			end
			rout_table.write
			dle_make_min_used := rout_table.min_used
		end

feature -- Dead code removal

	mark_dynamic_descendant_used (a_class: CLASS_C) is
			-- Mark features of descendants of DYNAMIC in the DC-set as used.
		do
			if a_class.is_dynamic and then a_class.inherits_from_dynamic then
					-- Protection of features of descendants
					-- of DYNAMIC in the DC-set.
				a_class.mark_all_used (remover)
				a_class.dle_mark_make (remover)
			end
		end

invariant

	extending: is_dynamic
	not_extendible: not extendible
	not_precompiling: not Compilation_modes.is_precompiling

end -- class DLE_SYSTEM_I
