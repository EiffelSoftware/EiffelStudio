indexing
	description: "Coclass eiffel server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_EIFFEL_SERVER_IMPL_GENERATOR

inherit
	WIZARD_COCLASS_EIFFEL_GENERATOR 
		redefine
			generate,
			set_default_ancestors
		end

	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR 
		redefine
			set_default_ancestors
		end

feature -- Basic operation

	generate (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate eiffel class for coclass.
		local
			a_description: STRING
			a_visible: WIZARD_WRITER_VISIBLE_CLAUSE
		do
			coclass_descriptor := a_coclass

			create a_visible.make
			a_visible.set_name (implemented_coclass_name (a_coclass.eiffel_class_name))
			system_descriptor.add_visible_class_server (a_visible)
			create eiffel_writer.make

			eiffel_writer.set_class_name (implemented_coclass_name (a_coclass.eiffel_class_name))

			create a_description.make (1000)
			a_description.append (a_coclass.eiffel_class_name)
			a_description.append (" Implementation.")
			eiffel_writer.set_description (a_description)
			set_default_ancestors (eiffel_writer)

			add_creation
			add_default_features (a_coclass)

			if not shared_wizard_environment.new_eiffel_project then
				process_interfaces (a_coclass)
			end

			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

			eiffel_writer := Void
		end

	process_interfaces (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process coclass interfaces.
		local
			interface_processor: WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_IMPL_PROCESSOR 
		do
			create interface_processor.make (a_coclass, eiffel_writer)
			interface_processor.process_interfaces
			dispatch_interface := interface_processor.dispatch_interface
		end

	add_creation is
			-- Add creation clause,.
		do
			eiffel_writer.add_creation_routine (Make_word)
			eiffel_writer.add_creation_routine ("make_from_pointer")
		end

	add_default_features (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add default features to coclass server. 
			-- e.g. make, constructor etc.
		do
			if shared_wizard_environment.new_eiffel_project then
				eiffel_writer.add_feature (make_feature_precursor, Initialization)
			else
				eiffel_writer.add_feature (make_feature, Initialization)
			end
			eiffel_writer.add_feature (make_from_pointer_feature, Initialization)
			eiffel_writer.add_feature (create_item_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_create_item_feature (a_component), Externals)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
		local
			tmp_writer: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create tmp_writer.make

			if shared_wizard_environment.new_eiffel_project then
				tmp_writer.set_name (shared_wizard_environment.eiffel_class_name)
				tmp_writer.add_redefine (make_word)
			else
				tmp_writer.set_name (coclass_descriptor.eiffel_class_name)
			end

			an_eiffel_writer.add_inherit_clause (tmp_writer)

			if shared_wizard_environment.new_eiffel_project then
				create tmp_writer.make
				tmp_writer.set_name ("ECOM_STUB")
				an_eiffel_writer.add_inherit_clause (tmp_writer)
			end
		end

	ccom_create_item_feature (a_component: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `create_item' feature.
		local
			feature_body: STRING
			an_argument: STRING
		do
			create Result.make
			Result.set_name ("ccom_create_item")
			Result.set_comment ("Initialize %Qitem%'")

			create an_argument.make (100)
			an_argument.append ("eif_object: like Current")
			Result.add_argument (an_argument)

			Result.set_result_type ("POINTER")

			create feature_body.make (100)
			feature_body.append (Tab_tab_tab)
			feature_body.append ("%"C++ %(new ")
			if a_component.namespace /= Void and then not a_component.namespace.empty then
				feature_body.append (a_component.namespace)
				feature_body.append ("::")
			end
			feature_body.append (a_component.c_type_name)
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (a_component.c_header_file_name)
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append ("(EIF_OBJECT)")
			feature_body.append (double_quote)

			Result.set_external
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	make_feature_precursor: WIZARD_WRITER_FEATURE is
			-- `make' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (Make_word)
			Result.set_comment ("Creation.")

			create feature_body.make (100)
			feature_body.append (Tab_tab_tab)
			feature_body.append ("Precursor ")
			feature_body.append (Open_curly_brace)
			feature_body.append (shared_wizard_environment.eiffel_class_name)
			feature_body.append (Close_curly_brace)

			Result.set_effective
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

end -- class WIZARD_COCLASS_EIFFEL_SERVER_GENERATOR

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
