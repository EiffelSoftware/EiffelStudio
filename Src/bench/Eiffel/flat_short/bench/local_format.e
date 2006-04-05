indexing
	description: "Format details related to the output of a format."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_FORMAT

feature -- Properties

	indent_depth: INTEGER
			-- Number of tabs after new line

feature {TEXT_FORMATTER_DECORATOR, EIFFEL_LIST, TEXT_FORMATTER}

	new_line_between_tokens: BOOLEAN
			-- Must a new line be inserted
			-- between EIFFEL_LIST tokens?

feature {TEXT_FORMATTER_DECORATOR, TEXT_FORMATTER} -- Implementation

	dot_needed: BOOLEAN
			-- Will a dot be needed before next call?

	separator: STRING
			-- Separator between tokens of the processed EIFFEL_LIST

	space_between_tokens: BOOLEAN
			-- Must a space character be inserted
			-- between EIFFEL_LIST tokens?

feature {TEXT_FORMATTER_DECORATOR, TEXT_FORMATTER} -- Local formatting control

	indent is
			-- Increment `indent_depth'.
		do
			indent_depth := indent_depth + 1
		ensure
			incremented: indent_depth = (old indent_depth) + 1
		end

	exdent is
			-- Decrement `indent_depth'.
		do
			indent_depth := indent_depth - 1
		ensure
			decremented: indent_depth = (old indent_depth) - 1
		end

	set_indent_depth (d: INTEGER) is
			-- Assign `d' to `indent_depth'.
		do
			indent_depth := d
		ensure
			assigned: d = indent_depth
		end

	set_dot_needed (b: BOOLEAN) is
			-- Set `dot_needed' to `b'.
		do
			dot_needed := b
		ensure
			dot_needed  = b
		end

	set_new_line_between_tokens (b: BOOLEAN) is
			-- Set indentation.
		do
			new_line_between_tokens := b
		ensure
			new_line_between_tokens = b
		end

	set_separator (s: like separator) is
			-- Set `separator' to `s'.	
		do
			separator := s
		ensure
			separator = s
		end

	set_space_between_tokens (b: BOOLEAN) is
			-- Set spacing.
		do
			space_between_tokens := b
		ensure
			space_between_tokens = b
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class LOCAL_FORMAT
