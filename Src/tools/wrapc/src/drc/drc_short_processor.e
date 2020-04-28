indexing

	description:

		"Generate HTML code explaining C declarations (brief version)"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class DRC_SHORT_PROCESSOR

inherit

	EWG_C_AST_TYPE_PROCESSOR

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_text_writer: like text_writer) is
		require
			a_text_writer_not_void: a_text_writer /= Void
		do
			text_writer := a_text_writer
		ensure
			text_writer_set: text_writer = a_text_writer
		end

feature

	process_primitive_type (a_type: EWG_C_AST_PRIMITIVE_TYPE) is
		local
			url: STRING
		do
			if string_equality_tester.test (a_type.name, "int") then
				url := int_url
			elseif string_equality_tester.test (a_type.name, "signed int") then
				url := signed_int_url
			elseif string_equality_tester.test (a_type.name, "unsigned int") then
				url := unsigned_int_url
			elseif string_equality_tester.test (a_type.name, "long") then
				url := long_url
			elseif string_equality_tester.test (a_type.name, "signed long") then
				url := signed_long_url
			elseif string_equality_tester.test (a_type.name, "unsigned long") then
				url := unsigned_long_url
			elseif string_equality_tester.test (a_type.name, "short") then
				url := short_url
			elseif string_equality_tester.test (a_type.name, "signed short") then
				url := signed_short_url
			elseif string_equality_tester.test (a_type.name, "unsigned short") then
				url := unsigned_short_url
			elseif string_equality_tester.test (a_type.name, "char") then
				url := char_url
			elseif string_equality_tester.test (a_type.name, "signed char") then
				url := signed_char_url
			elseif string_equality_tester.test (a_type.name, "unsigned char") then
				url := unsigned_char_url
			elseif string_equality_tester.test (a_type.name, "double") then
				url := double_url
			elseif string_equality_tester.test (a_type.name, "float") then
				url := float_url
			elseif string_equality_tester.test (a_type.name, "void") then
				url := void_url
			else
				url := unknown_built_in_url
			end
			text_writer.put_link (url, a_type.name)
		end

	process_pointer_type (a_type: EWG_C_AST_POINTER_TYPE) is
		do
			text_writer.put_link (pointer_url, "pointer")
			text_writer.put_string (" to ")
			put_indefinite_article_for_type (a_type.base)
			text_writer.put_string (" ")
			a_type.base.process (Current)
		end

	process_array_type (a_type: EWG_C_AST_ARRAY_TYPE) is
		do
			text_writer.put_link (array_url, "array")
			text_writer.put_string (" (")
			if a_type.is_size_defined then
				text_writer.put_string ("of size ")
				text_writer.put_code (a_type.size)
			else
				text_writer.put_string ("of unknown size")
			end
			text_writer.put_string (") whose elements are of type ")
			a_type.base.process (Current)
		end

	process_const_type (a_type: EWG_C_AST_CONST_TYPE) is
		do
			text_writer.put_link (constant_url, "constant")
			text_writer.put_string (" ")
			a_type.base.process (Current)
		end

	process_alias_type (a_type: EWG_C_AST_ALIAS_TYPE) is
		do
			text_writer.put_code (a_type.name)
			text_writer.put_string (" which is an ")
			text_writer.put_link (typedef_url, "alias")
			text_writer.put_string (" I explained above")
		end

	process_enum_type (a_type: EWG_C_AST_ENUM_TYPE) is
		local
			cs: DS_ARRAYED_LIST_CURSOR [EWG_C_AST_DECLARATION]
		do
			text_writer.put_link (enum_url, "enum")
			text_writer.put_string (" ")
			if a_type.is_anonymous then
				text_writer.put_string ("which doesnt have a name (it may have an alias though)")
			else
				text_writer.put_string ("called ")
				text_writer.put_code (a_type.name)
			end
			text_writer.put_new_line
			if a_type.members = Void then
				text_writer.put_string ("The enumeration constants for this ")
				text_writer.put_link (enum_url, "enum")
				text_writer.put_string (" have not (yet?) been specified.")
			else
				text_writer.put_string ("Here are the enumeration constants defined for this ")
				text_writer.put_link (enum_url, "enum")
				text_writer.put_string (":")
				text_writer.begin_unordered_list
				from
					cs := a_type.members.new_cursor
					cs.start
				until
					cs.off
				loop
					text_writer.begin_list_item
					text_writer.put_string (cs.item.declarator)
					text_writer.end_list_item
					cs.forth
				end
				text_writer.end_unordered_list
			end
		end

	process_struct_type (a_type: EWG_C_AST_STRUCT_TYPE) is
		do
			text_writer.put_link (struct_url, "struct")
			text_writer.put_string (" ")
			if a_type.is_anonymous then
				text_writer.put_string ("which doesn't have a name (it may have an alias though) ")
			else
				text_writer.put_string ("called ")
				text_writer.put_code (a_type.name)
			end
			text_writer.put_new_line
		end

	process_union_type (a_type: EWG_C_AST_UNION_TYPE) is
		do
			text_writer.put_link (union_url, "union")
			text_writer.put_string (" ")
			if a_type.is_anonymous then
				text_writer.put_string ("which doesn't have a name (it may have an alias though)")
			else
				text_writer.put_string ("called ")
				text_writer.put_code (a_type.name)
			end
			text_writer.put_new_line
		end

	process_function_type (a_type: EWG_C_AST_FUNCTION_TYPE) is
		do
			text_writer.put_link (function_url, "function")
		end

	process_eiffel_object_type (a_type: EWG_C_AST_EIFFEL_OBJECT_TYPE) is
		do
				check
					dead_end: False
				end
		end

feature {NONE}

	typedef_url: STRING is "/drc/typedef.html"

	int_url: STRING is "/drc/int.html"

	signed_int_url: STRING is "/drc/signed_int.html"

	unsigned_int_url: STRING is "/drc/unsigned_int.html"

	long_url: STRING is "/drc/long.html"

	signed_long_url: STRING is "/drc/signed_long.html"

	unsigned_long_url: STRING is "/drc/unsigned_long.html"

	short_url: STRING is "/drc/short.html"

	signed_short_url: STRING is "/drc/signed_short.html"

	unsigned_short_url: STRING is "/drc/unsigned_short.html"

	char_url: STRING is "/drc/char.html"

	signed_char_url: STRING is "/drc/signed_char.html"

	unsigned_char_url: STRING is "/drc/unsigned_char.html"

	double_url: STRING is "/drc/double.html"

	float_url: STRING is "/drc/float.html"

	void_url: STRING is "/drc/void.html"

	unknown_built_in_url: STRING is "/drc/unknown_built_in.html"

	pointer_url: STRING is "/drc/pointer.html"

	array_url: STRING is "/drc/array.html"

	constant_url: STRING is "/drc/constant.html"

	struct_url: STRING is "/drc/struct.html"

	union_url: STRING is "/drc/union.html"

	enum_url: STRING is "/drc/enum.html"

	function_url: STRING is "/drc/function.html"

	function_declaration_url: STRING is "/drc/function_declaration.html"

feature {NONE}

	text_writer: DRC_FORMATTED_TEXT_WRITER

	put_indefinite_article_for_type (a_type: EWG_C_AST_TYPE) is
		require
			a_type_not_void: a_type /= Void
		do
			if starts_type_with_vovel (a_type) then
				text_writer.put_string ("an")
			else
				text_writer.put_string ("a")
			end
		end

	starts_type_with_vovel (a_type: EWG_C_AST_TYPE): BOOLEAN is
		require
			a_type_not_void: a_type /= Void
		do
			a_type.process (vovel_tester)
			Result := vovel_tester.last_type_started_with_vovel
		end

	vovel_tester: DRC_VOVEL_TESTER is
		once
			create Result.make
		ensure
			vovel_tester_not_void: Result /= Void
		end

invariant

	text_writer_not_void: text_writer /= Void

end
