indexing
	description: "Component C client generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
				Result.append ("%N%Texcepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));")
				Result.append ("%N%Tif (excepinfo != NULL)%N%T%T")
				Result.append ("memset (excepinfo, %'\0%', sizeof (EXCEPINFO));")
			else
				create Result.make (0)
			end
		ensure
			non_void_initialization: Result /= Void
		end
	
	release_interface (a_variable_name: STRING): STRING is
			-- Code to release interface pointer held by `a_variable_name'
		require
			non_void_name: a_variable_name /= Void
			valid_name: not a_variable_name.is_empty
		do
			create Result.make (500)
			Result.append ("if (")
			Result.append (a_variable_name)
			Result.append (" != NULL)%N%T%T")
			Result.append (a_variable_name)
			Result.append ("->Release ();%N%T")
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

	co_initialize_ex_function: STRING is "%Thr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);%N";
			-- CoInitialize function call

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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

