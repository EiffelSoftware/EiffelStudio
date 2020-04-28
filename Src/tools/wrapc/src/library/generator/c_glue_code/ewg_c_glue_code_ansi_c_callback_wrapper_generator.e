note

	description:

		"Generates C glue code for callback wrappers"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_GLUE_CODE_ANSI_C_CALLBACK_WRAPPER_GENERATOR

inherit

	EWG_ABSTRACT_GENERATOR
		redefine
			make_internal
		end

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	EWG_RENAMER
		export {NONE} all end

	EWG_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

	EWG_C_CALLING_CONVENTION_CONSTANTS
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make_internal
		do
			Precursor
			make_printers
		end

	make_printers
		local
			parameter_printer: EWG_C_DECLARATOR_PRINTER
		do
			create declaration_printer.make (output_stream)
			create declaration_list_printer.make (output_stream, declaration_printer)
			create parameter_printer.make (output_stream)
			create parameter_list_printer.make (output_stream, parameter_printer)
		end

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
				make_printers
				output_stream.put_line ("#include <ewg_eiffel.h>")
				output_stream.put_string ("#include <")
				output_stream.put_string (directory_structure.relative_callback_c_glue_header_file_name)
				output_stream.put_line (">")
				output_stream.put_new_line
				output_stream.put_line ("#ifdef _MSC_VER")
				output_stream.put_line ("#pragma warning (disable:4715) // Not all control paths return a value")
				output_stream.put_line ("#endif")

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

feature {NONE} -- Implementation

	generate_callback_wrapper (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		do
			--generate_callback_entry_struct (a_callback_wrapper)

			generate_callback_entry_object (a_callback_wrapper)
			generate_callback_entry_effel_function_address (a_callback_wrapper, a_callback_wrapper.callbacks_per_type)

			generate_set_object_definition (a_callback_wrapper)
			generate_release_object_definition (a_callback_wrapper)

			generate_stub_definition (a_callback_wrapper, a_callback_wrapper.callbacks_per_type)


			generate_entry_setter_definition (a_callback_wrapper, a_callback_wrapper.callbacks_per_type)
			generate_stub_getter_definition (a_callback_wrapper, a_callback_wrapper.callbacks_per_type)
			generate_caller_definition (a_callback_wrapper)
		end


	generate_callback_entry_struct (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		do
			output_stream.put_string ("struct ")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_string ("_entry_struct ")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_entry = {NULL, NULL};")
			output_stream.put_new_line
		end


	generate_callback_entry_object (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		do
			output_stream.put_string ("void* ")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_object =  NULL;")
		end

	generate_callback_entry_effel_function_address (a_callback_wrapper: EWG_CALLBACK_WRAPPER; a_count: INTEGER)
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_count
			loop
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_string ("_eiffel_feature ")
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_string ("_address_")
				output_stream.put_integer (i)
				output_stream.put_line (" = NULL;")
				i := i + 1
			end
			output_stream.put_new_line
		end

	generate_stub_definition (a_callback_wrapper: EWG_CALLBACK_WRAPPER; a_count: INTEGER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			declarator: STRING
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_count
			loop
				create declarator.make (a_callback_wrapper.mapped_eiffel_name.count + ("_stub").count + i.out.count)
				declarator.append_string (a_callback_wrapper.mapped_eiffel_name)
				declarator.append_string ("_stub_")
				declarator.append_integer (i)
				declaration_printer.print_declaration_from_type (a_callback_wrapper.c_pointer_type.function_type,
																				 declarator)
				output_stream.put_new_line
				output_stream.put_line ("{")
				output_stream.put_string ("%Tif (")
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_string ("_object != NULL && ")
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_string ("_address_")
				output_stream.put_integer (i)
				output_stream.put_line (" != NULL)")
				output_stream.put_line ("%T{")
				output_stream.put_string ("%T%T")
				if a_callback_wrapper.c_pointer_type.function_type.return_type.skip_consts_and_aliases /= c_system.types.void_type then
					output_stream.put_string ("return ")
				end
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_string ("_address_")
				output_stream.put_integer (i)
				output_stream.put_string (" (eif_access(")
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_string ("_object)")
				if attached a_callback_wrapper.c_pointer_type.function_type.members as l_members and then l_members.count > 0 then
					output_stream.put_string (", ")
					parameter_list_printer.print_declaration_list (l_members)
				end
				output_stream.put_line (");")
				output_stream.put_line ("%T}")
				output_stream.put_line ("}")
				output_stream.put_new_line
				i := i + 1
			end
		end

	generate_set_object_definition (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		do
			output_stream.put_string ("void set_")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_object (void* a_object)")
			output_stream.put_line ("{")
			output_stream.put_string ("%T")
			output_stream.put_line ("if (a_object) {")
			output_stream.put_string ("%T%T")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_object = eif_protect(a_object);")
			output_stream.put_line ("%T} else { ")
			output_stream.put_string ("%T%T")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_object = NULL;")
			output_stream.put_line ("%T}")
			output_stream.put_line ("}")
			output_stream.put_new_line
		end

	generate_release_object_definition (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		do
			output_stream.put_string ("void release_")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_object ()")
			output_stream.put_line ("{")
			output_stream.put_string ("%T")
			output_stream.put_string ("eif_wean (")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_object);")
			output_stream.put_line ("}")
			output_stream.put_new_line
		end

	generate_entry_setter_definition (a_callback_wrapper: EWG_CALLBACK_WRAPPER; a_count: INTEGER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			i:INTEGER
		do
			from
				i := 1
			until
				i > a_count
			loop
				output_stream.put_string ("void set_")
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_string ("_entry_")
				output_stream.put_integer (i)
				output_stream.put_string (" (void* a_feature)")
				output_stream.put_line ("{")
				output_stream.put_string ("%T")
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_string ("_address_")
				output_stream.put_integer (i)
				output_stream.put_string (" = (")
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_line ("_eiffel_feature) a_feature;")
				output_stream.put_line ("}")
				output_stream.put_new_line
				i := i + 1
			end
		end

	generate_stub_getter_definition (a_callback_wrapper: EWG_CALLBACK_WRAPPER; a_count: INTEGER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_count
			loop
				output_stream.put_string ("void* get_")
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_string ("_stub_")
				output_stream.put_integer (i)
				output_stream.put_string (" ()")
				output_stream.put_line ("{")
				output_stream.put_string ("%Treturn (void*) ")
				output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
				output_stream.put_string ("_stub_")
				output_stream.put_integer (i)
				output_stream.put_line (";")
				output_stream.put_line ("}")
				output_stream.put_new_line
				i :=  i + 1
			end
		end

	generate_caller_definition (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			function: EWG_C_AST_FUNCTION_TYPE
			members: DS_ARRAYED_LIST [EWG_C_AST_DECLARATION]
			declarator: STRING
			declaration: EWG_C_AST_DECLARATION
			cs: DS_LINEAR_CURSOR [EWG_C_AST_DECLARATION]
		do
			if attached a_callback_wrapper.c_pointer_type.function_type.members as l_members then
				create members.make (l_members.count + 1)
				create declaration.make ("a_function",
												 c_system.types.void_pointer_type,
												 directory_structure.relative_callback_c_glue_header_file_name)
				members.force_last (declaration)
				from
					cs := l_members.new_cursor
					cs.start
				until
					cs.off
				loop
					create declaration.make (cs.item.declarator, cs.item.type,
													 directory_structure.relative_callback_c_glue_header_file_name)
					members.force_last (declaration)
					cs.forth
				end
				create function.make (directory_structure.relative_callback_c_glue_header_file_name,
											 a_callback_wrapper.c_pointer_type.function_type.return_type,
											 members)

				declarator := "call_"
				declarator.append_string (a_callback_wrapper.mapped_eiffel_name)
				declaration_printer.print_declaration_from_type (function, declarator)
				output_stream.put_new_line
				output_stream.put_line ("{")
				output_stream.put_string ("%T")
				if
					a_callback_wrapper.c_pointer_type.function_type.return_type.skip_consts_and_aliases /= c_system.types.void_type
				then
					output_stream.put_string ("return ")
				end
				output_stream.put_string ("((")
				declaration_printer.print_declaration_from_type (a_callback_wrapper.c_pointer_type, "")
				output_stream.put_string (")")
				output_stream.put_string ("a_function) (")
				parameter_list_printer.print_declaration_list (l_members)
				output_stream.put_line (");")
				output_stream.put_line ("}")
				output_stream.put_new_line
			end
		end

	declaration_printer: EWG_C_DECLARATION_PRINTER
	declaration_list_printer: EWG_C_DECLARATION_LIST_PRINTER
	parameter_list_printer: EWG_C_DECLARATION_LIST_PRINTER

invariant

	declaration_printer_not_void: declaration_printer /= Void
	declaration_list_printer_not_void: declaration_list_printer /= Void
	parameter_list_printer_not_void: parameter_list_printer /= Void

end
