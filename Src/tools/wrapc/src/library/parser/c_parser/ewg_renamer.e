note

	description:

		"Class that provides features to rename all kinds of C and Eiffel related strings"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_RENAMER

inherit

	ANY

	KL_CHARACTER_ROUTINES
		export {NONE} all end

	EWG_PRINT_ROUTINES
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	KL_IMPORTED_CHARACTER_ROUTINES
		export {NONE} all end

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

	EWG_SHARED_ANY_FEATURE_NAMES
		export {NONE} all end

	EWG_SHARED_STRUCT_FEATURE_NAMES
		export {NONE} all end

feature

	is_valid_eiffel_identifier (a_identifier: STRING): BOOLEAN
			-- Is `a_identifier' a valid Eiffel identifier?
		require
			a_identifier_not_void: a_identifier /= Void
		local
			i: INTEGER
			char: CHARACTER
		do
			Result := True
			from
				i := 1
			until
				i > a_identifier.count or Result = False
			loop
				char := a_identifier.item (i)
				if
					not (char = '_' or
						 is_letter (char) or
						 is_digit_non_gobo (char))
				then
					Result := False
				else
					i := i + 1
				end
			end
		end

	is_valid_c_identifier (a_identifier: STRING): BOOLEAN
			-- Is `a_identifier' a valid Eiffel identifier?
		require
			a_identifier_not_void: a_identifier /= Void
		do
			Result := is_valid_eiffel_identifier (a_identifier)
		end

feature

	eiffel_class_name_from_c_type (a_type: EWG_C_AST_TYPE): STRING
		require
			a_type_not_void: a_type /= Void
			a_type_not_anonymous: not a_type.is_anonymous
		do
			check attached a_type.name as l_name then
				Result := upper_lower_to_underscore (l_name)
				Result.to_upper
				remove_leading_underscores_from_string (Result)
				Result := escape_keywords (Result)
			end
		ensure
			result_not_void: Result /= Void
			result_is_valid_eiffel_identifier: is_valid_eiffel_identifier (Result)
		end

	eiffel_class_name_from_c_type_name (a_type_name: STRING): STRING
		require
			a_type_name_not_void: a_type_name /= Void
		do
			Result := upper_lower_to_underscore (a_type_name)
			Result.to_upper
			remove_leading_underscores_from_string (Result)
			Result := escape_keywords (Result)
		ensure
			result_not_void: Result /= Void
			result_is_valid_c_identifier: is_valid_eiffel_identifier (Result)
		end

	eiffel_class_name_from_c_callback_name (a_type_name: STRING): STRING
		require
			a_type_name_not_void: a_type_name /= Void
		do
			Result := upper_lower_to_underscore (a_type_name)
			Result.to_upper
			remove_leading_underscores_from_string (Result)
			Result := escape_keywords (Result)
		ensure
			result_not_void: Result /= Void
			result_is_valid_eiffel_identifier: is_valid_eiffel_identifier (Result)
		end

	c_define_constant_from_c_header_file_name (a_header_file_name: STRING): STRING
		require
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_has_extension: a_header_file_name.has ('.')
		local
			i: INTEGER
			a_ext: STRING
		do
			-- cut of file name extension
			-- NOTE: I am not sure why I have to clone here,
			--	     but weird things happen if I don't !
			Result := file_system.basename (a_header_file_name.twin)
			a_ext := file_system.extension (Result)
			Result.remove_tail (a_ext.count)
			Result.to_upper

			from
				i := 1
			until
				i > Result.count
			loop
				if Result.item (i) = '-' then
					Result.put ('_', i)
				end
				i := i + 1
			end
			Result.append_string ("__")
		end

	c_header_file_name_to_eiffel_class_name (a_header_file_name: STRING): STRING
		require
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_has_extension: a_header_file_name.has ('.')
		local
			i: INTEGER
			a_ext: STRING
			char: CHARACTER
		do
			-- cut of file name extension
			-- NOTE: I am not sure why I have to clone here,
			--	     but weird things happen if I don't !
			Result := file_system.basename (a_header_file_name.twin)
			a_ext := file_system.extension (Result)
			Result.remove_tail (a_ext.count)
			Result.to_upper

			from
				i := 1
			until
				i > Result.count
			loop
				char := Result.item (i)
				if not (char = '_' or is_letter (char) or is_digit_non_gobo (char)) then
					Result.put ('_', i)
				end
				i := i + 1
			end

			Result := upper_lower_to_underscore(Result)
			remove_leading_underscores_from_string (Result)
			Result.to_upper
			Result := escape_keywords (Result)
		ensure
			result_not_void: Result /= Void
			result_is_valid_eiffel_identifier: is_valid_eiffel_identifier (Result)
		end

	c_eiffel_callbacks_glue_header_name_from_callback_header_name (a_header_file_name: STRING): STRING
		require
			a_header_file_name_not_void: a_header_file_name /= Void
		do
			Result := file_name_without_extension_and_path (a_header_file_name)
			Result.append_string ("_c_eiffel_callbacks_glue")
		end

	eiffel_feature_name_from_c_function (a_function_declaration: EWG_C_AST_FUNCTION_DECLARATION): STRING
		require
			a_function_declaration_not_void: a_function_declaration /= Void
		do
			check attached a_function_declaration.declarator as l_declarator then
				Result := upper_lower_to_underscore(l_declarator)
				remove_leading_underscores_from_string (Result)
				Result := escape_keywords (Result)
			end
		ensure
			result_not_void: Result /= Void
			result_is_valid_eiffel_identifier: is_valid_eiffel_identifier (Result)
		end

	eiffel_feature_name_from_c_function_name (a_function_name: STRING): STRING
		require
			a_function_name_not_void: a_function_name /= Void
		do
			Result := upper_lower_to_underscore(a_function_name)
			remove_leading_underscores_from_string (Result)
			Result := escape_keywords (Result)
		ensure
			result_not_void: Result /= Void
			result_is_valid_eiffel_identifier: is_valid_eiffel_identifier (Result)
		end


	eiffel_feature_name_from_c_function_parameters (a_function_type: EWG_C_AST_FUNCTION_TYPE): STRING
		require
			a_function_type_not_void: a_function_type /= Void
		local
			declaration_printer: EWG_C_ANONYMOUS_DECLARATION_PRINTER
			declaration_list_printer: EWG_C_DECLARATION_LIST_PRINTER
		do
			create Result.make (40)
			create declaration_printer.make_string (Result)
			declaration_printer.print_declaration_from_type (a_function_type.return_type, "")
			create declaration_list_printer.make_string (Result, declaration_printer)
			Result.append_string ("_")
			if attached  a_function_type.members  as l_members and then l_members.count = 0 then
				Result.append_string ("void")
			elseif attached  a_function_type.members  as l_members then
				declaration_list_printer.print_declaration_list (l_members)
			end
			Result.to_lower
			-- TODO: optimize
			replace_all (Result, '*', 'p')
			remove_all (Result, ' ')
			replace_all (Result, '(', '_')
			replace_all (Result, ')', '_')
			replace_all (Result, ',', '_')
			replace_all (Result, '[', '_')
			replace_all (Result, ']', '_')
			Result.append_string ("_anonymous_callback")
		ensure
			result_not_void: Result /= Void
			result_is_valid_eiffel_identifier: is_valid_eiffel_identifier (Result)
		end

	eiffel_parameter_name_from_c_parameter_name (a_name: STRING): STRING
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not (a_name.count = 0)
		local
			escaped_name: STRING
		do
			Result := a_name.as_lower
			remove_leading_underscores_from_string (Result)
			if eiffel_keywords.has (Result) or else any_feature_names.has (Result) then
				create escaped_name.make (2 + Result.count)
				escaped_name.append_string ("a_")
				escaped_name.append_string (Result)
				Result := escaped_name
			end
		ensure
			result_not_void: Result /= Void
			resupt_not_empty: not (a_name.count = 0)
			result_is_valid_eiffel_identifier: is_valid_eiffel_identifier (Result)
		end

	append_eiffel_parameter_name_from_c_parameter_name_to_stream (a_stream: KI_CHARACTER_OUTPUT_STREAM; a_c_parameter_name: STRING)
		require
			a_stream_not_void: a_stream /= Void
			a_c_parameter_name_not_void: a_c_parameter_name /= Void
		do
			a_stream.put_string (eiffel_parameter_name_from_c_parameter_name (a_c_parameter_name))
		end


feature {NONE} -- Implementation

	remove_leading_underscores (a_name: STRING): STRING
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not (a_name.count = 0)
		local
			i: INTEGER
		do
			create Result.make (a_name.count)
			-- first skip all '_' characters
			from
				i := 1
			until
				i > a_name.count or else a_name.item (i) /= '_'
			loop
				i := i + 1
			end
			-- now copy the rest of the characters
			from
			until
				i > a_name.count
			loop
				Result.append_character (a_name.item (i))
				i := i + 1
			end

		ensure
			result_not_void: Result /= Void
			resupt_not_empty: not (Result.count = 0)
		end

	remove_leading_underscores_from_string (a_name: STRING)
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not (a_name.count = 0)
		local
			i: INTEGER
			j: INTEGER
		do
			-- first skip all '_' characters
			from
				i := 1
			until
				i > a_name.count or else a_name.item (i) /= '_'
			loop
				i := i + 1
				if a_name.item (i) = '_' then
					j := j + 1
				end
			end
			if a_name.item (1) = '_' then
				j := j + 1
			end
			a_name.remove_head (j)
		end

	escape_keywords (a_name: STRING): STRING
			-- TODO: does not only escape keywords
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not (a_name.count = 0)
		local
			lower: STRING
		do
			lower := a_name.twin
			lower.to_lower
			if eiffel_keywords.has (lower) then
				create Result.make_from_string ("a_")
				Result.append_string (a_name)
			elseif any_feature_names.has (lower) then
				create Result.make_from_string ("a_")
				Result.append_string (a_name)
			else
				Result := a_name
			end
		ensure
			result_not_void: Result /= Void
			resupt_not_empty: not (Result.count = 0)
		end


	escaped_struct_feature_name (a_name: STRING): STRING
			-- Escaped version of `a_name' so that it does not clash with
			-- an Eiffel keyword a feature from class ANY or class
			-- EWG_STRUCT
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not (a_name.count = 0)
		local
			lower: STRING
		do
			Result := a_name
			lower := a_name.twin
			lower.to_lower
			if eiffel_keywords.has (lower) then
				Result := Result.twin
				Result.append_string ("_")
			elseif any_feature_names.has (lower) then
				Result := Result.twin
				Result.append_string ("_")
			elseif struct_feature_names.has (lower) then
				Result := Result.twin
				Result.append_string ("_")
			end
		ensure
			result_not_void: Result /= Void
			result_not_empty: not (Result.count = 0)
		end

	eiffel_keywords: DS_HASH_SET [STRING]
			-- TODO: Create class like EWG_ANY_FEATURE_NAMES
		note
			EIS: "name=Eiffel Reserved words", "src=https://www.eiffel.org/doc/eiffel/Eiffel_programming_language_reserved_words", "protocol=uri"
		once
			create Result.make (100)
			Result.set_equality_tester (string_equality_tester)
				-- Taken from ETL Appendix G
			Result.put ("across")
			Result.put ("alias")
			Result.put ("all")
			Result.put ("and")
			Result.put ("as")
			Result.put ("assign")
			Result.put ("attached")
			Result.put ("attribute")
			Result.put ("check")
			Result.put ("class")
			Result.put ("convert")
			Result.put ("create")
			Result.put ("current")
			Result.put ("debug")
			Result.put ("deferred")
			Result.put ("detachable")
			Result.put ("do")
			Result.put ("else")
			Result.put ("elseif")
			Result.put ("end")
			Result.put ("ensure")
			Result.put ("expanded")
			Result.put ("export")
			Result.put ("external")
			Result.put ("false")
			Result.put ("feature")
			Result.put ("from")
			Result.put ("frozen")
			Result.put ("if")
			Result.put ("implies")
			Result.put ("infix")
			Result.put ("inherit")
			Result.put ("inspect")
			Result.put ("invariant")
			Result.put ("is")
			Result.put ("like")
			Result.put ("local")
			Result.put ("loop")
			Result.put ("not")
			Result.put ("note")
			Result.put ("obsolete")
			Result.put ("old")
			Result.put ("once")
			Result.put ("only")
			Result.put ("or")
			Result.put ("precursor")
			Result.put ("prefix")
			Result.put ("redefine")
			Result.put ("rename")
			Result.put ("require")
			Result.put ("rescue")
			Result.put ("result")
			Result.put ("retry")
			Result.put ("select")
			Result.put ("separate")
			Result.put ("then")
			Result.put ("true")
			Result.put ("tuple")
			Result.put ("undefine")
			Result.put ("unique")
			Result.put ("until")
			Result.put ("variant")
			Result.put ("void")
			Result.put ("when")
			Result.put ("xor")
			Result.put ("reference")

		end

	upper_lower_to_underscore (a_name: STRING): STRING
			-- Insert an underscore character between
			-- to sibling characters of different case
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not (a_name.count = 0)
		local
			i: INTEGER
			last_was_lower: BOOLEAN
		do
			create Result.make (a_name.count + 5)
			from
				i := 1
			until
				i > a_name.count
			loop
				-- ignore first character
				if i /= 1 then
					if last_was_lower and
						is_letter (a_name.item (i)) and
						is_upper (a_name.item (i))
					then
						Result.append_character ('_')
					end
				end
				Result.append_character (CHARACTER_.as_lower (a_name.item (i)))
				last_was_lower := is_letter (a_name.item (i)) and is_lower (a_name.item (i))
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			resupt_not_empty: not (a_name.count = 0)
		end

	is_letter (ch: CHARACTER): BOOLEAN
		do
			inspect ch
			when 'A' then Result := True
			when 'B' then Result := True
			when 'C' then Result := True
			when 'D' then Result := True
			when 'E' then Result := True
			when 'F' then Result := True
			when 'G' then Result := True
			when 'H' then Result := True
			when 'I' then Result := True
			when 'J' then Result := True
			when 'K' then Result := True
			when 'L' then Result := True
			when 'M' then Result := True
			when 'N' then Result := True
			when 'O' then Result := True
			when 'P' then Result := True
			when 'Q' then Result := True
			when 'R' then Result := True
			when 'S' then Result := True
			when 'T' then Result := True
			when 'U' then Result := True
			when 'V' then Result := True
			when 'W' then Result := True
			when 'X' then Result := True
			when 'Y' then Result := True
			when 'Z' then Result := True
			when 'a' then Result := True
			when 'b' then Result := True
			when 'c' then Result := True
			when 'd' then Result := True
			when 'e' then Result := True
			when 'f' then Result := True
			when 'g' then Result := True
			when 'h' then Result := True
			when 'i' then Result := True
			when 'j' then Result := True
			when 'k' then Result := True
			when 'l' then Result := True
			when 'm' then Result := True
			when 'n' then Result := True
			when 'o' then Result := True
			when 'p' then Result := True
			when 'q' then Result := True
			when 'r' then Result := True
			when 's' then Result := True
			when 't' then Result := True
			when 'u' then Result := True
			when 'v' then Result := True
			when 'w' then Result := True
			when 'x' then Result := True
			when 'y' then Result := True
			when 'z' then Result := True
			else
			end
		end

	is_digit_non_gobo (ch: CHARACTER): BOOLEAN
			-- Is `ch' a digit?
			-- Note: Once Gobo 3.5 is released use
			-- `KL_CHARACTER_ROUTINES.is_digit' instead.
		do
			inspect ch
			when '0' then Result := True
			when '1' then Result := True
			when '2' then Result := True
			when '3' then Result := True
			when '4' then Result := True
			when '5' then Result := True
			when '6' then Result := True
			when '7' then Result := True
			when '8' then Result := True
			when '9' then Result := True
			else
			end
		end

	is_lower (ch: CHARACTER): BOOLEAN
		do
			Result := CHARACTER_.as_lower (ch) = ch
		end

	is_upper (ch: CHARACTER): BOOLEAN
		do
			Result := CHARACTER_.as_upper (ch) = ch
		end

	escape_type_name_to_be_c_identifier (a_type_name: STRING)
		require
			a_type_name_not_void: a_type_name /= Void
		do
			replace_all (a_type_name, ' ', '_')
		end

feature

	average_c_parameter_length: INTEGER = 5
			-- Based on absolutely no evidence (;

end
