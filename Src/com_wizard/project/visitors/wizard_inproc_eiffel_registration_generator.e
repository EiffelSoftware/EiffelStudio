indexing
	description: "Eiffel Inprocess registration code generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INPROC_EIFFEL_REGISTRATION_GENERATOR

inherit
	WIZARD_REGISTRATION_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Access

	eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS

feature -- Basic operations

	generate is
			-- Generate Eiffel registration code for in-process server.
		do
			create eiffel_writer.make

			eiffel_writer.set_class_name (registration_class_name)
			eiffel_writer.set_description (description_message)

			add_creation

			eiffel_writer.add_feature (make_feature, Initialization)

			eiffel_writer.add_feature (dll_register_server_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_dll_register_server_feature, Externals)

			eiffel_writer.add_feature (dll_unregister_server_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_dll_unregister_server_feature, Externals)

			eiffel_writer.add_feature (dll_get_class_object_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_dll_get_class_object_feature, Externals)

			eiffel_writer.add_feature (dll_can_unload_now_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_dll_can_unload_now_feature, Externals)

			-- Generate code and file name.
			Shared_file_name_factory.create_registration_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	description_message: STRING is 
		"Set the registry keys necessary for COM to activate the component%%%N%T%T%T%T  %
		% %%Do not modify this class."

	Local_string_var: STRING is "local_string"
			-- Used for code generation.

	dll_register_server_name: STRING is "dll_register_server"
			-- Used for code generation.

	dll_unregister_server_name: STRING is "dll_unregister_server"
			-- Used for code generation.

	dll_get_class_object_name: STRING is "dll_get_class_object"
			-- Used for code generation.

	dll_can_unload_now_name: STRING is "dll_can_unload_now"
			-- Used for code generation.

	add_creation is
			-- Add creation procedures.
		do
			eiffel_writer.add_creation_routine (Make_word)
		end

	make_feature: WIZARD_WRITER_FEATURE is
			-- `make' feature
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (make_word)
			Result.set_effective
			Result.set_comment ("Initialize server.")

			tmp_body := clone (Tab_tab_tab)
			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	dll_register_server_feature: WIZARD_WRITER_FEATURE is
			-- Register Server.
		local
			tmp_comment, tmp_body: STRING
		do
			create Result.make
			Result.set_name (dll_register_server_name)
			Result.set_effective
			create tmp_comment.make (100)
			tmp_comment.append ("Register Server")
			Result.set_comment (tmp_comment)

			create tmp_body.make (500)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Result_keyword)
			tmp_body.append (Space)
			tmp_body.append (Assignment)
			tmp_body.append (Space)
			tmp_body.append (ccom_dll_register_server)

			Result.set_body (tmp_body)
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_dll_register_server_feature: WIZARD_WRITER_FEATURE is
			-- External Register server feature.
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (ccom_dll_register_server)
			Result.set_external

			Result.set_comment ("Register server.")

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Double_quote)
			tmp_body.append ("C++")
			tmp_body.append (Open_bracket)
			tmp_body.append (Macro)
			tmp_body.append (Space)
			tmp_body.append (Percent_double_quote)
			tmp_body.append ("server_registration.h")
			tmp_body.append (Percent_double_quote)
			tmp_body.append (Close_bracket)
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Colon)
			tmp_body.append (Space)
			tmp_body.append (Eif_integer)
			tmp_body.append (Double_quote)

			Result.set_body (tmp_body)
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	dll_unregister_server_feature: WIZARD_WRITER_FEATURE is
			-- Unregister Server.
		local
			tmp_comment, tmp_body: STRING
		do
			create Result.make
			Result.set_name (dll_unregister_server_name)
			Result.set_effective
			create tmp_comment.make (100)
			tmp_comment.append ("Unregister Server")
			Result.set_comment (tmp_comment)

			create tmp_body.make (500)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Result_keyword)
			tmp_body.append (Space)
			tmp_body.append (Assignment)
			tmp_body.append (Space)
			tmp_body.append (ccom_dll_unregister_server)

			Result.set_body (tmp_body)
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_dll_unregister_server_feature: WIZARD_WRITER_FEATURE is
			-- External Unregister server feature.
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (ccom_dll_unregister_server)
			Result.set_external

			Result.set_comment ("Unregister server.")

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Double_quote)
			tmp_body.append ("C++")
			tmp_body.append (Open_bracket)
			tmp_body.append (Macro)
			tmp_body.append (Space)
			tmp_body.append (Percent_double_quote)
			tmp_body.append ("server_registration.h")
			tmp_body.append (Percent_double_quote)
			tmp_body.append (Close_bracket)
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Colon)
			tmp_body.append (Space)
			tmp_body.append (Eif_integer)
			tmp_body.append (Double_quote)

			Result.set_body (tmp_body)
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	dll_get_class_object_feature: WIZARD_WRITER_FEATURE is
			-- Get Class Object.
		local
			tmp_comment, tmp_body, tmp_argument: STRING
		do
			create Result.make
			Result.set_name (dll_get_class_object_name)
			Result.set_effective
			create tmp_comment.make (100)
			tmp_comment.append ("Get class object.")
			Result.set_comment (tmp_comment)

			create tmp_argument.make (100)
			tmp_argument.append ("a_clsid, a_riid, ppv")
			tmp_argument.append (Colon)
			tmp_argument.append (Space)
			tmp_argument.append (Pointer_type)
			Result.add_argument (tmp_argument)

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Result_keyword)
			tmp_body.append (Space)
			tmp_body.append (Assignment)
			tmp_body.append (Space)
			tmp_body.append (ccom_dll_get_class_object)
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (("a_clsid, a_riid, ppv"))
			tmp_body.append (Close_parenthesis)

			Result.set_result_type (Integer_type)
			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_dll_get_class_object_feature: WIZARD_WRITER_FEATURE is
			-- External Get Class Object feature.
		local
			tmp_body, tmp_argument: STRING
		do
			create Result.make
			Result.set_name (ccom_dll_get_class_object)
			Result.set_external

			Result.set_comment ("Get Class Object.")

			create tmp_argument.make (100)
			tmp_argument.append ("a_clsid, a_riid, ppv")
			tmp_argument.append (Colon)
			tmp_argument.append (Space)
			tmp_argument.append (Pointer_type)
			Result.add_argument (tmp_argument)

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Double_quote)
			tmp_body.append ("C++")
			tmp_body.append (Open_bracket)
			tmp_body.append (Macro)
			tmp_body.append (Space)
			tmp_body.append (Percent_double_quote)
			tmp_body.append ("server_registration.h")
			tmp_body.append (Percent_double_quote)
			tmp_body.append (Close_bracket)
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append ("CLSID *")
			tmp_body.append (Comma_space)
			tmp_body.append ("IID *")
			tmp_body.append (Comma_space)
			tmp_body.append (C_void_pointer)
			tmp_body.append (Asterisk)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Colon)
			tmp_body.append (Space)
			tmp_body.append (Eif_integer)
			tmp_body.append (Double_quote)

			Result.set_body (tmp_body)
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	dll_can_unload_now_feature: WIZARD_WRITER_FEATURE is
			-- DLL can unload now.
		local
			tmp_comment, tmp_body: STRING
		do
			create Result.make
			Result.set_name (dll_can_unload_now_name)
			Result.set_effective
			create tmp_comment.make (100)
			tmp_comment.append ("Can unload now?")
			Result.set_comment (tmp_comment)

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Result_keyword)
			tmp_body.append (Space)
			tmp_body.append (Assignment)
			tmp_body.append (Space)
			tmp_body.append (ccom_dll_can_unload_now)

			Result.set_body (tmp_body)
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_dll_can_unload_now_feature: WIZARD_WRITER_FEATURE is
			-- External Can unload now feature.
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (ccom_dll_can_unload_now)
			Result.set_external

			Result.set_comment ("Can unload now?")

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Double_quote)
			tmp_body.append ("C++")
			tmp_body.append (Open_bracket)
			tmp_body.append (Macro)
			tmp_body.append (Space)
			tmp_body.append (Percent_double_quote)
			tmp_body.append ("server_registration.h")
			tmp_body.append (Percent_double_quote)
			tmp_body.append (Close_bracket)
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Colon)
			tmp_body.append (Space)
			tmp_body.append (Eif_integer)
			tmp_body.append (Double_quote)

			Result.set_body (tmp_body)
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

end -- class WIZARD_INPROC_EIFFEL_REGISTRATION_GENERATOR

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
