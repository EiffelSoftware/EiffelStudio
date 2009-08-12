note
	description: "[
		An output object used to display content to the default output stream.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_TTY

inherit
	OUTPUT_I

	LOCKABLE

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

feature -- Access

	name: IMMUTABLE_STRING_32
			-- <Precursor>
		do
			Result := once "Terminal"
		end

	formatter: TEXT_FORMATTER
			-- <Precursor>
		do
			if attached internal_formatter as l_result then
				Result := l_result
			else
				create {TERM_WINDOW} Result
				internal_formatter := Result
			end
		ensure then
			result_consistent: Result = formatter
		end

feature -- Status report

	is_active: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature -- Basic operations

	clear
			-- <Precursor>
		do
		end

	activate (a_force: BOOLEAN)
			-- <Precursor>
		do
		end

feature {NONE} -- Implementation: Internal cache

	internal_formatter: detachable like formatter
			-- Cached version of `internal_formatter'.
			-- Note: Do not use directly!

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
