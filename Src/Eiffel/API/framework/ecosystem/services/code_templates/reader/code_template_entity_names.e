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

feature -- Access

	author_tag: STRING_8 = "author"

	category_tag: STRING_8 = "category"

	categories_tag: STRING_8 = "categories"

	code_template_tag: STRING_8 = "code_template"

	code_templates_tag: STRING_8 = "code_templates"

	declarations_tag: STRING_8 = "declarations"

	default_tag: STRING_8 = "default"

	description_tag: STRING_8 = "description"

	literal_tag: STRING_8 = "literal"

	metadata_tag: STRING_8 = "metadata"

	title_tag: STRING_8 = "title"

	shortcut_tag: STRING_8 = "shortcut"

	template_tag: STRING_8 = "template"

	templates_tag: STRING_8 = "templates"

feature -- Attribute

	format_attribute: STRING_8 = "format"

	editable_attribute: STRING_8 = "editable"

	id_attribute: STRING_8 = "id"

	version_attribute: STRING_8 = "version"

feature -- Values

	contract_category: STRING_8 = "contract"

	code_category: STRING_8 = "code"

	class_category: STRING_8 = "class"

feature -- Token values

	cursor_token_name: STRING_8 = "cursor"

	selected_token_name: STRING_8 = "selected"

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
