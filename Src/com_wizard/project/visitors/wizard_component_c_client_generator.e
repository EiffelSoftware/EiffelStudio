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

	ECOM_INVOKE_KIND
		export
			{NONE} all
		end

feature -- Access

	dispatch_interface: BOOLEAN
			-- Is coclass contained dispatch interface?
			
feature {NONE} -- Implementation

	excepinfo_initialization: STRING is
			-- EXCEPINFO structure initialization.
		do
			if dispatch_interface then
				create Result.make (200)
				Result.append ("%R%N%Texcepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));")
				Result.append ("%R%N%Tif (excepinfo != NULL)%R%N%T%T")
				Result.append ("memset (excepinfo, %'\0%', sizeof (EXCEPINFO));")
			else
				create Result.make (0)
			end
		ensure
			non_void_initialization: Result /= Void
		end
	
	release_interface (a_name: STRING): STRING is
			-- Code to release interface
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			create Result.make (500)
			Result.append ("if (p_")
			Result.append (a_name)
			Result.append (" != NULL)%R%N%T%Tp_")
			Result.append (a_name)
			Result.append ("->Release ();%R%N%T")
		ensure
			non_void_release_interface: Result /= Void
			valid_release_interface: not Result.is_empty
		end

	add_default_function is
			-- Add default function.
		require
			non_void_cpp_class_writer: cpp_class_writer /= Void
		local
			l_writer: WIZARD_WRITER_C_FUNCTION
		do
			create l_writer.make
			l_writer.set_name ("ccom_item")
			l_writer.set_comment ("IUnknown interface")
			l_writer.set_result_type ("EIF_POINTER")
			l_writer.set_body ("%Treturn (EIF_POINTER)p_unknown;")
			cpp_class_writer.add_function (l_writer, Public)
		end

	ccom_last_error_code_function: WIZARD_WRITER_C_FUNCTION is
			-- `ccom_last_error_code' function.
		do
			create Result.make
			Result.set_name (ccom_last_error_code_name)
			Result.set_comment ("Last error code")
			Result.set_result_type ("EIF_INTEGER")
			Result.set_body ("%Treturn (EIF_INTEGER) excepinfo->wCode;")
		ensure
			non_void_function: Result /= Void
			non_void_function_name: Result.name /= Void
			non_void_function_body: Result.body /= Void
		end

	ccom_last_source_of_exception_function: WIZARD_WRITER_C_FUNCTION is
			-- `ccom_last_source_of_exception' function.
		do
			create Result.make
			Result.set_name (ccom_last_source_of_exception_name)
			Result.set_comment ("Last source of exception")
			Result.set_result_type ("EIF_REFERENCE")
			Result.set_body ("%Treturn (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);")
		ensure
			non_void_function: Result /= Void
			non_void_function_name: Result.name /= Void
			non_void_function_body: Result.body /= Void
		end

	ccom_last_error_description_function: WIZARD_WRITER_C_FUNCTION is
			-- `ccom_last_error_description' function.
		do
			create Result.make
			Result.set_name (ccom_last_error_description_name)
			Result.set_comment ("Last error description")
			Result.set_result_type ("EIF_REFERENCE")
			Result.set_body ("%Treturn (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);")
		ensure
			non_void_function: Result /= Void
			non_void_function_name: Result.name /= Void
			non_void_function_body: Result.body /= Void
		end

	ccom_last_error_help_file_function: WIZARD_WRITER_C_FUNCTION is
			-- `ccom_last_error_help_file' function.
		do
			create Result.make
			Result.set_name (ccom_last_error_help_file_name)
			Result.set_comment ("Last error help file")
			Result.set_result_type ("EIF_REFERENCE")
			Result.set_body ("%Treturn (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);")
		ensure
			non_void_function: Result /= Void
			non_void_function_name: Result.name /= Void
			non_void_function_body: Result.body /= Void
		end

	co_initialize_ex_function: STRING is "%Thr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);%R%N"
			-- CoInitialize function call

end -- class WIZARD_COMPONENT_C_CLIENT_GENERATOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

