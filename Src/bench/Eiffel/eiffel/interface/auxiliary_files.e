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

feature -- Plug and Makefile file

	generate_conformance_table is
			-- Generates conformance tables.
		local
			i, nb: INTEGER
			cl_type: CLASS_TYPE
			conformance_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
				-- Clear buffer for current generation
			buffer := generation_buffer
			buffer.clear_all

			buffer.putstring ("#include %"eif_project.h%"%N%
										%#include %"eif_struct.h%"%N%N")
			from
				i := 1
				nb := system.type_id_counter.value
			until
				i > nb
			loop
				cl_type := system.class_types.item (i)
if cl_type /= Void then
		-- FIXME
				cl_type.generate_conformance_table (buffer)
end
				i := i + 1
			end

			buffer.putstring ("struct conform *egc_fco_table_init[] = {%N")

			from
				i := 1
			until
				i > nb
			loop
				cl_type := system.class_types.item (i)
if cl_type /= Void then
				buffer.putstring ("&conf")
				buffer.putint (cl_type.type_id)
else
		-- FIXME
	buffer.putstring ("(struct conform *)0")
end
				buffer.putstring (",%N")
				i := i + 1
			end 
			buffer.putstring ("};%N")

			!! conformance_file.make_open_write (gen_file_name (context.final_mode, Econform));
			conformance_file.put_string (buffer)
			conformance_file.close
		end

feature -- Dynamic Library file

	generate_dynamic_lib_file is
			-- generate dynamic_lib.
		local
			dynamic_lib_exports: HASH_TABLE [LINKED_LIST[DYNAMIC_LIB_EXPORT_FEATURE],INTEGER]
			dl_exp:DYNAMIC_LIB_EXPORT_FEATURE
			Dynamic_lib_def_file: INDENT_FILE
			dynamic_lib_def_file_name: STRING
			C_dynamic_lib_file: INDENT_FILE
			C_dynamic_lib_file_name: STRING

			args: E_FEATURE_ARGUMENTS
			argument_names: FIXED_LIST [STRING]
			return_type: STRING
			system_name: STRING
			class_name: STRING
			feature_name: STRING
			internal_creation_name: STRING
			internal_feature_name: STRING
			buffer, def_buffer: GENERATION_BUFFER
		do
				-- Clear buffers for current generation
			buffer := generation_buffer
			buffer.clear_all
			def_buffer := header_generation_buffer
			def_buffer.clear_all

			dynamic_lib_exports:= system.eiffel_dynamic_lib.dynamic_lib_exports
			if dynamic_lib_exports /= Void and then not dynamic_lib_exports.empty then
				-- Generation of the header of the C_dynamic_lib_file
					buffer.putstring("/*****************%N")
					buffer.putstring(" *** EDYNLIB.C ***%N")
					buffer.putstring(" *****************/%N%N")
					
					buffer.putstring("#include %"egc_dynlib.h%"%N")

					buffer.putstring("%N")

				-- Generation of the header of the Dynamic_lib_def_file
					def_buffer.putstring("LIBRARY ")
					def_buffer.putstring(system_name)
					def_buffer.putstring(".dll%N")
					system_name.to_upper
					def_buffer.putstring("DESCRIPTION ")
					def_buffer.putstring(system_name)
					def_buffer.putstring(".DLL%N")
					def_buffer.putstring("%NEXPORTS%N")
					def_buffer.putstring("%N;System")
					def_buffer.putstring("%N%Tinit_rt")
					def_buffer.putstring("%N%Treclaim_rt%N") --FIXME

				-- generation of everything
				from
					dynamic_lib_exports.start
				until
					dynamic_lib_exports.after
				loop
					if (dynamic_lib_exports.item_for_iteration /= Void) then
						def_buffer.putstring( "%N; CLASS [" )

						class_name := clone(dynamic_lib_exports.item_for_iteration.item.dl_class.name_in_upper)
						def_buffer.putstring(class_name)
						def_buffer.putstring( "]%N" )

						from
							dynamic_lib_exports.item_for_iteration.start
						until
							dynamic_lib_exports.item_for_iteration.after
						loop
							if (dynamic_lib_exports.item_for_iteration.item /=Void)
							then
								internal_creation_name := Void

								dl_exp := dynamic_lib_exports.item_for_iteration.item
								buffer.putstring ("/***************************%N * ")
								buffer.putstring (class_name)

								if (dl_exp.dl_creation /= Void) and then (dl_exp.dl_routine.id /= dl_exp.dl_creation.id) then
										buffer.putstring (" (")
										buffer.putstring (dl_exp.dl_creation.name)
										buffer.putstring (")")
										internal_creation_name := dl_exp.dl_creation.body_id.feature_name (dl_exp.dl_class.types.first.id)
								elseif (dl_exp.dl_creation = Void) then
										buffer.putstring (" (!!)")
								end
								if (dl_exp.dl_routine /= Void) then
									feature_name := clone(dl_exp.dl_routine.name)
									internal_feature_name := dl_exp.dl_routine.body_id.feature_name (dl_exp.dl_class.types.first.id)
									args:= dl_exp.dl_routine.arguments

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
									return_type := clone ( cecil_type(dl_exp.dl_routine.type) )
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
											args.forth
										end
									end
									buffer.putstring (");")

									-- DEFINITION OF THE FUNCTION TO BE EXPORTED
									buffer.putstring ("%N")
									buffer.putstring (return_type)
									buffer.putstring (" ")
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

									buffer.putstring (")")
									buffer.putstring ("%N{")

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
									buffer.putstring ("%N%TEIF_OBJ main_obj;")
									buffer.putstring ("%N%TEIF_PROC ep;")
									buffer.putstring ("%N%TEIF_TYPE_ID eti;")
									if not return_type.is_equal("void") then
										buffer.putstring ("%N%T")
										buffer.putstring (return_type)
										buffer.putstring (" Return_Value ;")
									end -- When the feature return a value.
										

										--INITIALIZATION DYNAMIC_LIB and RT
									buffer.putstring ("%N%TDYNAMIC_LIB_RT_INITIALIZE(")

									if argument_names /= Void then
										buffer.putint (argument_names.count+1)
									else
										buffer.putint (1)
									end
									buffer.putstring (");%N")

										-- AFFECTION OF THE LOCAL VARIABLES `l[i]'
									if argument_names /= Void then
										from
											argument_names.start
										until
											argument_names.after
										loop
											if not args.i_th(argument_names.index).is_basic then
												buffer.putstring ("%N%Tl[")
												buffer.putint (argument_names.index)
												buffer.putstring ("] = (")
												buffer.putstring ( cecil_type(args.i_th(argument_names.index)) )
												buffer.putstring (") ")
												buffer.putstring(argument_names.item)
												buffer.putstring (" ;"); 
											end
											argument_names.forth
										end
									end


										-- CALCULATE THE MAIN OBJECT.
									buffer.putstring ("%N%Tl[0] = RTLN(")

									if Context.workbench_mode then
										buffer.putstring ("RTUD(");
										dl_exp.dl_class.actual_type.type_i.associated_class_type.id.generated_id (buffer)
										buffer.putchar (')');
									else
										buffer.putint (dl_exp.dl_class.actual_type.type_i.type_id - 1);
									end
									buffer.putstring (");")

										--CALL THE CREATION ROUTINE
									if internal_creation_name /= Void then
										buffer.putstring ("%N%T/* Call the creation routine */%N%T")
										buffer.putstring (internal_creation_name)
										buffer.putstring (" (l[0]);")
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
									buffer.putstring ("(l[0]")

									if argument_names /= Void then
										from
											argument_names.start
										until
											argument_names.after
										loop
											if not args.i_th(argument_names.index).is_basic then
												buffer.putstring (", l[")
												buffer.putint (argument_names.index)
												buffer.putstring ("]")
											else
												buffer.putstring (", ")
												buffer.putstring (argument_names.item)
											end
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
								if (dl_exp.dl_index /= 0) then
									def_buffer.putstring (" @ ")
									def_buffer.putint (dl_exp.dl_index)
								end
								def_buffer.putstring ("%N")
								buffer.putstring ("%N")
							end

							dynamic_lib_exports.item_for_iteration.forth
						end
					end
					dynamic_lib_exports.forth
				end

				system_name:= clone(system.eiffel_system.name)
				dynamic_lib_def_file_name.append_string(".def")
				!! Dynamic_lib_def_file.make_open_write (gen_file_name (context.final_mode, system_name))
				Dynamic_lib_def_file.put_string (def_buffer)
				Dynamic_lib_def_file.close

				!! C_dynamic_lib_file.make_open_write (gen_file_name (context.final_mode, "edynlib"));
				C_dynamic_lib_file.put_string (buffer)
				C_dynamic_lib_file.close
			end
		end

feature {NONE} -- DYNAMIC_LIB features

	cecil_type (type:TYPE_A): STRING is
		do
			if type = Void then
				Result := "void"
			elseif type.is_integer then
				Result := "EIF_INTEGER"
			elseif type.is_boolean then
				Result := "EIF_BOOLEAN"
			elseif type.is_real then
				Result := "EIF_REAL"
			elseif type.is_double then
				Result := "EIF_DOUBLE"
			elseif type.is_character then
				Result := "EIF_CHARACTER"
			elseif type.is_bits then
				Result := "EIF_BIT"
			elseif type.is_expanded then
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
			string_cl, bit_cl, array_cl, tuple_cl: CLASS_C
			arr_type_id, str_type_id, tup_type_id, type_id: INTEGER
			id: TYPE_ID
			to_c_feat, set_count_feat, creation_feature: FEATURE_I
			creators: EXTEND_TABLE [EXPORT_I, STRING]
			dispose_name, str_make_name, init_name, set_count_name, to_c_name: STRING
			arr_make_name, tup_make_name: STRING
			special_cl: SPECIAL_B
			cl_type: CLASS_TYPE
			final_mode: BOOLEAN
			plug_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
				-- Clear buffer for current generation
			buffer := generation_buffer
			buffer.clear_all

			final_mode := Context.final_mode

			buffer.open_write_c

			buffer.putstring ("#include %"egc_include.h%"%N")
			buffer.putstring ("#include %"eif_project.h%"%N")
			buffer.putstring ("#include %"eif_macros.h%"%N%N")

				-- Extern declarations
			string_cl := system.class_of_id (system.string_id)
			cl_type := string_cl.types.first
			id := cl_type.id
			str_type_id := cl_type.type_id
			creators := string_cl.creators
			creators.start

				-- Make string declaration
			creation_feature := string_cl.feature_table.item (creators.key_for_iteration)
			set_count_feat := string_cl.feature_table.item ("set_count")
			str_make_name := creation_feature.body_id.feature_name (id)
			set_count_name := set_count_feat.body_id.feature_name (id)
			buffer.putstring ("extern void ")
			buffer.putstring (str_make_name)
			buffer.putstring ("();%Nextern void ")
			buffer.putstring (set_count_name)
			buffer.putstring ("();%N")
			if system.has_separate then
				to_c_feat := string_cl.feature_table.item ("to_c")
				to_c_name := to_c_feat.body_id.feature_name (id)
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
				id := cl_type.id
				arr_type_id := cl_type.type_id
				creators := array_cl.creators
				creators.start
				creation_feature := array_cl.feature_table.item (creators.key_for_iteration)
				arr_make_name := creation_feature.body_id.feature_name (id)
-- FIXME
	--			array_make_name := clone (arr_make_name)
			else
				cl_type := System.Instantiator.Array_type.associated_class_type; 
				arr_type_id := cl_type.type_id
				arr_make_name := system.array_make_name
			end

			buffer.putstring ("extern void ")
			buffer.putstring (arr_make_name)
			buffer.putstring ("();%N")

				--| make tuple declaration
				--| Potentially same problems as above!
			if (system.tuple_make_name = Void) or not System.uses_precompiled or final_mode then
				tuple_cl := System.class_of_id (System.tuple_id)
				cl_type := System.Instantiator.Tuple_type.associated_class_type; 
				id := cl_type.id
				tup_type_id := cl_type.type_id
				creators := tuple_cl.creators
				creators.start
				creation_feature := tuple_cl.feature_table.item (creators.key_for_iteration)
				tup_make_name := creation_feature.body_id.feature_name (id)
-- FIXME
	--			array_make_name := clone (arr_make_name)
			else
				cl_type := System.Instantiator.Tuple_type.associated_class_type; 
				tup_type_id := cl_type.type_id
				tup_make_name := system.tuple_make_name
			end

			buffer.putstring ("extern void ")
			buffer.putstring (tup_make_name)
			buffer.putstring ("();%N")

			if final_mode and then System.array_optimization_on then
				System.remover.array_optimizer.generate_plug_declarations (buffer)
			else
				buffer.putstring ("%Nlong *eif_area_table = (long *)0;%N%
									%long *eif_lower_table = (long *)0;%N")
			end

			if final_mode then

					-- Do we need to protect the exception stack?
				buffer.putstring ("EIF_BOOLEAN exception_stack_managed = (EIF_BOOLEAN) ")
				if System.exception_stack_managed then
					buffer.putstring ("1;%N")
				else
					buffer.putstring ("0;%N")
				end

				init_name := system.routine_id_counter.initialization_rout_id.table_name
				dispose_name := system.routine_id_counter.dispose_rout_id.table_name

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

				-- Pointer on creation feature of class TUPLE
			buffer.putstring ("%Tegc_tupmake = (void (*)(EIF_REFERENCE)) ")
			buffer.putstring (tup_make_name)
			buffer.putstring (";%N")

				--Pointer on `set_count' of class STRING
			buffer.putstring ("%Tegc_strset = (void (*)(EIF_REFERENCE, EIF_INTEGER)) ")
			buffer.putstring (set_count_name)
			buffer.putstring (";%N")

				-- Dynamic type of class STRING
			buffer.putstring ("%N%Tegc_str_dtype = ")
			buffer.putint (str_type_id - 1)
			buffer.putstring (";%N")

				-- Dynamic type of class ARRAY[ANY]
			buffer.putstring ("%Tegc_arr_dtype = ")
			buffer.putint (arr_type_id - 1)
			buffer.putstring (";%N")

				-- Dynamic type of class TUPLE
			buffer.putstring ("%Tegc_tup_dtype = ")
			buffer.putint (tup_type_id - 1)
			buffer.putstring (";%N")

				-- Dispose routine id from class MEMORY (if compiled) 
			buffer.putstring ("%Tegc_disp_rout_id = ")
			if System.memory_class /= Void then
				buffer.putint (System.memory_dispose_id.id)
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
			if not final_mode then
					-- FIXME: Needs to be removed in Workbench mode, but there is
					-- still some work to do with the Byte code.
				buffer.putstring ("%Tegc_fco_table = egc_fco_table_init;%N")
			end
			buffer.putstring ("%Tegc_system_mod_init = egc_system_mod_init_init;%N")
			buffer.putstring ("%Tegc_partab = egc_partab_init;%N")
			buffer.putstring ("%Tegc_partab_size = egc_partab_size_init;%N")

			if not final_mode then
				buffer.putstring ("%Tegc_frozen = egc_frozen_init;%N")
				buffer.putstring ("%Tegc_fpatidtab = egc_fpatidtab_init;%N");
				buffer.putstring ("%Tegc_foption = egc_foption_init;%N")
				buffer.putstring ("%Tegc_address_table = egc_address_table_init;%N")
				buffer.putstring ("%Tegc_fdispatch = egc_fdispatch_init;%N")
				buffer.putstring ("%Tegc_fpattern = egc_fpattern_init;%N")
				
				buffer.putstring ("%N%Tegc_einit = egc_einit_init;%N")
				buffer.putstring ("%Tegc_tabinit = egc_tabinit_init;%N")
	
				buffer.putstring ("%N%Tegc_fcall = egc_fcall_init;%N")
				buffer.putstring ("%Tegc_forg_table = egc_forg_table_init;%N")
				buffer.putstring ("%Tegc_fdtypes = egc_fdtypes_init;%N")

			else
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
			buffer.putstring (System.version_tag);
			buffer.putstring (";%N}%N")
			buffer.close_c

			!! plug_file.make_open_write (gen_file_name (final_mode, Eplug));
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

			buffer.putstring ("%N%Tegc_int_ref_dtype = ")
			buffer.putint (system.integer_ref_dtype - 1)
			buffer.putstring (";%N%Tegc_bool_ref_dtype = ")
			buffer.putint (system.boolean_ref_dtype - 1)
			buffer.putstring (";%N%Tegc_real_ref_dtype = ")
			buffer.putint (system.real_ref_dtype - 1)
			buffer.putstring (";%N%Tegc_char_ref_dtype = ")
			buffer.putint (system.character_ref_dtype - 1)
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
-- FIXME
--			makefile_generator := Void
		end

end -- class AUXILIARY_FILES
