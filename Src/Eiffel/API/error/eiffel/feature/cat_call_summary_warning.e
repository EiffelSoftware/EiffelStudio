note
	description: "Give a summary of all catcall warnings."
	date: "$Date$"
	revision: "$Revision$"

class
	CAT_CALL_SUMMARY_WARNING

inherit
	COMPILER_WARNING

create
	make

feature

	make (a_summary: like summary)
			-- Intialize Current with `a_summary'.
		require
			a_summary_not_void: a_summary /= Void
		do
			summary := a_summary
		ensure
			summary_set: summary = a_summary
		end

feature -- Access

	summary: STRING
			-- Hold summary

	code: STRING = "Catcall Summary Report"

	file_name: like {ERROR}.file_name
		do
			-- Not applicable
		end

feature -- Formatting

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add (summary)
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
