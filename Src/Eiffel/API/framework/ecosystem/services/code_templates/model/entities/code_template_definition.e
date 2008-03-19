indexing
	description: "[
		Represents a full code template model definition file.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_TEMPLATE_DEFINITION

inherit
	CODE_NODE
		rename
			make as make_node
		end

create
	make

feature {NONE} -- Initialization

	make (a_factory: like code_factory)
			-- Initializes a code node.
			--
			-- `a_factory': Factory used for creating nodes.
		do
			code_factory := a_factory
			build_nodes (a_factory)
		ensure
			code_factory_set: code_factory = a_factory
		end

	initialize_nodes (a_factory: like code_factory)
			-- Initializes the default nodes for Current.
			--
			-- `a_factory': Factory used for creating nodes.
		do
			set_metadata (a_factory.create_code_metadata (Current))
			set_declarations (a_factory.create_code_declaration_collection (Current))
			set_templates (a_factory.create_code_template_collection (Current))
		end

feature -- Access

	frozen definition: !CODE_TEMPLATE_DEFINITION
			-- Top level code file.
		do
			Result ?= Current
		end

	metadata: !CODE_METADATA assign set_metadata
			-- Metadata for a give code file.

	declarations: !CODE_DECLARATION_COLLECTION assign set_declarations
			-- Identifier declarations for a given code file.

	templates: !CODE_TEMPLATE_COLLECTION assign set_templates
			-- Code templates (versioned and unversioned) for a given code file.

feature {CODE_NODE} -- Access

	code_factory: !CODE_FACTORY
			-- Factory used for creating code nodes

feature -- Element change

	set_metadata (a_data: like metadata)
			-- Sets the code file's metadata.
			--
			-- `a_data': Metadata node.
		do
			metadata := a_data
		ensure
			metadata_assigned: metadata = a_data
			a_data_is_parented: a_data.is_parented
			a_data_parent_set: a_data.parent = Current
		end

	set_declarations (a_decl: like declarations)
			-- Sets the code file's declarations.
			--
			-- `a_data': Declaration node.
		do
			declarations := a_decl
		ensure
			declarations_assigned: declarations = a_decl
			declarations_is_parented: declarations.is_parented
			declarations_parent_set: declarations.parent = Current
		end

	set_templates (a_templates: like templates)
			-- Sets the code file's code templates.
			--
			-- `a_templates': Code templates.
		do
			templates := a_templates
		ensure
			templates_assigned: templates = a_templates
			templates_is_parented: templates.is_parented
			templates_parent_set: templates.parent = Current
		end

feature -- Query

	applicable_default_item: CODE_TEMPLATE
			-- Attempts to retreive the default (unversioned) code template.
			--
			-- `Result': A code template with no version; Otherwise Void if not applicable template was located.
		do
			Result := templates.applicable_default_item
		ensure
			result_is_unversioned: ({CODE_VERSIONED_TEMPLATE}) #? Result = Void
		end

	applicable_item (a_version: !STRING_32): CODE_TEMPLATE
			-- Attempts to retreive the most applicable code template, given a string version.
			--
			-- `a_version': Version to find the most applicable template with.
			-- `Result': A code template that best matches the supplied [minimum] version; Otherwise Void if not applicable template was located.
		require
			not_a_version_is_empty: not a_version.is_empty
		do
			Result := templates.applicable_item (a_version)
		end

	applicable_item_with_version (a_version: !CODE_VERSION): CODE_TEMPLATE
			-- Attempts to retreive the most applicable code template, given a version.
			--
			-- `a_version': Version to find the most applicable template with.
			-- `Result': A code template that best matches the supplied [minimum] version; Otherwise Void if not applicable template was located.
		require
			not_a_version_is_default: not a_version.is_equal (create {!CODE_NUMERIC_VERSION}.make (0, 0, 0, 0))
		do
			Result := templates.applicable_item_with_version (a_version)
		end

feature -- Visitor

	process (a_visitor: !CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_template_definition (({!CODE_TEMPLATE_DEFINITION}) #? Current)
		end

invariant
	metadata_parent_set: metadata.parent = Current
	declarations_parent_set: declarations.parent = Current
	templates_parent_set: templates.parent = Current

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
