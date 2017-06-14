note
	description: "Represents a INI document AS root node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_DOCUMENT_NODE

inherit
	INI_SECTION_CONTAINER_NODE
		redefine
			make,
			extend_section
		end

	INI_PROPERTY_CONTAINER_NODE
		rename
			extend_property as extend_property_in_current,
			extend_literal as extend_literal_in_current
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize new document
		do
			Precursor {INI_SECTION_CONTAINER_NODE}
			Precursor {INI_PROPERTY_CONTAINER_NODE}
		end

feature -- Access

	span: INI_TEXT_SPAN
			-- Span of abstract syntax node
		local
			l_props: like properties
			l_sections: like sections
			l_start: INI_TEXT_SPAN
			l_end: INI_TEXT_SPAN
		do
			Result := internal_span
			if Result = Void then
				l_props := properties
				l_sections := sections
				if attached l_props then
					l_start := l_props.first.span
					if l_sections = Void then
						l_end := l_props.last.span
					else
						l_end := l_sections.last.span
					end
				elseif attached l_sections then
					l_start := l_sections.first.span
					l_end := l_sections.last.span
				end
				if attached l_start and attached l_end then
					create Result.make (l_start.start_line, l_start.start_index, l_end.end_line, l_end.end_index)
				else
					create Result.make (1, 0, 1, 0)
				end
				internal_span := Result
			end
		ensure then
			internal_span_attached: internal_span /= Void
		end

feature -- Extension

	extend_property (a_property: INI_PROPERTY_NODE)
			-- Extends properties with property `a_property'.
		require
			a_property_attached: a_property /= Void
			already_added: (sections.is_empty implies not properties.has (a_property)) or
				(not sections.is_empty implies not sections.last.properties.has (a_property))
		local
			l_sections: like sections
		do
			l_sections := sections
			if l_sections.is_empty then
				extend_property_in_current (a_property)
			else
				l_sections.last.extend_property (a_property)
			end
			internal_span := Void
		ensure then
			a_item_added: (sections.is_empty implies properties.has (a_property)) or
				(not sections.is_empty implies sections.last.properties.has (a_property))
			span_invalidated: internal_span = Void
		end

	extend_literal (a_id: INI_LITERAL_NODE)
			-- Extends literals with literal `a_id'.
		require
			a_id_attached: a_id /= Void
			already_added: (sections.is_empty implies not literals.has (a_id)) or
				(not sections.is_empty implies not sections.last.literals.has (a_id))
		local
			l_sections: like sections
		do
			l_sections := sections
			if l_sections.is_empty then
				extend_literal_in_current (a_id)
			else
				l_sections.last.extend_literal (a_id)
			end
			internal_span := Void
		ensure then
			a_item_added: (sections.is_empty implies literals.has (a_id)) or
				(not sections.is_empty implies sections.last.literals.has (a_id))
			span_invalidated: internal_span = Void
		end

	extend_section (a_section: INI_SECTION_NODE)
			-- Extends sections with section `a_section'.
		do
			Precursor {INI_SECTION_CONTAINER_NODE} (a_section)
			internal_span := Void
		ensure then
			span_invalidated: internal_span = Void
		end

feature -- Visitation

	visit (a_visitor: INI_NODE_VISITOR)
			-- Visit current node using vistor `a_vistor'
		do
			a_visitor.process_document (Current)
		end

feature {NONE} -- Internal Implementation Cache

	internal_span: detachable like span;
			-- Cached version of `span'
			-- Note: Do not use directly!

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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

end -- class {INI_DOCUMENT_NODE}
