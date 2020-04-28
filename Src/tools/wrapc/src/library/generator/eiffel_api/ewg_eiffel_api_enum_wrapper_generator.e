note
	description:

		"Generates Eiffel external wrappers for C enum types"

	library: "Eiffel Wrapper Generator Library"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	EWG_EIFFEL_API_ENUM_WRAPPER_GENERATOR

inherit

	EWG_ABSTRACT_GENERATOR

	EWG_RENAMER
		export {NONE} all end

create

	make

feature

	generate (a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			cs: DS_BILINEAR_CURSOR [EWG_ENUM_WRAPPER]
			file_name: STRING
			file: KL_TEXT_OUTPUT_FILE
		do
			from
				cs := a_eiffel_wrapper_set.new_enum_wrapper_cursor
				cs.start
			until
				cs.off
			loop
				file_name := file_system.pathname (directory_structure.eiffel_directory_name, cs.item.mapped_eiffel_name.as_lower + "_enum_api.e")
				create file.make (file_name)
				file.recursive_open_write
				if file.is_open_write then
					output_stream := file
					output_stream.put_line ("-- enum wrapper")
					generate_enum_wrapper (cs.item)
					file.close
				else
					error_handler.report_cannot_write_error (file_name)
				end
				cs.forth
				error_handler.tick
			end
		end

feature {NONE}

	generate_enum_wrapper (an_enum_wrapper: EWG_ENUM_WRAPPER)
		require
			an_enum_wrapper_not_void: an_enum_wrapper /= Void
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
			declaration_printer: EWG_C_ANONYMOUS_DECLARATION_PRINTER
			declaration: STRING
		do
			create declaration.make (20)
			create declaration_printer.make_string (declaration)
			declaration_printer.print_declaration_from_type (an_enum_wrapper.c_enum_type, "")
			escape_type_name_to_be_c_identifier (declaration)
			output_stream.put_string ("class ")
			output_stream.put_string (an_enum_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_ENUM_API")
			output_stream.put_new_line
			output_stream.put_line ("feature {ANY}")
			output_stream.put_new_line

			if attached an_enum_wrapper.c_enum_type.members as l_members then
				generate_is_valid_feature (an_enum_wrapper)
				from
					cs := l_members.new_cursor
					cs.start
				until
					cs.off
				loop
					generate_member (cs.item,
										  declaration,
										  an_enum_wrapper.header_file_name)
					cs.forth
				end
			end

			output_stream.put_line ("end")
		end

	generate_is_valid_feature (an_enum_wrapper: EWG_ENUM_WRAPPER)
		require
			an_enum_wrapper_not_void: an_enum_wrapper /= Void
			members_not_void: an_enum_wrapper.members /= Void
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
		do
			if attached an_enum_wrapper.c_enum_type.members as l_members then
				output_stream.put_line ("%Tis_valid_enum (a_value: INTEGER): BOOLEAN ")
				output_stream.put_line ("%T%T%T-- Is `a_value' a valid integer code for this enum ?")
				output_stream.put_line ("%T%Tdo")
				output_stream.put_string("%T%T%TResult := ")
				from
					cs := l_members.new_cursor
					cs.start
				until
					cs.off
				loop
					if attached cs.item.declarator as l_declarator then
						output_stream.put_string ("a_value = ")
						output_stream.put_string (eiffel_parameter_name_from_c_parameter_name (l_declarator))
						cs.forth
						if not cs.after then
							output_stream.put_string (" or ")
						end
					end
				end
				output_stream.put_new_line
				output_stream.put_line ("%T%Tend")
				output_stream.put_new_line
			end
		end

	generate_member (a_member: EWG_C_AST_DECLARATION;
						  an_enum_declaration: STRING;
						  a_header_file_name: STRING)
		require
			a_member_not_void: a_member /= Void
			an_enum_declaration_not_void: an_enum_declaration /= Void
			a_header_file_name_not_void: a_header_file_name /= Void
		local
			eiffel_member_name: STRING
		do
			if attached a_member.declarator as l_declarator then
				eiffel_member_name := eiffel_parameter_name_from_c_parameter_name (l_declarator)

				output_stream.put_string ("%T")
				output_stream.put_string (eiffel_member_name)
				output_stream.put_line (": INTEGER ")
				output_stream.put_line ("%T%Texternal")

				if
					eiffel_compiler_mode.is_ise_mode
				then
					output_stream.put_string ("%T%T%T%"C inline use <")
					output_stream.put_string (a_header_file_name)
					output_stream.put_string (">%"")
					output_stream.put_new_line
					output_stream.put_string ("%T%Talias")
					output_stream.put_new_line
					output_stream.put_string ("%T%T%T%"")
					output_stream.put_string (l_declarator)
					output_stream.put_string ("%"")
					output_stream.put_new_line
					output_stream.put_string ("%T%Tend")
					output_stream.put_new_line
				else
						check
							dead_end: False
						end
				end
				output_stream.put_new_line
			end
		end

end
