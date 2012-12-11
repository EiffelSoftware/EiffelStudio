note
	description: "[
		Services implementation for supporting the wizard engine, based on the service description {WIZARD_ENGINE_S}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	WIZARD_ENGINE

inherit
	WIZARD_ENGINE_S

	DISPOSABLE_SAFE

	SHARED_LOCALE
		export
			{NONE} all
		end

--inherit {NONE}
	KL_SHARED_FILE_SYSTEM

	EC_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

feature -- Basic operations

	render_template (a_template: READABLE_STRING_GENERAL; a_parameters: detachable DS_HASH_TABLE [ANY, STRING_32]): STRING_32
			-- <Precursor>
		local
			l_templates: like build_code_template
			l_renderer: CODE_TEMPLATE_STRING_RENDERER
			l_result: STRING_32
		do
			l_templates := build_code_template (a_template.as_string_32, a_parameters)
			if attached l_templates.template.applicable_default_item as l_default_template then
				create l_renderer
				l_renderer.render_template (l_default_template, l_templates.symbol_table)
				l_result := l_renderer.code
				check l_result_attached: attached l_result end

					-- Remove carriage return characters
				l_result.replace_substring_all ("%R", "")
				if preferences.misc_data.text_mode_is_windows then
						-- Add carriage returns when requested.
					l_result.replace_substring_all ("%N", "%N%R")
				end
				Result := l_result
			else
				create Result.make_empty
			end
		end

	render_template_from_file (a_file_name: PATH; a_parameters: detachable DS_HASH_TABLE [ANY, STRING_32]): detachable STRING_32
			-- <Precursor>
		local
			l_file: RAW_FILE
			l_contents: detachable STRING_32
			l_count: INTEGER
		do
			create l_file.make_with_path (a_file_name)
			if attached l_file then
					-- Read template contents
				l_count := l_file.count
				if l_count > 0 then
					l_file.open_read
					l_contents := read_string_32_from_file (l_file)
					l_file.close
					if attached l_contents then
						Result := render_template (l_contents, a_parameters)
					end
				else
					create Result.make_empty
				end
			end
		rescue
			if attached l_file and then not l_file.is_closed then
				l_file.close
			end
		end

	render_template_to_file (a_template: READABLE_STRING_GENERAL; a_parameters: detachable DS_HASH_TABLE [ANY, STRING_32]; a_destination_file: PATH)
			-- <Precursor>
		local
			l_file: RAW_FILE
			l_rendered: detachable STRING_32
		do
			l_rendered := render_template (a_template, a_parameters)
			if l_rendered /= Void then
				create l_file.make_with_path (a_destination_file)
				if attached l_file then
					l_file.open_write
					save_string_32_in_file (l_file, l_rendered)
					l_file.close
				end
			end
		rescue
			if attached l_file and then not l_file.is_closed then
				l_file.close
			end
		end

	render_template_from_file_to_file (a_file_name: PATH; a_parameters: detachable DS_HASH_TABLE [ANY, STRING_32]; a_destination_file: PATH)
			-- <Precursor>
		local
			l_file: RAW_FILE
			l_rendered: detachable STRING_32
		do
			l_rendered := render_template_from_file (a_file_name, a_parameters)
			if l_rendered /= Void then
				create l_file.make_with_path (a_destination_file)

				l_file.open_write
				save_string_32_in_file (l_file, l_rendered)
				l_file.close
			end
		rescue
			if attached l_file and then not l_file.is_closed then
				l_file.close
			end
		end

feature {NONE} -- Basic operations

	build_code_template (a_template: STRING_32; a_parameters: detachable DS_HASH_TABLE [ANY, STRING_32]): TUPLE [template: CODE_TEMPLATE_DEFINITION; symbol_table: CODE_SYMBOL_TABLE]
			-- Builds a code template definition file from a template text.
			--
			-- `a_template': The tokenized text to render with the supplied parameters.
			-- `a_parameters': A set of parameters to render the template using.
			-- `Result': The built code template definition and generated symbol table.
		require
			a_template_attached: a_template /= Void
			not_a_template_is_empty: not a_template.is_empty
			a_parameters_attached: a_parameters /= Void
		local
			l_cursor: DS_HASH_TABLE_CURSOR [ANY, STRING_32]
			l_key: STRING_32
			l_factory: CODE_FACTORY
			l_definition: CODE_TEMPLATE_DEFINITION
			l_declarations: CODE_DECLARATION_COLLECTION
			l_literal_declaration: CODE_LITERAL_DECLARATION
			l_templates: CODE_TEMPLATE_COLLECTION
			l_template: CODE_TEMPLATE
			l_table_builder: CODE_SYMBOL_TABLE_BUILDER
			l_table: CODE_SYMBOL_TABLE
		do
			create l_factory
			create l_definition.make (l_factory)

				-- Create template declarations
			l_declarations := l_definition.declarations
			l_cursor := a_parameters.new_cursor
			from l_cursor.start until l_cursor.after loop
				l_key := l_cursor.key
				check l_key_attached: l_key /= Void end
				l_literal_declaration := l_factory.new_code_literal_declaration (l_key, l_declarations)
				if attached l_cursor.item as l_item then
					l_literal_declaration.default_value := l_item.out.as_string_32
				end
				l_declarations.extend (l_literal_declaration)
				l_cursor.forth
			end

				-- Create template
			l_templates := l_definition.templates
			l_template := l_factory.new_code_template (l_templates)
			l_template.set_tokens_with_text (a_template)
			l_templates.extend (l_template)

				-- Build symbol table
			create l_table_builder.make (l_definition)
			l_table := l_table_builder.symbol_table

				-- Create result
			Result := [l_definition, l_table_builder.symbol_table]
		ensure
			result_attached: Result /= Void
			result_template_attached: Result.template /= Void
			result_symbol_table_attached: Result.symbol_table /= Void
			result_template_is_interface_usable: Result.template.is_interface_usable
			result_template_default_template_attached: Result.template.applicable_default_item /= Void
		end

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
