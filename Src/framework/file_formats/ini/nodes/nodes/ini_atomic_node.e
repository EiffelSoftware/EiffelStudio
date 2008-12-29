note
	description: "Base implementation for all atomic/terminal AS nodes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INI_ATOMIC_NODE

inherit
	INI_NODE

feature {NONE} -- Initialization

	make (a_text: like text; a_span: like span)
			-- Initialize abstract syntax node.
		require
			a_text_attached: a_text /= Void
			not_a_text_is_empty: not a_text.is_empty
			a_span_attached: a_span /= Void
		do
			internal_text := a_text
			internal_span := a_span
		ensure
			text_set: text = a_text
			span_set: span = a_span
		end

feature -- Access

	text: STRING
			-- String valur of `Current'
		do
			Result := internal_text
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	span: INI_TEXT_SPAN
			-- Span of abstract syntax node
		do
			Result := internal_span
		end

feature {NONE} -- Internal Implementation

	internal_span: like span
			-- Internal version of `span'
			-- Note: Do not use directly!

	internal_text: STRING
			-- Textual representation of abstract syntax node

invariant
	internal_text_attached: internal_text /= Void
	not_internal_text_is_empty: not internal_text.is_empty
	internal_span_attached: internal_span /= Void

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

end -- class {INI_ATOMIC_NODE}
