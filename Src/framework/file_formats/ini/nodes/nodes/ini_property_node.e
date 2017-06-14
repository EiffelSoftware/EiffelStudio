note
	description: "Represents a INI document property AS node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_PROPERTY_NODE

inherit
	INI_NODE

create
	make

feature {NONE} -- Initialization

	make (a_id: like identifier; a_assigner: like assigner; a_value: like value)
			-- Initialize section.
		require
			a_id_set: a_value = Void implies a_id /= Void
			a_assigner_attached: a_assigner /= Void
			a_value_attached: a_id = Void implies a_value /= Void
		do
			identifier := a_id
			assigner := a_assigner
			value := a_value
		ensure
			identifier_set: identifier = a_id
			assigner_set: assigner = a_assigner
			a_value_set: a_value = value
		end

feature -- Node Access

	identifier: detachable INI_ID_NODE
			-- Optional identifier.

	assigner: INI_SYMBOL_NODE
			-- Property assigner

	value: detachable INI_VALUE_NODE
			-- Optional value

feature -- Access

	span: INI_TEXT_SPAN
			-- Span of abstract syntax node
		local
			l_id: like identifier
			l_value: like value
			l_start: INI_TEXT_SPAN
			l_end: INI_TEXT_SPAN
		do
			Result := internal_span
			if Result = Void then
				l_id := identifier
				if l_id /= Void then
					l_start := l_id.span
				else
					l_start := assigner.span
				end
				l_value := value
				if l_value /= Void then
					l_end := l_value.span
				else
					l_end := assigner.span
				end
				create Result.make (l_start.start_line, l_start.start_index, l_end.end_line, l_end.end_index)
				internal_span := Result
			end
		ensure then
			internal_span_attached: internal_span /= Void
		end

feature -- Visitation

	visit (a_visitor: INI_NODE_VISITOR)
			-- Visit current node using vistor `a_vistor'
		do
			a_visitor.process_property (Current)
		end

feature {NONE} -- Internal Implementation Cache

	internal_span: detachable like span
			-- Cached version of `span'
			-- Note: Do not use directly!

invariant
	identifier_set: value = Void implies identifier /= Void
	assigner_attached: assigner /= Void
	value_attached: identifier = Void implies value /= Void

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

end
