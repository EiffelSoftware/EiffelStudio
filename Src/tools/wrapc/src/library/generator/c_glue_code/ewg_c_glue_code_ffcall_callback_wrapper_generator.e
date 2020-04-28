note

	description:

		"Generates C glue code for callback wrappers"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_GLUE_CODE_FFCALL_CALLBACK_WRAPPER_GENERATOR

inherit

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	EWG_RENAMER
		export {NONE} all end

	EWG_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

	EWG_C_CALLING_CONVENTION_CONSTANTS

	EWG_ABSTRACT_GENERATOR

create

	make

feature

feature -- Generation

	generate (a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			cs: DS_BILINEAR_CURSOR [EWG_CALLBACK_WRAPPER]
			file_name: STRING
			file: KL_TEXT_OUTPUT_FILE
		do
			file_name := directory_structure.callback_c_glue_code_file_name (eiffel_compiler_mode.eiffel_compiler_mode)
			create file.make (file_name)
			file.recursive_open_write
			if not file.is_open_write then
				error_handler.report_cannot_write_error (file_name)
			else
				output_stream := file
				output_stream.put_string ("#include ")
				output_stream.put_string (directory_structure.callback_c_glue_header_file_name (eiffel_compiler_mode.eiffel_compiler_mode))
				output_stream.put_line ("")
				output_stream.put_new_line
				from
					cs := a_eiffel_wrapper_set.new_callback_wrapper_cursor
					cs.start
				until
					cs.off
				loop
					generate_callback_wrapper (cs.item)
					cs.forth
					error_handler.tick
				end
				file.close
			end
		end

	generate_callback_wrapper (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
			calling_conventions_must_be_cdecl: attached a_callback_wrapper.c_pointer_type.function_type as l_function_type and then l_function_type.calling_convention = cdecl
		do

			if
				attached a_callback_wrapper.c_pointer_type.function_type as l_function_type and then
				attached l_function_type.return_type as l_return_type and then
				l_return_type.skip_consts_and_aliases =
				c_system.types.void_type
			then
				output_stream.put_string ("void ")
			else
					check
						todo: False
					end
--				output_stream.put_string (a_callback_wrapper.c_pointer_type.function_type.return_type.declaration_without_declarator)
				output_stream.put_character (' ')
			end

			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_stub (void* pdata, va_alist alist)")

			output_stream.put_line ("{")
			output_stream.put_line ("%Tstruct ewg_ffcall_callback_entry* entry_struct = (struct ewg_ffcall_callback_entry*) pdata;")

			generate_local_variables (a_callback_wrapper)

			generate_delegation_call (a_callback_wrapper)

			output_stream.put_line ("}")
			output_stream.put_new_line

			generate_stub_getter (a_callback_wrapper)
		end

	generate_local_variables (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
			name_generator: EWG_UNIQUE_NAME_GENERATOR
		do
			-- TODO: return type

			create name_generator.make_with_string_stream ("ewg_arg_")
			if attached a_callback_wrapper.c_pointer_type.function_type as l_function_type and then attached l_function_type.members as l_members then
				from
					cs := l_members.new_cursor
					cs.start
				until
					cs.off
				loop
					output_stream.put_character ('%T')
					name_generator.generate_new_name
						check
							todo: False
						end
					-- cs.item.type.append_declaration_to_stream (output_stream, name_generator.output_string)
					if attached name_generator.output_string as l_output_string then
						l_output_string.wipe_out
					end

					output_stream.put_line (";")
					cs.forth
				end
			end

			output_stream.put_new_line

			output_stream.put_character ('%T')
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_string ("_eiffel_feature feature = (")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_eiffel_feature) entry_struct->feature;")

			output_stream.put_new_line

			output_stream.put_string ("%Tva_start_")

			if attached a_callback_wrapper.c_pointer_type.function_type as l_function_type and then
				attached l_function_type.members as l_members and then
				attached l_function_type.return_type as l_return_type then

				generate_ffcall_type (l_return_type)
				create name_generator.make_with_string_stream ("ewg_arg_")
				from
					cs := l_members.new_cursor
					cs.start
				until
					cs.off
				loop
					output_stream.put_character ('%T')
					name_generator.generate_new_name
					if attached name_generator.output_string as l_output_string then
						output_stream.put_string (l_output_string)
						l_output_string.wipe_out
					end
					output_stream.put_string (" = va_arg_")
					generate_ffcall_type (cs.item.type)
					cs.forth
				end
			end

		end

	generate_delegation_call (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
			name_generator: EWG_UNIQUE_NAME_GENERATOR
		do
			-- TODO: return type

			output_stream.put_string ("%T(*feature) (eif_access (entry_struct->class), ")

			create name_generator.make_with_string_stream ("ewg_arg_")
			if attached a_callback_wrapper.c_pointer_type.function_type as l_function_type and then attached l_function_type.members as l_members
			then
				from
					cs := l_members.new_cursor
					cs.start
				until
					cs.off
				loop
					name_generator.generate_new_name
					if attached name_generator.output_string as l_output_string then
						output_stream.put_string (l_output_string)
						l_output_string.wipe_out
					end
					if not cs.is_last then
						output_stream.put_string (", ")
					end
					cs.forth
				end
			end
			output_stream.put_line (");")
		end

	generate_ffcall_type (a_type: EWG_C_AST_TYPE)
		require
			a_type_not_void: a_type /= Void
		local
			type: EWG_C_AST_TYPE
		do
			type := a_type.skip_consts_and_aliases
			if type.is_pointer_type then
				output_stream.put_string ("ptr (alist, ")
					check
						todo: False
					end
				--a_type.append_declaration_without_declarator_to_stream (output_stream)
				output_stream.put_line (");")
			elseif type = c_system.types.void_type then
				output_stream.put_line ("void (alist);")
			elseif type.is_primitive_type and then attached {EWG_C_AST_PRIMITIVE_TYPE} type as primitive_type then
				if primitive_type.is_int_type then
					output_stream.put_line ("int (alist);")
				elseif primitive_type.is_long_type then
					output_stream.put_line ("long (alist);")
				elseif primitive_type.is_double_type then
					output_stream.put_line ("double (alist);")
				elseif primitive_type.is_char_type then
					output_stream.put_line ("char (alist);")
				elseif primitive_type.is_short_type then
					output_stream.put_line ("short (alist);")
				elseif primitive_type.is_float_type then
					output_stream.put_line ("float (alist);")
				else
						check
							dead_end: False
						end
				end
			elseif type.is_struct_type then
					check
						not_implemented: False
					end
			elseif type.is_union_type then
					check
						not_implemented: False
					end
			elseif type.is_enum_type then
					check
						not_implemented: False
					end
			else
					check
						dead_end: False
					end
			end

		end

	generate_stub_getter (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		do
			output_stream.put_string ("void* get_")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_stub ()")
			output_stream.put_line ("{")
			output_stream.put_string ("%Treturn (void*) ")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_stub;")
			output_stream.put_line ("}")
		end

end
