indexing
	description: "Alias Eiffel generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_ALIAS_EIFFEL_GENERATOR

inherit
	WIZARD_EIFFEL_WRITER_GENERATOR

	WIZARD_DATA_VISITOR

	WIZARD_WRITER_FEATURE_CLAUSES
		export
			{NONE} all
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

feature -- Basic Operations

	generate (alias_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
			-- process alias
			-- generate code for alias described in `alias_descriptor'
			-- derived class in Eiffel
		local
			a_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			a_visible: WIZARD_WRITER_VISIBLE_CLAUSE
		do
			create eiffel_writer.make

			eiffel_writer.set_class_name (alias_descriptor.eiffel_class_name)
			eiffel_writer.set_description (alias_descriptor.description)
			eiffel_writer.set_effective

			a_data_type_descriptor := alias_descriptor.type_descriptor
			visit (a_data_type_descriptor)

			if not no_need_create_class then
				create a_visible.make
				a_visible.set_name (alias_descriptor.eiffel_class_name)
				a_visible.add_feature ("make_from_other")
				system_descriptor.add_visible_class_common (a_visible)
			end
		ensure then
	--		non_void_eiffel_writer: not no_need_create_class implies eiffel_writer /= Void
		end

feature -- Processing

	process_safearray_data_type (a_safearray_descriptor: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR) is
			-- Process SAFEARRAY
		local
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
			writer_feature: WIZARD_WRITER_FEATURE
			a_data_type_visitor: WIZARD_DATA_TYPE_VISITOR
			an_eiffel_type: STRING
		do
			a_data_type_visitor := a_safearray_descriptor.visitor
			an_eiffel_type := clone (a_data_type_visitor.eiffel_type)

			create inherit_clause.make
			inherit_clause.set_name (an_eiffel_type)

			eiffel_writer.add_inherit_clause (inherit_clause)

			eiffel_writer.add_creation_routine ("make")
			eiffel_writer.add_creation_routine ("make_from_array")
			eiffel_writer.add_creation_routine ("make_from_alias")

			writer_feature := create_from_ecom_array (an_eiffel_type)
			eiffel_writer.add_feature (writer_feature, Initialization)
		end

	process_automation_data_type (an_automation_descriptor: WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR) is
			-- Process Automation Data Type
		local
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
			writer_feature: WIZARD_WRITER_FEATURE
			a_data_type_visitor: WIZARD_DATA_TYPE_VISITOR
			a_type: INTEGER
			a_warning: STRING
		do
			create inherit_clause.make

			a_data_type_visitor := an_automation_descriptor.visitor

			a_type := a_data_type_visitor.vt_type

			create inherit_clause.make
			inherit_clause.set_name (a_data_type_visitor.eiffel_type)

			eiffel_writer.add_inherit_clause (inherit_clause)

			if a_data_type_visitor.is_structure then
				eiffel_writer.add_creation_routine ("make")
				eiffel_writer.add_creation_routine ("make_by_pointer")
				eiffel_writer.add_creation_routine ("make_from_alias")
				writer_feature := create_from_structure (a_data_type_visitor.eiffel_type)
				eiffel_writer.add_feature (writer_feature, Initialization)

			elseif a_data_type_visitor.is_basic_type or a_type = Vt_bool then
				eiffel_writer := Void
				no_need_create_class := True

			elseif a_type = Vt_bstr or a_type = Vt_lpstr or a_type = Vt_lpwstr then
				eiffel_writer.add_creation_routine ("make")
				eiffel_writer.add_creation_routine ("make_from_string")
				eiffel_writer.add_creation_routine ("make_from_alias")
				writer_feature := create_from_string (a_data_type_visitor.eiffel_type)
				eiffel_writer.add_feature (writer_feature, Initialization)

			else
				create a_warning.make (500)
				a_warning.append (message_output.Non_supported_alias)
				a_warning.append (Space)
				a_warning.append (a_data_type_visitor.eiffel_type)
				message_output.add_warning (Current, a_warning)

			end
		end
		
	process_array_data_type (an_array_descriptor: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR) is
			-- Process Array
		local
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
			writer_feature: WIZARD_WRITER_FEATURE
			a_data_type_visitor: WIZARD_DATA_TYPE_VISITOR
			an_eiffel_type: STRING
		do
			a_data_type_visitor := an_array_descriptor.visitor
			an_eiffel_type := clone (a_data_type_visitor.eiffel_type)

			create inherit_clause.make
			inherit_clause.set_name (an_eiffel_type)

			eiffel_writer.add_inherit_clause (inherit_clause)

			eiffel_writer.add_creation_routine ("make")
			eiffel_writer.add_creation_routine ("make_from_array")
			eiffel_writer.add_creation_routine ("make_from_alias")


			if an_array_descriptor.dimension_count = 1 then
				writer_feature := create_from_array (an_eiffel_type)
			else
				writer_feature := create_from_ecom_array (an_eiffel_type)
			end

			eiffel_writer.add_feature (writer_feature, Initialization)

		end

	process_user_defined_data_type (a_user_defined_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR) is
			-- Process User Defined Data Type
		local
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
			writer_feature: WIZARD_WRITER_FEATURE
			a_data_type_visitor: WIZARD_DATA_TYPE_VISITOR
			an_eiffel_type: STRING
		do
			a_data_type_visitor := a_user_defined_descriptor.visitor
			an_eiffel_type := clone (a_data_type_visitor.eiffel_type)

			create inherit_clause.make
			inherit_clause.set_name (a_data_type_visitor.eiffel_type)
			eiffel_writer.add_inherit_clause (inherit_clause)	

			if a_data_type_visitor.is_structure then
				eiffel_writer.add_creation_routine ("make")
				eiffel_writer.add_creation_routine ("make_by_pointer")
				eiffel_writer.add_creation_routine ("make_from_alias")
				writer_feature := create_from_structure (an_eiffel_type)
				eiffel_writer.add_feature (writer_feature, Initialization)

			elseif a_data_type_visitor.is_interface then
				eiffel_writer.add_creation_routine ("make_from_pointer")
				eiffel_writer.add_creation_routine ("make_from_other")
				eiffel_writer.add_creation_routine ("make_from_alias")
				writer_feature := create_from_interface (an_eiffel_type)
				eiffel_writer.add_feature (writer_feature, Initialization)

			elseif a_data_type_visitor.is_enumeration then

			else
				message_output.add_warning (Current, message_output.Non_supported_alias)

			end
		end

	process_pointed_data_type (a_pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR) is
			-- Process pointed Data Type
		local
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
			writer_feature: WIZARD_WRITER_FEATURE
			a_data_type_visitor: WIZARD_DATA_TYPE_VISITOR
			an_eiffel_type: STRING
		do
			a_data_type_visitor := a_pointed_descriptor.visitor
			an_eiffel_type := clone (a_data_type_visitor.eiffel_type)

			create inherit_clause.make
			inherit_clause.set_name (an_eiffel_type)
			eiffel_writer.add_inherit_clause (inherit_clause)

			eiffel_writer.add_creation_routine ("make_from_alias")

			if a_data_type_visitor.is_basic_type then
				eiffel_writer := Void
				no_need_create_class := True

			elseif a_data_type_visitor.is_basic_type_ref then
				eiffel_writer.add_creation_routine ("default_create")
				writer_feature := create_from_basic_type_ref (an_eiffel_type)

			elseif a_data_type_visitor.is_structure_pointer then
				eiffel_writer.add_creation_routine ("make")
				eiffel_writer.add_creation_routine ("make_by_pointer")
				writer_feature := create_from_structure (an_eiffel_type)

			elseif 
				a_data_type_visitor.is_interface_pointer or 
				a_data_type_visitor.is_coclass_pointer 
			then
				eiffel_writer.add_creation_routine ("make_from_pointer")
				eiffel_writer.add_creation_routine ("make_from_other")
				writer_feature := create_from_interface (an_eiffel_type)

			else
				eiffel_writer.add_creation_routine ("put")
				writer_feature := create_from_array (an_eiffel_type)

			end
			if not no_need_create_class then
				eiffel_writer.add_feature (writer_feature, Initialization)
			end
		end

feature {NONE} -- Implementation

	no_need_create_class: BOOLEAN
			-- Is it true that we should not create Eiffel class?

	create_from_ecom_array (an_eiffel_type: STRING): WIZARD_WRITER_FEATURE is
			-- Creation procedure, make from ECOM_ARRAY
		require
			non_void_eiffel_type: an_eiffel_type /= Void
			valid_eiffel_type: not an_eiffel_type.is_empty
		local
			argument, body: STRING
			assertion: WIZARD_WRITER_ASSERTION
		do
			create Result.make

			Result.set_name ("make_from_alias")

			create argument.make (50)
			argument.append ("an_alias")
			argument.append (Colon)
			argument.append (Space)
			argument.append (an_eiffel_type)
			Result.add_argument (argument)

			Result.set_comment ("Create from alias")

			create assertion.make ("non_void_alias", "an_alias /= Void")
			Result.add_precondition (assertion)

			create body.make (200)

			body.append (tab_tab_tab)
			body.append ("make_from_array")
			body.append (Space)
			body.append (Open_parenthesis)
			body.append ("an_alias")
			body.append (Comma)
			body.append (Space)
			body.append ("an_alias")
			body.append (Dot)
			body.append ("dimension_count")
			body.append (Comma)
			body.append (Space)
			body.append ("an_alias")
			body.append (Dot)
			body.append ("lower_indices")
			body.append (Comma)
			body.append (Space)
			body.append ("an_alias")
			body.append (Dot)
			body.append ("element_counts")
			body.append (Close_parenthesis)

			Result.set_body (body)

			create assertion.make ("valid_dimension_count", 
						"dimension_count = an_alias.dimension_count")
			Result.add_postcondition (assertion)

			create assertion.make ("valid_lower_indices",
						"lower_indices.is_equal (an_alias.lower_indices)")
			Result.add_postcondition (assertion)

			create assertion.make ("valid_element_counts",
						"element_counts.is_equal (an_alias.element_counts)")
			Result.add_postcondition (assertion)
		ensure
			non_void_writer_feature: Result /= Void
		end

	create_from_array (an_eiffel_type: STRING): WIZARD_WRITER_FEATURE is
			-- Creation procedure, make from ARRAY
		require
			non_void_eiffel_type: an_eiffel_type /= Void
			valid_eiffel_type: not an_eiffel_type.is_empty
		local
			argument, body: STRING
			assertion: WIZARD_WRITER_ASSERTION
		do
			create Result.make

			Result.set_name ("make_from_alias")

			create argument.make (50)
			argument.append ("an_alias")
			argument.append (Colon)
			argument.append (Space)
			argument.append (an_eiffel_type)
			Result.add_argument (argument)

			Result.set_comment ("Create from alias")

			create assertion.make ("non_void_alias", "an_alias /= Void")
			Result.add_precondition (assertion)

			create body.make (100)

			body.append (tab_tab_tab)
			body.append ("make_from_array")
			body.append (Space)
			body.append (Open_parenthesis)
			body.append ("an_alias")
			body.append (Close_parenthesis)

			Result.set_body (body)
		ensure
			non_void_writer_feature: Result /= Void
		end

	create_from_cell (an_eiffel_type: STRING): WIZARD_WRITER_FEATURE is
			-- Creation procedure, make from CELL
		require
			non_void_eiffel_type: an_eiffel_type /= Void
			valid_eiffel_type: not an_eiffel_type.is_empty
		local
			argument, body: STRING
			assertion: WIZARD_WRITER_ASSERTION
		do
			create Result.make

			Result.set_name ("make_from_alias")

			create argument.make (50)
			argument.append ("an_alias")
			argument.append (Colon)
			argument.append (Space)
			argument.append (an_eiffel_type)
			Result.add_argument (argument)

			Result.set_comment ("Create from alias")

			create assertion.make ("non_void_alias", "an_alias /= Void")
			Result.add_precondition (assertion)

			create body.make (100)

			body.append (tab_tab_tab)
			body.append ("put")
			body.append (Space)
			body.append (Open_parenthesis)
			body.append ("an_alias")
			body.append (Dot)
			body.append ("item")
			body.append (Close_parenthesis)
			Result.set_body (body)
		ensure
			non_void_writer_feature: Result /= Void
		end

	create_from_basic_type_ref (an_eiffel_type: STRING): WIZARD_WRITER_FEATURE is
			-- Creation procedure, make from CELL
		require
			non_void_eiffel_type: an_eiffel_type /= Void
			valid_eiffel_type: not an_eiffel_type.is_empty
		local
			argument, body: STRING
			assertion: WIZARD_WRITER_ASSERTION
		do
			create Result.make

			Result.set_name ("make_from_alias")

			create argument.make (50)
			argument.append ("an_alias")
			argument.append (Colon)
			argument.append (Space)
			argument.append (an_eiffel_type)
			Result.add_argument (argument)

			Result.set_comment ("Create from alias")

			create assertion.make ("non_void_alias", "an_alias /= Void")
			Result.add_precondition (assertion)

			create body.make (100)

			body.append (tab_tab_tab)
			body.append ("set_item")
			body.append (Space)
			body.append (Open_parenthesis)
			body.append ("an_alias")
			body.append (Dot)
			body.append ("item")
			body.append (Close_parenthesis)

			Result.set_body (body)
		ensure
			non_void_writer_feature: Result /= Void
		end

	create_from_interface (an_eiffel_type: STRING): WIZARD_WRITER_FEATURE is
			-- Creation procedure, make from Interface
		require
			non_void_eiffel_type: an_eiffel_type /= Void
			valid_eiffel_type: not an_eiffel_type.is_empty
		local
			argument, body: STRING
			assertion: WIZARD_WRITER_ASSERTION
		do
			create Result.make

			Result.set_name ("make_from_alias")

			create argument.make (50)
			argument.append ("an_alias")
			argument.append (Colon)
			argument.append (Space)
			argument.append (an_eiffel_type)
			Result.add_argument (argument)

			Result.set_comment ("Create from alias")

			create assertion.make ("non_void_alias", "an_alias /= Void")
			Result.add_precondition (assertion)

			create body.make (100)

			body.append (tab_tab_tab)
			body.append ("make_from_pointer")
			body.append (Space)
			body.append (Open_parenthesis)
			body.append ("an_alias")
			body.append (Dot)
			body.append ("item")
			body.append (Close_parenthesis)

			Result.set_body (body)
		ensure
			non_void_writer_feature: Result /= Void
		end

	create_from_structure (an_eiffel_type: STRING): WIZARD_WRITER_FEATURE is
			-- Creation procedure, make from Structure
		require
			non_void_eiffel_type: an_eiffel_type /= Void
			valid_eiffel_type: not an_eiffel_type.is_empty
		local
			argument, body: STRING
			assertion: WIZARD_WRITER_ASSERTION
		do
			create Result.make

			Result.set_name ("make_from_alias")

			create argument.make (50)
			argument.append ("an_alias")
			argument.append (Colon)
			argument.append (Space)
			argument.append (an_eiffel_type)
			Result.add_argument (argument)

			Result.set_comment ("Create from alias")

			create assertion.make ("non_void_alias", "an_alias /= Void")
			Result.add_precondition (assertion)

			create body.make (100)

			body.append (tab_tab_tab)
			body.append ("make_by_pointer")
			body.append (Space)
			body.append (Open_parenthesis)
			body.append ("an_alias")
			body.append (Dot)
			body.append ("item")
			body.append (Close_parenthesis)
			body.append (New_line_tab_tab_tab)

			body.append ("an_alias")
			body.append (Dot)
			body.append ("set_shared")

			Result.set_body (body)
		ensure
			non_void_writer_feature: Result /= Void
		end

	create_from_string (an_eiffel_type: STRING): WIZARD_WRITER_FEATURE is
			-- Creation procedure, make from STRING
		require
			non_void_eiffel_type: an_eiffel_type /= Void
			valid_eiffel_type: not an_eiffel_type.is_empty
		local
			argument, body: STRING
			assertion: WIZARD_WRITER_ASSERTION
		do
			create Result.make

			Result.set_name ("make_from_alias")

			create argument.make (50)
			argument.append ("an_alias")
			argument.append (Colon)
			argument.append (Space)
			argument.append (an_eiffel_type)
			Result.add_argument (argument)

			Result.set_comment ("Create from alias")

			create assertion.make ("non_void_alias", "an_alias /= Void")
			Result.add_precondition (assertion)

			create body.make (100)

			body.append (tab_tab_tab)
			body.append ("make_from_string")
			body.append (Space)
			body.append (Open_parenthesis)
			body.append ("an_alias")
			body.append (Close_parenthesis)

			Result.set_body (body)
		ensure
			non_void_writer_feature: Result /= Void
		end

end -- class WIZARD_ALIAS_EIFFEL_GENERATOR

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
  

