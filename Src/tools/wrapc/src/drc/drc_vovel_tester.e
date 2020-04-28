indexing

	description:

		"Tests if name of a type starts with a vovel"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class DRC_VOVEL_TESTER

inherit

	EWG_C_AST_TYPE_PROCESSOR

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make is
		do
		end

feature {ANY} -- Basic Queries

	last_type_started_with_vovel: BOOLEAN

feature

	process_primitive_type (a_type: EWG_C_AST_PRIMITIVE_TYPE) is
		do
			if string_equality_tester.test (a_type.name, "int") then
				last_type_started_with_vovel := True
			elseif string_equality_tester.test (a_type.name, "signed int") then
				last_type_started_with_vovel := False
			elseif string_equality_tester.test (a_type.name, "unsigned int") then
				last_type_started_with_vovel := True
			elseif string_equality_tester.test (a_type.name, "long") then
				last_type_started_with_vovel := False
			elseif string_equality_tester.test (a_type.name, "signed long") then
				last_type_started_with_vovel := False
			elseif string_equality_tester.test (a_type.name, "unsigned long") then
				last_type_started_with_vovel := True
			elseif string_equality_tester.test (a_type.name, "short") then
				last_type_started_with_vovel := False
			elseif string_equality_tester.test (a_type.name, "signed short") then
				last_type_started_with_vovel := False
			elseif string_equality_tester.test (a_type.name, "unsigned short") then
				last_type_started_with_vovel := True
			elseif string_equality_tester.test (a_type.name, "char") then
				last_type_started_with_vovel := False
			elseif string_equality_tester.test (a_type.name, "signed char") then
				last_type_started_with_vovel := False
			elseif string_equality_tester.test (a_type.name, "unsigned char") then
				last_type_started_with_vovel := True
			elseif string_equality_tester.test (a_type.name, "double") then
				last_type_started_with_vovel := False
			elseif string_equality_tester.test (a_type.name, "float") then
				last_type_started_with_vovel := False
			elseif string_equality_tester.test (a_type.name, "void") then
				last_type_started_with_vovel := False
			else
				last_type_started_with_vovel := True -- "unknown ..."
			end
		end

	process_pointer_type (a_type: EWG_C_AST_POINTER_TYPE) is
		do
			last_type_started_with_vovel := False
		end

	process_array_type (a_type: EWG_C_AST_ARRAY_TYPE) is
		do
			last_type_started_with_vovel := True
		end

	process_const_type (a_type: EWG_C_AST_CONST_TYPE) is
		do
			last_type_started_with_vovel := False
		end

	process_alias_type (a_type: EWG_C_AST_ALIAS_TYPE) is
		do
			last_type_started_with_vovel := is_character_vovel (a_type.name.item (1))
		end

	process_enum_type (a_type: EWG_C_AST_ENUM_TYPE) is
		do
			last_type_started_with_vovel := True
		end

	process_struct_type (a_type: EWG_C_AST_STRUCT_TYPE) is
		do
			last_type_started_with_vovel := False
		end

	process_union_type (a_type: EWG_C_AST_UNION_TYPE) is
		do
			last_type_started_with_vovel := True
		end

	process_function_type (a_type: EWG_C_AST_FUNCTION_TYPE) is
		do
			last_type_started_with_vovel := False
		end

	process_eiffel_object_type (a_type: EWG_C_AST_EIFFEL_OBJECT_TYPE) is
		do
				check
					dead_end: False
				end
		end


feature {NONE}

	is_character_vovel (a_character: CHARACTER): BOOLEAN is
		do
			Result := a_character = 'a' or
				a_character = 'e' or
				a_character = 'i' or
				a_character = 'o' or
				a_character = 'u'
		end

end
