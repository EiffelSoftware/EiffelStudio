note
	description: "[
		Command line parser for eiffel_echo application.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		redefine
			switch_groups
		end

create
	make

feature -- Access

	copyright: STRING = "Copyright Eiffel Software 1985-2022. All Rights Reserved."
			-- <Precursor>

	name: STRING_8 = "eiffel_echo"
			-- <Precursor>

	non_switched_argument_description: STRING_8 = "Text which will be displayed by tool"
			-- <Precursor>

	non_switched_argument_name: STRING_8 = "input"
			-- <Precursor>

	non_switched_argument_type: STRING_8 = "string"
			-- <Precursor>

	version: STRING_8 = "0.1"
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (2)
			Result.extend (create {ARGUMENT_SWITCH}.make (stdin_switch,
				"Make tool read line from STDIN instead of using arguments. A line only containing %"quit%" will make tool quit..", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (stderr_switch,
				"Make tool print output as errors.", True, False))
		end

	switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- <Precursor>
		once
			create Result.make (2)
			Result.extend (create {ARGUMENT_GROUP}.make (<< switch_of_name (stderr_switch) >>, True))
			Result.extend (create {ARGUMENT_GROUP}.make (<< switch_of_name (stdin_switch), switch_of_name (stderr_switch) >>, False))
		end

feature {NONE} -- Access

	stdin_switch: STRING = "i|stdin"
			-- Switch making tool read input from STDIN

	stderr_switch: STRING = "e|stderr"
			-- Switch making tool print output to STDERR

feature -- Status report

	has_stdin_option: BOOLEAN
			-- Was `stdin_switch' provided on command line?
		do
			Result := has_option (stdin_switch)
		end

	has_stderr_option: BOOLEAN
			-- Was `stderr_switch' provided on command line?
		do
			Result := has_option (stderr_switch)
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
