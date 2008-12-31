note
	description: "[
		Constants describing XML tags and attributes, and also any common default values.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

frozen class
	WIX_CONSTANTS

inherit
	SYSTEM_OBJECT

feature -- Namespace

	wix_ns: SYSTEM_STRING = "http://schemas.microsoft.com/wix/2006/wi"

feature -- Element names

	component_tag: SYSTEM_STRING = "Component"
	component_group_tag: SYSTEM_STRING = "ComponentGroup"
	component_ref_tag: SYSTEM_STRING = "ComponentRef"
	directory_ref_tag: SYSTEM_STRING = "DirectoryRef"
	directory_tag: SYSTEM_STRING = "Directory"
	file_tag: SYSTEM_STRING = "File"
	fragment_tag: SYSTEM_STRING = "Fragment"
	include_tag: SYSTEM_STRING = "Include"
	wix_tag: SYSTEM_STRING = "Wix"

feature -- Attribute names

	disk_id_attribute: SYSTEM_STRING = "DiskId"
	guid_attribute: SYSTEM_STRING = "Guid"
	file_source_attribute: SYSTEM_STRING = "FileSource"
	id_attribute: SYSTEM_STRING = "Id"
	key_path_attribute: SYSTEM_STRING = "KeyPath"
	name_attribute: SYSTEM_STRING = "Name"
	source_attribute: SYSTEM_STRING = "Source"
	win64_attribute: SYSTEM_STRING = "Win64"

feature -- Preprocessor names

	pi_ifndef: SYSTEM_STRING = "ifndef"
	pi_ifdef: SYSTEM_STRING = "ifdef"
	pi_if: SYSTEM_STRING = "if"
	pi_define: SYSTEM_STRING = "define"
	pi_else: SYSTEM_STRING = "else"
	pi_endif: SYSTEM_STRING = "endif"

feature -- Constants

	yes_value: SYSTEM_STRING = "yes"
	no_value: SYSTEM_STRING = "no"

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
