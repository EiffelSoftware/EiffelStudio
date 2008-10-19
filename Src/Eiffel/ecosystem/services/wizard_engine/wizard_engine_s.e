indexing
	description: "[
		Services interface for supporting the wizard engine.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	WIZARD_ENGINE_S

inherit
	SERVICE_I

	USABLE_I

feature -- Query

	is_valid_file_name (a_file_name: ?READABLE_STRING_GENERAL): BOOLEAN
			-- Determines if a file name is valid.
			--
			-- `a_file_name': The file name to check for validity.
			-- `Result': True if the file name is valid; False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_file_name_attached: a_file_name /= Void
		do
			Result := not a_file_name.is_empty
		ensure
			not_a_file_name_is_empty: Result implies not a_file_name.is_empty
		end

feature -- Basic operations

	render_template (a_template: !READABLE_STRING_GENERAL; a_parameters: ?DS_TABLE [!ANY, !STRING]): !STRING_32
			-- Renders a text template.
			--
			-- `a_template': The tokenized text to render with the supplied parameters.
			-- `a_parameters': A set of parameters to render the template using.
			-- `Result': The result of rendering the template.
		require
			is_interface_usable: is_interface_usable
			not_a_template_is_empty: not a_template.is_empty
		deferred
		end

	render_template_from_file (a_file_name: !READABLE_STRING_GENERAL; a_parameters: ?DS_TABLE [!ANY, !STRING]): ?STRING_32
			-- Renders a text template from a file.
			--
			-- `a_file_name': The source file name to retrieve a tokenized template from.
			-- `a_parameters': A set of parameters to render the template using.
			-- `Result': The result of rendering the template.
		require
			is_interface_usable: is_interface_usable
			a_file_name_is_valid_file_name: is_valid_file_name (a_file_name.as_string_8)
		deferred
		end

	render_template_to_file (a_template: !READABLE_STRING_GENERAL; a_parameters: ?DS_HASH_TABLE [!ANY, !STRING]; a_destination_file: !READABLE_STRING_GENERAL)
			-- Renders a text template to a destination file.
			--
			-- `a_template': The tokenized text to render with the supplied parameters.
			-- `a_parameters': A set of parameters to render the template using.
			-- `a_destination_file': The destination file to store the rendered template into.
		require
			is_interface_usable: is_interface_usable
			not_a_template_is_empty: not a_template.is_empty
			a_destination_file_is_valid_file_name: is_valid_file_name (a_destination_file)
		deferred
		end

	render_template_from_file_to_file (a_file_name: !READABLE_STRING_GENERAL; a_parameters: ?DS_TABLE [!ANY, !STRING]; a_destination_file: !READABLE_STRING_GENERAL)
			-- Renders a text template from a file to a destination file.
			--
			-- `a_file_name': The source file name to retrieve a tokenized template from.
			-- `a_parameters': A set of parameters to render the template using.
			-- `a_destination_file': The destination file to store the rendered template into.
		require
			is_interface_usable: is_interface_usable
			a_file_name_is_valid_file_name: is_valid_file_name (a_file_name.as_string_8)
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name.as_string_8)).exists
			a_destination_file_is_valid_file_name: is_valid_file_name (a_destination_file)
		deferred
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
