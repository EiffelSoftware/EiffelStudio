indexing
	description: "Component C client generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_C_CLIENT_GENERATOR

inherit
	ECOM_FUNC_KIND
		export
			{NONE} all
		end

	WIZARD_CPP_WRITER_GENERATOR

	WIZARD_COMPONENT_CLIENT_GENERATOR

	WIZARD_COMPONENT_C_GENERATOR
	
	ECOM_TYPE_FLAGS
		export
			{NONE} all
		end

	ECOM_VAR_FLAGS
		export
			{NONE} all
		end

	ECOM_INVOKE_KIND
		export
			{NONE} all
		end
	
feature -- Basic operations

	generate_functions_and_properties (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR;
					a_desc: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate functions and properties of 'a_desc'
			-- Process interface `a_desc'.
		local
			function_generator: WIZARD_CPP_CLIENT_FUNCTION_GENERATOR
			disp_func_generator: WIZARD_CPP_DISPATCH_CLIENT_FUNCTION_GENERATOR
			dual_func_generator: WIZARD_CPP_DUAL_CLIENT_FUNCTION_GENERATOR
			property_generator: WIZARD_CPP_CLIENT_PROPERTY_GENERATOR
		do
			if not a_desc.properties.empty then
				from
					a_desc.properties.start
				until
					a_desc.properties.off
				loop
					create property_generator

					property_generator.generate (a_component_descriptor, a_desc.name, a_desc.lcid, a_desc.properties.item)
					cpp_class_writer.add_function (property_generator.c_access_feature, Public)
					if not is_varflag_freadonly (a_desc.properties.item.var_flags) then
						cpp_class_writer.add_function (property_generator.c_setting_feature, Public)
					end

					a_desc.properties.forth
				end
			end

			if not a_desc.functions.empty then
				from
					a_desc.functions.start
				until
					a_desc.functions.off
				loop
					if not is_propertyputref (a_desc.functions.item.invoke_kind) then

						if a_desc.dual then
							create dual_func_generator
							dual_func_generator.generate (a_component_descriptor, a_desc.name, a_desc.functions.item)
							cpp_class_writer.add_function (dual_func_generator.ccom_feature_writer, Public)
							from
								dual_func_generator.c_header_files.start
							until
								dual_func_generator.c_header_files.after
							loop
								if not cpp_class_writer.import_files.has (dual_func_generator.c_header_files.item) then
									cpp_class_writer.add_import (dual_func_generator.c_header_files.item)
								end
								dual_func_generator.c_header_files.forth
							end
						elseif a_desc.dispinterface then
							create disp_func_generator
							disp_func_generator.generate (a_component_descriptor, a_desc.name, a_desc.guid.to_string, a_desc.lcid, a_desc.functions.item)
							cpp_class_writer.add_function (disp_func_generator.ccom_feature_writer, Public)

						else
							create function_generator
							function_generator.generate (a_component_descriptor, a_desc.name, a_desc.functions.item)
							cpp_class_writer.add_function (function_generator.ccom_feature_writer, Public)
							from
								function_generator.c_header_files.start
							until
								function_generator.c_header_files.after
							loop
								if not cpp_class_writer.import_files.has (function_generator.c_header_files.item) then
									cpp_class_writer.add_import (function_generator.c_header_files.item)
								end
								function_generator.c_header_files.forth
							end

						end
					end

					a_desc.functions.forth
				end
			end
			if 
				a_desc.inherited_interface /= Void and then not
				a_desc.inherited_interface.guid.is_equal (Iunknown_guid) and then
				not a_desc.inherited_interface.guid.is_equal (Idispatch_guid) 
			then
				generate_functions_and_properties (a_component_descriptor, a_desc.inherited_interface)
			end
		end

feature {NONE} -- Implementation

	release_interface (a_name: STRING): STRING is
			-- Code to release interface
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			-- if (`interface_variable_prepend'`a_name' == NULL )
			--	`interface_vaiable_prepend'`a_name'`Release_function'

			Result := clone (If_keyword)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Interface_variable_prepend)
			Result.append (a_name)
			Result.append (C_not_equal)
			Result.append (Null)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab)
			Result.append (Interface_variable_prepend)
			Result.append (a_name)
			Result.append (Release_function)
			Result.append (New_line_tab)
		ensure
			non_void_release_interface: Result /= Void
			valid_release_interface: not Result.empty
		end


	add_default_function is
			-- Add default function.
		require
			non_void_cpp_class_writer: cpp_class_writer /= Void
		local
			function_writer: WIZARD_WRITER_C_FUNCTION
			function_body: STRING
		do
			create function_writer.make
			function_writer.set_name ("ccom_item")
			function_writer.set_comment ("IUnknown interface")
			function_writer.set_result_type (Eif_pointer)

			create function_body.make (0)
			function_body.append (tab)
			function_body.append (Return)
			function_body.append (Space_open_parenthesis)
			function_body.append (Eif_pointer)
			function_body.append (Close_parenthesis)
			function_body.append (Iunknown_variable_name)
			function_body.append (Semicolon)

			function_writer.set_body (function_body)

			cpp_class_writer.add_function (function_writer, Public)

		end

	ccom_last_error_code_function: WIZARD_WRITER_C_FUNCTION is
			-- `ccom_last_error_code' function.

		local
			function_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_error_code_name)
			Result.set_comment ("Last error code")
			Result.set_result_type  (Eif_integer)

			create function_body.make (0)
			function_body.append (tab)

			-- return (EIF_INTEGER) excepinfo->wCode;

			function_body.append (Return)
			function_body.append (Space)
			function_body.append (Open_parenthesis)
			function_body.append (Eif_integer)
			function_body.append (Close_parenthesis)
			function_body.append (Space)
			function_body.append (Excepinfo_access)
			function_body.append (Wcode_field)
			function_body.append (Semicolon)

			Result.set_body (function_body)

		ensure
			non_void_function: Result /= Void
			non_void_function_name: Result.name /= Void
			non_void_function_body: Result.body /= Void
		end

	ccom_last_source_of_exception_function: WIZARD_WRITER_C_FUNCTION is
			-- `ccom_last_source_of_exception' function.
		local
			function_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_source_of_exception_name)
			Result.set_comment ("Last source of exception")
			Result.set_result_type  (Eif_reference)

			create function_body.make (0)
			function_body.append (tab)

			-- return (EIF_INTEGER) excepinfo->wCode;

			function_body.append (Return)
			function_body.append (Space)
			function_body.append (Open_parenthesis)
			function_body.append (Eif_reference)
			function_body.append (Close_parenthesis)
			function_body.append (Space)
			function_body.append (Ce_mapper)
			function_body.append (Dot)
			function_body.append ("ccom_ce_bstr")
			function_body.append (Space)
			function_body.append (Open_parenthesis)
			function_body.append (Excepinfo_access)
			function_body.append (Bstr_source_field)
			function_body.append (Close_parenthesis)
			function_body.append (Semicolon)

			Result.set_body (function_body)

		ensure
			non_void_function: Result /= Void
			non_void_function_name: Result.name /= Void
			non_void_function_body: Result.body /= Void
		end

	ccom_last_error_description_function: WIZARD_WRITER_C_FUNCTION is
			-- `ccom_last_error_description' function.
		local
			function_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_error_description_name)
			Result.set_comment ("Last error description")
			Result.set_result_type  (Eif_reference)

			create function_body.make (0)
			function_body.append (tab)

			-- return (EIF_INTEGER) excepinfo->wCode;

			function_body.append (Return)
			function_body.append (Space)
			function_body.append (Open_parenthesis)
			function_body.append (Eif_reference)
			function_body.append (Close_parenthesis)
			function_body.append (Space)
			function_body.append (Ce_mapper)
			function_body.append (Dot)
			function_body.append ("ccom_ce_bstr")
			function_body.append (Space)
			function_body.append (Open_parenthesis)
			function_body.append (Excepinfo_access)
			function_body.append (Bstr_description_field)
			function_body.append (Close_parenthesis)
			function_body.append (Semicolon)

			Result.set_body (function_body)

		ensure
			non_void_function: Result /= Void
			non_void_function_name: Result.name /= Void
			non_void_function_body: Result.body /= Void
		end

	ccom_last_error_help_file_function: WIZARD_WRITER_C_FUNCTION is
			-- `ccom_last_error_help_file' function.
		local
			function_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_error_help_file_name)
			Result.set_comment ("Last error help file")
			Result.set_result_type  (Eif_reference)

			create function_body.make (0)
			function_body.append (tab)

			-- return (EIF_INTEGER) excepinfo->wCode;

			function_body.append (Return)
			function_body.append (Space)
			function_body.append (Open_parenthesis)
			function_body.append (Eif_reference)
			function_body.append (Close_parenthesis)
			function_body.append (Space)
			function_body.append (Ce_mapper)
			function_body.append (Dot)
			function_body.append ("ccom_ce_bstr")
			function_body.append (Space)
			function_body.append (Open_parenthesis)
			function_body.append (Excepinfo_access)
			function_body.append (Bstr_help_file_field)
			function_body.append (Close_parenthesis)
			function_body.append (Semicolon)

			Result.set_body (function_body)

		ensure
			non_void_function: Result /= Void
			non_void_function_name: Result.name /= Void
			non_void_function_body: Result.body /= Void
		end

end -- class WIZARD_COMPONENT_C_CLIENT_GENERATOR

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
