indexing
	description: "Generate the auxiliary files at the end%
				%of a C generation"
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

creation
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
			eiffel_def_file: PLAIN_TEXT_FILE
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
			nb_ref: INTEGER
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
					dynamic_lib.set_file_name (System.dynamic_def_file)
					is_dll_generated := True
				end
			end
			if is_dll_generated then
				create eiffel_def_file.make (dynamic_lib.file_name)
				if
					eiffel_def_file.exists and then
					eiffel_def_file.is_readable and then
					eiffel_def_file.is_plain
				then
					eiffel_def_file.open_read
					is_dll_generated := dynamic_lib.parse_exports_from_file (eiffel_def_file)
					eiffel_def_file.close
					dynamic_lib_exports := dynamic_lib.dynamic_lib_exports
					system_name := clone(system.eiffel_system.name)
					is_dll_generated := not dynamic_lib_exports.is_empty
				else
					is_dll_generated := False
				end
			end

			if is_dll_generated then
						-- Generation of the header of the C_dynamic_lib_file
					buffer.putstring("/*****************%N")
					buffer.putstring(" *** EDYNLIB.C ***%N")
					buffer.putstring(" *****************/%N%N")
					
					buffer.putstring("#include %"egc_dynlib.h%"%N")

					buffer.putstring("%N")

						-- Generation of the header of the dynamic_lib_def_file
					def_buffer.putstring("LIBRARY ")
					def_buffer.putstring(system_name)
					def_buffer.putstring(".dll%N")
					system_name.to_upper
					def_buffer.putstring("DESCRIPTION ")
					def_buffer.putstring(system_name)
					def_buffer.putstring(".DLL%N")
					def_buffer.putstring("%NEXPORTS%N%N")

					-- generation of everything
				from
					dynamic_lib_exports.start
				until
					dynamic_lib_exports.after
				loop
					if (dynamic_lib_exports.item_for_iteration /= Void) then
						def_buffer.putstring( "%N; CLASS [" )

						from
							dynamic_lib_exports.item_for_iteration.start
							class_name := clone(dynamic_lib_exports.item_for_iteration.item.compiled_class.name_in_upper)
							def_buffer.putstring(class_name)
							def_buffer.putstring( "]%N" )
						until
							dynamic_lib_exports.item_for_iteration.after
						loop
							if (dynamic_lib_exports.item_for_iteration.item /=Void) then
								internal_creation_name := Void

								dl_exp := dynamic_lib_exports.item_for_iteration.item
								buffer.putstring ("/***************************%N * ")
								buffer.putstring (class_name)

								if (dl_exp.creation_routine /= Void) and then (dl_exp.routine.feature_id /= dl_exp.creation_routine.feature_id) then
										buffer.putstring (" (")
										buffer.putstring (dl_exp.creation_routine.name)
										buffer.putstring (")")
										internal_creation_name := clone (Encoder.feature_name (
													System.class_of_id (dl_exp.creation_routine.written_in).types.first.static_type_id,
													dl_exp.creation_routine.body_index))
								elseif (dl_exp.creation_routine = Void) then
										buffer.putstring (" (!!)")
								end
								if (dl_exp.routine /= Void) then
									if dl_exp.has_alias then
										feature_name := clone(dl_exp.alias_name)
									else
										feature_name := clone(dl_exp.routine.name)
									end
									internal_feature_name := clone (Encoder.feature_name (
											System.class_of_id (dl_exp.routine.written_in).types.first.static_type_id,
											dl_exp.routine.body_index))
									args:= dl_exp.routine.arguments

									def_buffer.putstring("%T")
									def_buffer.putstring(feature_name)

									buffer.putstring (" : ")
									buffer.putstring (feature_name)
									buffer.putstring(" <")
									buffer.putstring (internal_feature_name)
									buffer.putstring("> ")

									buffer.putstring ("%N ***************************/")


									-- GENERATION OF THE C-CODE

									if args /=Void then
										argument_names := args.argument_names
									else
										argument_names := Void
									end

									-- DECLARATION OF THE EXTERNAL (THE CREATION PROCEDURE, AND THE ROUTINE CALLED)
									----- Creation function
									if internal_creation_name /=Void then
										buffer.putstring ("%Nextern void ")
										buffer.putstring (internal_creation_name)
										buffer.putstring (" (EIF_REFERENCE);")
									end

									----- Routine function
									buffer.putstring ("%Nextern ")
									return_type := clone ( cecil_type(dl_exp.routine.type) )
									buffer.putstring (return_type)
										
									buffer.putstring (" ")
									buffer.putstring (internal_feature_name)
									buffer.putstring (" (EIF_REFERENCE")
									if args /= Void then
										from
											args.start
										until 
											args.after
										loop
											buffer.putstring (", ")
											buffer.putstring (cecil_type(args.item))
											if not args.item.is_basic then
												nb_ref := nb_ref + 1
											end
											args.forth
										end
									end
									buffer.putstring (");")

										-- DEFINITION OF THE FUNCTION TO BE EXPORTED
									buffer.putstring ("%N")
									buffer.putstring (return_type)
									buffer.putstring (" ")
									if dl_exp.has_call_type then
										buffer.putstring (dl_exp.call_type)
										buffer.putstring (" ")
									end
									buffer.putstring (feature_name)
									buffer.putstring (" (")

									if argument_names /= Void then
										from 
											argument_names.start
										until
											argument_names.after
										loop
											buffer.putstring (cecil_type(args.i_th (argument_names.index)))
											buffer.putstring(" ")
											buffer.putstring(argument_names.item)
											if not argument_names.islast then
												buffer.putstring(", ")
											end
											argument_names.forth
										end
									else
										buffer.putstring("void")
									end

									buffer.putstring (")%N{%TGTCX")

										--INFORMATION ABOUT THE FEATURE
									if internal_creation_name /= Void then
										buffer.putstring ("%N%T/* Creation : ")
										buffer.putstring (internal_creation_name)
										buffer.putstring ("; */")
									end
									buffer.putstring ("%N%T/* Feature  : ")
									buffer.putstring (internal_feature_name)
									buffer.putstring (" ;*/")

										--LOCAL VARIABLES
									buffer.putstring ("%N%TEIF_PROC ep;")
									buffer.putstring ("%N%TEIF_REFERENCE main_obj = (EIF_REFERENCE) 0;")
									buffer.putstring ("%N%TEIF_TYPE_ID eti;")
									if not return_type.is_equal("void") then
										buffer.putstring ("%N%T")
										buffer.putstring (return_type)
										buffer.putstring (" Return_Value ;")
									end -- When the feature return a value.
										
										--INITIALIZATION DYNAMIC_LIB and RT
									buffer.putstring ("%N%TDYNAMIC_LIB_RT_INITIALIZE(")
									buffer.putint (nb_ref + 1)
									buffer.putstring (");%N")

										-- AFFECTION OF THE LOCAL VARIABLES `l[i]'
									if argument_names /= Void then
										from
											argument_names.start
										until
											argument_names.after
										loop
											if not args.i_th(argument_names.index).is_basic then
												buffer.putstring ("%N%T")
												buffer.put_local_registration (argument_names.index, argument_names.item)
											end
											argument_names.forth
										end
									end


										-- CALCULATE THE MAIN OBJECT.
									buffer.putstring ("%N%T")
									buffer.put_local_registration (0, "main_obj")
									buffer.putstring ("%N%Tmain_obj = RTLN(")

									if Context.workbench_mode then
										buffer.putstring ("RTUD(");
										buffer.generate_type_id (dl_exp.compiled_class.actual_type.type_i.associated_class_type.static_type_id)
										buffer.putchar (')');
									else
										buffer.putint (dl_exp.compiled_class.actual_type.type_i.type_id - 1);
									end
									buffer.putstring (");")

										--CALL THE CREATION ROUTINE
									if internal_creation_name /= Void then
										buffer.putstring ("%N%T/* Call the creation routine */%N%T")
										buffer.putstring (internal_creation_name)
										buffer.putchar ('(')
										buffer.putstring ("main_obj")
										buffer.putstring (");")
									end
									
										--CALL THE ROUTINE
									buffer.putstring ("%N%N%T/* Call the routine */")
									buffer.putstring ("%N%T")
									if not return_type.is_equal("void") then
										buffer.putstring ("Return_Value = (")
										buffer.putstring (return_type)
										buffer.putstring (") ")
									end -- When the feature return a value.
									buffer.putstring (internal_feature_name)
									buffer.putchar ('(')
									buffer.putstring ("main_obj")

									if argument_names /= Void then
										from
											argument_names.start
										until
											argument_names.after
										loop
											buffer.putchar (',')
											buffer.putstring (argument_names.item)
											argument_names.forth
										end
									end
									
									buffer.putstring (");")
									buffer.putstring ("%N%TDYNAMIC_LIB_RT_END;")
									if not return_type.is_equal("void") then
										buffer.putstring ("%N%Treturn (")
										buffer.putstring (return_type)
										buffer.putstring (") Return_Value;")
									end -- When the feature return a value.
									buffer.putstring ("%N}%N")

								end
								if (dl_exp.index /= 0) then
									def_buffer.putstring (" @ ")
									def_buffer.putint (dl_exp.index)
								end
								def_buffer.putstring ("%N")
								buffer.putstring ("%N")
							end

							dynamic_lib_exports.item_for_iteration.forth
						end
					end
					dynamic_lib_exports.forth
				end

				system_name.append_string(".def")
				if context.final_mode then
					create dynamic_lib_def_file_name.make_from_string (Final_generation_path)
				else
					create dynamic_lib_def_file_name.make_from_string (Workbench_generation_path)
				end
				dynamic_lib_def_file_name.set_file_name (system_name)
				create dynamic_lib_def_file.make_open_write (dynamic_lib_def_file_name)
				dynamic_lib_def_file.put_string (def_buffer)
				dynamic_lib_def_file.close

				create C_dynamic_lib_file.make_c_code_file (gen_file_name (context.final_mode, "edynlib"));
				C_dynamic_lib_file.put_string (buffer)
				C_dynamic_lib_file.close
			end
		end

feature {NONE} -- DYNAMIC_LIB features

	cecil_type (type:TYPE_A): STRING is
		local
			int_a: INTEGER_A
			char_a: CHARACTER_A
		do
			if type = Void then
				Result := "void"
			elseif type.is_integer then
				Result := "EIF_INTEGER_"
				int_a ?= type
				Result.append_integer (int_a.size)
			elseif type.is_boolean then
				Result := "EIF_BOOLEAN"
			elseif type.is_real then
				Result := "EIF_REAL"
			elseif type.is_double then
				Result := "EIF_DOUBLE"
			elseif type.is_character then
				char_a ?= type
				if char_a.is_wide then
					Result := "EIF_WIDE_CHAR"
				else
					Result := "EIF_CHARACTER"
				end
			elseif type.is_bits then
				Result := "EIF_BIT"
			elseif type.is_true_expanded then
				Result := "EIF_EXPANDED"
			elseif type.is_pointer then
				Result := "EIF_POINTER"
			else
				Result := "EIF_REFERENCE"
			end
		end

feature -- Plug and Makefile file

	generate_plug is
			-- Generate plug with run-time
		local
			string_cl, bit_cl, array_cl, rout_cl: CLASS_C
			arr_type_id, str_type_id, type_id: INTEGER
			id: INTEGER
			to_c_feat, set_count_feat, set_make_feat, creation_feature: FEATURE_I
			set_rout_disp_feat: FEATURE_I
			creators: EXTEND_TABLE [EXPORT_I, STRING]
			dispose_name, str_make_name, init_name, set_count_name, to_c_name: STRING
			arr_make_name, set_rout_disp_name: STRING
			special_cl: SPECIAL_B
			cl_type: CLASS_TYPE
			final_mode: BOOLEAN
			plug_file: INDENT_FILE
			buffer: GENERATION_BUFFER

			has_argument: BOOLEAN
			root_cl: CLASS_C
			dtype: INTEGER
			rout_info: ROUT_INFO
			root_feat: FEATURE_I
			rcorigin: INTEGER
			rcoffset: INTEGER
		do
				-- Clear buffer for current generation
			buffer := generation_buffer
			buffer.clear_all

			final_mode := Context.final_mode

			buffer.putstring ("#include %"eif_project.h%"%N")
			buffer.putstring ("#include %"eif_macros.h%"%N")
			buffer.putstring ("#include %"egc_include.h%"%N%N")
			
			buffer.start_c_specific_code

				-- Extern declarations
			string_cl := system.class_of_id (system.string_id)
			cl_type := string_cl.types.first
			id := cl_type.static_type_id
			str_type_id := cl_type.type_id
			creators := string_cl.creators
			creators.start

				-- Make string declaration
			set_count_feat := string_cl.feature_table.item ("set_count")
			set_make_feat := string_cl.feature_table.item ("make")
			str_make_name := clone (Encoder.feature_name (id, set_make_feat.body_index))
			set_count_name := clone (Encoder.feature_name (id, set_count_feat.body_index))
			buffer.putstring ("extern void ")
			buffer.putstring (str_make_name)
			buffer.putstring ("();%Nextern void ")
			buffer.putstring (set_count_name)
			buffer.putstring ("();%N")
			if system.has_separate then
				to_c_feat := string_cl.feature_table.item ("to_c")
				to_c_name := clone (Encoder.feature_name (id, to_c_feat.body_index))
				buffer.putstring ("extern void ")
				buffer.putstring (to_c_name)
				buffer.putstring ("();%N")
			end

				--| make array declaration
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
				creation_feature := array_cl.feature_table.item ("make")
				arr_make_name := clone (Encoder.feature_name (id, creation_feature.body_index))
				system.set_array_make_name (arr_make_name)
			else
				cl_type := System.Instantiator.Array_type.associated_class_type; 
				arr_type_id := cl_type.type_id
				arr_make_name := system.array_make_name
			end

			buffer.putstring ("extern void ")
			buffer.putstring (arr_make_name)
			buffer.putstring ("();%N")

				-- Make routine declaration
			rout_cl := system.class_of_id (system.routine_class_id)

			if rout_cl.types /= Void and then not rout_cl.types.is_empty then
				cl_type := rout_cl.types.first
				id := cl_type.static_type_id
				set_rout_disp_feat := rout_cl.feature_table.item ("set_rout_disp")
				set_rout_disp_name := clone (Encoder.feature_name (id, set_rout_disp_feat.body_index))

				buffer.putstring ("extern void ")
				buffer.putstring (set_rout_disp_name)
				buffer.putstring ("();%N")
			end

			if final_mode and then System.array_optimization_on then
				System.remover.array_optimizer.generate_plug_declarations (buffer)
			else
				buffer.putstring ("%Nlong *eif_area_table = (long *)0;%N%
									%long *eif_lower_table = (long *)0;%N")
			end

			if final_mode then
				init_name := clone (Encoder.table_name (system.routine_id_counter.initialization_rout_id))
				dispose_name := clone (Encoder.table_name (system.routine_id_counter.dispose_rout_id))

				buffer.putstring ("extern char *(*")
				buffer.putstring (init_name)
				buffer.putstring ("[])();%N%
									%extern char *(*")
				buffer.putstring (dispose_name)
				buffer.putstring ("[])();%N%N")
			end

			if system.has_separate then
					--Pointer on `to_c' of class STRING
				buffer.putstring ("void (*eif_strtoc)() = ")
				buffer.putstring (to_c_name)
				buffer.putstring (";%N")
			end

				-- Declaration and definition of the egc_init_plug function.
			buffer.putstring ("%N%Nextern void egc_init_plug (void); %N")
			buffer.putstring ("void egc_init_plug (void)%N{%N")

				-- Do we need to collect GC data for the profiler?
			buffer.putstring ("%Tegc_prof_enabled = (EIF_INTEGER) ")
			if system.lace.ace_options.has_profile then
				buffer.putstring ("3;%N")
			else
				buffer.putstring ("0;%N")
			end

				-- Pointer on creation feature of class STRING
			buffer.putstring ("%Tegc_strmake = (void (*)(EIF_REFERENCE, EIF_INTEGER)) ")
			buffer.putstring (str_make_name)
			buffer.putstring (";%N")

				-- Pointer on creation feature of class ARRAY[ANY]
			buffer.putstring ("%Tegc_arrmake = (void (*)(EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER)) ")
			buffer.putstring (arr_make_name)
			buffer.putstring (";%N")

				--Pointer on `set_count' of class STRING
			buffer.putstring ("%Tegc_strset = (void (*)(EIF_REFERENCE, EIF_INTEGER)) ")
			buffer.putstring (set_count_name)
			buffer.putstring (";%N")

				--Pointer on `set_rout_disp' of class ROUTINE
			if set_rout_disp_name /= Void then
				buffer.putstring ("%Tegc_routdisp = (void (*)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE)) ")
				buffer.putstring (set_rout_disp_name)
				buffer.putstring (";%N")
			end

				-- Dynamic type of class STRING
			buffer.putstring ("%N%Tegc_str_dtype = ")
			buffer.putint (str_type_id - 1)
			buffer.putstring (";%N")

				-- Dynamic type of class ARRAY[ANY]
			buffer.putstring ("%Tegc_arr_dtype = ")
			buffer.putint (arr_type_id - 1)
			buffer.putstring (";%N")

				-- Dispose routine id from class MEMORY (if compiled) 
			buffer.putstring ("%Tegc_disp_rout_id = ")
			if System.memory_class /= Void then
				buffer.putint (System.memory_dispose_id)
			else
				buffer.putstring ("-1")
			end
			buffer.putstring (";%N")

				-- Dynamic type of class BIT_REF
			bit_cl := System.class_of_id (System.bit_id)
			type_id := bit_cl.types.first.type_id
			buffer.putstring ("%Tegc_bit_dtype = ")
			buffer.putint (type_id - 1)
			buffer.putstring (";%N")

			special_cl ?= System.special_class.compiled_class
			special_cl.generate_dynamic_types (buffer)
			generate_dynamic_ref_type (buffer)

			buffer.putstring ("%N%Tegc_ce_type = egc_ce_type_init;%N")
			buffer.putstring ("%Tegc_ce_gtype = egc_ce_gtype_init;%N")
			buffer.putstring ("%Tegc_fsystem = egc_fsystem_init;%N")
			buffer.putstring ("%Tegc_system_mod_init = egc_system_mod_init_init;%N")
			buffer.putstring ("%Tegc_partab = egc_partab_init;%N")
			buffer.putstring ("%Tegc_partab_size = egc_partab_size_init;%N")

			if not final_mode then
				buffer.putstring ("%Tegc_frozen = egc_frozen_init;%N")
				buffer.putstring ("%Tegc_fpatidtab = egc_fpatidtab_init;%N");
				buffer.putstring ("%Tegc_foption = egc_foption_init;%N")
				buffer.putstring ("%Tegc_address_table = egc_address_table_init;%N")
				buffer.putstring ("%Tegc_fpattern = egc_fpattern_init;%N")
				
				buffer.putstring ("%N%Tegc_einit = egc_einit_init;%N")
				buffer.putstring ("%Tegc_tabinit = egc_tabinit_init;%N")
	
				buffer.putstring ("%N%Tegc_fcall = egc_fcall_init;%N")
				buffer.putstring ("%Tegc_forg_table = egc_forg_table_init;%N")
				buffer.putstring ("%Tegc_fdtypes = egc_fdtypes_init;%N")

			else
					-- Do we need to protect the exception stack?
				buffer.putstring ("%Texception_stack_managed = (EIF_BOOLEAN) ")
				if System.exception_stack_managed then
					buffer.putstring ("1;%N")
				else
					buffer.putstring ("0;%N")
				end

					-- Initialization routines
				buffer.putstring ("%Tegc_ecreate = ")
				buffer.putstring ("(char *(**)(void)) ")
				buffer.putstring (init_name)
				buffer.putstring (";%N")

					-- Dispose routines
				buffer.putstring ("%Tegc_edispose = ")
				buffer.putstring ("(void (**)(void)) ")
				buffer.putstring (dispose_name)
				buffer.putstring (";%N")

				buffer.putstring ("%Tegc_ce_rname = egc_ce_rname_init;%N")
				buffer.putstring ("%Tegc_fnbref = egc_fnbref_init;%N")
				buffer.putstring ("%Tegc_fsize = egc_fsize_init;%N")
			end

			buffer.putstring ("%N%Tegc_system_name = %"")
			buffer.putstring (System.system_name)
			buffer.putstring ("%";%N%Tegc_compiler_tag = ")
			buffer.putint (System.version_tag)
			buffer.putstring (";%N%Tegc_project_version = ")
			buffer.putint (System.project_creation_time)

				-- Generate the number of static dynamic types.
			buffer.putstring (";%N%Tscount = ")
			buffer.putint (System.type_id_counter.value)
			buffer.putstring (";%N%N")

			if not final_mode then
				root_cl := System.root_class.compiled_class
				dtype := root_cl.types.first.type_id - 1
				if not Compilation_modes.is_precompiling and then System.creation_name /= Void then
					root_feat := root_cl.feature_table.item (System.creation_name)
					has_argument := root_feat.has_arguments
					rout_info := System.rout_info_table.item (root_feat.rout_id_set.first)
					rcorigin := rout_info.origin
					rcoffset := rout_info.offset
				else
					rcorigin := -1
				end

				buffer.putstring ("%Tegc_rcorigin = ")
				buffer.putint (rcorigin)
				buffer.putstring (";%N%Tegc_rcdt = ")
				buffer.putint (dtype)
				buffer.putstring (";%N%Tegc_rcoffset = ")
				buffer.putint (rcoffset)
				buffer.putstring (";%N%Tegc_rcarg = ")
				if has_argument then
					buffer.putstring ("1")
				else
					buffer.putstring ("0")
				end
				buffer.putstring (";%N%N")
			end

			buffer.putstring ("%Tegc_platform_level = 0x00000D00;%N}%N")
			buffer.end_c_specific_code

			create plug_file.make_c_code_file (gen_file_name (final_mode, Eplug));
			plug_file.put_string (buffer)
			plug_file.close
		end

	generate_dynamic_ref_type (buffer: GENERATION_BUFFER) is
			-- Generate dynaminc reference types of basic classes.
		require
			buffer_exists: buffer /= Void
		local
			local_system: SYSTEM_I
		do
			local_system := System

			buffer.putstring ("%N%Tegc_int8_ref_dtype = ")
			buffer.putint (system.integer_ref_dtype (8) - 1)
			buffer.putstring (";%N%Tegc_int16_ref_dtype = ")
			buffer.putint (system.integer_ref_dtype (16) - 1)
			buffer.putstring (";%N%Tegc_int32_ref_dtype = ")
			buffer.putint (system.integer_ref_dtype (32) - 1)
			buffer.putstring (";%N%Tegc_int64_ref_dtype = ")
			buffer.putint (system.integer_ref_dtype (64) - 1)
			buffer.putstring (";%N%Tegc_bool_ref_dtype = ")
			buffer.putint (system.boolean_ref_dtype - 1)
			buffer.putstring (";%N%Tegc_real_ref_dtype = ")
			buffer.putint (system.real_ref_dtype - 1)
			buffer.putstring (";%N%Tegc_char_ref_dtype = ")
			buffer.putint (system.character_ref_dtype - 1)
			buffer.putstring (";%N%Tegc_wchar_ref_dtype = ")
			buffer.putint (system.wide_char_ref_dtype - 1)
			buffer.putstring (";%N%Tegc_doub_ref_dtype = ")
			buffer.putint (system.double_ref_dtype - 1)
			buffer.putstring (";%N%Tegc_point_ref_dtype = ")
			buffer.putint (system.pointer_ref_dtype - 1)
			buffer.putstring (";%N");	
		end

	generate_make_file is
			-- Generate make file
		do
			system.makefile_generator.generate
			system.makefile_generator.clear
		end

end -- class AUXILIARY_FILES
