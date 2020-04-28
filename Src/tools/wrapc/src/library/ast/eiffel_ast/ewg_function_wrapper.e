note

	description:

		"Objects which wrap C function declarations"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_FUNCTION_WRAPPER

inherit

	EWG_CALLABLE_WRAPPER
		rename
			make as make_callable_wrapper
		end

	EWG_ABSTRACT_DECLARATION_WRAPPER
		rename
			make as make_abstract_wrapper
		end

create

	make

feature {NONE} -- Initialization

	make (a_mapped_eiffel_name: STRING;
			a_header_file_name: STRING;
			a_function_declaration: EWG_C_AST_FUNCTION_DECLARATION;
			a_members: like members;
			a_class_name: STRING)
		require
			a_mapped_eiffel_name_not_void: a_mapped_eiffel_name /= Void
			a_mapped_eiffel_name_not_empty: not a_mapped_eiffel_name.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
			a_function_declaration_not_void: a_function_declaration /= Void
			a_members_not_void: a_members /= Void
			a_class_name_not_void: a_class_name /= Void
			a_class_name_not_empty: a_class_name.count > 0
		do
			function_declaration := a_function_declaration
			class_name := a_class_name
			make_callable_wrapper (a_mapped_eiffel_name, a_header_file_name, a_members)
		ensure
			mapped_eiffel_name_set: mapped_eiffel_name = a_mapped_eiffel_name
			header_file_name_set: header_file_name = a_header_file_name
			function_declaration_set: function_declaration = a_function_declaration
			members_set: members = a_members
			class_name_set: class_name = a_class_name
		end

feature

	function_declaration: EWG_C_AST_FUNCTION_DECLARATION
			-- Function declaration to wrap

	declaration: EWG_C_AST_DECLARATION
		do
			Result := function_declaration
		end

	class_name: STRING
			-- Name of Eiffel class the wrappers for this function should be placed in

invariant

	function_declaration_not_void: function_declaration /= Void
	class_name_not_void: class_name /= Void
	class_name_not_empty: class_name.count > 0
	class_name_valid_eiffel_identifier: True -- TODO

end
