note
	description: "Represents a INI document section AS node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_SECTION_NODE

inherit
	INI_NODE

	INI_PROPERTY_CONTAINER_NODE
		rename
			make as make_prop_container
		redefine
			extend_property
		end

create
	make

feature {NONE} -- Initialization

	make (a_open: like open_bracket; a_label: like label; a_close: like close_bracket)
			-- Initialize section.
		do
			make_prop_container
			open_bracket := a_open
			label := a_label
			close_bracket := a_close
		ensure
			open_bracket_set: open_bracket = a_open
			label_set: label = a_label
			close_bracket_set: close_bracket = a_close
		end

feature -- Node Access

	open_bracket: INI_SYMBOL_NODE
			-- Section opener symbol

	label: INI_ID_NODE
			-- Section label name

	close_bracket: INI_SYMBOL_NODE
			-- Section closer symbol

feature -- Access

	span: INI_TEXT_SPAN
			-- Span of abstract syntax node
		local
			l_props: like properties
			l_start: INI_TEXT_SPAN
			l_end: INI_TEXT_SPAN
		do
			Result := internal_span
			if Result = Void then
				l_props := properties
				if l_props = Void then
					l_start := open_bracket.span
				else
					l_start := l_props.last.span
				end
				l_end := close_bracket.span
				create Result.make (l_start.start_line, l_start.start_index, l_end.end_line, l_end.end_index)
				internal_span := Result
			end
		ensure then
			internal_span_attached: internal_span /= Void
		end

feature -- Extension

	extend_property (a_item: INI_PROPERTY_NODE)
			-- Extends container with item `a_item'.
		do
			Precursor {INI_PROPERTY_CONTAINER_NODE} (a_item)
			internal_span := Void
		ensure then
			span_invalidated: internal_span = Void
		end

feature -- Visitation

	visit (a_visitor: INI_NODE_VISITOR)
			-- Visit current node using vistor `a_vistor'
		do
			a_visitor.process_section (Current)
		end

feature {NONE} -- Internal Implementation Cache

	internal_span: like span
			-- Cached version of `span'
			-- Note: Do not use directly!

invariant
	open_bracket_attached: open_bracket /= Void
	label_attached: label /= Void
	close_bracket_attached: close_bracket /= Void

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

end -- class {INI_SECTION_NODE}
