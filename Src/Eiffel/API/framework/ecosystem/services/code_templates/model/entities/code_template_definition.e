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

create
	make

feature {NONE} -- Initialization

	initialize_nodes (a_factory: like code_factory)
			-- Initializes the default nodes for Current.
			--
			-- `a_factory': Factory used for creating nodes.
		do
			metadata := a_factory.create_code_metadata
			metadata.parent := Current
			declarations := a_factory.create_code_declaration_collection
			declarations.parent := Current
			templates := a_factory.create_code_template_collection
			templates.parent := Current
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

feature -- Element change

	set_metadata (a_data: like metadata)
			-- Sets the code file's metadata.
			--
			-- `a_data': Metadata node.
		require
			not_a_data_is_parented: not a_data.is_parented
		do
			if a_data /= metadata then
				metadata.set_parent (Void)
			else
				a_data.parent := Current
				metadata := a_data
			end
		ensure
			old_metadata_parent_unset: old metadata.parent = Void
			metadata_assigned: metadata = a_data
			a_data_is_parented: a_data.is_parented
			a_data_parent_set: a_data.parent = Current
		end

	set_declarations (a_decl: like declarations)
			-- Sets the code file's declarations.
			--
			-- `a_data': Declaration node.
		require
			not_a_decl_is_parented: not a_decl.is_parented
		do
			if a_decl /= declarations then
				declarations.set_parent (Void)
			else
				a_decl.parent := Current
				declarations := a_decl
			end
		ensure
			old_declarations_parent_unset: old declarations.parent = Void
			declarations_assigned: declarations = a_decl
			declarations_is_parented: declarations.is_parented
			declarations_parent_set: declarations.parent = Current
		end

	set_templates (a_templates: like templates)
			-- Sets the code file's code templates.
			--
			-- `a_templates': Code templates.
		require
			not_a_templates_is_parented: not a_templates.is_parented
		do
			if a_templates /= templates then
				templates.parent := Void
			else
				templates.parent := Current
				templates := a_templates
			end
		ensure
			old_declarations_parent_unset: old a_templates.parent = Void
			templates_assigned: templates = a_templates
			templates_is_parented: templates.is_parented
			templates_parent_set: templates.parent = Current
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
