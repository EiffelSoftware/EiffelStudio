indexing
	description: "External AST node factories"
	status: "See notice at the end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_FACTORY

feature -- High level Factories

	new_c_extension_as (sig: SIGNATURE_AS; use_list: USE_LIST_AS): C_EXTENSION_AS is
			-- New C_EXTENSION_AS node.
		do
			create Result
			Result.initialize (sig, use_list)
		end

	new_cpp_extension_as (type: INTEGER; base_class: ID_AS; sig: SIGNATURE_AS; use_list: USE_LIST_AS): CPP_EXTENSION_AS is
			-- New CPP_EXTENSION_AS node.
		do
			create Result
			Result.initialize (type, base_class, sig, use_list)
		end

	new_struct_extension_as (name, field_name: ID_AS; type: EXTERNAL_TYPE_AS;
				use_list: USE_LIST_AS; is_cpp: BOOLEAN): STRUCT_EXTENSION_AS is
			-- New STRUCT_EXTENSION_AS node.
		do
			create Result.make (is_cpp)
			Result.initialize (name, field_name, type, use_list)
		end

	new_macro_extension_as (sig: SIGNATURE_AS; use_list: USE_LIST_AS; is_cpp: BOOLEAN): MACRO_EXTENSION_AS is
			-- New MACRO_EXTENSION_AS node.
		do
			create Result.make (is_cpp)
			Result.initialize (sig, use_list)
		end

	new_inline_as: EXTERNAL_EXTENSION_AS is
		do
		end

	new_il_extension_as (language_type, type: INTEGER; sig: SIGNATURE_AS; base_class: ID_AS): IL_EXTENSION_AS is
			-- New IL_EXTENSION_AS node.
		do
			create Result
			Result.initialize (language_type, type, sig, base_class)
		end

feature -- Low level factories

	new_signature_as (args: EIFFEL_LIST [EXTERNAL_TYPE_AS]; return_type: EXTERNAL_TYPE_AS): SIGNATURE_AS is
			-- New SIGNATURE_AS node.
		do
			create Result
			Result.initialize (args, return_type)
		end

	new_eiffel_list_external_type_as (n: INTEGER): EIFFEL_LIST [EXTERNAL_TYPE_AS] is
			-- New EIFFEL_LIST [EXTERNAL_TYPE_AS] node.
		do
			create Result.make (n)
		ensure
			Result_not_void: Result /= Void
		end

	new_use_list_as (n: INTEGER): USE_LIST_AS is
			-- New USE_LIST_AS node.
		do
			create Result.make (n)
		ensure
			Result_not_void: Result /= Void
		end

	new_external_type_as (id: ID_AS; is_struct, is_pointer, is_byref, is_enum: BOOLEAN): EXTERNAL_TYPE_AS is
			-- New EXTERNAL_TYPE_AS node.
		require
			id_not_void: id /= Void
		do
			create Result
			Result.initialize (id, is_struct, is_pointer, is_byref, is_enum)
		ensure
			Result_not_void: Result /= Void
		end

	new_double_quote_id_as (s: STRING): ID_AS is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			s.prepend_character ('%"')
			s.append_character ('%"')
			create Result.initialize (s)
		ensure
			id_as_not_void: Result /= Void
		end

	new_system_id_as (s: STRING): ID_AS is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			s.prepend_character ('<')
			s.append_character ('>')
			create Result.initialize (s)
		ensure
			id_as_not_void: Result /= Void
		end

	new_id_as (s: STRING): ID_AS is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			create Result.initialize (s)
		ensure
			id_as_not_void: Result /= Void
		end

end -- class EXTERNAL_FACTORY

--|----------------------------------------------------------------
--| Copyright (C), Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
