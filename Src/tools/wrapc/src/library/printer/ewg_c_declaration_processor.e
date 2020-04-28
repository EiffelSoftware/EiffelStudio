note

	description:

		"Abstract C declarator"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_DECLARATION_PROCESSOR

inherit

	EWG_C_AST_TYPE_PROCESSOR

	EWG_PRINTER
		redefine
			make_internal
		end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	EWG_C_CALLING_CONVENTION_CONSTANTS
		export {NONE} all end



create
	make,
	make_string
	
feature
	make_internal
		do
			reset
		end

feature -- Acccess

	declarator: STRING
			-- Declarator for declaration to generate

feature {EWG_C_AST_TYPE_PROCESSOR} -- Processing

	process_primitive_type (a_type: EWG_C_AST_PRIMITIVE_TYPE)
		do
			if attached a_type.name as l_name then
				output_stream.put_string (l_name)
			end
			if should_print_const then
				output_stream.put_character (' ')
				print_const
			end
			if has_declarator then
				output_stream.put_character (' ')
			end
			print_declarator
		end

	process_eiffel_object_type (a_type: EWG_C_AST_EIFFEL_OBJECT_TYPE)
		do
			process (c_system.types.void_pointer_type)
		end

	process_alias_type (a_type: EWG_C_AST_ALIAS_TYPE)
		do
			if attached a_type.name as l_name then
				output_stream.put_string (l_name)
			end

			if should_print_const then
				output_stream.put_character (' ')
				print_const
			end
			if has_declarator then
				output_stream.put_character (' ')
			end
			print_declarator
		end

	process_pointer_type (a_type: EWG_C_AST_POINTER_TYPE)
		do
			if attached last_type as l_last_type and then l_last_type.is_const_type then
				prepend_to_declarator ("*const ")
			else
				prepend_to_declarator ("*")
			end

			last_type := a_type
			process (a_type.base)
		end

	process_array_type (a_type: EWG_C_AST_ARRAY_TYPE)
		do
			append_to_declarator ("[")
			if attached a_type.size as l_size then
				append_to_declarator (l_size)
			end
			append_to_declarator ("]")
			if should_print_const then
				print_const
				output_stream.put_character (' ')
			end
			last_type := a_type
			process (a_type.base)
		end

	process_const_type (a_type: EWG_C_AST_CONST_TYPE)
		do
			last_type := a_type
			process (a_type.base)
		end

	process_function_type (a_type: EWG_C_AST_FUNCTION_TYPE)
		local
			declaration_printer: EWG_C_DECLARATION_PRINTER
			declaration_list_printer: EWG_C_DECLARATION_LIST_PRINTER
			l_declarator: STRING
		do
			if a_type.calling_convention = stdcall then
				prepend_to_declarator ("__stdcall ")
			elseif a_type.calling_convention = fastcall then
				prepend_to_declarator ("__fastcall ")
			end
			if should_print_const then
				prepend_to_declarator ("const ")
			end
			if attached last_type as l_last_type and then l_last_type.is_pointer_type then
				prepend_to_declarator ("(")
			end
			if attached last_type as l_last_type and then l_last_type.is_pointer_type then
				append_to_declarator (")")
			end
			create declaration_printer.make_string (text_after_declarator)
			create declaration_list_printer.make_string (text_after_declarator, declaration_printer)
			append_to_declarator (" (")
			if	attached a_type.members as l_members then
				declaration_list_printer.print_declaration_list (l_members)
				if a_type.has_ellipsis_parameter then
					append_to_declarator (", ...")
				end
			else
				if not a_type.has_ellipsis_parameter then
					declaration_printer.print_declaration_from_type (c_system.types.void_type, "")
				end
			end
			append_to_declarator (")")
			create l_declarator.make (text_before_declarator.count + declarator.count + text_after_declarator.count)
			l_declarator.append_string (text_before_declarator)
			l_declarator.append_string (declarator)
			l_declarator.append_string (text_after_declarator)
			create declaration_printer.make (output_stream)
			declaration_printer.print_declaration_from_type (a_type.return_type, l_declarator)
		end

	process_struct_type (a_type: EWG_C_AST_STRUCT_TYPE)
		do
			if a_type.is_anonymous then
					check
						has_perfect_alias: a_type.has_perfect_alias_type
					end
				if attached a_type.closest_alias_type as l_closest_alias_type then
					process (l_closest_alias_type)
				end
			else
				output_stream.put_string ("struct ")
				if attached a_type.name as l_name then
					output_stream.put_string (l_name)
				end
--				output_stream.put_string (a_type.name.as_lower)

				if should_print_const then
					output_stream.put_character (' ')
					print_const
				end
				if has_declarator then
					output_stream.put_character (' ')
				end
				print_declarator
			end
		end

	process_union_type (a_type: EWG_C_AST_UNION_TYPE)
		do
			if a_type.is_anonymous then
					check
						has_perfect_alias: a_type.has_perfect_alias_type
					end
				if attached a_type.closest_alias_type as l_closest_alias_type then
					process (l_closest_alias_type)
				end

			else
				output_stream.put_string ("union ")
				if attached a_type.name as l_name then
					output_stream.put_string (l_name)
				end

--				output_stream.put_string (a_type.name.as_lower)
				if should_print_const then
					output_stream.put_character (' ')
					print_const
				end
				if has_declarator then
					output_stream.put_character (' ')
				end
				print_declarator
			end
		end

	process_enum_type (a_type: EWG_C_AST_ENUM_TYPE)
		do
			if a_type.is_anonymous then
					check
						has_perfect_alias: a_type.has_perfect_alias_type
					end
				if attached a_type.closest_alias_type as l_closest_alias_type then
					process (l_closest_alias_type)
				end
			else
				output_stream.put_string ("enum ")
				if attached a_type.name as l_name  then
					output_stream.put_string (l_name)
				end
				if should_print_const then
					output_stream.put_character (' ')
					print_const
				end
				if has_declarator then
					output_stream.put_character (' ')
				end
				print_declarator
			end
		end

feature {NONE}

	text_before_declarator: STRING
			-- Text to output before `declarator'

	text_after_declarator: STRING
			-- Text to output after  `declarator'

	reset
		do
			create declarator.make_empty
			create text_after_declarator.make_empty
			create text_before_declarator.make_empty
			last_type := Void
		ensure
			declarator_not_void: declarator /= Void
			declarator_is_empty: declarator.count = 0
			text_before_declarator_not_void: text_before_declarator /= Void
			text_before_declarator_is_empty: text_before_declarator.count = 0
			text_after_declarator_not_void: text_after_declarator /= Void
			text_after_declarator_is_empty: text_after_declarator.count = 0
		end

	last_type: detachable EWG_C_AST_TYPE
			-- Last type that was processed

	process (a_type: EWG_C_AST_TYPE)
			-- Process `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_type_valid: a_type.is_named_recursive or a_type.based_type_recursive.is_function_type or a_type.based_type_recursive.is_eiffel_object_type or a_type.based_type_recursive.has_perfect_alias_type
			declarator_not_void: declarator /= Void
		do
			a_type.process (Current)
		end

	prepend_to_declarator (a_string: STRING)
			-- Prepend `a_string' to `text_before_declarator'.
		require
			a_string_not_void: a_string /= Void
			a_string_not_empty: a_string.count > 0
			text_before_declarator_not_void: text_before_declarator /= Void
		local
			new_text_before_declarator: STRING
		do
			create new_text_before_declarator.make (a_string.count + text_before_declarator.count)
			new_text_before_declarator.append_string (a_string)
			new_text_before_declarator.append_string (text_before_declarator)
			text_before_declarator := new_text_before_declarator
		ensure
			text_before_declarator_size: text_before_declarator.count = a_string.count + old text_before_declarator.count
			a_string_prepended: STRING_.same_string (text_before_declarator.substring (1, a_string.count), a_string)
			old_string_follows: STRING_.same_string (text_before_declarator.substring (a_string.count + 1, text_before_declarator.count), old text_before_declarator.twin)
		end

	append_to_declarator (a_string: STRING)
			-- Append `a_string' to `text_after_declarator'.
		require
			a_string_not_void: a_string /= Void
			a_string_not_empty: a_string.count > 0
			text_after_declarator_not_void: text_after_declarator /= Void
		do
			text_after_declarator.append_string (a_string)
		ensure
			text_after_declarator_size: text_after_declarator.count = a_string.count + old text_after_declarator.count
		end

	print_declarator
		require
			text_before_declarator_not_void: text_before_declarator /= Void
			text_after_declarator_not_void: text_after_declarator /= Void
			declarator_not_void: declarator /= Void
		do
			output_stream.put_string (text_before_declarator)
			output_stream.put_string (declarator)
			output_stream.put_string (text_after_declarator)
		end

	print_const
			-- Print "const".
		require
			should_print_const
		do
			output_stream.put_string ("const")
		end

	should_print_const: BOOLEAN
		do
			Result := attached last_type as l_last_type and then l_last_type.is_const_type
		end

	has_declarator: BOOLEAN
		require
			declarator_not_void: declarator /= Void
		do
			Result := declarator.count > 0
		end

end
