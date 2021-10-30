note
	description: "[
		XML parser callbacks for creating a in-memory model of a code template.
		
		Note: The model does nothing to preserve unknown nodes, so it cannot safely be used to emit
		      a code template on disk.
	]"
	doc: "wiki://Code Templates"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_TEMPLATE_LOAD_CALLBACK

inherit
	XML_STATE_LOAD_CALLBACKS
		rename
			make as make_es_callbacks
		redefine
			reset,
			on_error
		end

create
	make

feature {NONE} -- Initialization

	make (a_factory: like code_factory; a_parser: like xml_parser)
			-- Initializes a XML load callback using a code factory.
			--
			-- `a_factory': A factory for creating code template nodes.
			-- `a_parser': An XML parser to use to process the callbacks.
		require
			a_factory_attached: attached a_factory
			a_parser_attached: attached a_parser
		do
			code_factory := a_factory
			make_es_callbacks (a_parser)
		ensure
			code_factory_set: code_factory = a_factory
			xml_parser_set: xml_parser = a_parser
			xml_parser_callbacks_set: xml_parser.callbacks = Current
		end

feature -- Access

	last_code_template_definition: detachable CODE_TEMPLATE_DEFINITION
			-- The last parsed code template definition.

feature {NONE} -- Access

	last_declaration: detachable CODE_DECLARATION
			-- Last literal code declaration processed.

	code_factory: CODE_FACTORY
			-- Factory for generating code template nodes.

feature {NONE} -- Status report

	is_strict: BOOLEAN = False
			-- Is call back strict about checking well formed XML?
			-- If not, empty attributes, duplicates attribute, etc. fall through.

feature {NONE} -- Helpers

	format_utilities: CODE_FORMAT_UTILITIES
			-- Shared access to code formatting utilies.
		once
			create Result
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Basic operations

	reset
			-- <Precursor>
		do
			Precursor {XML_STATE_LOAD_CALLBACKS}
			last_code_template_definition := Void
			last_declaration := Void
		ensure then
			last_code_template_definition_detached: not attached last_code_template_definition
			last_declaration_detached: not attached last_declaration
		end

feature -- Formatting

	format_template (a_template: STRING_32): STRING_32
			-- Formats a template examining extracting it if any template delimiter are defined.
			--
			-- `a_template': The orginal template text to extract a delimited template from
			-- `Result': The extracted template.
		require
			a_template_attached: attached a_template
			not_a_template_is_empty: not a_template.is_empty
		local
			l_delimiter: STRING_32
			l_stop: BOOLEAN
			l_result: detachable STRING_32
			l_start, l_end: INTEGER
			l_count: INTEGER
		do
			l_count := a_template.count

			l_delimiter := {CODE_TEMPLATE_ENTITY_NAMES}.template_start_delimiter
			l_start := a_template.index_of (l_delimiter [1], 1)
			if l_start > 0 and l_start < l_count and then l_delimiter.is_equal (a_template.substring (l_start, l_start + (l_delimiter.count - 1))) then
				l_start := l_start + l_delimiter.count
				l_delimiter := {CODE_TEMPLATE_ENTITY_NAMES}.template_end_delimiter
				l_end := a_template.last_index_of (l_delimiter [l_delimiter.count], a_template.count)
				if l_end > l_start and then l_delimiter.is_equal (a_template.substring (l_end - (l_delimiter.count - 1), l_end)) then
					l_end := l_end - l_delimiter.count
					from until not a_template.item (l_start).is_space or l_stop loop
						l_stop := a_template.item (l_start) = '%N'
						l_start := l_start + 1
					end

					l_stop := False
					from until l_stop loop
						l_stop := not a_template.item (l_end).is_space or else a_template.item (l_end) = '%N'
						l_end := l_end - 1
					end
					if l_start < l_end then
						l_result := a_template.substring (l_start, l_end)
					end
				end
			end
			if attached l_result then
				Result := l_result
			else
				Result := a_template
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Process

	process_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			inspect a_state
			when t_code_template then
				process_code_template
			when t_metadata then
				process_metadata
			when t_categories then
				process_metadata_categories
			when t_declarations then
				process_declarations
			when t_literal then
				process_declaration_literal
			when t_object then
				process_declaration_object
			when t_templates then
				process_templates
			else
			end
		end

	process_end_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			inspect a_state
			when t_title then
				process_metadata_title
			when t_description then
				if attached last_declaration then
					process_declaration_description
				else
					process_metadata_description
				end
			when t_author then
				process_metadata_author
			when t_shortcut then
				process_metadata_shortcut
			when t_category then
				process_metadata_category
			when t_literal, t_object then
					-- Clear last literal or object declaration.
				last_declaration := Void
			when t_default then
				if attached {CODE_LITERAL_DECLARATION} last_declaration as literal then
					process_declaration_literal_default (literal)
				end
			when t_template then
				process_templates_template
			else
			end
		end

feature {NONE} -- Production processing

	process_code_template
			-- Processes the top-level code template node.
		require
			last_code_template_definition_detached: not attached last_code_template_definition
		local
			l_definition: like last_code_template_definition
		do
			l_definition := code_factory.new_code_template_defintion
			last_code_template_definition := l_definition

				-- Add built-in declarations

				-- Adds built-in 'selected' text declaration
			l_definition.declarations.extend (code_factory.new_code_built_in_literal_declaration ({CODE_TEMPLATE_ENTITY_NAMES}.selection_token_name, last_code_template_definition.declarations))
				-- Adds built-in 'cursor' text declaration
			l_definition.declarations.extend (code_factory.new_code_built_in_literal_declaration ({CODE_TEMPLATE_ENTITY_NAMES}.cursor_token_name, last_code_template_definition.declarations))
		ensure
			last_code_template_definition_attached: last_code_template_definition /= Void
		end

	process_metadata
			-- Processes the code template's metadata node.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		do
			-- Do nothing
		end

	process_metadata_title
			-- Processes a metadata title.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		local
			l_definition: like last_code_template_definition
			l_content: like current_content
		do
			l_content := current_content
			if not l_content.is_empty then
				l_definition := last_code_template_definition
				check l_definition_attached: attached l_definition end
				l_definition.metadata.title := l_content
			end
		end

	process_metadata_description
			-- Processes a metadata literal description.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		local
			l_definition: like last_code_template_definition
			l_content: like current_content
		do
			l_content := current_content
			if not l_content.is_empty then
				l_definition := last_code_template_definition
				check l_definition_attached: attached l_definition end
				l_definition.metadata.description := l_content
			end
		end

	process_metadata_author
			-- Processes a metadata author.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		local
			l_definition: like last_code_template_definition
			l_content: like current_content
		do
			l_content := current_content
			if not l_content.is_empty then
				l_definition := last_code_template_definition
				check l_definition_attached: attached l_definition end
				l_definition.metadata.author := l_content
			end
		end

	process_metadata_shortcut
			-- Processes a metadata shortcut.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		local
			l_definition: like last_code_template_definition
			l_content: like current_content
		do
			l_content := current_content
			if not l_content.is_empty then
				l_definition := last_code_template_definition
				check l_definition_attached: attached l_definition end
				last_code_template_definition.metadata.shortcut := l_content
			end
		end

	process_metadata_categories
			-- Processes a metadata category collection.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		do
			-- Nothing to do, use the templates node from the code file.
		end

	process_metadata_category
			-- Processes a metadata category.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		local
			l_definition: like last_code_template_definition
			l_categories: CODE_CATEGORY_COLLECTION
			l_category: like current_content
		do
			l_category := current_content
			if not l_category.is_empty then
				l_definition := last_code_template_definition
				check l_definition_attached: attached l_definition end
				l_categories := l_definition.metadata.categories
				if not l_categories.has (l_category) then
					l_categories.extend (l_category)
				end
			end
		end

	process_declarations
			-- Processes a declaration collection node.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		do
			-- Nothing to do, use the templates collection from the code file.
		end

	process_declaration_literal
			-- Processes a single declaration literal node.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		local
			l_literal: CODE_LITERAL_DECLARATION
			l_attributes: like current_attributes
			l_declarations: CODE_DECLARATION_COLLECTION
			l_default: STRING_32
			l_id: STRING
		do
			last_declaration := Void

				-- Fetch literal ID
			l_attributes := current_attributes
			if l_attributes.has (at_id) and then (attached l_attributes.item (at_id) as l_attribute) and then not l_attribute.is_empty then
				l_id := l_attribute.as_string_8
				l_declarations := last_code_template_definition.declarations
				if l_declarations.declaration (l_id) = Void or else not is_strict then
					l_literal := code_factory.new_code_literal_declaration (l_id, l_declarations)
					if l_attributes.has (at_editable) and then (attached l_attributes.item (at_editable) as l_editable) and then not l_editable.is_empty then
						l_literal.is_editable := to_boolean ({CODE_TEMPLATE_ENTITY_NAMES}.editable_attribute, l_editable, False)
					end
						-- Set the default value to the declaration name
					if l_literal.is_editable then
						create l_default.make_from_string (l_attribute)
						l_literal.default_value := l_default
					end
					l_declarations.extend (l_literal)
					last_declaration := l_literal
				else
						-- Duplicate declaration
					on_report_xml_error ("A declaration using the id '" + l_id + "' has already been taken!")
				end
			else
				on_report_xml_error ("Declaration literal is missing an 'id' attribute!")
			end
		ensure
			last_declaration_changed: not has_error implies last_declaration /= old last_declaration
		end

	process_declaration_object
			-- Processes a single declaration object node.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		local
			l_object: CODE_OBJECT_DECLARATION
			l_attributes: like current_attributes
			l_declarations: CODE_DECLARATION_COLLECTION
			l_default: STRING_32
			l_id: STRING
		do
			last_declaration := Void

				-- Fetch object ID
			l_attributes := current_attributes
			if l_attributes.has (at_id) and then (attached l_attributes.item (at_id) as l_attribute) and then not l_attribute.is_empty then
				l_id := l_attribute.as_string_8
				l_declarations := last_code_template_definition.declarations
				if l_declarations.declaration (l_id) = Void or else not is_strict then
					l_object := code_factory.new_code_object_declaration (l_id, l_declarations)
					if l_attributes.has (at_editable) and then (attached l_attributes.item (at_editable) as l_editable) and then not l_editable.is_empty then
						l_object.is_editable := to_boolean ({CODE_TEMPLATE_ENTITY_NAMES}.editable_attribute, l_editable, False)
					end

					if l_object.is_editable then
							-- Set the default value to the declaration name
						create l_default.make_from_string (l_attribute)
						l_object.default_value := l_default
					end

					if l_attributes.has (at_conforms_to) and then (attached l_attributes.item (at_conforms_to) as l_type) and then not l_type.is_empty then
							-- Set the conformance type
						l_object.must_conform_to := l_type
					end

					l_declarations.extend (l_object)
					last_declaration := l_object
				else
						-- Duplicate declaration
					on_report_xml_error ("A declaration using the id '" + l_id + "' has already been taken!")
				end
			else
				on_report_xml_error ("Declaration literal is missing an 'id' attribute!")
			end
		ensure
			last_declaration_changed: not has_error implies last_declaration /= old last_declaration
		end

	process_declaration_description
			-- Processes a declaration's description.
		require
			last_code_template_definition_attached: attached last_code_template_definition
			last_declaration_attached: attached last_declaration
		do
			if not current_content.is_empty then
				last_declaration.description := current_content
			end
		end

	process_declaration_literal_default (literal: CODE_LITERAL_DECLARATION)
			-- Processes a default value element of a declaration `literal'.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		do
			literal.default_value := current_content
		end

	process_templates
			-- Processes a template collection.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		do
			-- Nothing to do, use the templates collection from the code file.
		end

	process_templates_template
			-- Processes a template collection's template.
		require
			last_code_template_definition_attached: attached last_code_template_definition
		local
			l_attributes: like current_attributes
			l_templates: CODE_TEMPLATE_COLLECTION
			l_version: CODE_VERSION
			l_template: CODE_TEMPLATE
			l_text: like current_content
		do
			l_text := current_content
			if not l_text.is_empty then
				l_text := format_template (l_text)
			end

			l_templates := last_code_template_definition.templates
			l_attributes := current_attributes
			if l_attributes.has (at_version) then
				if (attached l_attributes.item (at_version) as l_value) and then not l_value.is_empty then
						-- Create a version template
					l_version := format_utilities.parse_version (l_value, code_factory)
					l_template := code_factory.new_code_versioned_template (l_version, l_templates)
					l_template.set_tokens_with_text (l_text)
					last_code_template_definition.templates.extend (l_template)
				else
					on_report_xml_error ("Template version attribute must contain a value!")
				end
			else
					-- Create an unversioned template
				l_template := code_factory.new_code_template (l_templates)
				l_template.set_tokens_with_text (l_text)
				l_templates.extend (l_template)
			end
		end

feature {NONE} -- Action handlers

	on_error (a_msg: READABLE_STRING_32; a_line: NATURAL; a_char: NATURAL)
			-- <Precursor>
		do
			Precursor (a_msg, a_line, a_char)
			xml_parser.abort
		end

feature {NONE} -- Factory

	new_tag_state_transitions: HASH_TABLE [HASH_TABLE [NATURAL_8, STRING_32], NATURAL_8]
			-- <Precursor>
		local
			l_trans: like new_tag_state_transitions.item
		do
			create Result.make (8)

				-- XML
				-- => code_template
			create l_trans.make (1)
			l_trans.force (t_code_template, {CODE_TEMPLATE_ENTITY_NAMES}.code_template_tag)
			Result.force (l_trans, t_none)

				-- code_template
				-- => metadata
				-- => declarations
				-- => templates
			create l_trans.make (3)
			l_trans.force (t_metadata, {CODE_TEMPLATE_ENTITY_NAMES}.metadata_tag)
			l_trans.force (t_declarations, {CODE_TEMPLATE_ENTITY_NAMES}.declarations_tag)
			l_trans.force (t_templates, {CODE_TEMPLATE_ENTITY_NAMES}.templates_tag)
			Result.force (l_trans, t_code_template)

				-- metadata
				-- => title
				-- => description
				-- => author
				-- => shortcut
				-- => categories
			create l_trans.make (5)
			l_trans.force (t_title, {CODE_TEMPLATE_ENTITY_NAMES}.title_tag)
			l_trans.force (t_description, {CODE_TEMPLATE_ENTITY_NAMES}.description_tag)
			l_trans.force (t_author, {CODE_TEMPLATE_ENTITY_NAMES}.author_tag)
			l_trans.force (t_shortcut, {CODE_TEMPLATE_ENTITY_NAMES}.shortcut_tag)
			l_trans.force (t_categories, {CODE_TEMPLATE_ENTITY_NAMES}.categories_tag)
			Result.force (l_trans, t_metadata)

				-- categories
				-- => category
			create l_trans.make (1)
			l_trans.force (t_category, {CODE_TEMPLATE_ENTITY_NAMES}.category_tag)
			Result.force (l_trans, t_categories)

				-- declarations
				-- => literal
			create l_trans.make (2)
			l_trans.force (t_literal, {CODE_TEMPLATE_ENTITY_NAMES}.literal_tag)
			l_trans.force (t_object, {CODE_TEMPLATE_ENTITY_NAMES}.object_tag)
			Result.force (l_trans, t_declarations)

				-- literal
				-- => description
				-- => default
			create l_trans.make (2)
			l_trans.force (t_description, {CODE_TEMPLATE_ENTITY_NAMES}.description_tag)
			l_trans.force (t_default, {CODE_TEMPLATE_ENTITY_NAMES}.default_tag)
			Result.force (l_trans, t_literal)

				-- object
				-- => description
				-- => default
			create l_trans.make (2)
			l_trans.force (t_description, {CODE_TEMPLATE_ENTITY_NAMES}.description_tag)
			l_trans.force (t_default, {CODE_TEMPLATE_ENTITY_NAMES}.default_tag)
			Result.force (l_trans, t_object)

				-- templates
				-- => template
			create l_trans.make (1)
			l_trans.force (t_template, {CODE_TEMPLATE_ENTITY_NAMES}.template_tag)
			Result.force (l_trans, t_templates)
		end

	new_attribute_states: HASH_TABLE [HASH_TABLE [NATURAL_8, STRING_32], NATURAL_8]
			-- <Precursor>
		local
			l_attr: like new_attribute_states.item
		do
			create Result.make (4)

				-- code_template
				-- @ format
			create l_attr.make (1)
			l_attr.force (at_format, {CODE_TEMPLATE_ENTITY_NAMES}.format_attribute)
			Result.force (l_attr, t_code_template)

				-- literal
				-- @ id
				-- @ editable
			create l_attr.make (2)
			l_attr.force (at_id, {CODE_TEMPLATE_ENTITY_NAMES}.id_attribute)
			l_attr.force (at_editable, {CODE_TEMPLATE_ENTITY_NAMES}.editable_attribute)
			Result.force (l_attr, t_literal)

				-- object
				-- @ id
				-- @ editable
				-- @ conforms_to
			create l_attr.make (3)
			l_attr.force (at_id, {CODE_TEMPLATE_ENTITY_NAMES}.id_attribute)
			l_attr.force (at_editable, {CODE_TEMPLATE_ENTITY_NAMES}.editable_attribute)
			l_attr.force (at_conforms_to, {CODE_TEMPLATE_ENTITY_NAMES}.conforms_to_attribute)
			Result.force (l_attr, t_object)

				-- template
				-- @ version
			create l_attr.make (1)
			l_attr.force (at_version, {CODE_TEMPLATE_ENTITY_NAMES}.version_attribute)
			Result.force (l_attr, t_template)
		end

feature {NONE} -- Tag states

	t_code_template: NATURAL_8       = 0x01

	t_metadata: NATURAL_8            = 0x02
	t_title: NATURAL_8               = 0x03
	t_description: NATURAL_8         = 0x04
	t_author: NATURAL_8              = 0x05
	t_shortcut: NATURAL_8            = 0x06
	t_categories: NATURAL_8          = 0x07
	t_category: NATURAL_8            = 0x08

	t_declarations: NATURAL_8        = 0x09
	t_literal: NATURAL_8             = 0x0A
	t_object:  NATURAL_8             = 0x0B
	t_default: NATURAL_8             = 0x0C

	t_templates: NATURAL_8           = 0x0D
	t_template: NATURAL_8            = 0x0E

feature {NONE} -- Attributes states

	at_format: NATURAL_8             = 0x50

	at_id: NATURAL_8                 = 0x51
	at_editable: NATURAL_8           = 0x52
	at_conforms_to: NATURAL_8        = 0x53

	at_version: NATURAL_8            = 0x54

invariant
	code_factory_attached: attached code_factory
	last_code_template_definition_attached: attached last_declaration implies attached last_code_template_definition

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
