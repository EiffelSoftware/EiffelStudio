indexing

	description:

		"Generate HTML code explaining C declarations (verbose version)"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class DRC_PROCESSOR

inherit

	DRC_SHORT_PROCESSOR
		rename
			make as make_short_processor
		redefine
			process_const_type,
			process_pointer_type,
			process_primitive_type,
			process_array_type,
			process_alias_type,
			process_enum_type,
			process_union_type,
			process_struct_type,
			process_function_type
		end

	EWG_C_AST_DECLARATION_NULL_PROCESSOR
		rename
			make as make_declaration_null_processor
		redefine
			process_typedef_declaration,
			process_function_declaration,
			process_variable_declaration,
			process_type_declaration
		end

create

	make

feature {NONE} -- Initialization

	make (a_text_writer: like text_writer) is
		require
			a_text_writer_not_void: a_text_writer /= Void
		do
			make_declaration_null_processor
			make_short_processor (a_text_writer)
			create types_already_explained.make
		ensure
			text_writer_set: text_writer = a_text_writer
		end

feature

	process_primitive_type (a_type: EWG_C_AST_PRIMITIVE_TYPE) is
		do
			Precursor (a_type)
			types_already_explained.put_last (a_type)
		end

	process_pointer_type (a_type: EWG_C_AST_POINTER_TYPE) is
		do
			Precursor (a_type)
			types_already_explained.put_last (a_type)
		end

	process_array_type (a_type: EWG_C_AST_ARRAY_TYPE) is
		do
			Precursor (a_type)
			types_already_explained.put_last (a_type)
		end

	process_const_type (a_type: EWG_C_AST_CONST_TYPE) is
		do
			Precursor (a_type)
			types_already_explained.put_last (a_type)
		end

	process_alias_type (a_type: EWG_C_AST_ALIAS_TYPE) is
		do
			Precursor (a_type)
			types_already_explained.put_last (a_type)
		end

	process_enum_type (a_type: EWG_C_AST_ENUM_TYPE) is
		do
			Precursor (a_type)
			types_already_explained.put_last (a_type)
		end

	process_struct_type (a_type: EWG_C_AST_STRUCT_TYPE) is
		do
			Precursor (a_type)
			if not types_already_explained.has (a_type) then
				types_already_explained.put_last (a_type)
				if a_type.members = Void then
					text_writer.put_string ("The fields for this ")
					text_writer.put_link (struct_url, "struct")
					text_writer.put_string (" have not (yet?) been specified.")
				else
					text_writer.put_string ("Here is the list of fields of this ")
					text_writer.put_link (struct_url, "struct")
					text_writer.put_string (":")
					process_members (a_type)
				end
			end
		end

	process_union_type (a_type: EWG_C_AST_UNION_TYPE) is
		do
			Precursor (a_type)
			if not types_already_explained.has (a_type) then
				types_already_explained.put_last (a_type)
				if a_type.members = Void then
					text_writer.put_string ("The fields for this ")
					text_writer.put_link (union_url, "union")
					text_writer.put_string (" have not (yet?) been specified.")
				else
					text_writer.put_string ("Here is a list of the components of this ")
					text_writer.put_link (union_url, "union")
					text_writer.put_string (":")
					process_members (a_type)
				end
			end
		end

	process_function_type (a_type: EWG_C_AST_FUNCTION_TYPE) is
		do
			Precursor (a_type)
			if not types_already_explained.has (a_type) then
				types_already_explained.put_last (a_type)
				process_function_signature (a_type)
			end
		end

feature

	process_typedef_declaration (a_base_type: EWG_C_AST_TYPE; a_alias: STRING) is
		do
			types_already_explained.wipe_out

			text_writer.begin_paragraph
			text_writer.put_string ("I found a ")
			text_writer.put_link (typedef_url, "typedef")
			text_writer.put_string (".")
			text_writer.put_new_line

			text_writer.put_string ("The ")
			text_writer.put_emphasized ("alias")
			text_writer.put_string (" name is ")
			text_writer.put_code (a_alias)
			text_writer.put_string (".")
			text_writer.put_new_line

			text_writer.put_string ("Thus the ")
			text_writer.put_emphasized ("identifier")
			text_writer.put_string (" ")
			text_writer.put_code (a_alias)
			text_writer.put_string (" stands for ")
			put_indefinite_article_for_type (a_base_type)
			text_writer.put_string (" ")
			a_base_type.process (Current)
			text_writer.put_string (".")
			text_writer.end_paragraph
		end

	process_function_declaration (a_function_type: EWG_C_AST_FUNCTION_TYPE; a_name: STRING) is
		do
			types_already_explained.wipe_out
			text_writer.begin_paragraph
			text_writer.put_string ("I found a ")
			text_writer.put_link (function_declaration_url, "function declaration")
			text_writer.put_string (".")
			text_writer.put_new_line

			text_writer.put_string ("The ")
			text_writer.put_link (function_url, "function")
			text_writer.put_string (" is called ")
			text_writer.put_code (a_name)
			text_writer.put_string (".")
			text_writer.put_new_line
			process_function_signature (a_function_type)
			text_writer.end_paragraph

			types_already_explained.wipe_out
		end

	process_variable_declaration (a_type: EWG_C_AST_TYPE; a_name: STRING) is
		do
			types_already_explained.wipe_out
			text_writer.begin_paragraph
			text_writer.put_string ("I found a variable declaration.")
			text_writer.put_new_line
			text_writer.put_string ("The ")
			text_writer.put_emphasized ("name")
			text_writer.put_string (" of the variable is ")
			text_writer.put_code (a_name)
			text_writer.put_string (" and its type is ")
			put_indefinite_article_for_type (a_type)
			text_writer.put_string (" ")
			a_type.process (Current)
			text_writer.put_string (".")
			text_writer.end_paragraph
		end

	process_type_declaration (a_type: EWG_C_AST_TYPE) is
		do
			types_already_explained.wipe_out
			text_writer.begin_paragraph
			text_writer.put_string ("I found the declaration of a type.")
			text_writer.put_new_line
			text_writer.put_string ("The type is ")
			put_indefinite_article_for_type (a_type)
			text_writer.put_string (" ")
			a_type.process (Current)
			text_writer.put_string (".")
			text_writer.end_paragraph
		end

feature {NONE}

	process_function_signature (a_type: EWG_C_AST_FUNCTION_TYPE) is
		local
			cs: DS_ARRAYED_LIST_CURSOR [EWG_C_AST_DECLARATION]
		do
			text_writer.put_new_line
			if a_type.return_type = c_system.types.void_type then
				text_writer.put_string ("The function doesnt have a return value.")
			else
				text_writer.put_string ("The function's return type is ")
				put_indefinite_article_for_type (a_type)
				text_writer.put_string (" ")
				a_type.return_type.process (Current)
			end
			text_writer.put_new_line
			if a_type.members.count = 0 then
				text_writer.put_string ("It doesn't have any parameter (or it allows for arbitrary parameters, I cannot tell the difference yet).")
				text_writer.put_new_line
			else
				text_writer.put_string ("It has the following parameters:")
				text_writer.put_new_line
				text_writer.begin_unordered_list
				from
					cs := a_type.members.new_cursor
					cs.start
				until
					cs.off
				loop
					text_writer.begin_list_item
					if cs.item.is_anonymous then
						text_writer.put_string ("Anonymous parameter of type ")
					else
						text_writer.put_string ("Parameter named ")
						text_writer.put_code (cs.item.declarator)
						text_writer.put_string (" of type ")
					end
					cs.item.type.process (Current)
					text_writer.end_list_item
					cs.forth
				end
				text_writer.end_unordered_list
			end
		end

	process_members (a_type: EWG_C_AST_COMPOSITE_TYPE) is
		require
			a_type_not_void: a_type /= Void
			members_not_void: a_type.members /= Void
		local
			cs: DS_ARRAYED_LIST_CURSOR [EWG_C_AST_DECLARATION]
		do
			text_writer.begin_unordered_list
			from
				cs := a_type.members.new_cursor
				cs.start
			until
				cs.off
			loop
				text_writer.begin_list_item
				if cs.item.is_anonymous then
					text_writer.put_string ("Anonymous component of type ")
				else
					text_writer.put_string ("Component named ")
					text_writer.put_code (cs.item.declarator)
					text_writer.put_string (" of type ")
				end
				cs.item.type.process (Current)
				text_writer.end_list_item
				cs.forth
			end
			text_writer.end_unordered_list
		end

feature {NONE}

	types_already_explained: DS_LINKED_LIST [EWG_C_AST_TYPE]

invariant

	types_already_explained_not_void: types_already_explained /= Void
	types_already_explained_not_has_void: not types_already_explained.has (Void)

end
