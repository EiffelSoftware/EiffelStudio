indexing
	description: "Generate the auxiliary files at the end%
				%of a C generation"
	date: "$Date$"
	revision: "$Revision$"

class
	AUXILIARY_FILES

inherit
	SHARED_ROUT_ID

	SHARED_CODE_FILES

	COMPILER_EXPORTER

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

	generate_plug is
			-- Generate plug with run-time
		local
			string_cl, bit_cl, array_cl: CLASS_C
			arr_type_id, str_type_id, type_id: INTEGER
			id: TYPE_ID
			to_c_feat, set_count_feat, creation_feature: FEATURE_I
			creators: EXTEND_TABLE [EXPORT_I, STRING]
			dispose_name, str_make_name, init_name, set_count_name, to_c_name: STRING
			arr_make_name: STRING
			special_cl: SPECIAL_B
			cl_type: CLASS_TYPE
			final_mode: BOOLEAN
			Plug_file: INDENT_FILE
			table_prefix: STRING
		do
			table_prefix := System.table_prefix
			final_mode := Context.final_mode

			Plug_file := plug_f (final_mode)
			Plug_file.open_write_c

			Plug_file.putstring ("#include %"eif_project.h%"%N%N")
			Plug_file.putstring ("#include %"eif_macros.h%"%N%N")

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
			Plug_file.putstring ("extern void ")
			Plug_file.putstring (str_make_name)
			Plug_file.putstring ("();%Nextern void ")
			Plug_file.putstring (set_count_name)
			Plug_file.putstring ("();%N")
			if system.has_separate then
				to_c_feat := string_cl.feature_table.item ("to_c")
				to_c_name := to_c_feat.body_id.feature_name (id)
				Plug_file.putstring ("extern void ")
				Plug_file.putstring (to_c_name)
				Plug_file.putstring ("();%N")
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

			Plug_file.putstring ("extern void ")
			Plug_file.putstring (arr_make_name)
			Plug_file.putstring ("();%N")

			if final_mode and then System.array_optimization_on then
				System.array_optimizer.generate_plug_declarations (Plug_file, table_prefix)
			else
				Plug_file.putstring ("long *eif_area_table = (long *)0;%N%
									%long *eif_lower_table = (long *)0;%N")
			end

			if final_mode then

					-- Do we need to protect the exception stack?
				Plug_file.putstring ("EIF_BOOLEAN exception_stack_managed = (EIF_BOOLEAN) ")
				if System.exception_stack_managed then
					Plug_file.putstring ("1;%N")
				else
					Plug_file.putstring ("0;%N")
				end

				init_name := Initialization_rout_id.table_name
				dispose_name := Dispose_rout_id.table_name

				Plug_file.putstring ("extern char *(*")
				Plug_file.putstring (table_prefix)
				Plug_file.putstring (init_name)
				Plug_file.putstring ("[])();%N%
									%extern char *(*")
				Plug_file.putstring (table_prefix)
				Plug_file.putstring (dispose_name)
				Plug_file.putstring ("[])();%N%N")
			end

			if system.has_separate then
					--Pointer on `to_c' of class STRING
				Plug_file.putstring ("void (*eif_strtoc)() = ")
				Plug_file.putstring (to_c_name)
				Plug_file.putstring (";%N")
			end

			if final_mode then
					-- Initialization routines
				Plug_file.putstring ("char *(**ecreate)() = ")
				Plug_file.putstring (table_prefix)
				Plug_file.putstring (init_name)
				Plug_file.putstring (";%N")

					-- Dispose routines
				Plug_file.putstring ("void (**edispose)() = ")
				Plug_file.putstring ("(void (**)()) ")
				Plug_file.putstring (table_prefix)
				Plug_file.putstring (dispose_name)
				Plug_file.putstring (";%N")

			end


				-- Declaration and definition of the egc_init_plug function.
			Plug_file.putstring ("extern void egc_init_plug (void); ")
			Plug_file.putstring ("void egc_init_plug (void)%N{")

				-- Do we need to collect GC data for the profiler?
			Plug_file.putstring ("EIF_INTEGER egc_prof_enabled = (EIF_INTEGER) ")
			if Lace.ace_options.has_profile then
				Plug_file.putstring ("3;%N")
			else
				Plug_file.putstring ("0;%N")
			end

				-- Pointer on creation feature of class STRING
			Plug_file.putstring ("egc_strmake = ")
			Plug_file.putstring (str_make_name)
			Plug_file.putstring (";%N")

				-- Pointer on creation feature of class ARRAY[ANY]
			Plug_file.putstring ("egc_arrmake = ")
			Plug_file.putstring (arr_make_name)
			Plug_file.putstring (";%N")

				--Pointer on `set_count' of class STRING
			Plug_file.putstring ("egc_strset = ")
			Plug_file.putstring (set_count_name)
			Plug_file.putstring (";%N")

				-- Dynamic type of class STRING
			Plug_file.putstring ("egc_str_dtype = ")
			Plug_file.putint (str_type_id - 1)
			Plug_file.putstring (";%N")

				-- Dynamic type of class ARRAY[ANY]
			Plug_file.putstring ("egc_arr_dtype = ")
			Plug_file.putint (arr_type_id - 1)
			Plug_file.putstring (";%N")

				-- Dispose routine id from class MEMORY (if compiled) 
			Plug_file.putstring ("egc_disp_rout_id = ")
			if System.memory_class /= Void then
				Plug_file.putint (System.memory_dispose_id.id)
			else
				Plug_file.putstring ("-1")
			end
			Plug_file.putstring (";%N")

				-- Dynamic type of class BIT_REF
			bit_cl := System.class_of_id (System.bit_id)
			type_id := bit_cl.types.first.type_id
			Plug_file.putstring ("egc_bit_dtype = ")
			Plug_file.putint (type_id - 1)
			Plug_file.putstring (";%N")

			special_cl ?= System.special_class.compiled_class
			special_cl.generate_dynamic_types (plug_file)
			generate_dynamic_ref_type (plug_file)

			Plug_file.putstring ("%N}")

			Plug_file.close_c
		end

	generate_dynamic_ref_type (plug_file: INDENT_FILE) is
			-- Generate dynaminc reference types of basic classes.
		require
			plug_file_exists: plug_file /= Void
			plug_file_open: plug_file.exists and then plug_file.is_writable
		local
			local_system: SYSTEM_I
		do
			local_system := System

			Plug_file.putstring ("%Nint egc_int_ref_dtype = ")
			Plug_file.putint (system.integer_ref_dtype - 1)
			Plug_file.putstring (";%Nint egc_bool_ref_dtype = ")
			Plug_file.putint (system.boolean_ref_dtype - 1)
			Plug_file.putstring (";%Nint egc_real_ref_dtype = ")
			Plug_file.putint (system.real_ref_dtype - 1)
			Plug_file.putstring (";%Nint egc_char_ref_dtype = ")
			Plug_file.putint (system.character_ref_dtype - 1)
			Plug_file.putstring (";%Nint egc_doub_ref_dtype = ")
			Plug_file.putint (system.double_ref_dtype - 1)
			Plug_file.put_string (";%Nint egc_point_ref_dtype = ")
			Plug_file.put_integer (system.pointer_ref_dtype - 1)
			Plug_file.put_string (";%N");	
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
