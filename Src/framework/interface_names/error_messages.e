note
	description: "[
		Collection of user interface error messages.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ERROR_MESSAGES

inherit
	SHARED_LOCALE

feature -- General purpose

	e_unknown_error: attached STRING_32 do Result := locale.translation ("Unknown error.") end

feature -- File

	e_file_does_not_exists (a_file_name: READABLE_STRING_GENERAL): STRING_32 do Result := locale.formatted_string ("The file '$1' does not exist.", [a_file_name]) end
	e_folder_does_not_exists (a_file_name: READABLE_STRING_GENERAL): STRING_32 do Result := locale.formatted_string ("The file '$1' does not exist.", [a_file_name]) end

feature -- Project

	e_must_open_project: STRING_32 do Result := locale.translation ("This function can only be performed once a project has been opened.%NPlease open a project and try again.") end

feature -- Project configuration

	e_precompile_catcall_detection_mismatch (target_value, precompile_value, none_value: READABLE_STRING_32): READABLE_STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context ("Selected target CAT-call detection setting %"$1%" does not match the setting %"$2%" of precompile. They should be the same if one of them is %"$3%".", "compiler"), target_value, precompile_value, none_value)
		end

	e_precompile_concurrency_mismatch (target_value, precompile_value: READABLE_STRING_32): READABLE_STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context ("Selected target concurrency setting %"$1%" does not match the setting %"$2%" of precompile. They should be the same.", "compiler"), target_value, precompile_value)
		end

	e_precompile_void_safety_mismatch (target_value, precompile_value, none_value: READABLE_STRING_32): READABLE_STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context ("Selected target void safety setting %"$1%" does not match the setting %"$2%" of precompile. They should be the same if one of them is %"$3%".", "compiler"), target_value, precompile_value, none_value)
		end

feature -- Code template

	e_code_template_parse (a_error: READABLE_STRING_GENERAL; a_file_name: READABLE_STRING_GENERAL): attached STRING_32 do Result := locale.formatted_string ("Unable to parse the code template  '$1'. Error: $2.", [a_file_name, a_error]) end
	e_code_template_read (a_file_name: READABLE_STRING_GENERAL): attached STRING_32 do Result := locale.formatted_string ("Unable to read the code template file '$1'.", [a_file_name]) end
	e_code_template_unable_to_find_template: attached STRING_32 do Result := locale.translation ("Unable to find an applicable template for the current version of EiffelStudio.") end

feature -- Contract tool

	e_contract_tool_save_failed: attached STRING_32 do Result := locale.translation ("There was a problem saving the contracts. Please check you have access to the class file.") end
	e_contract_tool_expression_error: attached STRING_32 do Result := locale.translation ("The entered contract expression is not a valid expression or contains syntax errors.%NPlease fix the error before continuing.") end

feature -- Help system

	e_help_unable_to_launch: attached STRING_32 do Result := locale.translation ("Unable to launch the help documentation.") end

feature -- Prompts

	e_save_session_data_failed: attached STRING_32 do Result := locale.translation ("There was an error when trying to store the EiffelStudio session data.") end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
