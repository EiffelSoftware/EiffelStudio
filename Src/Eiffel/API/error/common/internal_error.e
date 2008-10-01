indexing
	description: "Internal error of the compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INTERNAL_ERROR

inherit
	COMPILER_ERROR

create
	make

feature {NONE} -- Initialization

	make (m: like message) is
			-- New internal error with message `m'.
		require
			m_not_void: m /= Void
			m_not_empty: not m.is_empty
		do
			message := m
		ensure
			message_set: message = m
		end

feature -- Access

	code: STRING is "INTERNAL_ERROR"
			-- Name of error.

	file_name: STRING is
		do
		end

	message: STRING
			-- Description of internal error.

feature {ERROR_TRACER} -- Formatting

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			a_text_formatter.add ("Error message: ")
			a_text_formatter.add (message)
			a_text_formatter.add_new_line
		end

invariant
	message_not_void: message /= Void

indexing
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
