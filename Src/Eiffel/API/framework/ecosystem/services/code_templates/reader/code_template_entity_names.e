indexing
	description: "[
		A dictionary of code template definition file XML tag, attribute and value names.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_TEMPLATE_ENTITY_NAMES

inherit
	CODE_TOKEN_NAMES

feature -- Access

	author_tag: STRING = "author"

	category_tag: STRING = "category"

	categories_tag: STRING = "categories"

	code_template_tag: STRING = "code_template"

	code_templates_tag: STRING = "code_templates"

	declarations_tag: STRING = "declarations"

	default_tag: STRING = "default"

	description_tag: STRING = "description"

	literal_tag: STRING = "literal"

	metadata_tag: STRING = "metadata"

	object_tag: STRING = "object"

	template_tag: STRING = "template"

	templates_tag: STRING = "templates"

	title_tag: STRING = "title"

	shortcut_tag: STRING = "shortcut"

feature -- Attribute

	conforms_to_attribute: STRING = "conforms_to"

	editable_attribute: STRING = "editable"

	format_attribute: STRING = "format"

	id_attribute: STRING = "id"

	version_attribute: STRING = "version"

feature -- Values

	code_category: STRING = "code"

	contract_category: STRING = "contract"

	precondition_category: STRING = "precondition"

	postcondition_category: STRING = "postcondition"

	invariant_category: STRING = "invariant"

	class_category: STRING = "class"

feature -- Delimiters

	template_start_delimiter: STRING = "~#"

	template_end_delimiter: STRING = "#~"

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
