indexing
	description: "Byte code for routine creation expression"
	date: "$Date$"
	revision: "$Revision$"

class ROUTINE_CREATION_BL

inherit
	ROUTINE_CREATION_B
		redefine
			analyze, generate, 
			register, set_register, free_register,
			unanalyze
		end

	SHARED_C_LEVEL
	SHARED_TABLE
	SHARED_DECLARATIONS
	SHARED_INCLUDE

feature 

	register: REGISTRABLE
			-- Register for array containing the routine object

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r
		do
			register := r
		end

	unanalyze is
			-- Unanalyze expression
		do
			if arguments /= Void then
				arguments.unanalyze
			end
			if open_positions /= Void then
				open_positions.unanalyze
			end
			set_register (Void)
		end
	
	analyze is
			-- Analyze expression
		do
			if arguments /= Void then
				arguments.analyze
			end
			if open_positions /= Void then
				open_positions.analyze
			end
			get_register
			context.add_dftype_current
		end

	free_register is
			-- Free used registers for later use.
		do
			Precursor {ROUTINE_CREATION_B}
			if arguments /= Void then
				arguments.free_register
			end
			if open_positions /= Void then
				open_positions.free_register
			end
		end

	generate is
			-- Generate expression
		local
			cl_type_i: CL_TYPE_I
			gen_type: GEN_TYPE_I
			buf: GENERATION_BUFFER
		do
			if arguments /= Void then
				arguments.generate
			end

			if open_positions /= Void then
				open_positions.generate
			end

			buf := buffer
			cl_type_i ?= context.real_type (type)
			gen_type  ?= cl_type_i
			generate_block_open
			generate_gen_type_conversion (gen_type)
			print_register
			buf.put_string (" = ")
			buf.put_string ("RTLNR2(typres, ")
			generate_routine_address
			buf.put_string (", ")
			generate_true_routine_address
			buf.put_string (", ")

			if arguments /= Void then
				arguments.print_register
				buf.put_string (", ")
			else
				buf.put_string ("NULL, ")
			end

			if open_positions /= Void then
				open_positions.print_register
			else
				buf.put_string ("NULL")
			end

			buf.put_string (");")
			buf.put_new_line
			generate_block_close
		end

	generate_routine_address is
			-- Generate routine address
		local
			cl_type		: CL_TYPE_I
			table_name	: STRING
			buf			: GENERATION_BUFFER
			array_index: INTEGER
		do
			buf := buffer
			if context.workbench_mode then
				buf.put_string ("(EIF_POINTER) RTWPPR(")
				cl_type ?= context.real_type (class_type)
				buf.put_static_type_id (cl_type.associated_class_type.static_type_id)
				buf.put_string (gc_comma)
				buf.put_integer (feature_id)
				buf.put_character (')')
			else
				cl_type ?= context.real_type (class_type)
				array_index := Eiffel_table.is_polymorphic (rout_id, cl_type.type_id, True)
				if array_index = -2 then
						-- Function pointer associated to a deferred feature without
						-- any implementation
					buf.put_string ("NULL")
				else
					table_name := "_f"
					cl_type ?= context.real_type (class_type)
					table_name.append (Encoder.address_table_name (feature_id,
							cl_type.associated_class_type.static_type_id))

					buf.put_string ("(EIF_POINTER) ")
					buf.put_string (table_name)

						-- Remember extern declarations
					Extern_declarations.add_routine (type.c_type, table_name)

					if array_index >= 0 then
							-- Mark table used
						Eiffel_table.mark_used (rout_id)
					end
				end
			end
		end

	generate_true_routine_address is
			-- Generate true routine address, ie address of Eiffel routine
			-- and not an indirection to it.
			--| Based on code located in ADDRESS_B
		local
			cl_type: CL_TYPE_I
			internal_name, table_name: STRING
			rout_table: ROUT_TABLE
			buf: GENERATION_BUFFER
			array_index: INTEGER
			class_type_id: INTEGER
		do
			buf := buffer
			if context.workbench_mode then
				buf.put_string ("(EIF_POINTER) RTWPP(")
				cl_type ?= context.real_type (class_type)
				buf.put_static_type_id (cl_type.associated_class_type.static_type_id)
				buf.put_string (gc_comma)
				buf.put_integer (feature_id)
				buf.put_character (')')
			else
				cl_type ?= context.real_type (class_type)
				class_type_id := cl_type.type_id
				array_index := Eiffel_table.is_polymorphic (rout_id, class_type_id, True)
				if array_index = -2 then
						-- Function pointer associated to a deferred feature
						-- without any implementation
					buf.put_string ("NULL")
				elseif array_index >= 0 then
						-- Mark table used
					Eiffel_table.mark_used (rout_id)

					table_name := "f"
					table_name.append (Encoder.address_table_name (feature_id,
								cl_type.associated_class_type.static_type_id))

					buf.put_string ("(EIF_POINTER) ")
					buf.put_string (table_name)

						-- Remember extern declarations
					Extern_declarations.add_routine (type.c_type, table_name)
				else
					rout_table ?= Eiffel_table.poly_table (rout_id)
					rout_table.goto_implemented (class_type_id)
					if rout_table.is_implemented then
						internal_name := rout_table.feature_name
						buf.put_string ("(EIF_POINTER) ")
						buf.put_string (internal_name)

						shared_include_queue.put (
							System.class_type_of_id (
								rout_table.item.written_type_id).header_filename)
					else
							-- Call to a deferred feature without implementation
						buf.put_string ("NULL")
					end
				end
			end
		end

end -- class ROUTINE_CREATION_BL

