indexing
	description: "Eiffel record generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_RECORD_EIFFEL_GENERATOR

inherit
	WIZARD_EIFFEL_WRITER_GENERATOR

	WIZARD_WRITER_FEATURE_CLAUSES
		export
			{NONE} all
		end

	WIZARD_RECORD_GENERATOR

	WIZARD_EIFFEL_ASSERTION_GENERATOR

feature -- Access

	generate (a_descriptor: WIZARD_RECORD_DESCRIPTOR) is
			-- Generate eiffel client for record.
		local
			a_macro_accesser_name, a_macro_setter_name: STRING
			writer_inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
			an_external_size_name: STRING
			a_record_name, a_header_file_name: STRING
			a_field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR
			a_visible: WIZARD_WRITER_VISIBLE_CLAUSE
		do
			create a_visible.make
			a_visible.set_name (a_descriptor.eiffel_class_name)
			a_visible.add_feature ("make")
			a_visible.add_feature ("make_from_pointer")
			a_visible.add_feature ("set_shared")
			a_visible.add_feature ("set_unshared")
			system_descriptor.add_visible_class_common (a_visible)

			create eiffel_writer.make

			eiffel_writer.set_class_name (a_descriptor.eiffel_class_name)
			eiffel_writer.set_description (a_descriptor.description)
			eiffel_writer.set_effective

			create writer_inherit_clause.make
			writer_inherit_clause.set_name (Ecom_structure)
			eiffel_writer.add_inherit_clause (writer_inherit_clause)

			eiffel_writer.add_creation_routine ("make")
			eiffel_writer.add_creation_routine ("make_from_pointer")

			eiffel_writer.add_feature (make_from_pointer_feature, Initialization)
			an_external_size_name := external_size_name (a_descriptor.name)
			eiffel_writer.add_feature (structure_size_feature (an_external_size_name), Measurement)
			eiffel_writer.add_feature (external_structure_size (an_external_size_name, a_descriptor), Externals)

			a_record_name := a_descriptor.name
			a_header_file_name := impl_header_file_name (a_descriptor.c_header_file_name)
			from
				a_descriptor.fields.start
			until
				a_descriptor.fields.after
			loop
				a_field_descriptor := a_descriptor.fields.item
				a_macro_accesser_name := macro_accesser_name (a_record_name, a_field_descriptor)
				a_macro_setter_name:= macro_setter_name (a_record_name, a_field_descriptor)

				eiffel_writer.add_feature (access_feature (a_macro_accesser_name, a_field_descriptor), Access)
				eiffel_writer.add_feature (set_feature (a_macro_setter_name, a_field_descriptor), Basic_operations)
				eiffel_writer.add_feature (access_external_feature 
						(a_macro_accesser_name, a_header_file_name, 
						a_descriptor.namespace + "::" + a_descriptor.c_type_name, a_field_descriptor), Externals)
				eiffel_writer.add_feature (set_external_feature 
						(a_macro_setter_name, a_header_file_name, 
						a_descriptor.namespace + "::" + a_descriptor.c_type_name, a_field_descriptor), Externals)

				a_descriptor.fields.forth
			end

		end

feature {NONE} -- Implementation

	make_from_pointer_feature: WIZARD_WRITER_FEATURE is
			-- Creatio feature.
		do
			create Result.make

			Result.set_name ("make_from_pointer")
			Result.set_effective
			Result.add_argument ("a_pointer: POINTER")
			Result.set_body ("%T%T%Tmake_by_pointer (a_pointer)")
			Result.set_comment ("Make from pointer.")
		end

	external_size_name (record_name: STRING): STRING is
			-- Name of external feature, returning size of structure.
		require
			non_void_name: record_name /= Void
			valid_name: not record_name.empty
		do
			create Result.make (100)

			Result.append ("c_size_of_")
			Result.append (name_for_feature (record_name))
			Result.to_lower
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.empty
		end

	access_feature (a_macro_accesser_name: STRING; 
					a_field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR) : WIZARD_WRITER_FEATURE is
			-- Access feature
		require
			non_void_accesser_name: a_macro_accesser_name /= Void
			valid_accesser_name: not a_macro_accesser_name.empty
			non_void_field_descriptor: a_field_descriptor /= Void
		local
			a_data_type_visitor: WIZARD_DATA_TYPE_VISITOR
			body: STRING
		do
			create Result.make

			Result.set_name (name_for_feature_with_keyword_check (a_field_descriptor.name))
			Result.set_comment (a_field_descriptor.description)

			a_data_type_visitor := a_field_descriptor.data_type.visitor 

			if not a_data_type_visitor.is_enumeration then
				Result.set_result_type (a_data_type_visitor.eiffel_type)
			else
				Result.set_result_type (Integer_type)
			end

			Result.set_effective

			create body.make (1000)

			-- Result := `a_macro_accesser_name' (item)

			body.append (tab_tab_tab)
			body.append (Result_keyword)
			body.append (Space)
			body.append (Assignment)
			body.append (Space)
			body.append (a_macro_accesser_name)
			body.append (Space)
			body.append (Open_parenthesis)
			body.append ("item")
			body.append (Close_parenthesis)

			Result.set_body (body)

			if 
				not a_data_type_visitor.is_structure_pointer and 
				not a_data_type_visitor.is_interface_pointer and
				not a_data_type_visitor.is_coclass_pointer 
			then
				generate_postcondition (name_for_feature (a_field_descriptor.name), a_field_descriptor.data_type, True)
				from
					assertions.start
				until
					assertions.after
				loop
					Result.add_postcondition (assertions.item)
					assertions.forth
				end
			end
		end

	set_feature (a_macro_setter_name: STRING; 
					a_field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR) : WIZARD_WRITER_FEATURE is
			-- Set feature
		require
			non_void_setter_name: a_macro_setter_name /= Void
			valid_setter_name: not a_macro_setter_name.empty
			non_void_field_descriptor: a_field_descriptor /= Void
		local
			a_data_type_visitor: WIZARD_DATA_TYPE_VISITOR
			body: STRING
			a_name: STRING
			a_comment: STRING
			a_local_var: STRING
			an_argument_name, an_argument: STRING
		do
			create Result.make
			create body.make (1000)

			create a_name.make (1000)
			a_name.append (name_for_feature_with_keyword_check ("set_" + a_field_descriptor.name))

			create an_argument_name.make (100)
			an_argument_name.append ("a_")
			an_argument_name.append (name_for_feature_with_keyword_check (a_field_descriptor.name))

			Result.set_name (a_name)

			a_data_type_visitor := a_field_descriptor.data_type.visitor 

			if a_data_type_visitor.is_array_basic_type then
				create a_local_var.make (100)
				a_local_var.append ("any: ANY")
				body.append (tab_tab_tab)
				body.append ("any := ")
				body.append (an_argument_name)
				body.append (Dot)
				body.append (To_c_function)
				body.append (New_line)
				Result.add_local_variable (a_local_var)
			end

			create an_argument.make (100)
			an_argument.append (an_argument_name)
			an_argument.append (Colon)
			an_argument.append (Space)
			an_argument.append (a_data_type_visitor.eiffel_type)
		
			Result.add_argument (an_argument)

			create a_comment.make (100)
			a_comment.append ("Set ")
			a_comment.append (Back_quote)
			a_comment.append (name_for_feature_with_keyword_check (a_field_descriptor.name))
			a_comment.append (Single_quote)
			a_comment.append (Space)
			a_comment.append ("with")
			a_comment.append (Space)
			a_comment.append (Back_quote)
			a_comment.append (an_argument_name)
			a_comment.append (Single_quote)
			a_comment.append (Dot)

			Result.set_comment (a_comment)

			Result.set_effective


			-- `a_macro_setter_name' (item, `an_argument_name')

			body.append (tab_tab_tab)
			body.append (a_macro_setter_name)
			body.append (Space)
			body.append (Open_parenthesis)
			body.append ("item")
			body.append (Comma_space)

			if a_data_type_visitor.is_array_basic_type then
				body.append (Dollar)
				body.append ("any")

			elseif 
				a_data_type_visitor.is_interface_pointer or
				a_data_type_visitor.is_coclass_pointer or
				a_data_type_visitor.is_structure_pointer or 
				a_data_type_visitor.is_structure 
			then
				body.append (an_argument_name)
				body.append (Dot)
				body.append ("item")

			else
				body.append (an_argument_name)

			end

			body.append (Close_parenthesis)

			Result.set_body (body)

			generate_precondition (an_argument_name, a_field_descriptor.data_type, True, False)
			from
				assertions.start
			until
				assertions.after
			loop
				Result.add_precondition (assertions.item)
				assertions.forth
			end

		end

	access_external_feature (a_macro_accesser_name, a_header_file_name, c_record_name: STRING;
				a_field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- External access feature
		require
			non_void_macro_accesser_name: a_macro_accesser_name /= Void
			valid_macro_accesser_name: not a_macro_accesser_name.empty
			non_void_header_file_name: a_header_file_name /= Void
			valid_header_file_name: not a_header_file_name.empty
			non_void_field_descriptor: a_field_descriptor /= Void
		local
			body: STRING
			a_data_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make
			Result.set_external

			Result.set_name (a_macro_accesser_name)

			Result.add_argument (Pointer_variable)

			a_data_visitor := a_field_descriptor.data_type.visitor 

			Result.set_result_type (a_data_visitor.eiffel_type)

			create body.make (1000)
			body.append (tab_tab_tab)
			body.append (Double_quote)
			body.append ("C++")
			body.append (Space)
			body.append (Open_bracket)
			body.append ("macro")
			body.append (Space)
			body.append (Percent_double_quote)
			body.append (a_header_file_name)
			body.append (Percent_double_quote)
			body.append (Close_bracket)
			body.append (Open_parenthesis)
			body.append (c_record_name)
			body.append (Space)
			body.append (Asterisk)
			body.append (Close_parenthesis)
			body.append (Colon)

			if a_data_visitor.is_basic_type or (a_data_visitor.vt_type = Vt_bool) then
				body.append (a_data_visitor.cecil_type)
			else
				body.append (Eif_reference)
			end
			body.append (Double_quote)

			Result.set_body (body)
			Result.set_comment (a_field_descriptor.description)
		ensure
			non_void_writer_feature: Result /= Void
		end

	set_external_feature (a_macro_setter_name, a_header_file_name, c_record_name: STRING;
				a_field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- External set feature
		require
			non_void_macro_setter_name: a_macro_setter_name /= Void
			valid_macro_setter_name: not a_macro_setter_name.empty
			non_void_header_file_name: a_header_file_name /= Void
			valid_header_file_name: not a_header_file_name.empty
			non_void_field_descriptor: a_field_descriptor /= Void
		local
			body: STRING
			a_data_visitor: WIZARD_DATA_TYPE_VISITOR
			an_argument: STRING
		do
			create Result.make
			Result.set_external

			Result.set_name (a_macro_setter_name)
			Result.add_argument (Pointer_variable)

			a_data_visitor := a_field_descriptor.data_type.visitor 

			create an_argument.make (100)
			an_argument.append ("arg2")
			an_argument.append (Colon)
			an_argument.append (Space)

			create body.make (1000)
			body.append (tab_tab_tab)
			body.append (Double_quote)
			body.append ("C++")
			body.append (Space)
			body.append (Open_bracket)
			body.append ("macro")
			body.append (Space)
			body.append (Percent_double_quote)
			body.append (a_header_file_name)
			body.append (Percent_double_quote)
			body.append (Close_bracket)
			body.append (Open_parenthesis)
			body.append (c_record_name)
			body.append (Space)
			body.append (Asterisk)
			body.append (Comma)
			body.append (Space)

			if a_data_visitor.is_basic_type then
				an_argument.append (a_data_visitor.eiffel_type)
				body.append (a_data_visitor.c_type)

			elseif a_data_visitor.vt_type = Vt_bool then
				an_argument.append (a_data_visitor.eiffel_type)
				body.append (a_data_visitor.cecil_type)

			elseif a_data_visitor.is_array_basic_type then
				an_argument.append (Pointer_type)
				body.append (Eif_pointer)

			elseif a_data_visitor.is_enumeration then
				an_argument.append (Integer_type)
				body.append (a_data_visitor.c_type)

			elseif 
				a_data_visitor.is_interface or 
				a_data_visitor.is_interface_pointer or 
				a_data_visitor.is_coclass or 
				a_data_visitor.is_coclass_pointer or 
				a_data_visitor.is_structure or 
				a_data_visitor.is_structure_pointer 
			then
				an_argument.append (Pointer_type)
				body.append (a_data_visitor.c_type)
				if a_data_visitor.is_structure or a_data_visitor.is_interface then
					body.append (Space)
					body.append (Asterisk)
				end

			else
				an_argument.append (a_data_visitor.eiffel_type)
				body.append (Eif_object)
			end

			Result.add_argument (an_argument)

			body.append (Close_parenthesis)
			body.append (Double_quote)

			Result.set_body (body)
			Result.set_comment (a_field_descriptor.description)
			
		ensure
			non_void_writer_feature: Result /= Void
		end

	structure_size_feature (an_external_size_name: STRING): WIZARD_WRITER_FEATURE is
			-- Feature `structure-size'.
		require
			non_void_name: an_external_size_name /= Void
			valid_name: not an_external_size_name.empty
		local
			body: STRING
		do
			create Result.make
			Result.set_effective

			Result.set_name ("structure_size")
			Result.set_result_type (Integer_type)
			Result.set_comment ("Size of structure")

			create body.make (1000)

			body.append (tab_tab_tab)
			body.append (Result_keyword)
			body.append (Space)
			body.append (Assignment)
			body.append (Space)
			body.append (an_external_size_name)
			Result.set_body (body)
		ensure
			non_void_writer_feature: Result /= Void
		end

	external_structure_size (an_external_size_name: STRING;
				a_descriptor: WIZARD_RECORD_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- External feature, describing structure size.
		require
			non_void_name: an_external_size_name /= Void
			valid_name: not an_external_size_name.empty
			non_void_descriptor: a_descriptor /= Void
		local
			body: STRING
		do
			create Result.make
			Result.set_external

			Result.set_name (an_external_size_name)
			Result.set_result_type (Integer_type)

			create body.make (1000)
			body.append (tab_tab_tab)
			body.append (Double_quote)
			body.append ("C")
			body.append (Space)
			body.append (Open_bracket)
			body.append ("macro")
			body.append (Space)
			body.append (Percent_double_quote)
			body.append (a_descriptor.c_header_file_name)
			body.append (Percent_double_quote)
			body.append (Close_bracket)
			body.append (Double_quote)
			body.append (New_line_tab_tab)
			body.append (Alias_keyword)
			body.append (New_line_tab_tab_tab)
			body.append (Double_quote)
			body.append (Sizeof)
			body.append (Open_parenthesis)
			body.append (a_descriptor.namespace)
			body.append (colon + colon)
			body.append (a_descriptor.c_type_name)
			body.append (Close_parenthesis)
			body.append (Double_quote)

			Result.set_body (body)

			Result.set_comment ("Size of structure")
		ensure
			non_void_writer_feature: Result /= Void
		end

end -- class WIZARD_RECORD_EIFFEL_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

