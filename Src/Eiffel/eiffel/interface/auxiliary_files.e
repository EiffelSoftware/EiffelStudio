indexing
	description: "Generate the auxiliary files at the end%
				%of a C generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AUXILIARY_FILES

inherit
	SHARED_CODE_FILES

	COMPILER_EXPORTER

	SHARED_GENERATION

	SHARED_COMPILATION_MODES

	SHARED_EIFFEL_PROJECT

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make (current_system: SYSTEM_I; current_context: BYTE_CONTEXT)  is
		do
			system := current_system
			context := current_context
		end

feature -- Access

	system: SYSTEM_I

	context: BYTE_CONTEXT

feature -- Dynamic Library file

	generate_dynamic_lib_file is
			-- generate dynamic_lib.
		local
			dynamic_lib_exports: HASH_TABLE [LINKED_LIST[DYNAMIC_LIB_EXPORT_FEATURE],INTEGER]
			dl_exp: DYNAMIC_LIB_EXPORT_FEATURE
			dynamic_lib_def_file: INDENT_FILE
			dynamic_lib_def_file_name: FILE_NAME
			C_dynamic_lib_file: INDENT_FILE
			is_dll_generated: BOOLEAN
			dynamic_lib: E_DYNAMIC_LIB

			args: E_FEATURE_ARGUMENTS
			argument_names: LIST [STRING]
			return_type: STRING
			system_name: STRING
			class_name: STRING
			feature_name: STRING
			internal_creation_name: STRING
			internal_feature_name: STRING
			buffer, def_buffer: GENERATION_BUFFER
			nb_ref, i: INTEGER
		do
				-- Clear buffers for current generation
			buffer := generation_buffer
			buffer.clear_all
			def_buffer := header_generation_buffer
			def_buffer.clear_all

						-- We need to reparse the Eiffel DEF file in order to
						-- get the latest version saved by the user.
						--| Note: this is required because during some incremental
						--| compilation some IDs are going to be changed and thus
						--| what has been stored in E_DYNAMIC_LIB is not valid anymore.
			dynamic_lib := system.eiffel_dynamic_lib
			is_dll_generated := dynamic_lib /= Void
			if not is_dll_generated then
					-- Check if a `.def' file has been specified in the Ace file.
				if System.dynamic_def_file /= Void then
						-- Create for the first time the dynamic library.
					Eiffel_project.create_dynamic_lib
					dynamic_lib := system.eiffel_dynamic_lib
					is_dll_generated := True
				end
			end
			if is_dll_generated then
				dynamic_lib.update
				is_dll_generated := dynamic_lib.is_content_valid and not dynamic_lib.is_empty
				if is_dll_generated then
					dynamic_lib_exports := dynamic_lib.dynamic_lib_exports
					system_name := system.eiffel_system.name.twin
				end
			end

			if is_dll_generated then
						-- Generation of the header of the C_dynamic_lib_file
					buffer.put_string("/*****************%N")
					buffer.put_string(" *** EDYNLIB.C ***%N")
					buffer.put_string(" *****************/%N%N")

					buffer.put_string("#include %"egc_dynlib.h%"%N")

					buffer.put_string("%N")

						-- Generation of the header of the dynamic_lib_def_file
					def_buffer.put_string("LIBRARY ")
					def_buffer.put_string(system_name)
					def_buffer.put_string(".dll%N")
					def_buffer.put_string("%NEXPORTS%N")

					-- generation of everything
				from
					dynamic_lib_exports.start
				until
					dynamic_lib_exports.after
				loop
					if (dynamic_lib_exports.item_for_iteration /= Void) then
						def_buffer.put_string( "%N; CLASS [" )

						from
							dynamic_lib_exports.item_for_iteration.start
							class_name := dynamic_lib_exports.item_for_iteration.item.compiled_class.name_in_upper.twin
							def_buffer.put_string(class_name)
							def_buffer.put_string( "]%N" )
						until
							dynamic_lib_exports.item_for_iteration.after
						loop
							if (dynamic_lib_exports.item_for_iteration.item /=Void) then
								internal_creation_name := Void

								dl_exp := dynamic_lib_exports.item_for_iteration.item
								buffer.put_string ("/***************************%N * ")
								buffer.put_string (class_name)

								if (dl_exp.creation_routine /= Void) and then (dl_exp.routine.feature_id /= dl_exp.creation_routine.feature_id) then
										buffer.put_string (" (")
										buffer.put_string (dl_exp.creation_routine.name)
										buffer.put_string (")")
										internal_creation_name := Encoder.feature_name (
													System.class_of_id (dl_exp.creation_routine.written_in).types.first.static_type_id,
													dl_exp.creation_routine.body_index).twin
								elseif (dl_exp.creation_routine = Void) then
										buffer.put_string (" (!!)")
								end
								if (dl_exp.routine /= Void) then
									if dl_exp.has_alias then
										feature_name := dl_exp.alias_name.twin
									else
										feature_name := dl_exp.routine.name.twin
									end
									internal_feature_name := Encoder.feature_name (
											System.class_of_id (dl_exp.routine.written_in).types.first.static_type_id,
											dl_exp.routine.body_index).twin
									args:= dl_exp.routine.arguments

									def_buffer.put_string("%T")
									def_buffer.put_string(feature_name)

									buffer.put_string (" : ")
									buffer.put_string (feature_name)
									buffer.put_string(" <")
									buffer.put_string (internal_feature_name)
									buffer.put_string("> ")

									buffer.put_string ("%N ***************************/")

									-- GENERATION OF THE C-CODE

									if args /=Void then
										argument_names := args.argument_names
									else
										argument_names := Void
									end

									-- DECLARATION OF THE EXTERNAL (THE CREATION PROCEDURE, AND THE ROUTINE CALLED)
									----- Creation function
									if internal_creation_name /=Void then
										buffer.put_string ("%Nextern void ")
										buffer.put_string (internal_creation_name)
										buffer.put_string (" (EIF_REFERENCE);")
									end

									----- Routine function
									buffer.put_string ("%Nextern ")
									if dl_exp.routine.type /= Void then
										return_type := dl_exp.routine.type.type_i.c_type.c_string
									else
										return_type := "void"
									end
									buffer.put_string (return_type)

									buffer.put_string (" ")
									buffer.put_string (internal_feature_name)
									buffer.put_string (" (EIF_REFERENCE")
										-- Reinitialize `nb_ref'.
									nb_ref := 0
									if args /= Void then
										from
											args.start
										until
											args.after
										loop
											buffer.put_string (", ")
											args.item.type_i.c_type.generate (buffer)
											if not args.item.is_basic then
												nb_ref := nb_ref + 1
											end
											args.forth
										end
									end
									buffer.put_string (");")

										-- DEFINITION OF THE FUNCTION TO BE EXPORTED
									buffer.put_string ("%N")
									buffer.put_string (return_type)
									buffer.put_string (" ")
									if dl_exp.has_call_type then
										buffer.put_string (dl_exp.call_type)
										buffer.put_string (" ")
									end
									buffer.put_string (feature_name)
									buffer.put_string (" (")

									if argument_names /= Void then
										from
											argument_names.start
										until
											argument_names.after
										loop
											args.i_th (argument_names.index).type_i.c_type.generate (buffer)
											buffer.put_string(argument_names.item)
											if not argument_names.islast then
												buffer.put_string(", ")
											end
											argument_names.forth
										end
									else
										buffer.put_string("void")
									end

									buffer.put_string (")%N{%TGTCX")

										--INFORMATION ABOUT THE FEATURE
									if internal_creation_name /= Void then
										buffer.put_string ("%N%T/* Creation : ")
										buffer.put_string (internal_creation_name)
										buffer.put_string ("; */")
									end
									buffer.put_string ("%N%T/* Feature  : ")
									buffer.put_string (internal_feature_name)
									buffer.put_string (" ;*/")

										--LOCAL VARIABLES
									buffer.put_string ("%N%TEIF_REFERENCE main_obj = (EIF_REFERENCE) 0;")
									if not return_type.is_equal("void") then
										buffer.put_string ("%N%T")
										buffer.put_string (return_type)
										buffer.put_string (" Return_Value ;")
									end -- When the feature return a value.

										--INITIALIZATION DYNAMIC_LIB and RT
									buffer.put_string ("%N%TDYNAMIC_LIB_RT_INITIALIZE(")
									buffer.put_integer (nb_ref + 1)
									buffer.put_string (");%N")

										-- AFFECTION OF THE LOCAL VARIABLES `l[i]'
									if argument_names /= Void then
										from
												-- We start indexing at `1' because `0' is
												-- reserved for `main_obj' below.
											i := 1
											argument_names.start
										until
											argument_names.after
										loop
											if not args.i_th(argument_names.index).is_basic then
												buffer.put_string ("%N%T")
												buffer.put_local_registration (i, argument_names.item)
												i := i + 1
											end
											argument_names.forth
										end
									end

										-- CALCULATE THE MAIN OBJECT.
									buffer.put_string ("%N%T")
									buffer.put_local_registration (0, "main_obj")
									buffer.put_string ("%N%Tmain_obj = RTLN(")

									if Context.workbench_mode then
										buffer.put_string ("RTUD(");
										buffer.put_static_type_id (dl_exp.compiled_class.actual_type.type_i.associated_class_type.static_type_id)
										buffer.put_character (')');
									else
										buffer.put_type_id (dl_exp.compiled_class.actual_type.type_i.type_id);
									end
									buffer.put_string (");")

										--CALL THE CREATION ROUTINE
									if internal_creation_name /= Void then
										buffer.put_string ("%N%T/* Call the creation routine */%N%T")
										buffer.put_string (internal_creation_name)
										buffer.put_character ('(')
										buffer.put_string ("main_obj")
										buffer.put_string (");")
									end

										--CALL THE ROUTINE
									buffer.put_string ("%N%N%T/* Call the routine */")
									buffer.put_string ("%N%T")
									if not return_type.is_equal("void") then
										buffer.put_string ("Return_Value = (")
										buffer.put_string (return_type)
										buffer.put_string (") ")
									end -- When the feature return a value.
									buffer.put_string (internal_feature_name)
									buffer.put_character ('(')
									buffer.put_string ("main_obj")

									if argument_names /= Void then
										from
											argument_names.start
										until
											argument_names.after
										loop
											buffer.put_character (',')
											buffer.put_string (argument_names.item)
											argument_names.forth
										end
									end

									buffer.put_string (");")
									buffer.put_string ("%N%TDYNAMIC_LIB_RT_END;")
									if not return_type.is_equal("void") then
										buffer.put_string ("%N%Treturn (")
										buffer.put_string (return_type)
										buffer.put_string (") Return_Value;")
									end -- When the feature return a value.
									buffer.put_string ("%N}%N")

								end
								if (dl_exp.index /= 0) then
									def_buffer.put_string (" @ ")
									def_buffer.put_integer (dl_exp.index)
								end
								def_buffer.put_string ("%N")
								buffer.put_string ("%N")
							end

							dynamic_lib_exports.item_for_iteration.forth
						end
					end
					dynamic_lib_exports.forth
				end

				system_name.append_string(".def")
				if Context.final_mode then
					create dynamic_lib_def_file_name.make_from_string (project_location.final_path)
				else
					create dynamic_lib_def_file_name.make_from_string (project_location.workbench_path)
				end
				dynamic_lib_def_file_name.set_file_name (system_name)
				create dynamic_lib_def_file.make_open_write (dynamic_lib_def_file_name)
				def_buffer.put_in_file (dynamic_lib_def_file)
				dynamic_lib_def_file.close

				create C_dynamic_lib_file.make_c_code_file (gen_file_name (Context.final_mode, "edynlib"));
				buffer.put_in_file (C_dynamic_lib_file)
				C_dynamic_lib_file.close
			end
		end

feature -- Plug and Makefile file

	generate_plug is
			-- Generate plug with run-time
		local
			any_cl, string_cl, bit_cl, array_cl, rout_cl, exception_manager_cl: CLASS_C
			arr_type_id, str_type_id, type_id: INTEGER
			id: INTEGER
			str_make_feat, set_count_feat: FEATURE_I
			count_feat, internal_hash_code_feat: ATTRIBUTE_I
			creation_feature, correct_mismatch_feat: FEATURE_I
			feat: FEATURE_I
			creators: HASH_TABLE [EXPORT_I, STRING]
			dispose_name, str_make_name, init_name, exp_init_name,
			set_count_name: STRING
			arr_make_name, set_rout_disp_name: STRING
			set_exception_data_name, is_code_ignored_name: STRING
			last_exception_name, set_last_exception_name: STRING
			init_exception_manager_name, free_preallocated_trace_name: STRING
			once_raise_name: STRING
			correct_mismatch_name: STRING
			equal_name: STRING
			twin_name: STRING
			special_cl: SPECIAL_B
			cl_type: CLASS_TYPE
			final_mode: BOOLEAN
			plug_file: INDENT_FILE
			buffer: GENERATION_BUFFER

			has_argument: BOOLEAN
			root_cl: CLASS_C
			rout_info: ROUT_INFO
			root_feat: FEATURE_I
			rcorigin: INTEGER
			rcoffset: INTEGER

			l_create_type: CREATE_TYPE
			l_creation_type: CL_TYPE_I
			l_gen_type: GEN_TYPE_I

			l_rt_dbg_cl: CLASS_C
			l_rt_extension_notify_name, l_rt_extension_notify_argument_name: STRING
		do
				-- Clear buffer for current generation
			buffer := generation_buffer
			buffer.clear_all

			final_mode := Context.final_mode

			buffer.put_string ("/*%N")
			buffer.put_string (" * Generated by ISE ")
			buffer.put_string (Version_number)
			buffer.put_string ("%N */%N%N")
			buffer.put_string ("#include %"eif_eiffel.h%"%N")
			buffer.put_string ("#include %"eif_project.h%"%N")
			buffer.put_string ("#include %"egc_include.h%"%N%N")

			buffer.start_c_specific_code

				-- Extern declarations
			string_cl := system.class_of_id (system.string_8_id)
			cl_type := string_cl.types.first
			id := cl_type.static_type_id
			str_type_id := cl_type.type_id
			creators := string_cl.creators
			creators.start

				-- Make ANY declaration
			any_cl := system.any_class.compiled_class
			correct_mismatch_feat :=
				any_cl.feature_table.item_id (Names_heap.internal_correct_mismatch_name_id)
			correct_mismatch_name := Encoder.feature_name (any_cl.types.first.static_type_id,
				correct_mismatch_feat.body_index).twin
			buffer.put_string ("extern void ")
			buffer.put_string (correct_mismatch_name)
			buffer.put_string ("();%N")

			equal_name :=
				Encoder.feature_name (any_cl.types.first.static_type_id,
					any_cl.feature_table.item_id (Names_heap.equal_name_id).body_index).twin
			buffer.put_string ("extern EIF_BOOLEAN ")
			buffer.put_string (equal_name)
			buffer.put_string ("();%N")

			twin_name :=
				Encoder.feature_name (any_cl.types.first.static_type_id,
					any_cl.feature_table.item_id (Names_heap.twin_name_id).body_index).twin
			buffer.put_string ("extern EIF_REFERENCE ")
			buffer.put_string (twin_name)
			buffer.put_string ("();%N")

				-- Make STRING declaration
			str_make_feat := string_cl.feature_table.item_id (Names_heap.make_name_id)
			str_make_name := Encoder.feature_name (id, str_make_feat.body_index).twin
			buffer.put_string ("extern void ")
			buffer.put_string (str_make_name)
			buffer.put_string ("();%N")
			if final_mode then
				count_feat ?= string_cl.feature_table.item_id (Names_heap.count_name_id)
				internal_hash_code_feat ?= string_cl.feature_table.item_id (Names_heap.internal_hash_code_name_id)
			else
				set_count_feat ?= string_cl.feature_table.item_id (Names_heap.set_count_name_id)
				set_count_name := Encoder.feature_name (id, set_count_feat.body_index).twin
				buffer.put_string ("extern void ")
				buffer.put_string (set_count_name)
				buffer.put_string ("();%N")
			end

				--| make ARRAY declaration
				--| Temporary solution. When a system uses precompiled information,
				--| the C code for ARRAY[ANY] is never re-generated, but the computed
				--| name of the make routine will (unfortunately) change. Therefore, the
				--| name in the plug file might not match the name in the precompiled
				--| C file... Heavy!
			if (system.array_make_name = Void) or not System.uses_precompiled or final_mode then
				array_cl := System.class_of_id (System.array_id)
					--! Array ref type (i.e. ARRAY[ANY])
				cl_type := System.Instantiator.Array_type.associated_class_type;
				id := cl_type.static_type_id
				arr_type_id := cl_type.type_id
				creators := array_cl.creators
				creators.start
				creation_feature := array_cl.feature_table.item_id (Names_heap.make_name_id)
				arr_make_name := Encoder.feature_name (id, creation_feature.body_index).twin
				system.set_array_make_name (arr_make_name)
			else
				cl_type := System.Instantiator.Array_type.associated_class_type;
				arr_type_id := cl_type.type_id
				arr_make_name := system.array_make_name
			end

			buffer.put_string ("extern void ")
			buffer.put_string (arr_make_name)
			buffer.put_string ("();%N")

				-- Make ROUTINE declaration
			rout_cl := system.class_of_id (system.routine_class_id)

			if rout_cl.types /= Void and then not rout_cl.types.is_empty then
				cl_type := rout_cl.types.first
				id := cl_type.static_type_id
				if final_mode then
					feat := rout_cl.feature_table.item_id (Names_heap.set_rout_disp_final_name_id)
					set_rout_disp_name := Encoder.feature_name (id, feat.body_index).twin
				else
					feat := rout_cl.feature_table.item_id (Names_heap.set_rout_disp_name_id)
					set_rout_disp_name := Encoder.feature_name (id, feat.body_index).twin
				end
				buffer.put_string ("extern void ")
				buffer.put_string (set_rout_disp_name)
				buffer.put_string ("();%N")
			end

				-- Make exception manager declaration
			exception_manager_cl := system.class_of_id (system.exception_manager_class_id)
			if exception_manager_cl.types /= Void and then not exception_manager_cl.types.is_empty then
				exception_manager_cl := system.exception_manager_class.compiled_class
				feat := exception_manager_cl.feature_table.item_id (Names_heap.set_exception_data_name_id)
				id := exception_manager_cl.types.first.static_type_id
				set_exception_data_name := Encoder.feature_name (id, feat.body_index).twin
				buffer.put_string ("extern void ")
				buffer.put_string (set_exception_data_name)
				buffer.put_string ("();%N")

				feat := exception_manager_cl.feature_table.item_id (Names_heap.last_exception_name_id)
				last_exception_name := Encoder.feature_name (id, feat.body_index).twin
				buffer.put_string ("extern EIF_REFERENCE ")
				buffer.put_string (last_exception_name)
				buffer.put_string ("();%N")

				feat := exception_manager_cl.feature_table.item_id (Names_heap.set_last_exception_name_id)
				set_last_exception_name := Encoder.feature_name (id, feat.body_index).twin
				buffer.put_string ("extern EIF_BOOLEAN ")
				buffer.put_string (set_last_exception_name)
				buffer.put_string ("();%N")

				feat := exception_manager_cl.feature_table.item_id (Names_heap.is_code_ignored_name_id)
				is_code_ignored_name := Encoder.feature_name (id, feat.body_index).twin
				buffer.put_string ("extern EIF_BOOLEAN ")
				buffer.put_string (is_code_ignored_name)
				buffer.put_string ("();%N")

				feat := exception_manager_cl.feature_table.item_id (Names_heap.once_raise_name_id)
				once_raise_name := Encoder.feature_name (id, feat.body_index).twin
				buffer.put_string ("extern void ")
				buffer.put_string (once_raise_name)
				buffer.put_string ("();%N")

				feat := exception_manager_cl.feature_table.item_id (Names_heap.init_exception_manager_id)
				init_exception_manager_name := Encoder.feature_name (id, feat.body_index).twin
				buffer.put_string ("extern void ")
				buffer.put_string (init_exception_manager_name)
				buffer.put_string ("();%N")

				feat := exception_manager_cl.feature_table.item_id (Names_heap.free_preallocated_trace_id)
				free_preallocated_trace_name := Encoder.feature_name (id, feat.body_index).twin
				buffer.put_string ("extern void ")
				buffer.put_string (free_preallocated_trace_name)
				buffer.put_string ("();%N")
			end

				-- RT_EXTENSION declaration
			if
				not final_mode and then
				system.rt_extension_class /= Void and then system.rt_extension_class.is_compiled
			then
				l_rt_dbg_cl := system.rt_extension_class.compiled_class
				cl_type := l_rt_dbg_cl.types.first
				id := cl_type.static_type_id

				feat := l_rt_dbg_cl.feature_table.item_id (Names_heap.notify_name_id)
				if feat /= Void then
					l_rt_extension_notify_name := Encoder.feature_name (id, feat.body_index).twin
				end
				if l_rt_extension_notify_name /= Void then
					buffer.put_string ("extern void ")
					buffer.put_string (l_rt_extension_notify_name)
					buffer.put_string ("();")
					buffer.put_new_line
				end

				feat := l_rt_dbg_cl.feature_table.item_id (Names_heap.notify_argument_name_id)
				if feat /= Void then
					l_rt_extension_notify_argument_name := Encoder.feature_name (id, feat.body_index).twin
				end
				if l_rt_extension_notify_argument_name /= Void then
					buffer.put_string ("extern EIF_TYPED_VALUE ")
					buffer.put_string (l_rt_extension_notify_argument_name)
					buffer.put_string ("();")
					buffer.put_new_line
				end
			end

			if final_mode then
					-- Declaration needed for calling `egc_routine_tables_init'.
				buffer.put_string ("extern void egc_routine_tables_init (void);")
				buffer.put_new_line
			end

			if final_mode and then System.array_optimization_on then
				System.remover.array_optimizer.generate_plug_declarations (buffer)
			else
				buffer.put_string ("%Nlong *eif_area_table = (long *)0;%N%
									%long *eif_lower_table = (long *)0;%N")
			end

			if final_mode then
				init_name :=
					Encoder.routine_table_name (system.routine_id_counter.initialization_rout_id).twin
				exp_init_name :=
					Encoder.routine_table_name (system.routine_id_counter.creation_rout_id).twin

				buffer.put_string ("extern char *(*")
				buffer.put_string (init_name)
				buffer.put_string ("[])();%N")
				buffer.put_string ("extern char *(*")
				buffer.put_string (exp_init_name)
				buffer.put_string ("[])();%N")

				dispose_name := Encoder.routine_table_name (system.routine_id_counter.dispose_rout_id).twin
				buffer.put_string ("extern char *(*")
				buffer.put_string (dispose_name)
				buffer.put_string ("[])();%N%N")
			end

				-- Declaration and definition of the egc_init_plug function.
			buffer.put_string ("%N%Nextern void egc_init_plug (void); %N")
			buffer.put_string ("void egc_init_plug (void)%N{%N")

				-- Do we need to collect GC data for the profiler?
			buffer.put_string ("%Tegc_prof_enabled = (EIF_INTEGER) ")
			if system.universe.target.options.is_profile then
				buffer.put_string ("3;%N")
			else
				buffer.put_string ("0;%N")
			end

				-- Pointer on `correct_mismatch' of class ANY
			buffer.put_string ("%Tegc_correct_mismatch = (void (*)(EIF_REFERENCE)) ")
			buffer.put_string (correct_mismatch_name)
			buffer.put_string (";%N")

				-- Pointer on `equal' of class ANY
			if final_mode then
				buffer.put_string ("%Tegc_equal = (EIF_BOOLEAN (*)(EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE)) ")
			else
				buffer.put_string ("%Tegc_equal = (EIF_TYPED_VALUE (*)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) ")
			end
			buffer.put_string (equal_name)
			buffer.put_string (";%N")

				-- Pointer on `twin' of class ANY
			if final_mode then
				buffer.put_string ("%Tegc_twin = (EIF_REFERENCE (*)(EIF_REFERENCE)) ")
			else
				buffer.put_string ("%Tegc_twin = (EIF_TYPED_VALUE (*)(EIF_REFERENCE)) ")
			end
			buffer.put_string (twin_name)
			buffer.put_string (";%N")

				-- Pointer on creation feature of class STRING
			if final_mode then
				buffer.put_string ("%Tegc_strmake = (void (*)(EIF_REFERENCE, EIF_INTEGER)) ")
			else
				buffer.put_string ("%Tegc_strmake = (void (*)(EIF_REFERENCE, EIF_TYPED_VALUE)) ")
			end
			buffer.put_string (str_make_name)
			buffer.put_string (";%N")

				-- Pointer on creation feature of class ARRAY[ANY]
			if final_mode then
				buffer.put_string ("%Tegc_arrmake = (void (*)(EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER)) ")
			else
				buffer.put_string ("%Tegc_arrmake = (void (*)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) ")
			end
			buffer.put_string (arr_make_name)
			buffer.put_string (";%N")

			if final_mode then
					-- Offset from top of STRING object to access `count' attribute of class STRING
				buffer.put_string ("%Tegc_str_count_offset = ")
				string_cl.types.first.skeleton.generate_offset (buffer, count_feat.feature_id, False)
				buffer.put_string (";%N")

					-- Offset from top of STRING object to access `internal_hash_code' attribute of class STRING
				buffer.put_string ("%Tegc_str_hash_offset = ")
				string_cl.types.first.skeleton.generate_offset (buffer, internal_hash_code_feat.feature_id, False)
				buffer.put_string (";%N")
			else
				buffer.put_string ("%Tegc_strset = (void (*)(EIF_REFERENCE, EIF_TYPED_VALUE)) ")
				buffer.put_string (set_count_name)
				buffer.put_string (";%N")
			end

				--Pointer on `set_rout_disp' or 'set_rout_disp_final' of class ROUTINE
			if set_rout_disp_name /= Void then
				if final_mode then
					buffer.put_string ("%Tegc_routdisp_fl = (void (*)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_REFERENCE, EIF_BOOLEAN, EIF_INTEGER)) ")
				else
					buffer.put_string ("%Tegc_routdisp_wb = (void (*)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) ")
				end
				buffer.put_string (set_rout_disp_name)
				buffer.put_string (";%N")
			end

				-- Pointer on `set_exception_data' of class EXCEPTION_MANAGER.
			if set_exception_data_name /= Void then
				if final_mode then
					buffer.put_string ("%Tegc_set_exception_data = (void (*)(EIF_REFERENCE, EIF_INTEGER, EIF_BOOLEAN, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_BOOLEAN)) ")
				else
					buffer.put_string ("%Tegc_set_exception_data = (void (*)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) ")
				end
				buffer.put_string (set_exception_data_name)
				buffer.put_string (";%N")
			end

				-- Pointer on `set_last_exception' of class EXCEPTION_MANAGER.
			if set_last_exception_name /= Void then
				if final_mode then
					buffer.put_string ("%Tegc_set_last_exception = (void (*)(EIF_REFERENCE, EIF_REFERENCE)) ")
				else
					buffer.put_string ("%Tegc_set_last_exception = (void (*)(EIF_REFERENCE, EIF_TYPED_VALUE)) ")
				end
				buffer.put_string (set_last_exception_name)
				buffer.put_string (";%N")
			end

				-- Pointer on `last_exception' of class EXCEPTION_MANAGER.
			if last_exception_name /= Void then
				if final_mode then
					buffer.put_string ("%Tegc_last_exception = (EIF_REFERENCE (*)(EIF_REFERENCE)) ")
				else
					buffer.put_string ("%Tegc_last_exception = (EIF_TYPED_VALUE (*)(EIF_REFERENCE)) ")
				end
				buffer.put_string (last_exception_name)
				buffer.put_string (";%N")
			end

				-- Pointer on `is_code_ignored' of class EXCEPTION_MANAGER.
			if is_code_ignored_name /= Void then
				if final_mode then
					buffer.put_string ("%Tegc_is_code_ignored = (EIF_BOOLEAN (*)(EIF_REFERENCE, EIF_INTEGER)) ")
				else
					buffer.put_string ("%Tegc_is_code_ignored = (EIF_TYPED_VALUE (*)(EIF_REFERENCE, EIF_TYPED_VALUE)) ")
				end
				buffer.put_string (is_code_ignored_name)
				buffer.put_string (";%N")
			end

				-- Pointer on `raise' of class EXCEPTION_MANAGER.
			if once_raise_name /= Void then
				if final_mode then
					buffer.put_string ("%Tegc_once_raise = (void (*)(EIF_REFERENCE, EIF_REFERENCE)) ")
				else
					buffer.put_string ("%Tegc_once_raise = (void (*)(EIF_REFERENCE, EIF_TYPED_VALUE)) ")
				end
				buffer.put_string (once_raise_name)
				buffer.put_string (";%N")
			end

				-- Pointer on `init_exception_manager' of class EXCEPTION_MANAGER.
			if init_exception_manager_name /= Void then
				buffer.put_string ("%Tegc_init_exception_manager = (void (*)(EIF_REFERENCE)) ")
				buffer.put_string (init_exception_manager_name)
				buffer.put_string (";%N")
			end

				-- Pointer on `free_preallocated_trace_name' of class EXCEPTION_MANAGER.
			if free_preallocated_trace_name /= Void then
				buffer.put_string ("%Tegc_free_preallocated_trace = (void (*)(EIF_REFERENCE)) ")
				buffer.put_string (free_preallocated_trace_name)
				buffer.put_string (";%N")
			end

				-- Dynamic type of class STRING
			buffer.put_string ("%N%Tegc_str_dtype = ")
			buffer.put_type_id (str_type_id)
			buffer.put_string (";%N")

				-- Dynamic type of class ARRAY[ANY]
			buffer.put_string ("%Tegc_arr_dtype = ")
			buffer.put_type_id (arr_type_id)
			buffer.put_string (";%N")

				-- Dynamic type of class TUPLE
			buffer.put_string ("%Tegc_tup_dtype = ")
			buffer.put_type_id (system.tuple_class.compiled_class.types.first.type_id)
			buffer.put_string (";%N")

				-- Dispose routine id from class DISPOSABLE (if compiled)
			buffer.put_string ("%Tegc_disp_rout_id = ")
			if System.disposable_class /= Void and System.disposable_class.is_compiled then
				buffer.put_integer (System.disposable_dispose_id)
			else
				buffer.put_string ("-1")
			end
			buffer.put_string (";%N")

				-- Dynamic type of class BIT_REF
			bit_cl := System.class_of_id (System.bit_id)
			type_id := bit_cl.types.first.type_id
			buffer.put_string ("%Tegc_bit_dtype = ")
			buffer.put_type_id (type_id)
			buffer.put_string (";%N")

			special_cl ?= System.special_class.compiled_class
			special_cl.generate_dynamic_types (buffer)
			generate_dynamic_ref_type (buffer)

			buffer.put_string ("%N%Tegc_ce_type = egc_ce_type_init;%N")
			buffer.put_string ("%N%Tegc_ce_exp_type = egc_ce_exp_type_init;%N")
			buffer.put_string ("%Tegc_fsystem = egc_fsystem_init;%N")
			buffer.put_string ("%Tegc_system_mod_init = egc_system_mod_init_init;%N")
			buffer.put_string ("%Tegc_partab = egc_partab_init;%N")
			buffer.put_string ("%Tegc_partab_size = egc_partab_size_init;%N")

			if not final_mode or else system.keep_assertions then
				buffer.put_string ("%Tegc_foption = egc_foption_init;%N")
			end

			if not final_mode then
				buffer.put_string ("%Tegc_frozen = egc_frozen_init;%N")
				buffer.put_string ("%Tegc_fpatidtab = egc_fpatidtab_init;%N");
				buffer.put_string ("%Tegc_address_table = egc_address_table_init;%N")
				buffer.put_string ("%Tegc_fpattern = egc_fpattern_init;%N")

				buffer.put_string ("%N%Tegc_einit = egc_einit_init;%N")
				buffer.put_string ("%Tegc_tabinit = egc_tabinit_init;%N")

				buffer.put_string ("%N%Tegc_fcall = egc_fcall_init;%N")
				buffer.put_string ("%Tegc_forg_table = egc_forg_table_init;%N")
				buffer.put_string ("%Tegc_fdtypes = egc_fdtypes_init;%N")

			else
					-- Do we need to protect the exception stack?
				buffer.put_string ("%Texception_stack_managed = (EIF_BOOLEAN) ")
				if System.exception_stack_managed then
					buffer.put_string ("1;%N")
				else
					buffer.put_string ("0;%N")
				end

					-- Initialization routines
				buffer.put_string ("%Tegc_ecreate = ")
				buffer.put_string ("(char *(**)(void)) ")
				buffer.put_string (init_name)
				buffer.put_string (";%N")

					-- Initialization routines
				buffer.put_string ("%Tegc_exp_create = ")
				buffer.put_string ("(char *(**)(void)) ")
				buffer.put_string (exp_init_name)
				buffer.put_string (";%N")

					-- Dispose routines
				buffer.put_string ("%Tegc_edispose = ")
				buffer.put_string ("(void (**)(void)) ")
				buffer.put_string (dispose_name)
				buffer.put_string (";%N")

				buffer.put_string ("%Tegc_ce_rname = egc_ce_rname_init;%N")
				buffer.put_string ("%Tegc_fnbref = egc_fnbref_init;%N")
				buffer.put_string ("%Tegc_fsize = egc_fsize_init;%N")
			end

			buffer.put_string ("%N%Tegc_system_name = %"")
			buffer.put_string (System.name)
			buffer.put_string ("%";%N%Tegc_system_location = ")
			if final_mode then
				buffer.put_string_literal (project_location.final_path)
			else
				buffer.put_string_literal (project_location.workbench_path)
			end
			buffer.put_string (";%N%Tegc_compiler_tag = ")
			buffer.put_integer (System.version_tag)
			buffer.put_string (";%N%Tegc_project_version = ")
			buffer.put_integer (System.project_creation_time)

				-- Generate the number of dynamic types.
			buffer.put_string (";%N%Tscount = ")
			buffer.put_integer (System.type_id_counter.value)
			buffer.put_string (";%N%N")

			if not final_mode then
				check system.root_type /= Void end
				root_cl := System.root_type.associated_class
				if not Compilation_modes.is_precompiling and then System.root_creation_name /= Void then
					root_feat := root_cl.feature_table.item (System.root_creation_name)
					has_argument := root_feat.has_arguments
					rout_info := System.rout_info_table.item (root_feat.rout_id_set.first)
					rcorigin := rout_info.origin
					rcoffset := rout_info.offset
				else
					rcorigin := -1
				end

				buffer.put_string ("%Tegc_rcorigin = ")
				buffer.put_integer (rcorigin)
				buffer.put_string (";%N%Tegc_rcdt = 0")
				buffer.put_string (";%N%Tegc_rcoffset = ")
				buffer.put_integer (rcoffset)
				buffer.put_string (";%N%Tegc_rcarg = ")
				if has_argument then
					buffer.put_string ("1")
				else
					buffer.put_string ("0")
				end
				buffer.put_string (";%N%N")
			end

			buffer.put_string ("%Tegc_platform_level = 0x00000D00;")
			buffer.put_new_line

				--| RT_EXTENSION and co...
			if
				not final_mode and then
				system.rt_extension_class /= Void and then system.rt_extension_class.is_compiled
			then
				buffer.put_string ("%Tegc_rt_extension_dt = ")
				buffer.put_type_id (system.rt_extension_type_id)
				buffer.put_string (";")
				buffer.put_new_line

				if l_rt_extension_notify_name /= Void then
					if context.final_mode then
						buffer.put_string ("%Tegc_rt_extension_notify = (void (*)(EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE)) ")
					else
						buffer.put_string ("%Tegc_rt_extension_notify = (void (*)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) ")
					end
					buffer.put_string (l_rt_extension_notify_name)
					buffer.put_character (';')
					buffer.put_new_line
				end
				if l_rt_extension_notify_argument_name /= Void then
					if context.final_mode then
						buffer.put_string ("%Tegc_rt_extension_notify_argument = (EIF_REFERENCE (*)(EIF_REFERENCE, EIF_INTEGER)) ")
					else
						buffer.put_string ("%Tegc_rt_extension_notify_argument = (EIF_TYPED_VALUE (*)(EIF_REFERENCE, EIF_TYPED_VALUE)) ")
					end
					buffer.put_string (l_rt_extension_notify_argument_name)
					buffer.put_character (';')
					buffer.put_new_line
				end
			end

			if final_mode then
					-- Initialize polymorphic tables
				buffer.put_string ("%Tegc_routine_tables_init();")
				buffer.put_new_line
			end

			buffer.put_string ("}%N%N")

				-- Declaration and definition of the egc_rcdt_init function.
			buffer.put_string ("void egc_rcdt_init (void)%N{")
			buffer.indent
			buffer.put_new_line
			buffer.put_string ("if (egc_rcdt == 0) {")
			buffer.put_new_line
			l_creation_type := system.root_type.type_i
			l_gen_type ?= l_creation_type
			if l_gen_type /= Void then
				context.set_buffer (buffer)
				buffer.indent
				buffer.put_new_line
					-- Because generic object creation requires a context object,
					-- we simply create a temporary one of type ANY, used to
					-- create an instance of our generic type.
				buffer.put_string ("EIF_REFERENCE l_root_obj, Current = RTLN(")
				buffer.put_type_id (system.any_class.compiled_class.types.first.type_id)
				buffer.put_string (");")
				buffer.put_new_line
					-- Go ahead an create our generic type.
				create l_create_type.make (l_creation_type)
				l_create_type.generate_start (buffer)
				l_create_type.generate_gen_type_conversion
				buffer.put_string ("l_root_obj = ")
				l_create_type.generate
				buffer.put_string (";")
				buffer.put_new_line
				l_create_type.generate_end (buffer)
					-- Set `egc_rcdt' to the right dynamic type
				buffer.put_string ("egc_rcdt = Dftype(l_root_obj);")
				buffer.exdent
			else
				buffer.put_string ("%T%Tegc_rcdt = ")
				buffer.put_type_id (l_creation_type.type_id)
				buffer.put_character (';')
			end
			buffer.put_new_line
			buffer.put_character ('}')
			buffer.exdent
			buffer.put_new_line
			buffer.put_string ("}%N%N")

			buffer.end_c_specific_code

			create plug_file.make_c_code_file (x_gen_file_name (final_mode, Eplug));
			buffer.put_in_file (plug_file)
			plug_file.close
		end

	generate_dynamic_ref_type (buffer: GENERATION_BUFFER) is
			-- Generate dynaminc reference types of basic classes.
		require
			buffer_exists: buffer /= Void
		do
			buffer.put_string ("%N%Tegc_uint8_ref_dtype = ")
			buffer.put_type_id (system.natural_ref_type_id (8))
			buffer.put_string (";%N%Tegc_uint16_ref_dtype = ")
			buffer.put_type_id (system.natural_ref_type_id (16))
			buffer.put_string (";%N%Tegc_uint32_ref_dtype = ")
			buffer.put_type_id (system.natural_ref_type_id (32))
			buffer.put_string (";%N%Tegc_uint64_ref_dtype = ")
			buffer.put_type_id (system.natural_ref_type_id (64))
			buffer.put_string (";%N%Tegc_int8_ref_dtype = ")
			buffer.put_type_id (system.integer_ref_type_id (8))
			buffer.put_string (";%N%Tegc_int16_ref_dtype = ")
			buffer.put_type_id (system.integer_ref_type_id (16))
			buffer.put_string (";%N%Tegc_int32_ref_dtype = ")
			buffer.put_type_id (system.integer_ref_type_id (32))
			buffer.put_string (";%N%Tegc_int64_ref_dtype = ")
			buffer.put_type_id (system.integer_ref_type_id (64))
			buffer.put_string (";%N%Tegc_bool_ref_dtype = ")
			buffer.put_type_id (system.boolean_ref_type_id)
			buffer.put_string (";%N%Tegc_real32_ref_dtype = ")
			buffer.put_type_id (system.real_32_ref_type_id)
			buffer.put_string (";%N%Tegc_char_ref_dtype = ")
			buffer.put_type_id (system.character_8_ref_type_id)
			buffer.put_string (";%N%Tegc_wchar_ref_dtype = ")
			buffer.put_type_id (system.character_32_ref_type_id)
			buffer.put_string (";%N%Tegc_real64_ref_dtype = ")
			buffer.put_type_id (system.real_64_ref_type_id)
			buffer.put_string (";%N%Tegc_point_ref_dtype = ")
			buffer.put_type_id (system.pointer_ref_type_id)
			buffer.put_string (";%N");

			buffer.put_string ("%N%Tegc_uint8_dtype = ")
			buffer.put_type_id (uint8_c_type.type_id)
			buffer.put_string (";%N%Tegc_uint16_dtype = ")
			buffer.put_type_id (uint16_c_type.type_id)
			buffer.put_string (";%N%Tegc_uint32_dtype = ")
			buffer.put_type_id (uint32_c_type.type_id)
			buffer.put_string (";%N%Tegc_uint64_dtype = ")
			buffer.put_type_id (uint64_c_type.type_id)
			buffer.put_string (";%N%Tegc_int8_dtype = ")
			buffer.put_type_id (int8_c_type.type_id)
			buffer.put_string (";%N%Tegc_int16_dtype = ")
			buffer.put_type_id (int16_c_type.type_id)
			buffer.put_string (";%N%Tegc_int32_dtype = ")
			buffer.put_type_id (int32_c_type.type_id)
			buffer.put_string (";%N%Tegc_int64_dtype = ")
			buffer.put_type_id (int64_c_type.type_id)
			buffer.put_string (";%N%Tegc_bool_dtype = ")
			buffer.put_type_id (boolean_c_type.type_id)
			buffer.put_string (";%N%Tegc_real32_dtype = ")
			buffer.put_type_id (real32_c_type.type_id)
			buffer.put_string (";%N%Tegc_char_dtype = ")
			buffer.put_type_id (char_c_type.type_id)
			buffer.put_string (";%N%Tegc_wchar_dtype = ")
			buffer.put_type_id (wide_char_c_type.type_id)
			buffer.put_string (";%N%Tegc_real64_dtype = ")
			buffer.put_type_id (real64_c_type.type_id)
			buffer.put_string (";%N%Tegc_point_dtype = ")
			buffer.put_type_id (pointer_c_type.type_id)

				-- Exceptions
			buffer.put_string (";%N%Tegc_except_emnger_dtype = ")
			buffer.put_type_id (system.exception_manager_type_id)
			buffer.put_string (";%N")
		end

	generate_make_file is
			-- Generate make file
		do
			system.makefile_generator.generate
			system.makefile_generator.clear
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end -- class AUXILIARY_FILES
