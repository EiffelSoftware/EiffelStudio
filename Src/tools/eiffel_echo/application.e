indexing
	description : "eiffel_echo application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
			--
			-- Note: replace this with argument parser library once void safe version is available.
		local
			l_args: ARGUMENT_PARSER
		do
			create l_args.make (True, False)
			l_args.execute (agent start (l_args))
		end

	start (a_args: ARGUMENT_PARSER)
			-- Process input.
		require
			a_args_successful: a_args.is_successful
		local
			l_echo: ECHO
		do
			if a_args.has_stderr_option then
				create l_echo.make (create {OUTPUT_MEDIUM}.make (io.error))
			else
				create l_echo.make (create {OUTPUT_MEDIUM}.make (io.output))
			end
			if a_args.has_stdin_option then
				l_echo.process (create {INPUT_LINE_READER}.make (io.input))
			else
				l_echo.process (create {INPUT_LIST}.make (a_args.values))
			end
		end

;indexing
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
