note
	description: "[
		Visitor pattern implmentation of `INI_AST_VISITOR' for constructing complete
		documents from an INI AST.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_DOCUMENT_BUILDER_NODE_VISITOR

inherit
	INI_NODE_VISITOR
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialze document builder visitor.
		do
			create document.make
			container := document
		end

feature -- Access

	document: INI_DOCUMENT
			-- Document created during visitation

feature {NONE}  -- Processing

	process_document (a_document: INI_DOCUMENT_NODE)
			-- Process document node `a_document'.
		do
			process_list (a_document.properties)
			process_list (a_document.literals)
			process_list (a_document.sections)
		end

	process_section (a_section: INI_SECTION_NODE)
			-- Process document section node `a_section'.
		local
			l_section: INI_SECTION
			l_document: like document
		do
			l_document := document
			create l_section.make (a_section.label, l_document)
			l_document.sections.extend (l_section)
			container := l_section
			process_list (a_section.properties)
			process_list (a_section.literals)
		ensure then
			new_container_set: container /= old container
		end

	process_property (a_property: INI_PROPERTY_NODE)
			-- Process property node `a_property' in container `a_container'
		local
			l_property: INI_PROPERTY
			l_id: INI_ID_NODE
			l_value: INI_VALUE_NODE
			l_str_value: STRING
			l_container: like container
		do
			l_container := container
			l_id := a_property.identifer
			l_value := a_property.value
			if l_value = Void then
				create l_str_value.make_empty
			else
				l_str_value := l_value
			end
			if l_id = Void then
				create l_property.make_default (l_str_value, l_container)
			else
				create l_property.make (l_id, l_str_value, l_container)
			end
			l_container.properties.extend (l_property)
		ensure then
			property_extended: container.properties.count = old container.properties.count + 1
		end

	process_literal (a_literal: INI_LITERAL_NODE)
			-- Process literal `a_literal'.
		local
			l_lit: INI_LITERAL
			l_container: like container
		do
			l_container := container
			create l_lit.make (a_literal.text, l_container)
			l_container.literals.extend (l_lit)
		ensure then
			property_extended: container.literals.count = old container.literals.count + 1
		end

	process_id (a_id: INI_ID_NODE)
			-- Process identifier `a_id'.
		do
			check
				False
			end

			--| Should never be called!
		end

	process_symbol (a_symbol: INI_SYMBOL_NODE)
			-- Process syntax symbol `a_symbol'.
		do
			check
				False
			end

			--| Should never be called!
		end

	process_value (a_value: INI_VALUE_NODE)
			-- Process value `a_value'.
		do
			check
				False
			end

			--| Should never be called!
		end

feature {NONE} -- Implementation

	container: INI_PROPERTY_CONTAINER
			-- Last property container

invariant
	document_attached: document /= Void
	container_attached: container /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {INI_DOCUMENT_BUILDER_AST_VISITOR}
