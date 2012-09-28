note
	description: "Abstract class for instruction AS node. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class INSTRUCTION_AS

inherit
	AST_EIFFEL

feature -- Access

	line_pragma: detachable BREAK_AS
			-- Associated line if any

feature {EIFFEL_PARSER_SKELETON} -- Line pragma

	set_line_pragma (a_line_pragma: like line_pragma)
			-- Set `line_pragma' with `a_line_pragma'.
		do
			line_pragma := a_line_pragma
		ensure
			line_pragma_set: line_pragma = a_line_pragma
		end

feature -- Status report

	starts_with_parenthesis: BOOLEAN
			-- Is the first format item a "(".
			-- See: INTERNAL_AS.format_compound.
		do
			-- False
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class INSTRUCTION_AS
