note
	description: "[
		Simple echo class which redirects input from a {INPUT_PROVIDER} to a {OUTPUT_RECEIVER}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECHO

create
	make

feature {NONE} -- Initialize

	make (a_output: like output)
			-- Initialize `Current'.
			--
			-- `a_output': Output receivcer to which input will be redirected.
		do
			output := a_output
		ensure
			output_set: output = a_output
		end

feature {NONE} -- Access

	output: OUTPUT_REDIRECTOR
			-- Output receivcer to which input will be redirected.

feature -- Basic operations

	process (a_input: INPUT_PROVIDER)
			-- Redirect all input retrieved from an input provider to `output'.
			--
			-- `a_input': Input provider from which input is received.
		do
			from
				a_input.retrieve
			until
				not a_input.has_next
			loop
				output.put (a_input.next)
				a_input.retrieve
			end
		ensure
			not_has_next: not a_input.has_next
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
